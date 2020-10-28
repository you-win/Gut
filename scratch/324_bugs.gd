extends SceneTree


class BadRefCheck:
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

	# Runs the relevant code from the doubler to create an object that has
	# instances loaded by id.
	func dynamic_object_check(ref_this):
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
		var loaded  = make_script(code).new()

		print('-- test_something results --')
		print('direct check:   ', loaded.__gut_metadata_.stubber == ref_this.stubber)

		var test = load('res://addons/gut/test.gd').new()
		test.assert_eq(loaded.__gut_metadata_.stubber, ref_this.stubber)
		print('assert result:  ',  test._fail_pass_text[0])


# Upon further investigation the related tests are failing for the same reason
# as the other tests.  When it performs the loop simulated by _check_if_connected
# it is not seeing two obejects as being equla when they are.
class AssertConnectedCheck:
	class HasSignal:
		signal the_signal

	class Connect:
		func signal_hanlder():
			print('handled')

	# Simulates the check used by assert_connected when a method name is
	# not specified.  Checks for a connection between the two obects for
	# the given signal without caring about what method it is connected to.
	func _check_if_connected(signaler_obj, connect_to_obj, signal_name):
		var connections = signaler_obj.get_signal_connection_list(signal_name)
		for conn in connections:
			if((conn.source == signaler_obj) and (conn.target == connect_to_obj)):
				return true
		return false

	func connect_and_check():
		var connect = Connect.new()
		var has_signal = HasSignal.new()
		has_signal.connect('the_signal', connect, 'signal_handler')

		print('-- connect_and_check results --')
		print('direct check:     ', has_signal.is_connected('the_signal', connect, 'signal_handler'))
		print('simulated check:  ', _check_if_connected(has_signal, connect, 'the_signal'))

class SimpleReplication:
	const SIGNAL_NAME = 'test_signal'
	const METHOD_NAME = 'test_signal_connector'

	class Signaler:
		signal test_signal

	class ConnectTo:
		func test_signal_connector():
			pass

	func run_it():
		var s = Signaler.new()
		var c = ConnectTo.new()
		s.connect(SIGNAL_NAME, c, METHOD_NAME)
		print('are connected = ', _check_if_connected(s, c, SIGNAL_NAME))

	# Simulates the check used by assert_connected when a method name is
	# not specified.  Checks for a connection between the two obects for
	# the given signal without caring about what method it is connected to.
	func _check_if_connected(signaler_obj, connect_to_obj, signal_name):
		var connections = signaler_obj.get_signal_connection_list(signal_name)
		for conn in connections:
			print('source/signaler:  ', conn.source, '==', signaler_obj, ' is ', conn.source == signaler_obj)
			print('target/connect_to:  ', conn.target, '==', connect_to_obj, ' is ', conn.target == connect_to_obj)
			if((conn.source == signaler_obj) and (conn.target == connect_to_obj)):
				return true
		return false

func _run_failing_test_code():
	var test_script = load('res://test/integration/test_345_beta_issues_simple.gd').new()
	test_script.test_using_local_copy_of_connection_check_logic()

func _init():
	#BadRefCheck.new().dynamic_object_check(BadRefCheck.HasStubber.new())
	#AssertConnectedCheck.new().connect_and_check()
	#SimpleReplication.new().run_it()
	_run_failing_test_code()
	quit()