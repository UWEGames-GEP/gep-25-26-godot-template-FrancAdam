extends CanvasLayer

# allows to drag in a instance of invenotry data in editor
@export var inventory: InventoryData 
# defers the initialization of a member variable until the ready function is called
@onready var items_list: VBoxContainer = $Panel/VBoxContainer/ItemsList
const Slot = preload("res://GEP Core/UI/ItemSlotButton.tscn")

@onready var alphabetical_sort_button: Button = $Panel/SortButtons/AlphabeticalSortButton
@onready var rarity_sort_button: Button = $Panel/SortButtons/RaritySortButton
@onready var sort_order_toggle: Button = $Panel/SortButtons/SortOrderToggle


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory.inventory_updated.connect(refreshUI)
	
	alphabetical_sort_button.pressed.connect(inventory.alphabeticalSort)
	rarity_sort_button.pressed.connect(inventory.raritySort)
	sort_order_toggle.pressed.connect(inventory.toggleSort)
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
		
