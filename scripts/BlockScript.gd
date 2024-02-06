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
	#var vec = Vector2(5803,-9675)
	#to_global(vec)
	active = true
	children = get_children()
	#print(children)
	#printChi()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += delta
	var adj_x = cord.adjust_x(global_position.x)
	var adj_y = cord.adjust_y(global_position.y)
	#print(str("(",adj_x,", ",adj_y,")"))
	if(Input.is_action_just_pressed("tetris_left")):
		if(check_left()&&active):
			global_translate(Vector2(-block_width,0))
	if(Input.is_action_just_pressed("tetris_right")):
		if(check_right()&&active):
			global_translate(Vector2(block_width,0))
	if(Input.is_action_just_pressed("rotate_right")):
		if(check_rotate_right()&&active):
			rotate(1.570)
	if(Input.is_action_just_pressed("rotate_left")):
		if(check_rotate_right()&&active):
			rotate(1.570)
	if(Input.is_action_just_pressed("drop")&&active):
		step_time = 0.01
	if(Input.is_action_just_pressed("down")&&active):
		if(check_down()&&active):
			global_translate(Vector2(0,block_width))
			
	if(count >= step_time && active):
		if(check_down()):
			#move_local_y(block_width)
			global_translate(Vector2(0,block_width))
			#print(str("(",adj_x,", ",adj_y,")"))
			#printChi()
			count = 0
		else:
			pass
		
func printChi():
	#print(str("global shape ",global_position))
	#print(str("adjust shape ",cord.adjust_vector(global_position.x,global_position.y)))
	#print(str(cord.adjust_y(global_position.y)))
	var c = 0
	for i in children :
		var pos = cord.adjust_vector(i.global_position.x,i.global_position.y)
		print(str("global child ",c," ",i.global_position))
		print(str("local  child ",c," ",pos))
		c += 1

func child_loc():
	var pos
	var arr = Array()
	for i in children :
		pos = cord.adjust_vector(i.global_position.x,i.global_position.y)
		arr.append(pos)
	return arr
	
func child_loc_off(off_x,off_y):
	var pos
	var arr = Array()
	for i in children :
		pos = cord.adjust_vector(i.global_position.x,i.global_position.y)
		pos[0] += off_x
		pos[1] += off_y
		arr.append(pos)
	return arr

func check_left():
	var test = child_loc_off(-1,0)
	for i in test:
		if(get_parent().empty_dest(i)):
			return true
		else:
			return false
func check_right():
	var test = child_loc_off(1,0)
	for i in test:
		if(get_parent().empty_dest(i)):
			return true
		else:
			return false
func check_down():
	var test = child_loc_off(0,2)
	for i in test:
		if(get_parent().empty_dest(i)):
			#print("empty")
			return true
		else:
			#print("full")
			printChi()
			get_parent().spawn_rand()
			add_to_parrent()
			active = false
			return false
			
func check_rotate_right():
	##TODO
	return true
func check_rotate_left():
	##TODO
	return true
	
func add_to_parrent():
	var childs = child_loc()
	for i in childs:
		#print(str(i[0]," ",i[1]))
		get_parent().squares.append(i)
		#print("printing_squares")
		#get_parent().print_squares()
