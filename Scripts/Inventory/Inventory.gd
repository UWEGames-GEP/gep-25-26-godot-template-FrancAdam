extends Node
class_name Inventory

#@onready var inventoryUI = get_node("GameManager")

@export var items : Array[ItemData] = [] #@export is equivalent of [serialized field] in Unity

enum SortOrder{
	Ascending,
	Descending
}

var sord_order : SortOrder = SortOrder.Ascending
var last_sort := 0


func addItem(item: ItemData) -> void:
	items.append(item)
	print("Added item:", item.item_name)
	var inventory_size = items.size()
	print("inventory size: " + str(inventory_size))

func removeItem(item: ItemData) ->void:
	# spawn back into world
	# inventory is a child of player
	var player = get_parent()
	var spawn_pos = player.global_transform.origin + player.transform.basis.z * -1 + Vector3.UP # position in front of player
	
	var instance = item.scene.instantiate() # initiate node
	instance.global_transform.origin = spawn_pos # set position
	
	get_tree().current_scene.add_child(instance) # sets the instance as a child of the current scene
	
	items.erase(item) # equivalent of .remove() from Unity

func removeFirst():
	if items.size() > 0:
		removeItem(items[0])
