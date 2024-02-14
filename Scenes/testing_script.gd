extends Node2D

var center
var child
# Called when the node enters the scene tree for the first time.
func _ready():
	child = get_children()[0]
	for node in child.get_children():
		if str(node).begins_with("TestBlockBlack2"):
			center = node
			print("and the center node is: ")
		print(node)
	child.global_position =  Vector2(300,300)
	print(child.global_position)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
[0,-1],[0,1],[-1,1],[-1,0],[1,0],[1,1],[0,1],[0,-1],[1,-1],[1,0],[-1,0],[-1,-1]
	
