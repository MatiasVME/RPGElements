extends Node

func _ready():
	$RPGDialog.connect("changed_transmitter_name", self, "_on_changed_transmitter_name")
	$RPGDialog.connect("changed_avatar", self, "_on_changed_avatar")
	$RPGDialog.connect("updated_text", self, "_on_udated_text")
	$RPGDialog.connect("start_dialog", self, "_on_start_dialog")
	$RPGDialog.connect("end_dialog", self, "_on_end_dialog")
	$RPGDialog.connect("changed_text", self, "_on_change_text")
	$RPGDialog.connect("end_section", self, "_on_end_section")
	
	$RPGDialog.add_section("Pedro", "Hola estimado ¿Cómo ha estado?")
	$RPGDialog.add_section("Juan", "Hola ¿Qué tal?, ¿Bién y usted?")
	$RPGDialog.add_section("Pedro", "Bién acá programando un juego")
	$RPGDialog.add_section("Juan", "Ohh eso me parece genial")
	$RPGDialog.add_section("Pedro", "Gracias")

func _on_changed_transmitter_name():
	if $RPGDialog.get_transmitter_name() != null:
		$Title/Name.text = $RPGDialog.get_transmitter_name()
	
func _on_udated_text():
	if $RPGDialog.get_text() != null:
		$Dialog/Text.text = $RPGDialog.get_text()
		
func _on_start_dialog():
	$Anim.play("show")
	
func _on_end_dialog():
	$Anim.play_backwards("show")

func _on_Delay_timeout():
	$RPGDialog.start_dialog()
	
func _on_change_text():
	$Dialog/Button.disabled = true

func _on_Button_pressed():
	$RPGDialog.next_pressed()

func _on_end_section():
	$Dialog/Button.disabled = false
