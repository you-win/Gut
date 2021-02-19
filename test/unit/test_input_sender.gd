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
		# not a receiver
		var thing = HasInputEvents.new()
		add_child_autofree(thing)

		var event = InputEventKey.new()
		event.pressed = true
		event.scancode = KEY_Y
		sender.send_event(event)

		yield(yield_for(.1), YIELD)
		assert_true(Input.is_key_pressed(KEY_Y), 'is_pressed')
		# illustrate that sending events to Input will also cause _input
		# and _unhandled_inpu to fire on anything in the tree.
		assert_eq(thing.input_event, event, '_input key')
		assert_eq(thing.unhandled_event, event, '_input key')
		assert_null(thing.gui_event, 'gui event')

class TestCreateKeyEvents:
	extends "res://addons/gut/test.gd"

	var InputSender = _utils.InputSender

	func test_key_up_creates_event_for_key():
		var sender = InputSender.new()
		var event = sender.key_up(KEY_A)
		assert_true(event is InputEventKey, 'is InputEventKey')
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
		assert_true(event is InputEventKey, 'is InputEventKey')
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
		assert_true(e is InputEventAction)

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
		assert_true(e is InputEventAction)

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

	class InputTracker:
		var inputs = []

		func _input(event):
			inputs.append(event)

	func test_when_recoding_events_are_not_sent():
		var r = autofree(HasInputEvents.new())
		var sender = InputSender.new(r)
		sender.record()
		sender.key_down(KEY_Q)
		assert_null(r.input_event)

	func test_events_can_be_played_back():
		var r = autofree(InputTracker.new())
		var sender = InputSender.new(r)

		var e1 = InputEventAction.new()
		e1.set_action("foo")
		var e2 = InputEventAction.new()
		e2.set_action("bar")

		sender.record()
		sender.send_event(e1)
		sender.send_event(e2)
		sender.play()

		assert_eq(r.inputs, [e1, e2])

	func test_can_clear_recording():
		var r = autofree(InputTracker.new())
		var sender = InputSender.new(r)

		var e1 = InputEventAction.new()
		e1.set_action("foo")
		var e2 = InputEventAction.new()
		e2.set_action("bar")

		sender.record()
		sender.send_event(e1)
		sender.send_event(e2)
		sender.clear_recording()
		sender.play()

		assert_eq(r.inputs, [])

	func test_emits_signal_when_play_ends():
		var r = autofree(InputTracker.new())
		var sender = InputSender.new(r)
		watch_signals(sender)

		var e1 = InputEventAction.new()
		e1.set_action("foo")
		var e2 = InputEventAction.new()
		e2.set_action("bar")

		sender.record()
		sender.send_event(e1)
		sender.send_event(e2)
		sender.play()

		assert_signal_emitted(sender, 'playback_finished')

	func test_playback_adds_delays():
		var r = autofree(InputTracker.new())
		var sender = InputSender.new(r)

		sender.record()
		sender.key_down(KEY_1, .5)
		sender.key_up(KEY_1, .5)
		var e = InputEventAction.new()
		e.action = "foobar"
		sender.send_event(e)
		sender.play()

		assert_eq(r.inputs.size(), 1, "first input sent")

		yield(yield_for(.7), YIELD)
		assert_eq(r.inputs.size(), 2, "second input sent")

		yield(yield_to(sender, 'playback_finished', 5), YIELD)
		assert_eq(r.inputs.size(), 3, "last input sent")









