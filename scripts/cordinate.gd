extends Node2D

class_name cordinate
#these will be the offset vars for cordinate calls
var unit = 625
var remain_x = 178
var remain_y = 300
var offset_x = -9
var offset_y = 15


func adjust_x(x: int):
	var ans = (x - remain_x)/unit + offset_x
	return ans

func adjust_y(y: int):
	var ans = (y - remain_y)/unit + offset_y
	return ans
	
func adjust_vector(x,y):
	var ans = Array()
	ans.append((x - remain_x)/unit - offset_x)
	ans.append((y - remain_y)/unit - offset_y)
	return ans
