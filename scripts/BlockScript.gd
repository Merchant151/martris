extends Node2D

var cord = cordinate.new()
var count = 0
var double_count = 0
var waiter = 0
var block_width = 625
var step_time = 0.5
var step_two = 0.05
var active : bool
var children
var left_press = false
var right_press = false
var down_press = false
#rotational properties
var parent = 0 # used to determine the rotation set
var rotation_array
var rotation_state = 0
var rotation_num  = 1
var center_child

var ALL_ROT_SETS = [
[[[0,-1],[0,1],[1,1]],[[-1,0],[1,0],[1,-1]],[[0,1],[0,-1],[-1,-1]],[[1,0],[-1,0],[-1,1]]],#TAN THIS PROCESS WAS EXTREEMLY TEDIOUS SO GLAD I SPENT HOURS DOING SOMTHING BY HAND THAT WOULD HAVE TAKEN ONLY AN HOUR TO LEARN HOW TO DO WITH MATH
[[[-1,0],[1,0],[0,-1]],[[0,1],[0,-1],[-1,0]],[[1,0],[-1,0],[0,1]],[[0,-1],[0,1],[1,0]]],#BLUE
[[[0,-1],[-1,-1],[1,0]],[[-1,0],[-1,1],[0,-1]],[[0,1],[1,1],[-1,0]],[[1,0],[1,-1],[0,1]]],#GREEN
[[[0,-1],[0,1],[-1,1]],[[-1,0],[1,0],[1,1]],[[0,1],[0,-1],[1,-1]],[[1,0],[-1,0],[-1,-1]]],#PURPLE
[[[-1,0],[0,-1],[-1,-1]]],#RED
[[[0,-1],[0,1],[0,-2]],[[-1,0],[1,0],[2,0]]],#YELLOW
[[[0,-1],[1,-1],[-1,0]],[[-1,0],[-1,-1],[0,1]],[[0,1],[1,0],[-1,1]],[[1,0],[0,-1],[1,1]]]#VOMIT
] # I just realized there is a way to calculate the sign changes without writing in all of these in. (i forget what the operation is called but it comes from trig)
#var position = vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE #should make this pausible because parrent isn't
	active = true
	children = get_children()
	init_rotational_properties()
	rotation_array = [0]
	load_rotation_set(2)
	#printChi()

func load_rotation_set(x):
	parent = x
	var par_string
	match parent:
		0:
			par_string = "TestBlockBlack4"
			rotation_array = ALL_ROT_SETS[0]
			rotation_num = 3
		1:
			par_string = "TestBlockBlack2"
			rotation_array = ALL_ROT_SETS[1]
			rotation_num = 3
		2:
			par_string = "TestBlock3"
			rotation_array = ALL_ROT_SETS[2]
			rotation_num = 3
		3:
			par_string = "TestBlockBlack4"
			rotation_array = ALL_ROT_SETS[3]
			rotation_num = 3
		4:
			par_string = "TestBlockBlack3"
			rotation_array = ALL_ROT_SETS[4]
			rotation_num = 0
		5:
			par_string = "TestBlockBlack4"
			rotation_array = ALL_ROT_SETS[5]
			rotation_num = 1
		6:  
			par_string = "TestBlockBlack"
			rotation_array = ALL_ROT_SETS[6]
			rotation_num = 3
	set_center_child(par_string)
func set_center_child(ch_name:String):
	#print(ch_name)
	for node in children:
		#print(node)
		if str(node).begins_with(ch_name):
			#print("set")
			center_child = node
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += delta
	double_count += delta
	if left_press || right_press || down_press : waiter += delta
	#var adj_x = cord.adjust_x(global_position.x)
	#var adj_y = cord.adjust_y(global_position.y)
	#print(str("(",adj_x,", ",adj_y,")"))
	if(Input.is_action_just_pressed("tetris_left")):
		if(check_left()&&active):
			left_press = true
			global_translate(Vector2(-block_width,0))
			bugs()
	elif(Input.is_action_just_released("tetris_left")):
			left_press = false
			waiter = 0
	if(left_press && active):
		if(check_left() && waiter >= 0.5 && double_count >= step_two ):
			global_translate(Vector2(-block_width,0))
			bugs()
			double_count = 0 
	if(Input.is_action_just_pressed("tetris_right")):
		if(check_right()&&active):
			right_press = true
			global_translate(Vector2(block_width,0))
			bugs()
	elif(Input.is_action_just_released("tetris_right")):
			right_press = false
			waiter = 0
	if(right_press && active):
		if(check_right() && waiter >= 0.5 && double_count >= step_two ):
			global_translate(Vector2(block_width,0))
			bugs()
			double_count = 0 
	if(Input.is_action_just_pressed("rotate_left")&&rotation_num > 0&&active):
		var roTo = rotation_state
		if(rotation_state == rotation_num):
			roTo = 0
		else:
			roTo +=1
		#print(roTo)
		pre_def_rotation(roTo)
		#if(check_rotate(roTo)&&active):
			#rotate(1.57079)
		bugs()
	if(Input.is_action_just_pressed("rotate_right")&&rotation_num > 0&&active):
		var roTo = rotation_state
		if(rotation_state == 0):
			roTo = rotation_num
		else:
			roTo -=1
		pre_def_rotation(roTo)
		#if(check_rotate(roTo)&&active):
			#rotate(1.57079)
		bugs()
	if(Input.is_action_just_pressed("drop")&&active):
		step_time = 0.01
	if(Input.is_action_just_pressed("down")&&active):
		if(check_down()&&active):
			down_press = true
			global_translate(Vector2(0,block_width))
			bugs()
	elif(Input.is_action_just_released("down")):
		down_press = false
		waiter = 0
	if(down_press && active):
		if(check_down() && waiter >= 0.5 && double_count >= step_two ):
			global_translate(Vector2(0,block_width))
			bugs()
			double_count = 0 
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
	return true
func check_rotate_left():
	##TODO
	return true
func check_rotate(roTo):
	
	return true
	
func pre_def_rotation(roTo):
	var pos = 0
	var new_cords = translate_cords(rotation_array[roTo],[center_child.global_position.x,center_child.global_position.y])#took me a while to figure out I needed the duplicate function here
	if !check_cords(new_cords):
		print("fail")
		return
	print("pass")
	for child in children:
		if child != center_child:
			child.global_position = Vector2 (new_cords[pos][0],new_cords[pos][1])
			pos+=1
	rotation_state = roTo
	
func translate_cords(globe, center):
	#globe = [[-1,0],[1,0],[2,0]] #setting it for now this can be commented out
	#multiply glob
	var final_globe = globe.duplicate(true)#solved by reubs thanks
	print(center)
	#print(str(rotation_array)+"ROT_ARR 1")
	#print(str(globe)+"GLOBE 1")
	for pods in final_globe:
		#print(str(pods)+"pod1")
		pods[0] = pods[0]*block_width
		pods[1] = pods[1]*block_width
		#translation
		pods[0] = pods[0] + center[0]
		pods[1] = pods[1] + center[1]
		#print(str(pods)+"pods2")
	#print(str(globe)+"GLOBE 2")
	#print(str(rotation_array)+"ROT_ARR 2")
	
	return final_globe
func add_to_parrent():
	var childs = child_loc()
	for i in childs:
		#print(str(i[0]," ",i[1]))
		get_parent().squares.append(i)
		#print("printing_squares")
		#get_parent().print_squares()
func bugs():
	#get_parent().debug_me(child_loc())
	pass
	
func init_rotational_properties():
	pass#set cotation array depending on block name, Set rotation num
func check_cords(cords):
	var pos
	var arr = Array()
	for i in cords :
		pos = cord.adjust_vector(i[0],i[1])
		arr.append(pos)
	for i in arr:
		if(!get_parent().empty_dest(i)):
			return false
	return true
