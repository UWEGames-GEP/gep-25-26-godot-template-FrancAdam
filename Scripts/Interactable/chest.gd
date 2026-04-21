extends StaticBody3D

@export var player_template: CharacterBody3D 
@onready var chest_inventory_ui: CanvasLayer = $ChestInventoryUI
@onready var range: CollisionShape3D = $Range

signal chest_changed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	player_template.chest_state_changed.connect(openInventory)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func openInventory():
	if chest_inventory_ui.visible == false:
		chest_inventory_ui.visible = true
		chest_changed.emit()
	else:
		closeInventory()
	
func closeInventory():
	chest_inventory_ui.visible = false
	chest_changed.emit()
