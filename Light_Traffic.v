
module Light_Traffic (A, B, Clk, A_Traffic, B_Traffic);

    input A, B, Clk, A_Traffic, B_Traffic;
    output A_Light, B_Light,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0];
    
    wire Enable_PO_Handle;
    wire Enable_Auto;

    assign Enable_PO_Handle=A|B;
    assign Enable_Auto=~Enable_PO_Handle;

endmodule

module PO_Handle(Enable_PO_Handle,A_Light, B_Light,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0]);

    input Enable_PO_Handle;
    output A_Light, B_Light,A_Time_L[3:0],A_Time_H[3:0],B_Time_L[3:0],B_Time_H[3:0];

endmodule

module Light_Auto(Enable_Auto,)