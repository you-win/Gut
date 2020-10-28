extends 'res://addons/gut/test.gd'


class TestConnectionAsserts:
	extends 'res://addons/gut/test.gd'

	const SIGNAL_NAME = 'test_signal'
	const METHOD_NAME = 'test_signal_connector'

	class Signaler:
		signal test_signal

	class ConnectTo:
		func test_signal_connector():
			pass

	# # From test_test.gd/TestConnectionAsserts
	func test_when_target_connected_to_source_connected_passes_without_method_name():
		var s = Signaler.new()
		var c = ConnectTo.new()
		s.connect(SIGNAL_NAME, c, METHOD_NAME)
		assert_connected(s, c, SIGNAL_NAME)
		assert_true(is_passing(), 'This test should be passing')
		# gr.test.assert_connected(s, c, SIGNAL_NAME)
		# assert_pass(gr.test)

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

	func test_using_local_copy_of_connection_check_logic():
		var s = Signaler.new()
		var c = ConnectTo.new()
		s.connect(SIGNAL_NAME, c, METHOD_NAME)
		assert_true(_check_if_connected(s, c, SIGNAL_NAME), 'This should be true')

	func test_using_is_connected_directly():
		var s = Signaler.new()
		var c = ConnectTo.new()
		s.connect(SIGNAL_NAME, c, METHOD_NAME)
		assert_true(s.is_connected(SIGNAL_NAME, c, METHOD_NAME), 'This should be true')

	func test_simple_case():
		var s = Signaler.new()
		var s2 = s
		print(s, '==', s2, ' is ', s == s2)


class TestPossibleProblems:
	extends 'res://addons/gut/test.gd'
	class Foo:
		var bar = 1
	func test_instances_in_dictionaries():
		var s1 = Foo.new()
		var d1 = {'a':1, 'b':{'instance':s1}}
		var d2 = {'a':1, 'b':{'instance':s1}}
		assert_eq(d1['b']['instance'], s1, 'direct compare')
		assert_eq(d1['b']['instance'], d2['b']['instance'], 'dictionary compare')


# -----------------------------------------------
# Doubler related failing tests.
# -----------------------------------------------

# test_doubler_and_spy.gd/TestBoth
# func test_spy_is_set_in_metadata():
# 	var inst = _doubler.double(DOUBLE_ME_PATH).new()
# 	assert_eq(inst.__gut_metadata_.spy, _spy)

# test_doubler_and_stubber.gd
# func test_doubled_have_ref_to_stubber():
# 	gr.doubler.set_stubber(gr.stubber)
# 	var d = gr.doubler.double(DOUBLE_ME_PATH).new()
# 	assert_eq(d.__gut_metadata_.stubber, gr.stubber)

# test_test_stubber_doubler.gd/TestBasics
# func test_double_sets_stubber_for_doubled_class():
# 	var d = gr.test.double(DOUBLE_ME_PATH).new()
# 	assert_eq(d.__gut_metadata_.stubber, gr.gut.get_stubber())
