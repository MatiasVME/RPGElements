extends Node

func _ready():
	$RPGDialog.connect("changed_transmitter_name", self, "_on_changed_transmitter_name")
	$RPGDialog.connect("changed_avatar", self, "_on_changed_avatar")
	$RPGDialog.connect("updated_text", self, "_on_udated_text")
	$RPGDialog.connect("start_dialog", self, "_on_start_dialog")
	$RPGDialog.connect("end_dialog", self, "_on_end_dialog")
	
	
	$RPGDialog.add_section("Pedro", "TEST123", null)
	$RPGDialog.add_section("Pedro", "Hola estimado ¿Cómo ha estado?", null)
	$RPGDialog.add_section("Juan", "Hola ¿Qué tal?, ¿Bién y usted?", null)
	$RPGDialog.add_section("Pedro", "Bién acá programando un juego", null)
	$RPGDialog.add_section("Juan", "Ohh eso me parece genial", null)
	$RPGDialog.add_section("Pedro", "Gracias", null)

func _on_changed_transmitter_name():
	if $RPGDialog.get_transmitter_name() != null:
		$Title/Name.text = $RPGDialog.get_transmitter_name()
	
func _on_changed_avatar():
	# TODO: hacer que cambie el avatar también
	return
	
func _on_udated_text():
	if $RPGDialog.get_text() != null:
		$Dialog/Text.text = $RPGDialog.get_text()
		
func _on_start_dialog():
	$Anim.play("show")
	
func _on_end_dialog():
	$Anim.play_backwards("show")

func _on_Delay_timeout():
	$RPGDialog.start_dialog()
