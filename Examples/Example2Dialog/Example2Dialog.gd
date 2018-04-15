extends Node

func _ready():
		$RPGDialog.connect("changed_transmitter_name", self, "_on_changed_transmitter_name")
		$RPGDialog.connect("changed_avatar", self, "_on_changed_avatar")
		$RPGDialog.connect("updated_text", self, "_on_udated_text")
	
		$RPGDialog.add_section("Pedro picapiedras", "hablo muchas cosas blab jlkfj s kflj askfj ", null)
		$RPGDialog.add_section("Holaxs", "hafsgfdg dgdf  gf  balblakjsdlk asdjlkfj s kflj askfj ", null)
		$RPGDialog.add_section("xD", "sdfsdaf jsdlk asdjlkfj s kflj askfj ", null)
		$RPGDialog.add_section("Pedro sd", "hablogd g fdgb balblakjsdllkfj s kflj askfj ", null)
		$RPGDialog.add_section("fdsa picapiedras", "hablo mgdf  gdgdgs blab bdjlkfj s kflj askfj ", null)
		$RPGDialog.add_section("Pedro fads", "hablo muchas cosas blab bal s kflj askfj ", null)
#		self.set_current_dialog(i_dialog.get_dialogue())
		$RPGDialog.start_dialog()

func _on_changed_transmitter_name():
	$Title/Name.text = $RPGDialog.get_text()
	
func _on_changed_avatar():
	# TODO: hacer que cambie el avatar también
	return
	
func _on_udated_text():
	$Dialog/Text.text = $RPGDialog.get_text()