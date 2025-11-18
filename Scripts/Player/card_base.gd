extends Control

func set_card_info(card: Card):
	$Panel/CardFront/VBoxContainer/CardName.text = card.cardname
	$Panel/CardBack/VBoxContainer/CardName.text = card.cardname
	$Panel/CardFront/VBoxContainer/CardDescription.text = card.description
	# Not yet implemented, will need further testing
	# $CardFront/MarginContainer/VBoxContainer/TextureRect.texture = card.sprite
	$Panel/CardBack/VBoxContainer/CardPositives.text = "\n".join(card.positives)
	$Panel/CardBack/VBoxContainer/CardNegatives.text = "\n".join(card.negatives)

func toggle_side():
	if $Panel/CardFront.visible:
		$Panel/CardFront.hide()
		$Panel/CardBack.show()
	else:
		$Panel/CardBack.hide()
		$Panel/CardFront.show()


func _on_panel_mouse_entered():
	toggle_side()


func _on_panel_mouse_exited():
	toggle_side()
