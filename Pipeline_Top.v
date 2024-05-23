`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 11:08:56 PM
// Design Name: 
// Module Name: Pipeline_Top
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


module Pipeline_Top(clk, rst);

input clk, rst;

wire PCSrcE,RegWriteW,RegWriteE,MemWriteE,BranchE,AluSrcE,RegWriteM,MemWriteM;
wire [31:0] PCTargetE,PCPlus4D,InstrD, PCD,ResultW,RD2_E,RD1_E,PCE,ImmExt_E,PCPlus4E, WriteDataM,Alu_Result_M,PCPlus4M,RdM,ReadDataW,PCPlus4W,Alu_Result_W ;
wire [4:0] RdE, RdW;
wire [2:0] ALUControlE;
wire [1:0] ResultSrcE,ResultSrcM,ResultSrcW; 
wire [4:0] Rs1_E, Rs2_E;
wire [1:0] ForwardAE,ForwardBE;

fetch_cycle Fetch(.clk(clk),
                  .rst(rst),
                  .PCSrcE(PCSrcE),
                  .PCTargetE(PCTargetE),
                  .PCPlus4D(PCPlus4D),
                  .InstrD(InstrD),
                  .PCD(PCD));
                  
Decode_cycle Decode(.clk(clk),
                    .rst(rst),
                    .RegWriteW(RegWriteW),
                    .RdW(RdW),
                    .ResultW(ResultW),
                    .InstrD(InstrD),
                    .PCD(PCD),
                    .PCPlus4D(PCPlus4D),
                    .RegWriteE(RegWriteE),
                    .AluSrcE(AluSrcE),
                    .BranchE(BranchE),
                    .MemWriteE(MemWriteE),
                    .ALUControlE(ALUControlE),
                    .ResultSrcE(ResultSrcE),
                    .RD1_E(RD1_E),
                    .RD2_E(RD2_E),
                    .ImmExt_E(ImmExt_E),
                    .PCE(PCE),
                    .PCPlus4E(PCPlus4E),
                    .RdE(RdE),
                    .Rs1_E(Rs1_E),
                    .Rs2_E(Rs2_E));      
          
Execute_cycle Execute(.clk(clk),
                      .rst(rst),
                      .RegWriteE(RegWriteE),
                      .AluSrcE(AluSrcE),
                      .BranchE(BranchE),
                      .MemWriteE(MemWriteE),
                      .ALUControlE(ALUControlE),
                      .ResultSrcE(ResultSrcE),
                      .RD1_E(RD1_E),
                      .RD2_E(RD2_E),
                      .ImmExt_E(ImmExt_E),
                      .PCE(PCE),
                      .PCPlus4E(PCPlus4E),
                      .RdE(RdE),
                      .PCTargetE(PCTargetE),
                      .PCSrcE(PCSrcE),
                      .RegWriteM(RegWriteM),
                      .MemWriteM(MemWriteM),
                      .ResultSrcM(ResultSrcM),
                      .WriteDataM(WriteDataM),
                      .Alu_Result_M(Alu_Result_M),
                      .PCPlus4M(PCPlus4M),
                      .RdM(RdM),
                      .ResultW(ResultW),
                      .ForwardA_E(ForwardAE),
                      .ForwardB_E(ForwardBE));  
                      
Memory_cycle Memory(.clk(clk),
                    .rst(rst),
                    .RegWriteM(RegWriteM),
                    .ResultSrcM(ResultSrcM),
                    .Alu_Result_M(Alu_Result_M),
                    .WriteDataM(WriteDataM),
                    .RdM(RdM),
                    .PCPlus4M(PCPlus4M),
                    .MemWriteM(MemWriteM),
                    .RegWriteW(RegWriteW),
                    .RdW(RdW),
                    .ResultSrcW(ResultSrcW),
                    .ReadDataW(ReadDataW),
                    .PCPlus4W(PCPlus4W),
                    .Alu_Result_W(Alu_Result_W));         
                    
Writeback_cycle Write(.clk(clk), 
                      .rst(rst),
                      .ResultSrcW(ResultSrcW),
                      .ReadDataW(ReadDataW),
                      .PCPlus4W(), 
                      .Alu_Result_W(Alu_Result_W),
                      .ResultW(ResultW));                                                               

Hazard_Unit forwarding_block(. rst(rst) ,
                             . RegWriteW(RegWriteW),
                             . RegWriteM(RegWriteM),
                             . RdM(RdM),
                             . RdW(RdW),
                             . Rs1_E(Rs1_E),
                             . Rs2_E(Rs2_E),
                             . ForwardAE(ForwardAE),
                             . ForwardBE(ForwardBE));
endmodule
