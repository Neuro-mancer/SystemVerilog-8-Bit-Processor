module up3_cu_tb(input logic [3:0] KEY, output logic [9:0] LEDR,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	logic fetch, load_ac, load_pc, inc_pc, load_iru, load_irl, store_mem;
	logic [7:0] pc, opcode, value, ac, mdr, mar, state;
	logic [7:0] left_hex_in, right_hex_in, middle_hex_in;
	
	// remember to initialize LEDs
	up3_cu up3_cu_test(.clk(KEY[0]), .reset(~KEY[1]), .fetch(fetch), 
		.load_ac(load_ac), .load_pc(load_pc), .inc_pc(inc_pc), .load_iru(load_iru),
		.load_irl(load_irl), .store_mem(store_mem), .pc(pc), .opcode(opcode), 
		.value(value), .mdr(mdr), .ac(ac), .mar(mar), .State(state));
		
		always_comb
			begin
				if(KEY[3])
				begin
					left_hex_in = pc;
					right_hex_in = mdr;
					middle_hex_in = mar;
					LEDR[9] = 1;
					LEDR[8] = 0;
					LEDR[7:0] = state;
				end
				else
				begin
					left_hex_in = opcode;
					right_hex_in = ac;
					middle_hex_in = value;
					LEDR[9] = 0;
					LEDR[8] = 0;
					LEDR[7] = 0;
					LEDR[6] = load_ac;
					LEDR[5] = load_iru;
					LEDR[4] = load_irl;
					LEDR[3] = load_pc;
					LEDR[2] = inc_pc;
					LEDR[1] = fetch;
					LEDR[0] = store_mem;
				end
			end
		
	dualseg7 left_display(.dataIn(left_hex_in), .display1(HEX5), .display0(HEX4));
	dualseg7 right_display(.dataIn(right_hex_in), .display1(HEX1), .display0(HEX0));
	dualseg7 middle_display(.dataIn(middle_hex_in), .display1(HEX3), .display0(HEX2));
	

	
endmodule
