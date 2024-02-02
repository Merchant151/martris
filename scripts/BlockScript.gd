extends Node2D


var count = 0
var block_width = 625
var step_time = 0.5
#var position = vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += delta
	print("%1.3f" % count)
	print(global_position)
	#print(Vector2())
	#print(Position)
	#print(position)
	
	if(count >= step_time):
		move_local_y(block_width)
		count = 0
		
