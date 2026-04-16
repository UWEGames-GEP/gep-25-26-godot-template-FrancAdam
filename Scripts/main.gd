extends Node

@export var x := 2
var y: int = 3
var xy = 0
var aaa = "a"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello World")
	xy = xy + (x + y)
	print("x + y = " + str(xy))
	$Label.text = "Result: " + str(xy)
	$Label.modulate = Color.GREEN
	
	
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if (event.is_action_pressed("my_action")):
		$Label.modulate = Color.RED
	if (event.is_action_released("my_action")):
		$Label.modulate = Color.GREEN
	if (event.is_action_pressed("G")):
		xy += 20
		$Label.text = "Result: " + str(xy) #SKIBIDI
		$Label.position.x += 10
		
