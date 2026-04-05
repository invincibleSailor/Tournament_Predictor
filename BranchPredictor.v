module BranchPredictor#(
	parameter PC_bits=6,
	parameter Hist_bits=4
)(
	input wire clk,
	input wire rst,
	input wire [PC_bits-1:0] pc,
	input wire actual_outcome,
	output wire prediction
);
	reg [Hist_bits-1:0] GHR; //Global History Register
	reg [1:0] global_PHT [0:(1<<Hist_bits)-1]; // Global Prediction History Table
	reg [Hist_bits-1:0] local_LHT [0:(1<<PC_bits)-1]; // Local History Table
	reg [1:0] local_PHT [0:(1<<Hist_bits)-1];	// Local Prediction History Table
	reg [1:0] choice_PHT [0:(1<<Hist_bits)-1]; //Choice Predictor Table
	
	wire [Hist_bits-1:0] global_index;
	wire [Hist_bits-1:0] local_hist;
	
	assign global_index = GHR;
	assign local_hist   = local_LHT[pc];
	
	wire global_pred;
   wire local_pred;
   wire choose_global;

	assign global_pred  = global_PHT[global_index][1];
   assign local_pred   = local_PHT[local_hist][1];
   assign choose_global = choice_PHT[global_index][1];
	
	assign prediction = choose_global ? global_pred : local_pred;
	task automatic update_counter;
		inout [1:0] counter;
		input taken;
		begin
			if(taken && counter != 2'b11)
				counter = counter + 1'b1;
			else if (!taken && counter != 2'b00)
				counter = counter - 1'b1;
		end
	endtask
	integer i;
	
	always @(posedge clk or posedge rst) begin
		if(rst)begin
			GHR<=0;
			for (i=0;i<(1<<Hist_bits);i=i+1) begin
				global_PHT[i]<=2'b01;
				local_PHT[i]<=2'b01;
				choice_PHT[i]<=2'b01;
			end
			for (i=0;i<(1<<PC_bits);i=i+1)
				local_LHT[i]<=0;
				
			end else begin
			update_counter(global_PHT[global_index], actual_outcome);
			update_counter(local_PHT[local_hist],actual_outcome);
			if (global_pred != local_pred) begin
				if(global_pred == actual_outcome)
					update_counter(choice_PHT[global_index],1'b1);
				else
					update_counter(choice_PHT[global_index],1'b0);
			end
			
			local_LHT[pc]<={local_hist[Hist_bits-2:0],actual_outcome};
			GHR<={GHR[Hist_bits-2:0],actual_outcome};
		end
	end
endmodule
			
				
			