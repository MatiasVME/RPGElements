# MIT License
#
# Copyright (c) 2018 Matías Muñoz Espinoza
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

tool
extends "RPGElement.gd"

# Estos son las propiedades que deben ser asignadas a la interfaz:
# transmitter_name : Es el nombre que emite el mensaje actual.
# avatar : texture de avatar, imagen actual.
# text: texto actual. 
var transmitter_name setget , get_transmitter_name
var avatar setget , get_avatar
var text setget , get_text

# Posición del avatar
enum AvatarPos {LEFT, RIGHT}
var avatar_pos = LEFT

var dialogue = []

var timer

# Se cambia el trasmitter_name
signal changed_transmitter_name
# Se cambia el avatar
signal changed_avatar
# Pasa al siguiente texto
signal changed_text
# Se actualiza el texto (por cada letra)
signal updated_text
# Comienza el dialogo
signal start_dialog
# Termina el dialogo
signal end_dialog

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.wait_time = 0.2
	timer.autostart = true
	
	if self.debug:
		connect("changed_transmitter_name", self, "_on_changed_transmitter_name")
		connect("changed_avatar", self, "_on_changed_avatar")
		connect("changed_text", self, "_on_changed_text")
		connect("updated_text", self, "_on_updated_text")
		connect("start_dialog", self, "_on_start_dialog")
		connect("end_dialog", self, "_on_end_dialog")

# Métodos Públicos
#

func add_section(_transmitter_name, _text, _img, _avatar_pos = LEFT):
	var section = new_section()
	
	section["TransmitterName"] = _transmitter_name
	section["Text"] = _text
	section["Avatar"] = _img
	
	dialogue.append(section)
	
func get_dialogue():
	return dialogue
	
func start_dialog():
	if dialogue == null or current_text == null:
		debug("El dialogo es null: ", dialogue)
		return
	
	emit_signal("start_dialog")
	has_increased = true
	timer.start()

# Setters/Getters
#
	
func get_transmitter_name():
	return transmitter_name
	
func get_avatar():
	return avatar

func get_text():
	return text

# Métodos "Privados"
#

func new_section():
	var section = {
		TransmitterName = null,
		Text = null,
		Avatar = null
	}
	
	return section

const TEST_MODE = false

var index_dialog = 0
var index_letter = 0
var current_text = ""
var text_progress = ""
var has_increased = false
var next_dialog = false
var is_finish = false

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if is_finish:
			stop_dialog()
			
		next_dialog()
	
func stop_dialog():
	dialogue = null

	index_dialog = 0
	index_letter = 0
	current_text = ""
	text_progress = ""
	has_increased = false
	next_dialog = false
	is_finish = false
	
	emit_signal("start_dialog")

# Es para ver si el index_dialog ha incrementado
func has_increased():
	if has_increased:
		has_increased = false
		return true
	else:
		return false

func next_dialog():
	if next_dialog:
		next_dialog = false
		emit_signal("changed_text")
		
		return true
	else:
		return false

# Events
#

func _on_Timer_timeout():
	print("TIMER")
	if next_dialog:
		text_progress = ""
		return
	
	if has_increased:
		current_text = dialogue[index_dialog]["Text"]
		emit_signal("updated_text")
		
		if transmitter_name != dialogue[index_dialog]["TransmitterName"]:
			transmitter_name = dialogue[index_dialog]["TransmitterName"]
			emit_signal("changed_transmitter_name")
		
		if avatar.texture != dialogue[index_dialog]["Avatar"]:
			avatar.texture = dialogue[index_dialog]["Avatar"]
			emit_signal("changed_avatar")
	
	text_progress += current_text[index_letter]
	index_letter += 1
	
	if index_letter == current_text.length():
		index_letter = 0
		index_dialog += 1
		has_increased = true
		next_dialog = true
		
#	if index_letter < current_text.length() and index_letter % 2 == 0:
#		SoundManager.play_sound(SoundManager.Sound.WRITE)

	print(text_progress)

	if dialogue.size() == index_dialog and current_text.length() == text_progress.length():
		is_finish = true
		timer.stop()

func _on_changed_transmitter_name():
	debug("_on_changed_transmitter_name")
	
func _on_changed_avatar():
	debug("_on_changed_avatar")

func _on_changed_text():
	debug("_on_changed_text")
	
func _on_updated_text():
	debug("_on_updated_text")
	
func _on_start_dialog():
	debug("_on_start_dialog")
	
func _on_end_dialog():
	debug("_on_end_dialog")