extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var s = get_viewport().size;
	var start_pos = Vector2(s.x * 0.5, 0) # Starting position in screen coordinates
	var end_pos = Vector2(s.x * 0.5, s.y) # Ending position in screen coordinates
	var color = Color(1, 1, 1) # Line color
#	draw_line(start_pos, end_pos, color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
