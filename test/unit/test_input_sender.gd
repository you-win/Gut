extends "res://addons/gut/test.gd"


class HasInputEvents:
	extends Control

	var input_event = null
	var gui_event = null
	var unhandled_event = null

	func _input(event):
		input_event = event
	func _gui_input(event):
		gui_event = event
	func _unhandled_input(event):
		unhandled_event = event


class MissingGuiInput:
	extends Node

	var input_event = null
	var unhandled_event = null

	func _input(event):
		input_event = event
	func _unhandled_input(event):
		unhandled_event = event

class InputTracker:
	extends Node
	var inputs = []
	var input_frames = []

	var _frame_counter = 0

	func _process(delta):
		_frame_counter += 1

	func _input(event):
		inputs.append(event)
		input_frames.append(_frame_counter)

class TestTheBasics:
	extends "res://addons/gut/test.gd"

	var InputSender = _utils.InputSender

	func test_can_make_one():
		assert_not_null(InputSender.new())

	func test_add_receiver():
		var sender = InputSender.new()
		var r = autofree(Node.new())
		sender.add_receiver(r)
		assert_eq(sender.get_receivers(), [r])

	func test_can_init_with_a_receiver():
		var r = autofree(Node.new())
		var sender = InputSender.new(r)
		assert_eq(sender.get_receivers(), [r])


class TestSendEvent:
	extends "res://addons/gut/test.gd"

	var InputSender = _utils.InputSender


	func test_sends_event_to_input():
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)
		var event = InputEventKey.new()
		sender.send_event(event)
		assert_eq(r.input_event, event)

	func test_sends_event_to_gui_input():
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)
		var event = InputEventKey.new()
		sender.send_event(event)
		assert_eq(r.gui_event, event)

	func test_sends_event_to_unhandled_input():
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)
		var event = InputEventKey.new()
		sender.send_event(event)
		assert_eq(r.unhandled_event, event)

	func test_sends_event_to_multiple_receivers():
		var r1 = autofree(HasInputEvents.new())
		var r2 = autofree(HasInputEvents.new())
		var sender = InputSender.new(r1)
		sender.add_receiver(r2)

		var event = InputEventKey.new()
		sender.send_event(event)

		assert_eq(r1.input_event, event)
		assert_eq(r2.input_event, event)

	func test_works_if_gui_event_missing():
		var r = autofree(MissingGuiInput.new())
		var sender = InputSender.new(r)
		var event = InputEventKey.new()
		sender.send_event(event)
		pass_test("we got here")

	func test_works_if_no_input_methods_exist_on_object():
		var r = Reference.new()
		var sender = InputSender.new(r)
		var event = InputEventKey.new()
		sender.send_event(event)
		pass_test("we got here")

	func test_sends_events_to_Input():
		var sender = InputSender.new(Input)
		# not a receiver, in the tree so Input will send events it gets with
		# parse_input_event to _input and _unhandled_input
		var thing = HasInputEvents.new()
		add_child_autofree(thing)

		var event = InputEventKey.new()
		event.pressed = true
		event.scancode = KEY_Y
		sender.send_event(event)

		#yield(yield_for(.1), YIELD)
		assert_true(Input.is_key_pressed(KEY_Y), 'is_pressed')

		# illustrate that sending events to Input will also cause _input
		# and _unhandled_inpu to fire on anything in the tree.
		assert_eq(thing.input_event, event, '_input event')
		assert_eq(thing.unhandled_event, event, '_unhandled event')
		assert_null(thing.gui_event, 'gui event')


class TestCreateKeyEvents:
	extends "res://addons/gut/test.gd"

	var InputSender = _utils.InputSender

	func test_key_up_creates_event_for_key():
		var sender = InputSender.new()
		var event = sender.key_up(KEY_A)
		assert_is(event, InputEventKey, 'is InputEventKey')
		assert_eq(event.scancode, KEY_A)
		assert_false(event.pressed, "pressed")

	func test_key_up_converts_lowercase_string_to_scancode():
		var sender = InputSender.new()
		var event = sender.key_up('a')
		assert_eq(event.scancode, KEY_A)

	func test_key_up_converts_uppercase_string_to_scancode():
		var sender = InputSender.new()
		var event = sender.key_up('A')
		assert_eq(event.scancode, KEY_A)

	func test_key_down_creates_event_for_key():
		var sender = InputSender.new()
		var event = sender.key_down(KEY_B)
		assert_is(event, InputEventKey, 'is InputEventKey')
		assert_eq(event.scancode, KEY_B)
		assert_true(event.pressed, "pressed")

	func test_key_down_converts_lowercase_string_to_scancode():
		var sender = InputSender.new()
		var event = sender.key_down('z')
		assert_eq(event.scancode, KEY_Z)

	func test_key_up_sends_event():
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)
		sender.key_up("C")
		assert_eq(r.input_event.scancode, KEY_C)

	func test_key_down_sends_event():
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)
		sender.key_down(KEY_Q)
		assert_eq(r.input_event.scancode, KEY_Q)


class TestCreateActionEvents:
	extends "res://addons/gut/test.gd"

	var InputSender = _utils.InputSender

	func test_action_up_creates_correct_class():
		var sender = InputSender.new()
		var e = sender.action_up("foo", 1.0)
		assert_is(e, InputEventAction)

	func test_action_up_sets_properties():
		var sender = InputSender.new()
		var e = sender.action_up("foo", .5)
		assert_eq(e.action, "foo", "action name")
		assert_eq(e.pressed, false, "pressed")
		assert_eq(e.strength, .5, 'strength')

	func test_action_up_sends_event():
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)
		sender.action_up("foo", .5)
		assert_eq(r.input_event.action, "foo")

	func test_action_down_creates_correct_class():
		var sender = InputSender.new()
		var e = sender.action_down("foo", 1.0)
		assert_is(e, InputEventAction)

	func test_action_down_sets_properties():
		var sender = InputSender.new()
		var e = sender.action_down("foo", .5)
		assert_eq(e.action, "foo", "action name")
		assert_eq(e.pressed, true, "pressed")
		assert_eq(e.strength, .5, 'strength')

	func test_action_down_sends_event():
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)
		sender.action_down("foo", .5)
		assert_eq(r.input_event.action, "foo")


class TestSequence:
	extends "res://addons/gut/test.gd"

	var InputSender = _utils.InputSender

	func test_when_recoding_events_are_not_sent():
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)

		sender.wait_frames(1)
		sender.key_down(KEY_Q)
		assert_null(r.input_event)


	func test_emits_signal_when_play_ends():
		var r = add_child_autofree(InputTracker.new())
		var sender = InputSender.new(r)
		watch_signals(sender)

		var e1 = InputEventAction.new()
		e1.set_action("foo")
		var e2 = InputEventAction.new()
		e2.set_action("bar")

		sender.wait_frames(1)
		sender.send_event(e1)
		sender.send_event(e2)

		yield(yield_to(sender, "playback_finished", 2), YIELD)
		assert_signal_emitted(sender, 'playback_finished')

	func test_playback_adds_delays():
		var r = add_child_autofree(InputTracker.new())
		var sender = InputSender.new(r)

		var cust_event = InputEventAction.new()
		cust_event.action = "foobar"

		sender.key_down(KEY_1)
		sender.wait(.5)
		sender.key_up(KEY_1)
		sender.wait(.5)
		sender.send_event(cust_event)

		assert_eq(r.inputs.size(), 1, "first input sent")

		yield(yield_for(.7), YIELD)
		assert_eq(r.inputs.size(), 2, "second input sent")

		yield(yield_to(sender, 'playback_finished', 5), YIELD)
		assert_eq(r.inputs.size(), 3, "last input sent")

	func test_can_wait_frames():
		var r = add_child_autofree(InputTracker.new())
		var sender = InputSender.new(r)

		var cust_event = InputEventAction.new()
		cust_event.action = "foobar"

		sender.key_down(KEY_1)
		sender.wait_frames(30)
		sender.key_up(KEY_1)
		sender.wait_frames(30)
		sender.send_event(cust_event)

		assert_eq(r.inputs.size(), 1, "first input sent")

		yield(yield_for(.7), YIELD)
		assert_eq(r.inputs.size(), 2, "second input sent")

		yield(yield_to(sender, 'playback_finished', 5), YIELD)
		assert_eq(r.inputs.size(), 3, "last input sent")

	func test_non_delayed_events_happen_on_the_same_frame_when_delayed_seconds():
		var r = add_child_autofree(InputTracker.new())
		var sender = InputSender.new(r)

		sender.key_down("z")
		sender.wait(.5)
		sender.key_down("a")
		sender.key_down("b")
		sender.wait(.5)
		sender.key_down("c")

		yield(yield_to(sender, "playback_finished", 2), YIELD)
		assert_eq(r.input_frames[1], r.input_frames[2])
		assert_eq(r.inputs[1].scancode, KEY_A)
		assert_eq(r.inputs[2].scancode, KEY_B)

	func test_non_delayed_events_happen_on_the_same_frame_when_delayed_frames():
		var r = add_child_autofree(InputTracker.new())
		var sender = InputSender.new(r)

		sender.key_down("a")
		sender.wait_frames(10)
		sender.key_up("a")
		sender.key_down("b")
		sender.wait_frames(20)
		sender.key_down("c")

		yield(yield_to(sender, "playback_finished", 2), YIELD)
		assert_eq(r.input_frames[1], r.input_frames[2])
		assert_eq(r.inputs[1].scancode, KEY_A)
		assert_eq(r.inputs[2].scancode, KEY_B)


class TestMouseButtons:
	extends "res://addons/gut/test.gd"

	var InputSender = _utils.InputSender

	func assert_mouse_event_props(method, pressed, button_index):
		var sender = InputSender.new()
		var event = sender.call(method, (Vector2(10, 10)))
		assert_is(event, InputEventMouseButton, 'correct class')
		assert_eq(event.position, Vector2(10, 10), 'position')
		assert_eq(event.pressed, pressed, 'pressed')
		assert_eq(event.button_index, button_index, 'button_index')

	func assert_mouse_event_positions(method):
		var sender = InputSender.new()
		var event = sender.call(method, Vector2(10, 10), Vector2(11, 11))
		assert_eq(event.position, Vector2(10, 10), "position")
		assert_eq(event.global_position, Vector2(11, 11), "global position")

	func assert_mouse_event_sends_event(method):
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)
		var event = sender.call(method, Vector2(22, 22))
		assert_eq(r.input_event, event, 'event sent')

	func test_lmb_down():
		assert_mouse_event_props("mouse_left_button_down", true, BUTTON_LEFT)
		assert_mouse_event_positions("mouse_left_button_down")
		assert_mouse_event_sends_event("mouse_left_button_down")

	func test_lmb_up():
		assert_mouse_event_props("mouse_left_button_up", false, BUTTON_LEFT)
		assert_mouse_event_positions("mouse_left_button_up")
		assert_mouse_event_sends_event("mouse_left_button_up")

	func test_double_clickk():
		assert_mouse_event_props("mouse_double_click", false, BUTTON_LEFT)
		assert_mouse_event_positions("mouse_double_click")
		assert_mouse_event_sends_event("mouse_double_click")
		var sender = InputSender.new()
		var event = sender.mouse_double_click(Vector2(1, 1))
		assert_true(event.doubleclick, "double click")

	func test_rmb_down():
		assert_mouse_event_props("mouse_right_button_down", true, BUTTON_RIGHT)
		assert_mouse_event_positions("mouse_right_button_down")
		assert_mouse_event_sends_event("mouse_right_button_down")

	func test_rmb_up():
		assert_mouse_event_props("mouse_right_button_up", false, BUTTON_RIGHT)
		assert_mouse_event_positions("mouse_right_button_up")
		assert_mouse_event_sends_event("mouse_right_button_up")

	# func test_what_chaining_looks_like():
	# 	var r = autofree(InputTracker.new())
	# 	var sender = InputSender.new(r)

	# 	sender\
	# 		.key_down('a')\
	# 		.wait(.5)\
	# 		.key_down("b")\
	# 		.wait(.5)\
	# 		.key_down("c")

	# 	yield(sender, "playback_finished")
	# 	assert_eq(r.inputs.size(), 3)
