extends Resource
class_name ItemData

enum ItemRarity{
	COMMON,
	RARE,
	EPIC,
	LEGENDARY
}

# setup default values for each item
@export var item_name : String = "Default_Name"
@export var pickupable : bool
@export var rarity : ItemRarity
@export var scene : PackedScene
