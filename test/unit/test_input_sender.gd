extends "res://addons/gut/test.gd"

var InputSender = _utils.InputSender


func test_can_make_one():
    assert_not_null(InputSender.new())