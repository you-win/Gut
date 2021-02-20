# ##############################################################################
#(G)odot (U)nit (T)est class
#
# ##############################################################################
# The MIT License (MIT)
# =====================
#
# Copyright (c) 2020 Tom "Butch" Wesley
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
# ##############################################################################
# Description
# -----------
# This class sends input to one or more recievers.  The receivers' _input,
# _unhandled_input, and _gui_input are called sending InputEvent* events.
# InputEvents can be sent via the helper methods or a custom made InputEvent
# can be sent via send_event(...)
#
# All helper methods and send_event include an optional delay parameter which
# can be used in conjunction with record() and play() to create a sequence of
# input to play back to all receivers.
#
# Finally, all helper methods also return the event they create so this class
# can also be used as a factory for creating InputEvents easier.  Just do not
# add any receivers via the constructor or add_receiver.
# ##############################################################################


# Implemented InputEvent* convenience methods
# 	InputEventAction
# 	InputEventKey
# 	InputEventMouseButton

# Yet to implement InputEvents
# 	InputEventJoypadButton
# 	InputEventJoypadMotion
# 	InputEventMagnifyGesture
# 	InputEventMIDI
# 	InputEventMouseMotion
# 	InputEventPanGesture
# 	InputEventScreenDrag
# 	InputEventScreenTouch

class InputQueueItem:
	extends Node

	var events = []
	var time_delay = null
	var frame_delay = null
	var _waited_frames = 0
	var _is_ready = false
	var _delay_started = false

	signal event_ready

	func _process(delta):
		if(frame_delay > 0 and _delay_started):
			_waited_frames += 1
			if(_waited_frames >= frame_delay):
				emit_signal("event_ready")

	func _init(t_delay, f_delay):
		time_delay = t_delay
		frame_delay = f_delay
		_is_ready = time_delay == 0 and frame_delay == 0

	func _on_time_timeout():
		_is_ready = true
		emit_signal("event_ready")

	func _delay_timer(t):
		return Engine.get_main_loop().root.get_tree().create_timer(t)

	func is_ready():
		return _is_ready

	func start():
		_delay_started = true
		if(time_delay > 0):
			var t = _delay_timer(time_delay)
			t.connect("timeout", self, "_on_time_timeout")


var _receivers = []
var _input_queue = []
var _next_queue_item = null

signal playback_finished


func _init(r=null):
	if(r != null):
		add_receiver(r)


func _to_scancode(which):
	var key_code = which
	if(typeof(key_code) == TYPE_STRING):
		key_code = key_code.to_upper().to_ascii()[0]
	return key_code


func _send_event(event):
	for r in _receivers:
		if(r == Input):
			Input.parse_input_event(event)
		else:
			if(r.has_method("_input")):
				r._input(event)

			if(r.has_method("_gui_input")):
				r._gui_input(event)

			if(r.has_method("_unhandled_input")):
				r._unhandled_input(event)


func _send_or_record_event(event):
	if(_next_queue_item != null):
		_next_queue_item.events.append(event)
	else:
		_send_event(event)


func _new_mouse_button_event(position, global_position, pressed, button_index):
	var event = InputEventMouseButton.new()
	event.position = position
	if(global_position != null):
		event.global_position = global_position
	event.pressed = pressed
	event.button_index = button_index

	return event


func add_receiver(obj):
	_receivers.append(obj)


func get_receivers():
	return _receivers


func key_up(which):
	var event = InputEventKey.new()
	event.scancode = _to_scancode(which)
	event.pressed = false
	_send_or_record_event(event)
	return event


func key_down(which):
	var event = InputEventKey.new()
	event.scancode = _to_scancode(which)
	event.pressed = true
	_send_or_record_event(event)
	return event


func action_up(which, strength):
	var event  = InputEventAction.new()
	event.action = which
	event.strength = strength
	_send_or_record_event(event)
	return event


func action_down(which, strength):
	var event  = InputEventAction.new()
	event.action = which
	event.strength = strength
	event.pressed = true
	_send_or_record_event(event)
	return event


func mouse_left_button_down(position, global_position=null):
	var event = _new_mouse_button_event(position, global_position, true, BUTTON_LEFT)
	_send_or_record_event(event)
	return event


func mouse_left_button_up(position, global_position=null):
	var event = _new_mouse_button_event(position, global_position, false, BUTTON_LEFT)
	_send_or_record_event(event)
	return event


func mouse_double_click(position, global_position=null):
	var event = _new_mouse_button_event(position, global_position, false, BUTTON_LEFT)
	event.doubleclick = true
	_send_or_record_event(event)
	return event


func mouse_right_button_down(position, global_position=null):
	var event = _new_mouse_button_event(position, global_position, true, BUTTON_RIGHT)
	_send_or_record_event(event)
	return event


func mouse_right_button_up(position, global_position=null):
	var event = _new_mouse_button_event(position, global_position, false, BUTTON_RIGHT)
	_send_or_record_event(event)
	return event


func send_event(event):
	_send_or_record_event(event)


func _on_queue_item_ready(item):
	for event in item.events:
		_send_event(event)

	var done_event = _input_queue.pop_front()
	done_event.queue_free()

	if(_input_queue.size() == 0):
		emit_signal("playback_finished")
	else:
		_input_queue[0].start()


func _add_queue_item(item):
	item.connect("event_ready", self, "_on_queue_item_ready", [item])
	_next_queue_item = item
	_input_queue.append(item)
	Engine.get_main_loop().root.add_child(item)
	if(_input_queue.size() == 1):
		item.start()


func wait(t):
	var item = InputQueueItem.new(t, 0)
	_add_queue_item(item)


func wait_frames(num_frames):
	var item = InputQueueItem.new(0, num_frames)
	_add_queue_item(item)
