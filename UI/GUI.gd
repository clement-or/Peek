extends Node2D

onready var progress_bar = $VBoxContainer/HBoxContainer/ProgressBar

func _ready():
	pass

func set_progress_range(mini, maxi):
	progress_bar.min_value = mini
	progress_bar.max_value = maxi

func set_progress(value):
	progress_bar.value = value

func toggle_progress_bar():
	progress_bar.visible = !progress_bar.visible()