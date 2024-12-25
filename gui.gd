extends Control

@onready var SLOT_SCENE = preload("res://Scenes/slot.tscn")
@onready var BOARD_GRID = $ChessBoard/BoardGrid
@onready var PIECE_SCENE = preload("res://Scenes/piece.tscn")
@onready var CHESS_BOARD = $ChessBoard
@onready var INPUT_FEN = $InputFen

var grid_array := []
var piece_array := []
var icon_offset := Vector2(43,43)
var piece_selected = null

var FEN_STRING = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"

func _ready() -> void:
	for row in range(8):
		for col in range(8):
			create_slot((row + col) % 2 != 0)
	piece_array.resize(64)
	piece_array.fill(0)
	

func _process(delta: float) -> void:
	pass

func create_slot(isOdd: bool):
	var new_slot = SLOT_SCENE.instantiate()
	new_slot.slot_id = grid_array.size()
	new_slot.set_background(isOdd)
	BOARD_GRID.add_child(new_slot)
	grid_array.push_back(new_slot)
	new_slot.slot_clicked.connect(_on_slot_clicked)

func _on_slot_clicked(slot) -> void:
	if not piece_selected:
		return
	if piece_selected == grid_array[slot.slot_id]:
		return
	move_piece(piece_selected, slot.slot_id)
	piece_selected = null

func move_piece(piece, location) -> void:
	if piece_array[location]:
		piece_array[location].queue_free()
		piece_array[location] = 0
	
	var tween = get_tree().create_tween()
	tween.tween_property(piece, "global_position", grid_array[location].global_position + icon_offset, 0.2)
	
	piece_array[piece.slot_id] = 0
	piece_array[location] = piece
	piece.slot_id = location

func add_piece(piece_type, location) -> void:
	var new_piece = PIECE_SCENE.instantiate()
	CHESS_BOARD.add_child(new_piece)
	new_piece.set_meta("piece", piece_type)
	new_piece.PIECE_TYPE = piece_type
	new_piece.load_icon(piece_type)
	new_piece.global_position = grid_array[location].global_position + icon_offset
	piece_array[location] = new_piece
	new_piece.slot_id = location
	new_piece.piece_selected.connect(_on_piece_selected)

func parse_fen(fen: String) -> void:
	var rows = fen.split(" ")[0].split("/")
	var board_index := 0
	for row in rows:
		for char in row:
			if char.is_valid_int(): 
				board_index += char.to_int()
			else: 
				add_piece(DataHandler.FEN_DICT.get(char, null), board_index)
				board_index += 1

func _on_piece_selected(piece):
	if not piece_selected:
		piece_selected = piece
	else:
		_on_slot_clicked(grid_array[piece.slot_id])

func set_board_filter(bitmap: int):
	for i in range(64):
		if bitmap & 1:
			grid_array[i].set_filter(DataHandler.SLOT_STATE.FREE)
		bitmap = bitmap >> 1

func _on_test_button_pressed() -> void:
	DataHandler.clear_children(CHESS_BOARD)
	parse_fen(FEN_STRING)
	set_board_filter(1023)

func _on_input_fen_text_changed() -> void:
	FEN_STRING = INPUT_FEN.text
