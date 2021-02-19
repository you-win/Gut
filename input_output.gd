

var __gut_metadata_ = {
    path = 'Null',
    subpath = '',
    stubber = __gut_instance_from_id(2875),
    spy = __gut_instance_from_id(-1),
    gut = __gut_instance_from_id(-1),
}

func __gut_instance_from_id(inst_id):
    if(inst_id ==  -1):
            return null
    else:
            return instance_from_id(inst_id)

func __gut_should_call_super(method_name, called_with):
    if(__gut_metadata_.stubber != null):
            return __gut_metadata_.stubber.should_call_super(self, method_name, called_with)
    else:
            return false

var __gut_utils_ = load('res://addons/gut/utils.gd').get_instance()

func __gut_spy(method_name, called_with):
    if(__gut_metadata_.spy != null):
            __gut_metadata_.spy.add_call(self, method_name, called_with)

func __gut_get_stubbed_return(method_name, called_with):
    if(__gut_metadata_.stubber != null):
            return __gut_metadata_.stubber.get_return(self, method_name, called_with)
    else:
            return null

func  _init():
    if(__gut_metadata_.gut != null):
            __gut_metadata_.gut.get_autofree().add_free(self)

# ------------------------------------------------------------------------------
# Methods start here
# ------------------------------------------------------------------------------
func is_key_pressed(p_scancode=null):
    __gut_spy('is_key_pressed', [p_scancode])
    if(__gut_should_call_super('is_key_pressed', [p_scancode])):
            return Input.is_key_pressed(p_scancode)
    else:
            return __gut_get_stubbed_return('is_key_pressed', [p_scancode])

func is_mouse_button_pressed(p_button=null):
    __gut_spy('is_mouse_button_pressed', [p_button])
    if(__gut_should_call_super('is_mouse_button_pressed', [p_button])):
            return Input.is_mouse_button_pressed(p_button)
    else:
            return __gut_get_stubbed_return('is_mouse_button_pressed', [p_button])

func is_joy_button_pressed(p_device=null, p_button=null):
    __gut_spy('is_joy_button_pressed', [p_device, p_button])
    if(__gut_should_call_super('is_joy_button_pressed', [p_device, p_button])):
            return Input.is_joy_button_pressed(p_device, p_button)
    else:
            return __gut_get_stubbed_return('is_joy_button_pressed', [p_device, p_button])

func is_action_pressed(p_action=null):
    __gut_spy('is_action_pressed', [p_action])
    if(__gut_should_call_super('is_action_pressed', [p_action])):
            return Input.is_action_pressed(p_action)
    else:
            return __gut_get_stubbed_return('is_action_pressed', [p_action])

func is_action_just_pressed(p_action=null):
    __gut_spy('is_action_just_pressed', [p_action])
    if(__gut_should_call_super('is_action_just_pressed', [p_action])):
            return Input.is_action_just_pressed(p_action)
    else:
            return __gut_get_stubbed_return('is_action_just_pressed', [p_action])

func is_action_just_released(p_action=null):
    __gut_spy('is_action_just_released', [p_action])
    if(__gut_should_call_super('is_action_just_released', [p_action])):
            return Input.is_action_just_released(p_action)
    else:
            return __gut_get_stubbed_return('is_action_just_released', [p_action])

func get_action_strength(p_action=null):
    __gut_spy('get_action_strength', [p_action])
    if(__gut_should_call_super('get_action_strength', [p_action])):
            return Input.get_action_strength(p_action)
    else:
            return __gut_get_stubbed_return('get_action_strength', [p_action])

func add_joy_mapping(p_mapping=null, p_update_existing=false):
    __gut_spy('add_joy_mapping', [p_mapping, p_update_existing])
    if(__gut_should_call_super('add_joy_mapping', [p_mapping, p_update_existing])):
            return Input.add_joy_mapping(p_mapping, p_update_existing)
    else:
            return __gut_get_stubbed_return('add_joy_mapping', [p_mapping, p_update_existing])

func remove_joy_mapping(p_guid=null):
    __gut_spy('remove_joy_mapping', [p_guid])
    if(__gut_should_call_super('remove_joy_mapping', [p_guid])):
            return Input.remove_joy_mapping(p_guid)
    else:
            return __gut_get_stubbed_return('remove_joy_mapping', [p_guid])

func joy_connection_changed(p_device=null, p_connected=null, p_name=null, p_guid=null):
    __gut_spy('joy_connection_changed', [p_device, p_connected, p_name, p_guid])
    if(__gut_should_call_super('joy_connection_changed', [p_device, p_connected, p_name, p_guid])):
            return Input.joy_connection_changed(p_device, p_connected, p_name, p_guid)
    else:
            return __gut_get_stubbed_return('joy_connection_changed', [p_device, p_connected, p_name, p_guid])

func is_joy_known(p_device=null):
    __gut_spy('is_joy_known', [p_device])
    if(__gut_should_call_super('is_joy_known', [p_device])):
            return Input.is_joy_known(p_device)
    else:
            return __gut_get_stubbed_return('is_joy_known', [p_device])

func get_joy_axis(p_device=null, p_axis=null):
    __gut_spy('get_joy_axis', [p_device, p_axis])
    if(__gut_should_call_super('get_joy_axis', [p_device, p_axis])):
            return Input.get_joy_axis(p_device, p_axis)
    else:
            return __gut_get_stubbed_return('get_joy_axis', [p_device, p_axis])

func get_joy_name(p_device=null):
    __gut_spy('get_joy_name', [p_device])
    if(__gut_should_call_super('get_joy_name', [p_device])):
            return Input.get_joy_name(p_device)
    else:
            return __gut_get_stubbed_return('get_joy_name', [p_device])

func get_joy_guid(p_device=null):
    __gut_spy('get_joy_guid', [p_device])
    if(__gut_should_call_super('get_joy_guid', [p_device])):
            return Input.get_joy_guid(p_device)
    else:
            return __gut_get_stubbed_return('get_joy_guid', [p_device])

func get_connected_joypads():
    __gut_spy('get_connected_joypads', [])
    if(__gut_should_call_super('get_connected_joypads', [])):
            return Input.get_connected_joypads()
    else:
            return __gut_get_stubbed_return('get_connected_joypads', [])

func get_joy_vibration_strength(p_device=null):
    __gut_spy('get_joy_vibration_strength', [p_device])
    if(__gut_should_call_super('get_joy_vibration_strength', [p_device])):
            return Input.get_joy_vibration_strength(p_device)
    else:
            return __gut_get_stubbed_return('get_joy_vibration_strength', [p_device])

func get_joy_vibration_duration(p_device=null):
    __gut_spy('get_joy_vibration_duration', [p_device])
    if(__gut_should_call_super('get_joy_vibration_duration', [p_device])):
            return Input.get_joy_vibration_duration(p_device)
    else:
            return __gut_get_stubbed_return('get_joy_vibration_duration', [p_device])

func get_joy_button_string(p_button_index=null):
    __gut_spy('get_joy_button_string', [p_button_index])
    if(__gut_should_call_super('get_joy_button_string', [p_button_index])):
            return Input.get_joy_button_string(p_button_index)
    else:
            return __gut_get_stubbed_return('get_joy_button_string', [p_button_index])

func get_joy_button_index_from_string(p_button=null):
    __gut_spy('get_joy_button_index_from_string', [p_button])
    if(__gut_should_call_super('get_joy_button_index_from_string', [p_button])):
            return Input.get_joy_button_index_from_string(p_button)
    else:
            return __gut_get_stubbed_return('get_joy_button_index_from_string', [p_button])

func get_joy_axis_string(p_axis_index=null):
    __gut_spy('get_joy_axis_string', [p_axis_index])
    if(__gut_should_call_super('get_joy_axis_string', [p_axis_index])):
            return Input.get_joy_axis_string(p_axis_index)
    else:
            return __gut_get_stubbed_return('get_joy_axis_string', [p_axis_index])

func get_joy_axis_index_from_string(p_axis=null):
    __gut_spy('get_joy_axis_index_from_string', [p_axis])
    if(__gut_should_call_super('get_joy_axis_index_from_string', [p_axis])):
            return Input.get_joy_axis_index_from_string(p_axis)
    else:
            return __gut_get_stubbed_return('get_joy_axis_index_from_string', [p_axis])

func start_joy_vibration(p_device=null, p_weak_magnitude=null, p_strong_magnitude=null, p_duration=0):
    __gut_spy('start_joy_vibration', [p_device, p_weak_magnitude, p_strong_magnitude, p_duration])
    if(__gut_should_call_super('start_joy_vibration', [p_device, p_weak_magnitude, p_strong_magnitude, p_duration])):
            return Input.start_joy_vibration(p_device, p_weak_magnitude, p_strong_magnitude, p_duration)
    else:
            return __gut_get_stubbed_return('start_joy_vibration', [p_device, p_weak_magnitude, p_strong_magnitude, p_duration])

func stop_joy_vibration(p_device=null):
    __gut_spy('stop_joy_vibration', [p_device])
    if(__gut_should_call_super('stop_joy_vibration', [p_device])):
            return Input.stop_joy_vibration(p_device)
    else:
            return __gut_get_stubbed_return('stop_joy_vibration', [p_device])

func vibrate_handheld(p_duration_ms=500):
    __gut_spy('vibrate_handheld', [p_duration_ms])
    if(__gut_should_call_super('vibrate_handheld', [p_duration_ms])):
            return Input.vibrate_handheld(p_duration_ms)
    else:
            return __gut_get_stubbed_return('vibrate_handheld', [p_duration_ms])

func get_gravity():
    __gut_spy('get_gravity', [])
    if(__gut_should_call_super('get_gravity', [])):
            return Input.get_gravity()
    else:
            return __gut_get_stubbed_return('get_gravity', [])

func get_accelerometer():
    __gut_spy('get_accelerometer', [])
    if(__gut_should_call_super('get_accelerometer', [])):
            return Input.get_accelerometer()
    else:
            return __gut_get_stubbed_return('get_accelerometer', [])

func get_magnetometer():
    __gut_spy('get_magnetometer', [])
    if(__gut_should_call_super('get_magnetometer', [])):
            return Input.get_magnetometer()
    else:
            return __gut_get_stubbed_return('get_magnetometer', [])

func get_gyroscope():
    __gut_spy('get_gyroscope', [])
    if(__gut_should_call_super('get_gyroscope', [])):
            return Input.get_gyroscope()
    else:
            return __gut_get_stubbed_return('get_gyroscope', [])

func get_last_mouse_speed():
    __gut_spy('get_last_mouse_speed', [])
    if(__gut_should_call_super('get_last_mouse_speed', [])):
            return Input.get_last_mouse_speed()
    else:
            return __gut_get_stubbed_return('get_last_mouse_speed', [])

func get_mouse_button_mask():
    __gut_spy('get_mouse_button_mask', [])
    if(__gut_should_call_super('get_mouse_button_mask', [])):
            return Input.get_mouse_button_mask()
    else:
            return __gut_get_stubbed_return('get_mouse_button_mask', [])

func set_mouse_mode(p_mode=null):
    __gut_spy('set_mouse_mode', [p_mode])
    if(__gut_should_call_super('set_mouse_mode', [p_mode])):
            return Input.set_mouse_mode(p_mode)
    else:
            return __gut_get_stubbed_return('set_mouse_mode', [p_mode])

func get_mouse_mode():
    __gut_spy('get_mouse_mode', [])
    if(__gut_should_call_super('get_mouse_mode', [])):
            return Input.get_mouse_mode()
    else:
            return __gut_get_stubbed_return('get_mouse_mode', [])

func warp_mouse_position(p_to=null):
    __gut_spy('warp_mouse_position', [p_to])
    if(__gut_should_call_super('warp_mouse_position', [p_to])):
            return Input.warp_mouse_position(p_to)
    else:
            return __gut_get_stubbed_return('warp_mouse_position', [p_to])

func action_press(p_action=null, p_strength=1):
    __gut_spy('action_press', [p_action, p_strength])
    if(__gut_should_call_super('action_press', [p_action, p_strength])):
            return Input.action_press(p_action, p_strength)
    else:
            return __gut_get_stubbed_return('action_press', [p_action, p_strength])

func action_release(p_action=null):
    __gut_spy('action_release', [p_action])
    if(__gut_should_call_super('action_release', [p_action])):
            return Input.action_release(p_action)
    else:
            return __gut_get_stubbed_return('action_release', [p_action])

func set_default_cursor_shape(p_shape=0):
    __gut_spy('set_default_cursor_shape', [p_shape])
    if(__gut_should_call_super('set_default_cursor_shape', [p_shape])):
            return Input.set_default_cursor_shape(p_shape)
    else:
            return __gut_get_stubbed_return('set_default_cursor_shape', [p_shape])

func get_current_cursor_shape():
    __gut_spy('get_current_cursor_shape', [])
    if(__gut_should_call_super('get_current_cursor_shape', [])):
            return Input.get_current_cursor_shape()
    else:
            return __gut_get_stubbed_return('get_current_cursor_shape', [])

func set_custom_mouse_cursor(p_image=null, p_shape=0, p_hotspot=Vector2(0, 0)):
    __gut_spy('set_custom_mouse_cursor', [p_image, p_shape, p_hotspot])
    if(__gut_should_call_super('set_custom_mouse_cursor', [p_image, p_shape, p_hotspot])):
            return Input.set_custom_mouse_cursor(p_image, p_shape, p_hotspot)
    else:
            return __gut_get_stubbed_return('set_custom_mouse_cursor', [p_image, p_shape, p_hotspot])

func parse_input_event(p_event=null):
    __gut_spy('parse_input_event', [p_event])
    if(__gut_should_call_super('parse_input_event', [p_event])):
            return Input.parse_input_event(p_event)
    else:
            return __gut_get_stubbed_return('parse_input_event', [p_event])

func set_use_accumulated_input(p_enable=null):
    __gut_spy('set_use_accumulated_input', [p_enable])
    if(__gut_should_call_super('set_use_accumulated_input', [p_enable])):
            return Input.set_use_accumulated_input(p_enable)
    else:
            return __gut_get_stubbed_return('set_use_accumulated_input', [p_enable])

func free():
    __gut_spy('free', [])
    if(__gut_should_call_super('free', [])):
            return Input.free()
    else:
            return __gut_get_stubbed_return('free', [])

func get_class():
    __gut_spy('get_class', [])
    if(__gut_should_call_super('get_class', [])):
            return Input.get_class()
    else:
            return __gut_get_stubbed_return('get_class', [])

func is_class(p_class=null):
    __gut_spy('is_class', [p_class])
    if(__gut_should_call_super('is_class', [p_class])):
            return Input.is_class(p_class)
    else:
            return __gut_get_stubbed_return('is_class', [p_class])

func set(p_property=null, p_value=null):
    __gut_spy('set', [p_property, p_value])
    if(__gut_should_call_super('set', [p_property, p_value])):
            return Input.set(p_property, p_value)
    else:
            return __gut_get_stubbed_return('set', [p_property, p_value])

func get(p_property=null):
    __gut_spy('get', [p_property])
    if(__gut_should_call_super('get', [p_property])):
            return Input.get(p_property)
    else:
            return __gut_get_stubbed_return('get', [p_property])

func set_indexed(p_property=null, p_value=null):
    __gut_spy('set_indexed', [p_property, p_value])
    if(__gut_should_call_super('set_indexed', [p_property, p_value])):
            return Input.set_indexed(p_property, p_value)
    else:
            return __gut_get_stubbed_return('set_indexed', [p_property, p_value])

func get_indexed(p_property=null):
    __gut_spy('get_indexed', [p_property])
    if(__gut_should_call_super('get_indexed', [p_property])):
            return Input.get_indexed(p_property)
    else:
            return __gut_get_stubbed_return('get_indexed', [p_property])

func get_property_list():
    __gut_spy('get_property_list', [])
    if(__gut_should_call_super('get_property_list', [])):
            return Input.get_property_list()
    else:
            return __gut_get_stubbed_return('get_property_list', [])

func get_method_list():
    __gut_spy('get_method_list', [])
    if(__gut_should_call_super('get_method_list', [])):
            return Input.get_method_list()
    else:
            return __gut_get_stubbed_return('get_method_list', [])

func notification(p_what=null, p_reversed=false):
    __gut_spy('notification', [p_what, p_reversed])
    if(__gut_should_call_super('notification', [p_what, p_reversed])):
            return Input.notification(p_what, p_reversed)
    else:
            return __gut_get_stubbed_return('notification', [p_what, p_reversed])

func to_string():
    __gut_spy('to_string', [])
    if(__gut_should_call_super('to_string', [])):
            return Input.to_string()
    else:
            return __gut_get_stubbed_return('to_string', [])

func get_instance_id():
    __gut_spy('get_instance_id', [])
    if(__gut_should_call_super('get_instance_id', [])):
            return Input.get_instance_id()
    else:
            return __gut_get_stubbed_return('get_instance_id', [])

func set_script(p_script=null):
    __gut_spy('set_script', [p_script])
    if(__gut_should_call_super('set_script', [p_script])):
            return Input.set_script(p_script)
    else:
            return __gut_get_stubbed_return('set_script', [p_script])

func get_script():
    __gut_spy('get_script', [])
    if(__gut_should_call_super('get_script', [])):
            return Input.get_script()
    else:
            return __gut_get_stubbed_return('get_script', [])

func set_meta(p_name=null, p_value=null):
    __gut_spy('set_meta', [p_name, p_value])
    if(__gut_should_call_super('set_meta', [p_name, p_value])):
            return Input.set_meta(p_name, p_value)
    else:
            return __gut_get_stubbed_return('set_meta', [p_name, p_value])

func remove_meta(p_name=null):
    __gut_spy('remove_meta', [p_name])
    if(__gut_should_call_super('remove_meta', [p_name])):
            return Input.remove_meta(p_name)
    else:
            return __gut_get_stubbed_return('remove_meta', [p_name])

func get_meta(p_name=null):
    __gut_spy('get_meta', [p_name])
    if(__gut_should_call_super('get_meta', [p_name])):
            return Input.get_meta(p_name)
    else:
            return __gut_get_stubbed_return('get_meta', [p_name])

func has_meta(p_name=null):
    __gut_spy('has_meta', [p_name])
    if(__gut_should_call_super('has_meta', [p_name])):
            return Input.has_meta(p_name)
    else:
            return __gut_get_stubbed_return('has_meta', [p_name])

func get_meta_list():
    __gut_spy('get_meta_list', [])
    if(__gut_should_call_super('get_meta_list', [])):
            return Input.get_meta_list()
    else:
            return __gut_get_stubbed_return('get_meta_list', [])

func add_user_signal(p_signal=null, p_arguments=[]):
    __gut_spy('add_user_signal', [p_signal, p_arguments])
    if(__gut_should_call_super('add_user_signal', [p_signal, p_arguments])):
            return Input.add_user_signal(p_signal, p_arguments)
    else:
            return __gut_get_stubbed_return('add_user_signal', [p_signal, p_arguments])

func has_user_signal(p_signal=null):
    __gut_spy('has_user_signal', [p_signal])
    if(__gut_should_call_super('has_user_signal', [p_signal])):
            return Input.has_user_signal(p_signal)
    else:
            return __gut_get_stubbed_return('has_user_signal', [p_signal])

func set_deferred(p_property=null, p_value=null):
    __gut_spy('set_deferred', [p_property, p_value])
    if(__gut_should_call_super('set_deferred', [p_property, p_value])):
            return Input.set_deferred(p_property, p_value)
    else:
            return __gut_get_stubbed_return('set_deferred', [p_property, p_value])

func callv(p_method=null, p_arg_array=null):
    __gut_spy('callv', [p_method, p_arg_array])
    if(__gut_should_call_super('callv', [p_method, p_arg_array])):
            return Input.callv(p_method, p_arg_array)
    else:
            return __gut_get_stubbed_return('callv', [p_method, p_arg_array])

func has_method(p_method=null):
    print("1")
    __gut_spy('has_method', [p_method])
    print("2")
    if(__gut_should_call_super('has_method', [p_method])):
            print("3")
            return Input.has_method(p_method)
    else:
            print("4")
            return __gut_get_stubbed_return('has_method', [p_method])

func has_signal(p_signal=null):
    __gut_spy('has_signal', [p_signal])
    if(__gut_should_call_super('has_signal', [p_signal])):
            return Input.has_signal(p_signal)
    else:
            return __gut_get_stubbed_return('has_signal', [p_signal])

func get_signal_list():
    __gut_spy('get_signal_list', [])
    if(__gut_should_call_super('get_signal_list', [])):
            return Input.get_signal_list()
    else:
            return __gut_get_stubbed_return('get_signal_list', [])

func get_signal_connection_list(p_signal=null):
    __gut_spy('get_signal_connection_list', [p_signal])
    if(__gut_should_call_super('get_signal_connection_list', [p_signal])):
            return Input.get_signal_connection_list(p_signal)
    else:
            return __gut_get_stubbed_return('get_signal_connection_list', [p_signal])

func get_incoming_connections():
    __gut_spy('get_incoming_connections', [])
    if(__gut_should_call_super('get_incoming_connections', [])):
            return Input.get_incoming_connections()
    else:
            return __gut_get_stubbed_return('get_incoming_connections', [])

func connect(p_signal=null, p_target=null, p_method=null, p_binds=[], p_flags=0):
    __gut_spy('connect', [p_signal, p_target, p_method, p_binds, p_flags])
    if(__gut_should_call_super('connect', [p_signal, p_target, p_method, p_binds, p_flags])):
            return Input.connect(p_signal, p_target, p_method, p_binds, p_flags)
    else:
            return __gut_get_stubbed_return('connect', [p_signal, p_target, p_method, p_binds, p_flags])

func disconnect(p_signal=null, p_target=null, p_method=null):
    __gut_spy('disconnect', [p_signal, p_target, p_method])
    if(__gut_should_call_super('disconnect', [p_signal, p_target, p_method])):
            return Input.disconnect(p_signal, p_target, p_method)
    else:
            return __gut_get_stubbed_return('disconnect', [p_signal, p_target, p_method])

func is_connected(p_signal=null, p_target=null, p_method=null):
    __gut_spy('is_connected', [p_signal, p_target, p_method])
    if(__gut_should_call_super('is_connected', [p_signal, p_target, p_method])):
            return Input.is_connected(p_signal, p_target, p_method)
    else:
            return __gut_get_stubbed_return('is_connected', [p_signal, p_target, p_method])

func set_block_signals(p_enable=null):
    __gut_spy('set_block_signals', [p_enable])
    if(__gut_should_call_super('set_block_signals', [p_enable])):
            return Input.set_block_signals(p_enable)
    else:
            return __gut_get_stubbed_return('set_block_signals', [p_enable])

func is_blocking_signals():
    __gut_spy('is_blocking_signals', [])
    if(__gut_should_call_super('is_blocking_signals', [])):
            return Input.is_blocking_signals()
    else:
            return __gut_get_stubbed_return('is_blocking_signals', [])

func property_list_changed_notify():
    __gut_spy('property_list_changed_notify', [])
    if(__gut_should_call_super('property_list_changed_notify', [])):
            return Input.property_list_changed_notify()
    else:
            return __gut_get_stubbed_return('property_list_changed_notify', [])

func set_message_translation(p_enable=null):
    __gut_spy('set_message_translation', [p_enable])
    if(__gut_should_call_super('set_message_translation', [p_enable])):
            return Input.set_message_translation(p_enable)
    else:
            return __gut_get_stubbed_return('set_message_translation', [p_enable])

func can_translate_messages():
    __gut_spy('can_translate_messages', [])
    if(__gut_should_call_super('can_translate_messages', [])):
            return Input.can_translate_messages()
    else:
            return __gut_get_stubbed_return('can_translate_messages', [])

func tr(p_message=null):
    __gut_spy('tr', [p_message])
    if(__gut_should_call_super('tr', [p_message])):
            return Input.tr(p_message)
    else:
            return __gut_get_stubbed_return('tr', [p_message])

func is_queued_for_deletion():
    __gut_spy('is_queued_for_deletion', [])
    if(__gut_should_call_super('is_queued_for_deletion', [])):
            return Input.is_queued_for_deletion()
    else:
            return __gut_get_stubbed_return('is_queued_for_deletion', [])
