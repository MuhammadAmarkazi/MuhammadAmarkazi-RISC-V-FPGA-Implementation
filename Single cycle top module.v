`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2024 04:33:21 PM
// Design Name: 
// Module Name: Single_cycle_top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


///We'r writing top module for load word instruction///

module Single_cycle_top_module(clk,rst);
//we used here clk for syncronization of compnents///
input clk,rst;

wire [31:0] pc, RD_instr, ScrB_top, ScrA_top,Pc_addertop,PCTarget1,PCNext,ALUResult_A,ReadData
            ,WriteData,mux_SrcB_top,Result;
wire RegWrite,MemWrite,ALUSrc,Branch,Zero,PCSrc;
wire [1:0] ResultSrc;
wire [1:0] ImmSrc;
///wire  [1:0] ALUOp;
wire [2:0]  ALUControl_top;
//Module Instantiation of PC for creating hirearcy  ///

PC_mem PC(
          .clk(clk),
          .rst(rst),
          .PC_NEXT(PCNext),
          .PC(pc)
          );
PCPlus4 pc_adder(
            .a(pc),
            .b(32'd4),
            .s(Pc_addertop)
            );
mux2_1 mux2(
            .a(Pc_addertop),
            .b(PCTarget1),
            .s(PCSrc),
            .result(PCNext)
                        );
PCPlus4 PCTarget(
                        .a(pc),
                        .b(mux_SrcB_top),
                        .s(PCTarget1)
                        );

Instr_mem instruction_memory(
          .rst(rst),
          .A(pc),
          .RD(RD_instr)
          );

Reg_mem Reg_mem(
          .clk(clk),
          .rst(rst),
          .WE3(RegWrite),
          .A1(RD_instr[19:15]),
          .A2(RD_instr[24:20]),
          .A3(RD_instr[11:7]),
         /// .WD3(I_typeresult),
         .WD3(Result),
          .RD1(ScrA_top),
          //.RD2(WriteData)
          .RD2(WriteData)
          );
     
sign_ext sign_extension(
          .In(RD_instr),
          .ImmExt(mux_SrcB_top),
           .ImmSrc(ImmSrc)
);

mux2_1 mux(
            .a(WriteData),
            .b(mux_SrcB_top),
            .s(ALUSrc),
            .result(ScrB_top)
            );

ALU_8 alu(
           .A(ScrA_top),
           .B(ScrB_top),
           .ALUControls(ALUControl_top),
           .result(ALUResult_A),
           .Zero(Zero),
           .N(),
           .C(),
           .V(),
           .stl()
);

mux4_1 mux3(
            .a(ALUResult_A),
                .b(ReadData),
                .c(Pc_addertop),
                .d(),
                .s(ResultSrc),
                .result(Result)
                 );
            
data_mem data_memory(
            .A(ALUResult_A),
            .WD(WriteData),
            .clk(clk),
            .rst(rst),
            .WE(MemWrite),
            ///.RD(I_typeresult)
             .RD(ReadData)
);

Control_unit_top Control_unit(
                .Op(RD_instr[6:0]) ,
                .func3(RD_instr[14:12]),
                .func7(RD_instr[30]),
                .ResultSrc(ResultSrc),
                 .PCSrc(PCSrc),
                 .MemWrite(MemWrite),
                 .AluSrc(ALUSrc),
                 .ImmSrc(ImmSrc),
                 .RegWrite(RegWrite),
                 /// .ALUOp(ALUOp[1:0]),
                 .Branch(Branch),
                 .Zero(Zero),
                 .ALUControl(ALUControl_top)
       );

endmodule
