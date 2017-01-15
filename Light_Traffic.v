
module Light_Traffic (A, B, R, Clk, A_Traffic, B_Traffic,count,finished,first_both_red,A_Light, B_Light,A_Time_L,A_Time_H,B_Time_L,B_Time_H);

    input A, B, R, Clk, A_Traffic, B_Traffic,finished,first_both_red;
    output count,A_Light, B_Light,[3:0] A_Time_L,[3:0] A_Time_H,[3:0] B_Time_L,[3:0] B_Time_H;
    reg [3:0] state;
    parameter S0 = 3'b100, S1 = 3'b101, S2 = 3'b000, S3 = 3'b001, S4=3'b010, S5=3'b011, //Auto
                 S6=3'b100, S7=3'b010, //Police_Handle
                 S8=3'b010, S9=3'b011, S10=3'b000, S11=3'b001; //Wink
    
    always @ (posedge Clk or negedge R)
        if (~R) state = S0; //Initialize to state S0
        else if(~A & ~B)
            case (state)
                S0: state = S1;
                S1: if(finished) state = S2;
                S2: state = S3;
                S3: if(finished) begin
                        if(~first_both_red) 
                            state = S4;
                        else begin
                            if(~(A_Traffic & B_Traffic))
                                state=S8;
                            else
                                state = S0;
                        end
                    end
                S4: state=S5;
                S5: if(finished) state=S2;
                //5s Check
                //assign output
                S8: state=S9;
                S9: if(finished) state=S10;
                S10: state=S11;
                S11: if(finished) state=S8;
            endcase
        else begin
            if(A)
                state=S6;
            else if(B)
                state=S7;
        end

    assign #10 AB = state[2:1];
    assign #10 count= state[0];

endmodule

module counter_A (En,Q,CLK,RST);
    input En,CLK,RST;
    output [7:0]Q;
    reg [7:0] num;
    always @ (posedge CLK)
        if (~RST) state = 9'b0;
        else
            if (En)
                num=num+1;
    assign #10 Q = num;
endmodule

module counter_B (En,Q,CLK,RST);
    input En,CLK,RST;
    output [7:0]Q;
    reg [7:0] num;
    always @ (posedge CLK)
        if (~RST) state = 9'b0;
        else
            if (En)
                num=num+1;
    assign #10 Q = num;
endmodule

module main(A, B, R, Clk, A_Traffic, B_Traffic,A_Light, B_Light,A_Time_L,A_Time_H,B_Time_L,B_Time_H);
   
    input A, B, R, Clk, A_Traffic, B_Traffic;
    output A_Light, B_Light,[3:0] A_Time_L,[3:0] A_Time_H,[3:0] B_Time_L,[3:0] B_Time_H;                                                                                                                                                                                       
    reg count, finished;
    wire [15:0]Q;
    //5s Check
    //assign output
    //wich use of cnt 5 or 95?
    //solve first_both_red,A_Light for pass
    Light_Traffic (A, B, R, Clk, A_Traffic, B_Traffic,count,finished,first_both_red,A_Light, B_Light,A_Time_L,A_Time_H,B_Time_L,B_Time_H);
    counter8 my_counter(En,Q,CLK,RST);
    and a(finished,Q[2], Q[1], Q[0]);
endmodule