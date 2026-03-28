extends Node

signal story_progress_changed(new_value)
var listening = true
var inventory = ""
var _story_progress = 0
var story_progress: int:
	get: return _story_progress
	set(value):
		_story_progress = value
		story_progress_changed.emit(value)
