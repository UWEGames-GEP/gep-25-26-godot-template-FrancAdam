extends CanvasLayer

# allows to drag in a instance of invenotry data in editor
@export var inventory: InventoryData 
# defers the initialization of a member variable until the ready function is called
@onready var items_list: VBoxContainer = $Panel/VBoxContainer/ItemsList
const Slot = preload("res://GEP Core/UI/ItemSlotButton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory.inventory_updated.connect(refreshUI)
	refreshUI()

func refreshUI() -> void: 
	# clear old items
	for child in items_list.get_children():
		child.queue_free()
		
	# add each item back
	for item in inventory.items:
		var slot = Slot.instantiate()
		items_list.add_child(slot)
		slot.setItem(item)
		slot.inventory = inventory
		
