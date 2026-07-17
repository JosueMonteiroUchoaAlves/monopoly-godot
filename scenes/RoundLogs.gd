extends Control

@onready var label: RichTextLabel = $PanelContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.round_log.connect(log_the_text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func log_the_text(log_text:String):
	label.append_text(log_text + "\n")
