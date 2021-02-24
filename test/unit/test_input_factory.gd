extends "res://addons/gut/test.gd"


class TestCreateKeyEvents:
	extends "res://addons/gut/test.gd"

	var InputFactory = _utils.InputFactory

	func test_key_up_creates_event_for_key():
		var event = InputFactory.key_up(KEY_A)
		assert_is(event, InputEventKey, 'is InputEventKey')
		assert_eq(event.scancode, KEY_A)
		assert_false(event.pressed, "pressed")

	func test_key_up_converts_lowercase_string_to_scancode():
		var event = InputFactory.key_up('a')
		assert_eq(event.scancode, KEY_A)

	func test_key_up_converts_uppercase_string_to_scancode():
		var event = InputFactory.key_up('A')
		assert_eq(event.scancode, KEY_A)

	func test_key_down_creates_event_for_key():
		var event = InputFactory.key_down(KEY_B)
		assert_is(event, InputEventKey, 'is InputEventKey')
		assert_eq(event.scancode, KEY_B)
		assert_true(event.pressed, "pressed")

	func test_key_down_converts_lowercase_string_to_scancode():
		var event = InputFactory.key_down('z')
		assert_eq(event.scancode, KEY_Z)


class TestCreateActionEvents:
	extends "res://addons/gut/test.gd"

	var InputFactory = _utils.InputFactory

	func test_action_up_creates_correct_class():
		var e = InputFactory.action_up("foo", 1.0)
		assert_is(e, InputEventAction)

	func test_action_up_sets_properties():
		var e = InputFactory.action_up("foo", .5)
		assert_eq(e.action, "foo", "action name")
		assert_eq(e.pressed, false, "pressed")
		assert_eq(e.strength, .5, 'strength')

	func test_action_up_defaults_strength():
		var e = InputFactory.action_up("foo")
		assert_eq(e.strength, 1.0)


	func test_action_down_creates_correct_class():
		var e = InputFactory.action_down("foo", 1.0)
		assert_is(e, InputEventAction)

	func test_action_down_sets_properties():
		var e = InputFactory.action_down("foo", .5)
		assert_eq(e.action, "foo", "action name")
		assert_eq(e.pressed, true, "pressed")
		assert_eq(e.strength, .5, 'strength')

	func test_action_down_defaults_strength():
		var e = InputFactory.action_down("foo")
		assert_eq(e.strength, 1.0)


class TestMouseButtons:
	extends "res://addons/gut/test.gd"

	var InputFactory = _utils.InputFactory

	func assert_mouse_event_props(method, pressed, button_index):
		var event = InputFactory.call(method, (Vector2(10, 10)))
		assert_is(event, InputEventMouseButton, 'correct class')
		assert_eq(event.position, Vector2(10, 10), 'position')
		assert_eq(event.pressed, pressed, 'pressed')
		assert_eq(event.button_index, button_index, 'button_index')

	func assert_mouse_event_positions(method):
		var event = InputFactory.call(method, Vector2(10, 10), Vector2(11, 11))
		assert_eq(event.position, Vector2(10, 10), "position")
		assert_eq(event.global_position, Vector2(11, 11), "global position")

	func test_lmb_down():
		assert_mouse_event_props("mouse_left_button_down", true, BUTTON_LEFT)
		assert_mouse_event_positions("mouse_left_button_down")

	func test_lmb_up():
		assert_mouse_event_props("mouse_left_button_up", false, BUTTON_LEFT)
		assert_mouse_event_positions("mouse_left_button_up")

	func test_double_clickk():
		assert_mouse_event_props("mouse_double_click", false, BUTTON_LEFT)
		assert_mouse_event_positions("mouse_double_click")
		var event = InputFactory.mouse_double_click(Vector2(1, 1))
		assert_true(event.doubleclick, "double click")

	func test_rmb_down():
		assert_mouse_event_props("mouse_right_button_down", true, BUTTON_RIGHT)
		assert_mouse_event_positions("mouse_right_button_down")

	func test_rmb_up():
		assert_mouse_event_props("mouse_right_button_up", false, BUTTON_RIGHT)
		assert_mouse_event_positions("mouse_right_button_up")