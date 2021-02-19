
# Implemented InputEvents
# 	InputEventAction
# 	InputEventKey

# Yet to implement InputEvents
# 	InputEventMagnifyGesture
# 	InputEventPanGesture
# 	InputEventMouseButton
# 	InputEventMouseMotion
# 	InputEventJoypadButton
# 	InputEventJoypadMotion
# 	InputEventMIDI
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