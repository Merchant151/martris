extends Label
var active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#text = "new text???"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if(!active&&Input.is_action_just_pressed("test_x")):
	#	print("show")
	#	show()
	#	active = true
	#elif (active&&Input.is_action_just_pressed("test_x")):
	#	hide()
	#	print("hide")
	#	active = false
	pass

func set_score(x):
	
	text = "Score " + str(x)
	print("FOO BAR FOO")
	#text ="score"
	#text = "Score" + String(x)
	#score = x 
	
