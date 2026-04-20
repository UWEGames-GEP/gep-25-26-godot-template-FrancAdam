extends Node
class_name InventoryData

#@onready var inventoryUI = get_node("GameManager")

@export var items : Array[ItemData] = [] #@export is equivalent of [serialized field] in Unity

signal inventory_updated

func addItem(item: ItemData) -> void:
	items.append(item)
	print("Added item:", item.item_name)
	var inventory_size = items.size()
	print("inventory size: " + str(inventory_size))
	inventory_updated.emit()

func removeItem(item: ItemData) ->void:
	# spawn back into world
	# inventory is a child of player
	var player = $"../mannequiny-0_4_0"
	var forward = player.global_transform.basis.z
	var spawn_pos = player.global_transform.origin + forward * 2 + Vector3.UP # position in front of player

	
	var instance = item.scene.instantiate() # initiate node
	instance.global_transform.origin = spawn_pos # set position
	
	instance.item_data = item # sets its item data
	
	# adds the item back into the world under the node ItemObject
	get_tree().current_scene.get_node("ItemObject").add_child(instance) 
	
	# removes the spawned item from the items array
	items.erase(item) # equivalent of .remove() from Unity
	
	#debug
	print(str(item.item_name) + " (" + str(item.rarity) + ") removed from inventory")
	inventory_updated.emit()

func removeFirst():
	if items.size() > 0:
		removeItem(items[0])
		
		
func _input(event):
	if (event.is_action_pressed("G")):
		removeFirst()
	if (event.is_action_pressed("H - Print array")):
		for item in items:
			print(item.item_name)
