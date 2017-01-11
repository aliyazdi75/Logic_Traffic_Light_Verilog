
module Light_Traffic (A, B, R, Clk, A_Traffic, B_Traffic);

    input A, B, R, Clk, A_Traffic, B_Traffic;
    
    wire Enable_PO_Handle;
    wire Enable_Auto;

    assign Enable_PO_Handle=A|B&~R;
    assign Enable_Auto=~Enable_PO_Handle;

    PO_Handle poh= PO_Handle(Enable_PO_Handle,A,B,A_Light, B_Light,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0]);
    Light_Auto la=Light_Auto(Enable_Auto,Clk, A_Traffic, B_Traffic, A_Light, B_Light,1,1)

endmodule

module PO_Handle(Enable_PO_Handle,A,B,A_Light, B_Light,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0]);

    input Enable_PO_Handle;
    output A_Light, B_Light, A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0];
    if (Enable_PO_Handle) begin
        assign A_Light=A;
        assign B_Light=B;
        assign A_Time_L[0]=1;
        assign A_Time_L[1]=1;
        assign A_Time_L[2]=1;
        assign A_Time_L[3]=1;
        assign B_Time_L[0]=1;
        assign B_Time_L[1]=1;
        assign B_Time_L[2]=1;
        assign B_Time_L[3]=1;
    end

endmodule

module Light_Auto(Enable_Auto, Clk, A_Traffic, B_Traffic, A_Light, B_Light, Finished, Exsi_Traffic);
    
    input Enable_Auto, Clk, A_Traffic, B_Traffic, Finished, Exsi_Traffic;
    output A_Light, B_Light;
    Count

endmodule

module A_Green_Counter(Rst,En,Clk,Finished,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0]);

    input Rst,En,Clk;
    output Finished,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0];

endmodule 

module B_Green_Counter(Rst,En,Clk, Finished,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0]);

    input Rst,En,Clk;
    output Finished,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0];

endmodule

module Check_Traffic(End_Period,Clk,A_Traffic,B_Traffic, Exsi_Traffic,Count,Finished);

    input End_Period,Clk,A_Traffic,B_Traffic,Finished;
    output Count,Exsi_Traffic;

endmodule

module Check_Traffic_Counter(Rst,En,Finished);
    
    input Rst,En;
    output Finished;

endmodule

module Light_Wink(Exsi_Traffic,Count,Finished,A_Light,B_Light,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0]);

    input Exsi_Traffic,Finished;
    output Count,A_Light,B_Light,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0];

endmodule

module Light_Wink_Counter(Rst,En,Finished);
    
    input Rst,En;
    output Finished;

endmodule
