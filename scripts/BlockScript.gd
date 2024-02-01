extends Node

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
	print(count)
	print(Vector2())
	#print(position)
	if(count >= step_time):
		count = 0
		
