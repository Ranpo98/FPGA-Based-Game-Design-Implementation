module jumpstate(
    input logic Clock, Reset, 
	input logic [7:0] Keycode,
	output logic [2:0] outstate 
);

	enum logic [2:0] { Main_Menu, 
                       Game,
					   Pause 	

						}   State, Next_state;   // Internal state logic
	always_ff @ (posedge Clock)
	begin
		if (Reset) 
			State <= Main_Menu;
		else 
			State <= Next_state;
	end

    always_comb 
    begin
        // Default next state is staying at current state
		Next_state = State;

        unique case(State)
			Main_Menu: 
				begin
					if(Keycode == 8'd44) // space 
						Next_state = Game; 
					else 
						Next_state = Main_Menu; 
				end 
			Game:
				begin
					if(Keycode == 8'd41) // esc 
						Next_state = Pause; 
					else 
						Next_state = Game; 
				end
			Pause: 
			begin 
				if(Keycode != 9'h0)
					Next_state = Game;
				else 
					Next_state = Pause; 
			end 
		endcase 
		
		unique case(State)

			Main_Menu:
			// probably output some main screen menu 
				outstate = 3'b000; 
			Game: 
			// the actual gameplay logic
				outstate = 3'b001;  
			Pause:
			// pause screen 
				outstate = 3'b010;
		endcase 


    end


endmodule 