extends Node

var PIECE_ASSETS := {
	PIECE_TYPE.BLACK_BISHOP: "res://Assets/black_bishop.png",
	PIECE_TYPE.BLACK_KING: "res://Assets/black_king.png",
	PIECE_TYPE.BLACK_KNIGHT: "res://Assets/black_knight.png",
	PIECE_TYPE.BLACK_PAWN: "res://Assets/black_pawn.png",
	PIECE_TYPE.BLACK_QUEEN: "res://Assets/black_queen.png",
	PIECE_TYPE.BLACK_ROOK: "res://Assets/black_rook.png",
	PIECE_TYPE.WHITE_BISHOP: "res://Assets/white_bishop.png",
	PIECE_TYPE.WHITE_KING: "res://Assets/white_king.png",
	PIECE_TYPE.WHITE_KNIGHT: "res://Assets/white_knight.png",
	PIECE_TYPE.WHITE_PAWN: "res://Assets/white_pawn.png",
	PIECE_TYPE.WHITE_QUEEN: "res://Assets/white_queen.png",
	PIECE_TYPE.WHITE_ROOK: "res://Assets/white_rook.png"
}
const FEN_DICT := {
	"b": PIECE_TYPE.BLACK_BISHOP,
	"k": PIECE_TYPE.BLACK_KING,
	"n": PIECE_TYPE.BLACK_KNIGHT,
	"p": PIECE_TYPE.BLACK_PAWN,
	"q": PIECE_TYPE.BLACK_QUEEN,
	"r": PIECE_TYPE.BLACK_ROOK,
	"B": PIECE_TYPE.WHITE_BISHOP,
	"K": PIECE_TYPE.WHITE_KING,
	"N": PIECE_TYPE.WHITE_KNIGHT,
	"P": PIECE_TYPE.WHITE_PAWN,
	"Q": PIECE_TYPE.WHITE_QUEEN,
	"R": PIECE_TYPE.WHITE_ROOK
}
enum PIECE_TYPE 
{
	BLACK_BISHOP,
	BLACK_KING,
	BLACK_KNIGHT,
	BLACK_PAWN,
	BLACK_QUEEN,
	BLACK_ROOK,
	WHITE_BISHOP,
	WHITE_KING,
	WHITE_KNIGHT,
	WHITE_PAWN,
	WHITE_QUEEN,
	WHITE_ROOK
}

enum SLOT_STATE
{
	NONE,
	FREE
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clear_children(node: Node) -> void:
	for child in node.get_children():
		if(child.has_meta("piece")):
			node.remove_child(child)
			child.queue_free()
