extends Button
class_name ItemSlotButton

var item_data: ItemData
var inventory: InventoryData

@onready var label: Label = $ItemLabel

func _ready():
	if not pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)	
		
func setItem(item: ItemData):
	item_data = item
	label.text = item.item_name + " (" + rarityToString(item.rarity) + ")"
	label.modulate = item.getColor()


func _on_pressed():
	if item_data and inventory:
		inventory.removeItem(item_data)
		

func rarityToString(rarity: int) -> String:
	match rarity:
		0: return "Common"
		1: return "Rare"
		2: return "Epic"
		3: return "Legendary"
	return "Unknown"
