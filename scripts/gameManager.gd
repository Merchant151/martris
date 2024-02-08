extends Node
const window_x = 600
const window_y = 900
const left_bound = -10
const right_bound = 10
const bottom_bound=33 

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
	cords = cordinate.new()
	squares.append([256,256])# Replace with function body.
	#print(str(get_viewport().size))
	var view = get_window()
	#print(str(typeof(get_viewport())))
	var v = Vector2i(window_x,window_y)
	view.set_size(v)
	
	#print(view.get_size())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_key_pressed(KEY_P)):
		#print("spawning?")
		del_row(31)
	pass
	#if(Input.is_action_just_pressed("tetris_left")):
	#	print("left pressed")
	#if(Input.is_action_just_pressed("tetris_right")):
	#	print("right pressed")

func new_square(sq): 
	squares.append(sq)

func remove_row() :
	pass
func print_squares():
	for i in squares:
		print(str(i[0]," ",i[1]))
	
func empty_dest(pos):
	#print_squares()
	for i in squares:
		if(i[0] == pos[0] && i[1] == pos[1]):
			print(str("hit square at (",i[0]," , ",i[1],")"))
			print("hit square")
			return false
		#elif(pos[1] == i[1]):
			#print("bottom square")
			#return false
	if(pos[0] <= left_bound || pos[0] >= right_bound):
		print("left or right boundry")
		return false
	elif(pos[1] == bottom_bound):
		print("bottom boundry")
		return false
	else:
		#print("true")
		return true

func spawn_rand():
	#var test = load("res://Shapes/yellow_shape.tscn")
	var rng = RandomNumberGenerator.new()
	var num = rng.randi_range(0, 5)
	#print(str("spawning",prefabs[num]))
	var child = prefabs[num].instantiate()
	add_child(child)
	var vec = Vector2(5803,-9675)
	child.set_global_position(vec)
	
func debug_me(potato):
	print("========")
	debug.live_board(squares,potato)	

func row_clear():
	var row_len = right_bound - left_bound
	for row in range(0,bottom_bound):
		var x_count = 0
		for collumn in range(left_bound,right_bound):
			for i in squares:
				if (i[0]==collumn&&i[1]==row):
					x_count += 1
		if x_count == row_len:
			del_row(row)
			print(str("del row: ",row))

func del_row(row):
	del_grid_row(row)
	var LB=cords.dejust_x(left_bound+1)
	var RB=cords.dejust_x(right_bound-1)
	var y = cords.dejust_y(row)
	print("searching for cord: " + str(y))
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
			if(slipperies.global_position.x >= LB&&slipperies.global_position.x <= RB&&slipperies.global_position.y == y+25):
				#print(str(slipperies)+"passed")
				kill_the_child(slipperies)
				pass
			pass
		
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
	pass
