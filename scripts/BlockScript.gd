extends Node2D

var cord = cordinate.new()
var count = 0
var block_width = 625
var step_time = 0.5
var active : bool
var children
#rotational properties
var rotation_array
var rotation_state = 0
var rotation_num  = 0
var center_child
#var position = vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_array = Array()
	#var vec = Vector2(5803,-9675)
	#to_global(vec)
	active = true
	children = get_children()
	init_rotational_properties()
	#printChi()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += delta
	#var adj_x = cord.adjust_x(global_position.x)
	#var adj_y = cord.adjust_y(global_position.y)
	#print(str("(",adj_x,", ",adj_y,")"))
	if(Input.is_action_just_pressed("tetris_left")):
		if(check_left()&&active):
			global_translate(Vector2(-block_width,0))
			bugs()
	if(Input.is_action_just_pressed("tetris_right")):
		if(check_right()&&active):
			global_translate(Vector2(block_width,0))
			bugs()
	if(Input.is_action_just_pressed("rotate_right")&&rotation_num > 0):
		
		var roTo
		if(rotation_state == rotation_num):
			roTo = 0
		else:
			roTo +=1
		pass
		if(check_rotate(roTo)&&active):
			rotate(1.57079)
			bugs()
	if(Input.is_action_just_pressed("rotate_left")&&rotation_num > 0):
		var roTo
		if(rotation_state == 0):
			roTo = rotation_num
		else:
			roTo -=1
		pass
		if(check_rotate(roTo)&&active):
			rotate(1.57079)
			bugs()
	if(Input.is_action_just_pressed("drop")&&active):
		step_time = 0.01
	if(Input.is_action_just_pressed("down")&&active):
		if(check_down()&&active):
			global_translate(Vector2(0,block_width))
			bugs()
	if(count >= step_time && active):
		if(check_down()):
			#move_local_y(block_width)
			global_translate(Vector2(0,block_width))
			bugs()
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
	children = get_children()
	var pos
	var arr = Array()
	for i in children :
		#print(str(i)+": child_loc_off")
		pos = cord.adjust_vector(i.global_position.x,i.global_position.y)
		pos[0] += off_x
		pos[1] += off_y
		arr.append(pos)
	return arr
func check_left():
	#print("check Left")
	var test = child_loc_off(-1,0)
	for i in test:
		if(!get_parent().empty_dest(i)):
			return false
	return true
func check_right():
	#print("check right")
	var test = child_loc_off(1,0)
	for i in test:
		if(!get_parent().empty_dest(i)):
			return false
	return true
func check_down():
	#print("check down")
	var test = child_loc_off(0,1)
	for i in test:
		if(!get_parent().empty_dest(i)):
			#printChi()
			get_parent().spawn_rand()
			add_to_parrent()
			active = false
			get_parent().row_clear()
			return false
	return true
func check_rotate_right():
	##TODO
	return true
func check_rotate_left():
	##TODO
	return true
func check_rotate(roTo):
	
	return true
	
func pre_def_rotation(roTo):
	var pos = 0
	var new_cords = translate_cords(rotation_array[roTo],[center_child.x,center_child.y])###x and y needs to be fixed TODO
	for child in children:
		if child != center_child:
			
			pos+=1
	pass
	
func translate_cords(globe, center):
	return Array()
func add_to_parrent():
	var childs = child_loc()
	for i in childs:
		#print(str(i[0]," ",i[1]))
		get_parent().squares.append(i)
		#print("printing_squares")
		#get_parent().print_squares()
func bugs():
	get_parent().debug_me(child_loc())
	pass
	
func init_rotational_properties():
	pass#set cotation array depending on block name, Set rotation num
