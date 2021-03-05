extends SceneTree

var _utils = load('res://addons/gut/utils.gd').new()
# created from print_common_instanced_methods
var common_methods = [
"free",
"_notification",
"_set",
"_get",
"_get_property_list",
"_init",
"_to_string",
"get_class",
"is_class",
"set",
"get",
"set_indexed",
"get_indexed",
"get_property_list",
"get_method_list",
"notification",
"to_string",
"get_instance_id",
"set_script",
"get_script",
"set_meta",
"remove_meta",
"get_meta",
"has_meta",
"get_meta_list",
"add_user_signal",
"has_user_signal",
"emit_signal",
"call",
"call_deferred",
"set_deferred",
"callv",
"has_method",
"has_signal",
"get_signal_list",
"get_signal_connection_list",
"get_incoming_connections",
"connect",
"disconnect",
"is_connected",
"set_block_signals",
"is_blocking_signals",
"property_list_changed_notify",
"set_message_translation",
"can_translate_messages",
"tr",
"is_queued_for_deletion",]

var db_classes = {}

var bad_ones = [
	"Object",
	"GDScriptNativeClass",
	"Physics2DDirectSpaceStateSW",
	"BulletPhysicsDirectSpaceState"
]

var missing_singletons = [
	"ClassDB",
	"EditorNavigationMeshGenerator",
	"GodotSharp",
]


func get_instanced_ClassDB_classes(invert=false):
	var classes = ClassDB.get_class_list()

	# these blow up when used with get_singleton_by_name

	var instanced = []
	for c in classes:
		# in addition to the bad_ones, anything that starts with "_" blows
		# up in get_singleton_by_name
		if(bad_ones.has(c)):
			print("skip ", c)
		else:
			# Anything that starts with an underscore appears to exist as
			# a keyword without the undrescore.
			if(c.substr(0, 1) == "_"):
				c = c.substr(1)
			var inst = _utils.get_singleton_by_name(c)
			var is_inst = _utils.is_instance(inst)
			if(is_inst or !is_inst and invert):
				instanced.append([c, inst])

	return instanced

func print_other_info(loaded):
	print('---------------------------------')
	print(loaded)
	#print('path = ', loaded.get_path())
	# if(loaded.get_base_script() != null):
	# 	print('base script path = ', loaded.get_base_script().get_path())
	# else:
	# 	print('NO base_script')
	print('class = ', loaded.get_class())
	print("meta:\n", loaded.get_meta_list())


func print_class_db_info(name="Node2D"):
	if(!ClassDB.class_exists(name)):
		name = "_" + name
	#print("ClassDB for ", name)
	print("  exists = ", ClassDB.class_exists(name))
	if(!ClassDB.class_exists(name)):
		return
	print("  can instance = ", ClassDB.can_instance(name))
	print('  category = ',  ClassDB.class_get_category(name))
	print("  endabled = ", ClassDB.is_class_enabled(name))


func print_instanced_info():
	var instanced = get_instanced_ClassDB_classes()
	for i in instanced:
		print(i[0])
		print_other_info(i[1])
		print_class_db_info(i[0])
		print()


func print_common_instanced_methods():
	var instanced = get_instanced_ClassDB_classes()
	var counter = _utils.OneToMany.new()
	for inst in instanced:
		var methods = inst[1].get_method_list()
		for method in methods:
			counter.add(method["name"], inst[0])

	for key in counter._items:
		if(counter._items[key].size() == instanced.size()):
			print(key)


# finds none, they are the same.
func print_missing_common_methods_in_non_instanced_methods():
	var nons = get_instanced_ClassDB_classes(true)
	var missing = _utils.OneToMany.new()

	for n in nons:
		var methods = n[1].get_method_list()
		var method_names = []
		for m in methods:
			method_names.append(m["name"])

		for c in common_methods:
			if(!method_names.has(c)):
				missing.add(c, n[0])

	for key in missing._items:
		if(missing._items[key].size() == nons.size()):
			print(key)


func sort_and_print_array(a):
	a.sort()
	for item in a:
		print(item)


func print_bad_ones_info():
	for b in bad_ones:
		print(b, "\n-------")
		print_class_db_info(b)
		print()



func main():
	#print_common_instanced_methods()
	#print_missing_common_methods_in_non_instanced_methods()
	#print_instanced_info()
	#print_bad_ones()
	#sort_and_print_array(Array(ClassDB.get_class_list()))
	for missing in missing_singletons:
		var inst = _utils.get_singleton_by_name(missing)
		print(missing, ":  ", inst)





func _init():
	main()
	_utils.free()
	quit()



