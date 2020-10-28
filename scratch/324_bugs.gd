extends SceneTree

class Faker:
	var a = 'a'

class HasStubber:
	var stubber = load('res://addons/gut/stubber.gd').new()

var Doubler  = load('res://addons/gut/doubler.gd')
var _utils =  load('res://addons/gut/utils.gd').new()

func make_script(text):
	var script = GDScript.new()
	script.set_source_code(text)
	script.reload()
	return script

func make_thing_with_ref(ref_this):
	var code = str('var the_ref = instance_from_id(', ref_this.get_instance_id(), ')')
	return make_script(code).new()

func see_if_it_works():
	var thing = Node2D.new()
	var ref = make_thing_with_ref(thing)
	print(thing == ref.the_ref)

	var test = load('res://addons/gut/test.gd').new()
	test.assert_eq(thing, ref.the_ref)
	print(test._fail_pass_text[0])

	thing.free()
	test.free()

func  test_something(ref_this):
	var _base_script_text = _utils.get_file_as_text('res://addons/gut/double_templates/script_template.txt')
	var id = ref_this.get_instance_id()
	var values = {
		"path":'asdf',
		"subpath":'obj_info.get_subpath()',
		"stubber_id":ref_this.stubber.get_instance_id(),
		"spy_id":id,
		"extends":'',
		"gut_id":-1
	}

	var code = _base_script_text.format(values)
	print(code)
	var loaded  = make_script(code).new()
	print(loaded.__gut_metadata_.stubber == ref_this.stubber)

	var test = load('res://addons/gut/test.gd').new()
	test.assert_eq(loaded.__gut_metadata_.stubber, ref_this.stubber)
	print(test._fail_pass_text[0])


func _init():
	test_something(HasStubber.new())
	quit()