extends Node
const window_x = 600
const window_y = 900
const left_bound = -10
const right_bound = 10
const bottom_bound=33 
var pause
var game_over
signal show()
signal show_pause()
signal show_end()
signal hide()
signal score(value)
var score_int
var num_clear

var prefabs = [
load("res://Shapes/tan_shape.tscn"),
load("res://Shapes/blue_shape.tscn"),
load("res://Shapes/green_shape.tscn"),
load("res://Shapes/Purple_shape.tscn"),
load("res://Shapes/red_shape.tscn"),
load("res://Shapes/yellow_shape.tscn")]

var squares = Array()
var debug = debugger.new()
var cords

# Called when the node enters the scene tree for the first time.
func _ready():
	num_clear = 0
	var ready_msg = get_node("Ui/a/v/h/menu/Restart")
	var pause_msg = get_node("Ui/a/v/h/menu/Pause")
	var end_msg   = get_node("Ui/a/v/h/menu/GameOver")
	var score_tag = get_node("Ui2/MarginContainer/VBoxContainer/menuBox/Score") 
	if !show.is_connected(ready_msg.show_tip):
		show.connect(ready_msg.show_tip)
	if !show_pause.is_connected(ready_msg.show_tip):
		show_pause.connect(ready_msg.show_tip)
	if !show_end.is_connected(ready_msg.show_tip):
		show_end.connect(ready_msg.show_tip)
	if !hide.is_connected(ready_msg.hide_tip):
		hide.connect(ready_msg.hide_tip)
	if !show_pause.is_connected(pause_msg.show_tip):
		show_pause.connect(pause_msg.show_tip)
	if !show_end.is_connected(end_msg.show_tip):
		show_end.is_connected(end_msg.show_tip)
	if !hide.is_connected(pause_msg.hide_tip):
		hide.connect(pause_msg.hide_tip)
	if !hide.is_connected(end_msg.hide_tip):
		hide.connect(end_msg.hide_tip)
	if !score.is_connected(score_tag.set_score):
		score.connect(score_tag.set_score)
	
	score_int = 0
	score.emit(score_int)
	hide.emit()
	game_over = false
	process_mode = Node.PROCESS_MODE_ALWAYS # allows node to process durring pause
	cords = cordinate.new()
	squares.append([256,256])# Replace with function body.
	#print(str(get_viewport().size))
	var view = get_window()
	#print(str(typeof(get_viewport())))
	var v = Vector2i(window_x,window_y)
	view.set_size(v)
	spawn_rand()
	
	
	#print(view.get_size())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_action_just_pressed("esc")&& pause):
		print("unpaused")
		unpause_game()
	elif(Input.is_action_just_pressed("esc")&& !game_over):
		print("paused")
		pause_game()
	if(Input.is_action_just_released("restart")&& (game_over||pause)):
		_clear_all_blocks()
		_ready()
		unpause_game()
		print("x")
	pass

func pause_game():
	pause = true
	get_tree().paused = true
	show_pause.emit()
func unpause_game():
	pause = false
	get_tree().paused = false
	hide.emit()
func _end_game():
	game_over = true
	get_tree().paused = true
	show_end.emit()
#func show_pause():
#	pass
#func hide_pause():
#	pass

func new_square(sq): 
	squares.append(sq)

func remove_row() :
	pass
func print_squares():
	for i in squares:
		pass
		#print(str(i[0]," ",i[1]))
	
func empty_dest(pos):
	#print_squares()
	for i in squares:
		if(i[0] == pos[0] && i[1] == pos[1]):
			#print(str("hit square at (",i[0]," , ",i[1],")"))
			#print("hit square")
			return false
		#elif(pos[1] == i[1]):
			#print("bottom square")
			#return false
	if(pos[0] <= left_bound || pos[0] >= right_bound):
		print(str("hit boundry at (",pos[0]," , ",pos[1],")"))
		print("left or right boundry")
		return false
	elif(pos[1] == bottom_bound):
		print("bottom boundry")
		return false
	else:
		#print(str("pass boundry at (",pos[0]," , ",pos[1],")"))
		return true

func spawn_rand():
	#if check_active():
	#	return
	num_clear = 0
	#var test = load("res://Shapes/yellow_shape.tscn")
	var rng = RandomNumberGenerator.new()
	var num = rng.randi_range(0, 5)
	#print(str("spawning",prefabs[num]))
	var child = prefabs[num].instantiate()
	add_child(child)
	var vec = Vector2(5803,-9675)
	child.set_global_position(vec)
	child.load_rotation_set(num)
	
func check_active():
	var childs = get_children()
	for child in childs:
		if ("active" in child):
			if child.active == true:
				print("found active")
				return true
	
	return false
	
func debug_me(potato):
	print("========")
	debug.live_board(squares,potato)	

func row_clear():
	_out_of_bounds()
	#print("checking rows")
	var row_len = right_bound - left_bound -1
	#print("at row_LEN: "+str(row_len))
	for row in range(0,bottom_bound):
		#print("ROW :"+ str(row))
		var x_count = 0
		for collumn in range(left_bound,right_bound):
			for i in squares:
				if (i[0]==collumn&&i[1]==row):
					x_count += 1
		#print("ROW :"+ str(row)+" C: "+str(x_count))
		if x_count == row_len:
			del_row(row)
			num_clear = num_clear +1
			#print(str("del row: ",row))
	match num_clear:
		1:
			score_int = score_int + 50
		2:
			score_int = score_int + 100
		3: 
			score_int = score_int + 500
		4: 
			score_int = score_int + 1000
	score.emit(score_int)
	

func _out_of_bounds():
	for i in squares: 
		if (i[1] <= 0 ):
			print("Game Over")
			_end_game()

func del_row(row):
	del_grid_row(row)
	var LB=cords.dejust_x(left_bound+1)
	var RB=cords.dejust_x(right_bound-1)
	var y = cords.dejust_y(row)
	#print("searching for cord: " + str(y))
	#print("cord adjustment " + str(y+50))
	var shapes = get_children()
	var sckubes=Array()
	for shape in shapes:
		var scklroiop = shape.get_children()#give me a break on the var names im tired and I think its funny 
		for sKAckarak in scklroiop:
			sckubes.append(sKAckarak)
		#print(shape.get_child_count())
	#print(sckubes)
	for i in range(left_bound+1,right_bound-1):
		for slipperies in sckubes:
			#print(slipperies.global_position.y)
			#print("cord adjustment " + str(y+50))
			if(slipperies.global_position.x >= LB&&slipperies.global_position.x <= RB&&slipperies.global_position.y == y):
				#print(str(slipperies)+"passed")
				slipperies.get_parent().active = false
				kill_the_child(slipperies)
				pass
			pass
	move_down(row)

func kill_the_child(c):
	c.queue_free()
	pass
	
func del_grid_row(row): #deletes cordinates from the virtual grid
	var row_list = Array()
	for i in range(squares.size()):
		if (squares[i][1] == row):
			row_list.append(squares[i])
	for i in row_list:
		squares.erase(i)
	for i in range(squares.size()): ### I am moving the entire virtual grid blocks above (inverse y axis) the row down one 
		if(squares[i][1] < row):
			squares[i][1] += 1
func move_down(row):
	var LB=cords.dejust_x(left_bound+1)
	var RB=cords.dejust_x(right_bound-1)
	var y = cords.dejust_y(row)
	var all_shapes = get_children()
	for shape in all_shapes:
		if (shape.get_child_count() > 0):
			var blocks = shape.get_children()
			for block in blocks:
				if(block.global_position.x >=LB&&block.global_position.x <=RB&&block.global_position.y < y-25&&!block.get_parent().to_string().contains("Ui")):
					#print(block.get_parent().to_string())
					block.global_translate(Vector2(0,block.get_parent().block_width))
					pass
					#ADD MOVE CHILD DOWN

func _clear_all_blocks():
	for i in range(-4,33):
		del_row(i)
	
