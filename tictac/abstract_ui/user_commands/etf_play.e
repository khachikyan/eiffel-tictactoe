note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE
		redefine play end
create
	make
feature -- command
	play(player: STRING ; press: INTEGER_64)
		require else
			play_precond(player, press)
    	do
    		model.reset
    		if model.g.player_1.name ~ "" or model.g.player_2.name ~ "" then
    			model.set_report (model.out_player_dne + model.out_start_new_game)

    		elseif model.g.player_1.name /~ player and model.g.player_2.name /~ player then
    			model.set_report (model.out_player_dne + model.g.turn.name + model.out_plays_next)

    		elseif model.g.turn.name /~ player then
    			model.set_report (model.out_wrong_turn + model.g.turn.name + model.out_plays_next)

    		elseif model.g.game_board.get_piece_at (press.as_integer_32) /~ model.g.game_board.empty_field then
    			model.set_report (model.out_button_taken + model.g.turn.name + model.out_plays_next)
    			
    		else
    			model.g.add_move (press.to_integer_32, model.g.turn.piece)
				model.set_report (model.out_report_success + model.g.turn.name + model.out_plays_next)
    		end


			etf_cmd_container.on_change.notify ([Current])
    	end

end
