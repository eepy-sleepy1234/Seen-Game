extends MarginContainer

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var textlabel: Label = $"../textbox/MarginContainer/HBoxContainer/Label"
@onready var namelabel: Label = $"../textbox/MarginContainer2/HBoxContainer/Label"
@onready var oldGuyOh = $"../../AudioStreamPlayer"
@onready var oldGuyWAIT = $"../../OldGuyWait"
@onready var angryscout = $"../../AngryScout"
@onready var long_legs = $"../../LongLegRelief"
@onready var angryNurse = $"../../AngryNurse"
var open = false
var tween = create_tween()

var scientist_text = ["everything looks good", "I need to shut this down", "phew, that was a close one", "Why can I walk through everything besides these stairs?", "and why can I talk to people and ghosts?", "let me try something", "the door's locked. There's gotta be a key somewhere", "I can't be dead I just talked to a nurse", "why is there a p in your nickname", "...", "anyway I'm scientist guy", "Well I'm leaving, I need to figure out what's going on", "sigh.", "what do you need", "What's the SEGM", "Are you a member of the segm", "i'm asking", "still me", "i was given something to deliver to you", "what does the segm even mean?", "that's a stupid name and abbreviation", "nothing", "I don't need this anymore", "The only way I can get out of here is to become a ghost"]
var sepcogg_text = ["Told you so", "Hey there.", "Haven't seen you around, you must be a new dead", "Go walk through those crates to see", "My name's Super Epic Cool Old Ghost Guy, but my friends call me SEPCOGG", "the p is silent", "That's a weird name", "WAIT I NEED YOUR HELP", "Give this to a member of the SEGM", "Just find a ghost wearing a suit", "Welcome back.", "I know someone who can help you,", "but you need to go through an epic secret puzzle dungeon that is designed specifically for partial ghost people.", "Just be careful, that place is crawling with SEGM members"]
var nurse_text = ["Oh, you're finally awake. Let me get a doctor for you.", "you should get back in bed", "you really can't be wandering off like that"]
var segm_text = ["depends, who's asking?", "oh right, yeah i am. who's wondering?", "oh right, why?", "who's asking?", "oh right", "it stands for super evil ghost mafia", "what was that?", "boss will definitely be hearing about this"]
var boss_text = "you think you can make fun of the segm and get away with it? Think again"
var doctor_text = ["Hey, I recognize you! Why don't you come back to the hospital with me."]
func write_text(new_text) -> void:
	if new_text == "you really can't be wandering off like that":
		angryNurse.play()
	if new_text == "Hey there.":
		oldGuyOh.play()
	if new_text == "WAIT I NEED YOUR HELP":
		oldGuyWAIT.play()
	if new_text == "boss will definitely be hearing about this":
		angryscout.play()
	if new_text == "Hey, I recognize you! Why don't you come back to the hospital with me.":
		long_legs.play()	
	
	if new_text in scientist_text:
		namelabel.text = "Scientist Guy"
	elif new_text in sepcogg_text:
		namelabel.text = "Sepcogg"
	elif new_text in nurse_text:
		namelabel.text = "nurse"
	elif new_text in segm_text:
		namelabel.text = "Segm member"
	elif new_text in doctor_text:
		namelabel.text = "Doctor long legs"
	elif new_text == boss_text:
		namelabel.text = "SEGM boss"
	Globals.listening = false
	textlabel.text = new_text
	open_box()
	if tween:
		tween.kill()
	textlabel.visible_ratio = 0.0
	await get_tree().create_timer(0.5).timeout
	tween = create_tween()
	tween.tween_property(textlabel, "visible_ratio", 1, len(textlabel.text) * 0.05)
	await tween.finished
	if new_text not in ["I should give this to the ghost up there first", "phew, that was a close one", "don't walk out on her like that", "Why can I walk through everything besides these stairs?", "The only way I can get out of here is to become a ghost"]:
		Globals.listening = true

func continue_text(new_text) -> void:
	Globals.listening = false
	
	if new_text in scientist_text:
		namelabel.text = "Scientist Guy"
	elif new_text in sepcogg_text:
		namelabel.text = "Sepcogg"
	elif new_text in nurse_text:
		namelabel.text = "nurse"
	elif new_text in segm_text:
		namelabel.text = "Segm member"
	elif new_text in doctor_text:
		namelabel.text = "Doctor long legs"
	textlabel.text = new_text
	if not open:
		open_box()
	if tween:
		tween.kill()
	textlabel.visible_ratio = 0.0
	await get_tree().create_timer(0.5).timeout
	tween = create_tween()
	tween.tween_property(textlabel, "visible_ratio", 1, len(textlabel.text) * 0.01)
	await tween.finished
	if new_text not in ["you should get back in bed", "and why can I talk to people and ghosts?"]:
		Globals.listening = true

func open_box():
	open = true
	animation.play("open")

func close_box():
	textlabel.text = ""
	open = false
	animation.play("close")
