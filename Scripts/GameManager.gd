extends Node
class_name GameManager

enum GameState{
	GAMEPLAY,
	PAUSE
}
var current_game_state
@export var chest: StaticBody3D
@onready var inventory_ui: CanvasLayer = $"../InventoryUi"
@onready var chest_inventory_ui: CanvasLayer = $"../Chest/ChestInventoryUI"
@onready var paused_ui: CanvasLayer = $"../PausedUI"
var inventory_opened := false
signal inventory_state_changed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_game_state = GameState.GAMEPLAY
	process_mode = Node.PROCESS_MODE_ALWAYS # this makes sure that _process runs even when the game is paused
	#chest.chest_opened.connect(mouseEnable)
	#chest.chest_closed.connect(mouseDisable)
	chest.chest_changed.connect(openInventory)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if (event.is_action_pressed("Pause")):
		pause()
	if (event.is_action_pressed("OpenInventory")):
		if current_game_state == GameState.GAMEPLAY:
			openInventory()
			
			
		print(current_game_state) #debug -> 0=GAMEPLAY 1=PAUSE


func pause():
	match current_game_state:
		GameState.GAMEPLAY:
			current_game_state = GameState.PAUSE
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			paused_ui.visible = true
			print("Game Paused")
		GameState.PAUSE:
			current_game_state = GameState.GAMEPLAY
			get_tree().paused = false
			paused_ui.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			print("Game Unpaused")

func openInventory():
	match inventory_ui.visible:
		false:
			inventory_ui.visible = true
		true:
			inventory_ui.visible = false
			if chest_inventory_ui.visible:
				chest_inventory_ui.visible = false
	updateMouseState()


func updateMouseState():
	var any_open = inventory_ui.visible or chest_inventory_ui.visible
	if any_open:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	inventory_state_changed.emit()
