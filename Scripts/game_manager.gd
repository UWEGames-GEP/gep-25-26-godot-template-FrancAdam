extends Node
# @onready var inventoryUI = get_node("path_to_the_node") -> to access other scripts

enum GameState{
	GAMEPLAY,
	PAUSE
}
var current_game_state
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_game_state = GameState.GAMEPLAY
	process_mode = Node.PROCESS_MODE_ALWAYS # this makes sure that _process runs even when the game is paused

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if (event.is_action_pressed("Pause")):
		pause()
			
		print(current_game_state) #debug -> 0=GAMEPLAY 1=PAUSE


func pause():
	match current_game_state:
		GameState.GAMEPLAY:
			current_game_state = GameState.PAUSE
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			print("Game Paused")
		GameState.PAUSE:
			current_game_state = GameState.GAMEPLAY
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			print("Game Unpaused")
