extends SceneTree

const SIGNAL_NAME = 'test_signal'
const METHOD_NAME = 'test_signal_connector'

class Signaler:
	signal test_signal

class ConnectTo:
	func test_signal_connector():
		pass

func _init():
	var s = Signaler.new()
	var c = ConnectTo.new()
	s.connect(SIGNAL_NAME, c, METHOD_NAME)
	print('are connected = ', _check_if_connected(s, c, SIGNAL_NAME))
	quit()

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
