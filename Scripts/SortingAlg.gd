extends Node
const TEST_INVENTORY = preload("res://GEP Core/Items/test_inventory.tres")
const ItemData = preload("res://Scripts/Inventory/ItemData.gd")

#enum SortType{
	#BUBBLE,
	#INSERT
#}
#var last_sort:= SortType.BUBBLE

func _ready() -> void:
	print("before: ")
	printArr(TEST_INVENTORY.InventoryArray)
	insertion_sort(TEST_INVENTORY.InventoryArray, 1)
	print("after: ")
	printArr(TEST_INVENTORY.InventoryArray)

#debug
func printArr(arr: Array):
	for i in arr:
		print(i.item_name)

# simple sort that sorts the array alphabetically
func bubble_sort(arr : Array, sort_order : bool):
	var n = arr.size()
	var swapped: bool
	
	for i in range(n - 1):
		swapped = false
		for j in range(n-i-1):
			match sort_order:
				false: #Ascending
					if arr[j].item_name > arr[j+1].item_name:
						var temp: ItemData = arr[j]
						arr[j] = arr[j+1]
						arr[j+1] = temp
						swapped = true
				true: #Descending
					if arr[j].item_name < arr[j+1].item_name:
						var temp: ItemData = arr[j]
						arr[j] = arr[j+1]
						arr[j+1] = temp
						swapped = true
		if !swapped:
			break
			
func insertion_sort(arr: Array, sort_order : bool):
	var n = arr.size()
	
	for i in range(n):
		var key: ItemData = arr[i]
		var j = i - 1
		match sort_order:
			false:
				while j >= 0 && arr[j].rarity > key.rarity:
					arr[j + 1] = arr[j]
					j = j - 1
				arr[j + 1] = key
			true:
				while j >= 0 && arr[j].rarity < key.rarity:
					arr[j + 1] = arr[j]
					j = j - 1
				arr[j + 1] = key
	
