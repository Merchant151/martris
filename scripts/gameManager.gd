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

# Called when the node enters the scene tree for the first time.
func _ready():
	squares.append([256,256])# Replace with function body.
	#print(str(get_viewport().size))
	var view = get_window()
	#print(str(typeof(get_viewport())))
	var v = Vector2i(window_x,window_y)
	view.set_size(v)
	
	#print(view.get_size())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if(Input.is_key_pressed(KEY_P)):
		#print("spawning?")
		#spawn_rand()
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
			print("left or right square")
			return false
		elif(pos[1] == i[1]):
			print("bottom square")
			return false
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
	print(str("spawning",prefabs[num]))
	var child = prefabs[num].instantiate()
	add_child(child)
	var vec = Vector2(5803,-9675)
	child.set_global_position(vec)
	
	


