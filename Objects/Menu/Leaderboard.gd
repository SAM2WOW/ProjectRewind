extends Control

signal on_leaderboard_closed

const ScoreItem = preload("res://addons/silent_wolf/Scores/ScoreItem.tscn")

var list_index = 0
var ld_name = "main"


func _ready():
	loading_board()


func loading_board():
	# Reset list index
	list_index = 0
	
	print("SilentWolf.Scores.leaderboards: " + str(SilentWolf.Scores.leaderboards))
	print("SilentWolf.Scores.ldboard_config: " + str(SilentWolf.Scores.ldboard_config))
	#var scores = SilentWolf.Scores.scores
	var scores = []
	if ld_name in SilentWolf.Scores.leaderboards:
		scores = SilentWolf.Scores.leaderboards[ld_name]
	var local_scores = SilentWolf.Scores.local_scores
	
	if len(scores) > 0: 
		render_board(scores, local_scores)
	else:
		# use a signal to notify when the high scores have been returned, and show a "loading" animation until it's the case...
		add_loading_scores_message()
		yield(get_tree().create_timer(0.1), "timeout")
		yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
		hide_message()
		render_board(SilentWolf.Scores.scores, local_scores)


func render_board(scores, local_scores):
	var all_scores = scores
	if ld_name in SilentWolf.Scores.ldboard_config and is_default_leaderboard(SilentWolf.Scores.ldboard_config[ld_name]):
		all_scores = merge_scores_with_local_scores(scores, local_scores)
		if !scores and !local_scores:
			add_no_scores_message()
	else:
		if !scores:
			add_no_scores_message()
	for score in scores:
		add_item(score.player_name, str(int(score.score)))


func is_default_leaderboard(ld_config):
	var default_insert_opt = (ld_config.insert_opt == "keep")
	var not_time_based = !("time_based" in ld_config)
	return  default_insert_opt and not_time_based


func merge_scores_with_local_scores(scores, local_scores, max_scores=10):
	if local_scores:
		for score in local_scores:
			var in_array = score_in_score_array(scores, score)
			if !in_array:
				scores.append(score)
			scores.sort_custom(self, "sort_by_score");
	var return_scores = scores
	if scores.size() > max_scores:
		return_scores = scores.resize(max_scores)
	return return_scores


func sort_by_score(a, b):
	if a.score > b.score:
		return true;
	else:
		if a.score < b.score:
			return false;
		else:
			return true;


func score_in_score_array(scores, new_score):
	var in_score_array =  false
	if new_score and scores:
		for score in scores:
			if score.score_id == new_score.score_id: # score.player_name == new_score.player_name and score.score == new_score.score:
				in_score_array = true
	return in_score_array


func add_item(player_name, score):
	var item = ScoreItem.instance()
	list_index += 1
	item.get_node("MarginContainer/HBoxContainer/PlayerName").text = str(list_index) + str(". ") + player_name
	item.get_node("MarginContainer/HBoxContainer/Score").text = score
	item.margin_top = list_index * 100
	$MarginContainer/VBoxContainer/CenterContainer/ScrollContainer/ScoreContainer.add_child(item)
	item.get_node("AnimationPlayer").play("intro")

func add_no_scores_message():
	var item = $MarginContainer/VBoxContainer/CenterContainer/Message
	item.text = "No scores yet!"
	item.show()
	item.margin_top = 135


func add_loading_scores_message():
	var item = $MarginContainer/VBoxContainer/CenterContainer/Message
	item.text = "Loading scores..."
	item.show()
	item.margin_top = 135


func hide_message():
	$MarginContainer/VBoxContainer/CenterContainer/Message.hide()


# Submit Scores
func _on_Submit_pressed():
	var name = $MarginContainer/VBoxContainer/HBoxContainer/NameEdit.get_text()
	if not name.empty():
		SilentWolf.Scores.persist_score(name, (Global.Console.money * 100))
	
	$MarginContainer/VBoxContainer/HBoxContainer/NameEdit.hide()
	$MarginContainer/VBoxContainer/HBoxContainer/Submit.hide()
	
	refresh_board()


# Closed
func _on_Close_pressed():
	emit_signal("on_leaderboard_closed")


# Refresh
func _on_Refresh_pressed():
	refresh_board()


func refresh_board():
	var scorebox = $MarginContainer/VBoxContainer/CenterContainer/ScrollContainer/ScoreContainer
	for i in scorebox.get_children():
		i.queue_free()
	loading_board()
