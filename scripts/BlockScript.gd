extends Node2D

var cord = cordinate.new()
var count = 0
var block_width = 625
var step_time = 0.5
var active : bool
var children  
#var position = vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	active = true
	children = get_children()
	print(children)
	printChi()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	count += delta
	#print("%1.3f" % count)
	#print(global_position)
	var adj_x = cord.adjust_x(global_position.x)
	var adj_y = cord.adjust_y(global_position.y)
	#print(str("(",adj_x,", ",adj_y,")"))
	if(Input.is_action_just_pressed("tetris_left")):
		#print("left pressed")
		move_local_x(-block_width)
	if(Input.is_action_just_pressed("tetris_right")):
		#print("right pressed")
		move_local_x(block_width)
		
	if(count >= step_time && active):
		move_local_y(block_width)
		printChi()
		print(str("(",adj_x,", ",adj_y,")"))
		count = 0
		
func printChi():
	print(str("global shape ",global_position))
	print(str("adjust shape ",cord.adjust_vector(global_position.x,global_position.y)))
	print(str(cord.adjust_y(global_position.y)))
	var c = 0
	for i in children :
		var pos = cord.adjust_vector(i.global_position.x,global_position.y)
		print(str("global child ",c," ",i.global_position))
		print(str("local  child ",c," ",pos))
		c += 1

func child_loc():
	for i in children :
		var pos = cord.adjust_vector(i.global_position.x,global_position.y)
		
