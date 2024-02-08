extends Node
class_name debugger

var live_shapes

var row_x_start=-10
var row_x_end = 10
var row_y_end = 33
var row_y_start=0
# Called when the node enters the scene tree for the first time.
func _ready():
	#print_cords(arr)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func print_cords(arr):
	var constructed = construct_row_strings(arr)
	#var row_string = " [ ][ ] "
	var new_line = "\n"
	var border = " ================== "
	print(str(constructed,new_line,border))

func construct_row_strings(cords):
	var grid_strings = ""
	for y in range(row_y_start,row_y_end):
		#rint("constructing y: "+ str(y))
		for x in range(row_x_start+1,row_x_end):
			#rint("constructing x: "+ str(x))
			var empty = true
			var collision = 0
			for i in cords:
				#print(str(cords)
				
				if(x==i[0]&&y==i[1]):
					collision+=1
					empty = false
			if(empty == true):
				grid_strings += "[ ]"
			elif(collision>1):
				grid_strings += "[C]"
				push_error("you have a collision at: "+str(x," , ",y))
			else:
				grid_strings += "[X]"
		grid_strings += "\n"
	return grid_strings

func live_board(die,live):
	live_shapes = live
	for i in die: 
		live_shapes.append(i)
	print_cords(live_shapes)
	
