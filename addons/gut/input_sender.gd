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

var _receivers = []
var _is_recording = false
var _recorded_events = []


signal playback_finished

func _init(r=null):
	if(r != null):
		add_receiver(r)


func _delay_timer(t):
	return Engine.get_main_loop().root.get_tree().create_timer(t)


func _to_scancode(which):
	var key_code = which
	if(typeof(key_code) == TYPE_STRING):
		key_code = key_code.to_upper().to_ascii()[0]
	return key_code


func _send_event(event):
	for r in _receivers:
		if(r == Input):
			# This has to be a call_deferred or it doesn't work for some reason.
			# Found this solution on a forum post that I have since lost.
			Input.call_deferred('parse_input_event', event)
		else:
			if(r.has_method("_input")):
				r._input(event)

			if(r.has_method("_gui_input")):
				r._gui_input(event)

			if(r.has_method("_unhandled_input")):
				r._unhandled_input(event)


func _send_or_record_event(event, delay):
	if(_is_recording):
		_recorded_events.append([event, delay])
	else:
		_send_event(event)


func _new_mouse_button_event(positions, pressed, button_index):
	var event = InputEventMouseButton.new()
	if(typeof(positions) == TYPE_ARRAY):
		event.position = positions[0]
		event.global_position = positions[1]
	else:
		event.position = positions
	event.pressed = pressed
	event.button_index = button_index

	return event


func add_receiver(obj):
	_receivers.append(obj)


func get_receivers():
	return _receivers


func key_up(which, delay=null):
	var event = InputEventKey.new()
	event.scancode = _to_scancode(which)
	event.pressed = false
	_send_or_record_event(event, delay)
	return event


func key_down(which, delay=null):
	var event = InputEventKey.new()
	event.scancode = _to_scancode(which)
	event.pressed = true
	_send_or_record_event(event, delay)
	return event


func action_up(which, strength, delay=null):
	var event  = InputEventAction.new()
	event.action = which
	event.strength = strength
	_send_or_record_event(event, delay)
	return event


func action_down(which, strength, delay=null):
	var event  = InputEventAction.new()
	event.action = which
	event.strength = strength
	event.pressed = true
	_send_or_record_event(event, delay)
	return event


func mouse_left_button_down(positions, delay=null):
	var event = _new_mouse_button_event(positions, true, BUTTON_LEFT)
	_send_or_record_event(event, delay)
	return event


func mouse_left_button_up(positions, delay=null):
	var event = _new_mouse_button_event(positions, false, BUTTON_LEFT)
	_send_or_record_event(event, delay)
	return event


func mouse_double_click(positions, delay=null):
	var event = _new_mouse_button_event(positions, false, BUTTON_LEFT)
	event.doubleclick = true
	_send_or_record_event(event, delay)
	return event


func mouse_right_button_down(positions, delay=null):
	var event = _new_mouse_button_event(positions, true, BUTTON_RIGHT)
	_send_or_record_event(event, delay)
	return event


func mouse_right_button_up(positions, delay=null):
	var event = _new_mouse_button_event(positions, false, BUTTON_RIGHT)
	_send_or_record_event(event, delay)
	return event


func send_event(event,delay=null):
	_send_or_record_event(event, delay)


func record():
	_is_recording = true


func play():
	_is_recording = false
	for event in _recorded_events:
		_send_event(event[0])
		if(event[1] != null):
			yield(_delay_timer(event[1]), 'timeout')
	emit_signal("playback_finished")


func clear_recording():
	_recorded_events.clear()