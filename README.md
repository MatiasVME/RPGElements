# RPGElements [WIP]

![logo](https://github.com/MatiasVME/RPGElements/blob/master/images/RPGElementsFull.png)

[Work In Progress] RPGElements es un plugin que facilita la lógica para crear juegos RPG a través de nodos personalizados

## Resumen

RPGElements es una solución genérica a la lógica que presentan los juegos RPG.

Por ejemplo: Con el nodo RPGCharacter podrá representar la lógica de un personaje, como podría ser el añadirle experiencia. Con el nodo RPGItem podrá representar un item del juego, tiene todas las características comúnes de un item (item_name, description, amount, buy_price, sell_price, etc.)

## Estado del proyecto

El proyecto es usable, aunque hay algunos nodos que no estan muy testeados y también algunos nodos contienen métodos incompletos.

En su mayor parte los nodos personalizados son usables. A continuación se dice el estado de los nodos:

![](https://github.com/MatiasVME/RPGElements/blob/master/addons/rpg_elements/icons/RPGCharacter.png) **RPGCharacter:** Muy usable

![](https://github.com/MatiasVME/RPGElements/blob/master/addons/rpg_elements/icons/RPGDialog.png) **RPGDialog:** Muy usable

![](https://github.com/MatiasVME/RPGElements/blob/master/addons/rpg_elements/icons/RPGInventory.png) **RPGInventory:** Usable, aunque contiene métodos no testeados y incompletos.

![](https://github.com/MatiasVME/RPGElements/blob/master/addons/rpg_elements/icons/RPGItem.png) **RPGItem:** Muy usable

![](https://github.com/MatiasVME/RPGElements/blob/master/addons/rpg_elements/icons/RPGStats.png) **RPGStats:** Muy usable

![](https://github.com/MatiasVME/RPGElements/blob/master/addons/rpg_elements/icons/RPGWeightInventory.png) **RPGWeightInventory:** Usable, aunque contiene métodos no testeados y incompletos.

![](https://github.com/MatiasVME/RPGElements/blob/master/addons/rpg_elements/icons/RPGSlotInventory.png) **RPGSlotInventory:** No creado aún

## Instalación y uso

### Deseo testear el plugin

Para testear el plugin usted puede clonar el repositorio y abrirlo con **Godot 3.0.x** podrá encontrar una carpeta **test_addons** con ejemplos de uso.

### Deseo usar el plugin en un proyecto

Para usar el plugin en un proyecto requiere hacer los siguientes pasos:

1) Descargar o clonar el proyecto.

2) Copiar la carpeta addons del proyecto descargado y añadir esa carpeta en la raiz de su proyecto actual.

3) Abrir el editor y activar el plugin en **proyectos >> ajustes del proyecto >> plugins**

## Nodos personalizados

A continuación se describira el uso de los nodos personalizados, si tiene dudas del funcionamiento de algún método puede levantar un issue de github o puede consultar el código fuente del respectivo nodo que esta utilizando. Los métodos estan en inglés pero los comentarios en español.

### RPGCharacter

RPGCharacter es un nodo personalizado que se usa para la lógica de los juegos RPG. El nodo contiene un sistema de niveles, por lo que se puede añadir experiencia, subir de nivel, etc.

Suponiendo que usted tiene el nodo $RPGCharacter en su escena veamos el siguiente ejemplo:

```gdscript
extends Node

func _ready():
	# $RPGCharacter es un player, podría también podría ser un character NPC
	$RPGCharacter.player_name = "$RPGCharacter"
	
	# Añade xp y sube de nivel
	$RPGCharacter.add_xp(1)
	$RPGCharacter.add_xp(10)
	
	# HP
	#
	
	$RPGCharacter.remove_hp(3)
    $RPGCharacter.remove_hp(100)
	$RPGCharacter.revive()
    $RPGCharacter.remove_hp(5)
	$RPGCharacter.add_hp(1)
	$RPGCharacter.add_hp(5)

	# Energía
	#

	$RPGCharacter.remove_energy(5)
	$RPGCharacter.add_energy(1)

	# Damage (recibe daño, toma en cuenta la defensa)
	# 
	
	$RPGCharacter.damage(3)
	$RPGCharacter.set_defense_rate(50)
	$RPGCharacter.damage(30)

```

También RPGCharacter contiene las siguientes señales, para que usted pueda realizar eventos si ocurre algo:

```gdscript
signal level_up(current_level)
signal add_xp(amount)
# El amount es la cantidad que se añadió, no siempre es la
# cantidad enviada por medio de "add_hp(amount)"
signal add_hp(amount)
signal remove_hp(amount)
signal full_hp
signal dead
signal revive
signal add_energy(amount)
signal remove_energy(amount)
signal full_energy
signal no_energy
```

### RPGDialog

RPGDialog es un nodo personalizado que gestiona dialogos, se encarga de escribir letra por letra (Como una máquina de escribir) y emite señales por cada evento importante que pase.

![](https://github.com/MatiasVME/RPGElements/blob/master/images/animations/RPGDialog.gif)

Tomando en cuenta que usted añadión RPGDialog a la escena, a continuación un ejemplo:

```gdscript
extends Node

func _ready():
    # Estas mismas señales se pueden añadir desde el editor
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

```

Puede ver este ejemplo ya funcionando en el directorio **test_addons/rpg_elements/example_dialog/**
