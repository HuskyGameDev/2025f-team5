extends Node

# This might need changed later but this is for referencing UI elements from anywhere
# - Values are set by the UI elements on _ready()
var dna_menu

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
		"threshold": 20,
		"cards": [
			{
				"name": "Fast Walk",
				"effect_type": "movement", #can probably be an enum
				"description": "High Speed, Low Damage",
				"positive": "+ Increases your walking speed by 50 units",
				"negative": "- Decreases damage by 1",
				"sprite": null,
				"health": 0,
				"speed": 50,
				"shot_speed": 0,
				"bullet_lifetime": 0,
				"damage": -1.0,
				"firerate": 0,
				"bullet": null,
			},
			{
				"name": "Bullet Spray",
				"effect_type": "shooting",
				"description": "Bullet Spray",
				"positive": "+ Turns your firerate WAY UP",
				"negative": "- Makes your bullets smaller\n- Large damage decrease",
				"sprite": null,
				"health": 0,
				"speed": 0,
				"shot_speed": 0,
				"bullet_lifetime": 0,
				"damage": -5.0,
				"firerate": -0.4,
				"bullet": null,
			},
			{
				"name": "Nothing Ever Happens",
				"effect_type": "None",
				"description": "Nothing ever happens",
				"positive": "+ N/a",
				"negative": "- N/a",
				"sprite": null,
				"health": 0,
				"speed": 0,
				"shot_speed": 0,
				"bullet_lifetime": 0,
				"damage": 0,
				"firerate": 0,
				"bullet": null,
			}
		],
	},
}
