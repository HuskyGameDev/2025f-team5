extends Node

# Create globals for bullet body and sprite

var bullet_types = {
	"default": {"sprite": "res://Resource/Bullet/Sprite2D/default_bullet.tres", "collision_body": "res://Resource/Bullet/CollisionShape2D/default_bullet.tres"},
	"mini": {"sprite": "res://Resource/Bullet/Sprite2D/mini_bullet.tres", "collision_body": "res://Resource/Bullet/CollisionShape2D/mini_bullet.tres"}
}

# for values that are numbers, such as health, the number returned is a modifier
# i.e. "health": -1 -> player has 1 less hp than before
# 
# bullet modifier is either null for no changes, or the name of its bullet type
var dna_types = {
	"mini": {
		"rarity": 1, # Rarity describes how many are needed for a level up - 1 means 1 kill
		"health": 0,
		"speed": 50,
		"shot_speed": 0,
		"bullet_lifetime": -1.0,
		"damage": -5.0,
		"firefirate": -0.4,
		"bullet": "mini"
	}
}
