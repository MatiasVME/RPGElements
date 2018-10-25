# MIT License
#
# Copyright (c) 2018 Matías Muñoz Espinoza
# Copyright (c) 2018 Jovani Pérez
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

export (String) var player_name setget set_player_name, get_player_name

export (int) var level = 1 setget get_level
export (int) var level_max = 30 setget get_level_max, set_level_max

# Vitalidad
export (int) var hp = 0 setget set_hp, get_hp
export (int) var max_hp = 10 setget set_max_hp, get_max_hp
# Mana
export (int) var energy = 0 setget set_energy, get_energy
export (int) var max_energy = 10 setget set_max_energy, get_max_energy
# var defense = 0 # TODO: Implementar defensa en un futuro

var xp = 0
var xp_required = get_xp_required(level + 1)
var xp_total = 0

signal level_up
signal gain_xp
signal add_hp
signal remove_hp
signal full_hp
signal dead
signal add_energy
signal remove_energy
signal full_energy
signal no_energy
# signal add_defense # TODO
# signal remove_defense # TODO

func _ready():
	# Signals
	if debug:
		connect("level_up", self, "_on_level_up")
		connect("gain_xp", self, "_on_gain_xp")
		connect("add_hp", self, "_on_add_hp")
		connect("remove_hp", self, "_on_remove_hp")
		connect("full_hp", self, "_on_full_hp")
		connect("dead", self, "_on_dead")
		connect("add_energy", self, "_on_add_energy")
		connect("remove_energy", self, "_on_remove_energy")
		connect("full_energy", self, "_on_full_energy")
		connect("no_energy", self, "_on_no_energy")
#		connect("", self, "_on_")

# Métodos Públicos
#

func gain_xp(amount):
	xp_total += amount
	xp += amount
	
	while xp >= xp_required:
		xp -= xp_required
		
		level_up()
	
	emit_signal("gain_xp")

func level_up():
	level += 1
	xp_required = get_xp_required(level + 1)
	
	emit_signal("level_up")

func add_hp(_hp):
	if hp + _hp < max_hp:
		hp += _hp
		emit_signal("add_hp")
	else: # Significa que se esta añadiendo más hp de lo que se podría
		hp = max_hp
		emit_signal("add_hp")
		emit_signal("full_hp")
	
func remove_hp(_hp):
	if _hp > 0:
		if hp - _hp > 0:
			hp -= _hp
			emit_signal("remove_hp")
		else:
			hp = 0
			emit_signal("dead")
	else:
		.debug("No se puede eliminar esa cantidad de HP")
	
func add_energy(_energy):
	if energy + _energy < max_energy:
		energy += _energy
		emit_signal("add_energy")
	else:
		energy = max_energy
		emit_signal("full_energy")

func remove_energy(_energy):
	if _energy > 0:
		if energy - _energy > 0:
			energy -= _energy
			emit_signal("remove_energy")
		else:
			energy = 0
			emit_signal("no_energy")
	else:
		.debug("No se puede eliminar esa cantidad de energía")

func restore_hp():
	hp = max_hp
	emit_signal("full_hp")

# Setters/Getters
#

func get_xp():
	return xp

func get_xp_required(_level):
	return round(pow(_level, 1.8) + _level * 4)
	
func get_level():
	return level
	
func get_level_max():
	return level_max
	
func set_level_max(_level_max):
	level_max = _level_max

func set_player_name(_player_name):
	player_name = _player_name
	
func get_player_name():
	return player_name
	
func set_hp(_hp):
	hp = _hp
	
	if hp > max_hp:
		hp = max_hp
		emit_signal("full_hp")
	elif hp <= 0:
		hp = 0
		emit_signal("dead")
	
func get_hp():
	return hp
	
func set_max_hp(_max_hp):
	if _max_hp > 0:
		max_hp = _max_hp
	else:
		.debug("_max_hp tiene que ser mayor que 0")
	
func get_max_hp():
	return max_hp

func set_energy(_energy):
	energy = _energy
	
	if energy > max_energy:
		energy = max_energy
		emit_signal("full_energy")
	elif energy <= 0:
		energy = 0
		emit_signal("no_energy")
	
func get_energy():
	return energy
	
func set_max_energy(_max_energy):
	max_energy = _max_energy
	
func get_max_energy():
	return max_energy

# Señales
#

func _on_level_up():
	.debug("Has subido de nivel!!: ", level)
	
func _on_get_xp():
	.debug("Obtener XP: ", xp)
	
func _on_gain_xp():
	.debug("Añadir HP: ", hp)
	
func _on_remove_hp():
	.debug("Eliminar HP: ", hp)
	
func _on_full_hp():
	.debug("HP esta lleno: ", hp)
	
func _on_dead():
	.debug("Has muerto: ", hp)

func _on_add_energy():
	.debug("Añadir energía: ", energy)

func _on_remove_energy():
	.debug("Eliminar energía: ", energy)
	
func _on_full_energy():
	.debug("Estas lleno de energía: ", energy)
	
func _on_no_energy():
	.debug("No queda energía: ", energy)

# Métodos "Privados"
#