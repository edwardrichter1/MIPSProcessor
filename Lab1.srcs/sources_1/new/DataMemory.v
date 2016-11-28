`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - data_memory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the positive clock edge if 'MemWrite' 
// signal is 1. 'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is not 
// clocked.
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData, DataMem); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input Clk;
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 
    input [1:0] DataMem;

    output reg[31:0] ReadData; // Contents of memory location at Address
    reg [31:0] memory [4115:0]; // Data memory can contain 64x64 frame, 4x4 window, and 4 dimensions
    
    initial begin
        //$readmemh("data_memory.txt", memory);
        memory[0] = 32'd32;
        memory[1] = 32'd16;
        memory[2] = 32'd16;
        memory[3] = 32'd16;
        memory[4] = 32'd0;
        memory[5] = 32'd0;
        memory[6] = 32'd0;
        memory[7] = 32'd0;
        memory[8] = 32'd0;
        memory[9] = 32'd0;
        memory[10] = 32'd0;
        memory[11] = 32'd0;
        memory[12] = 32'd0;
        memory[13] = 32'd0;
        memory[14] = 32'd0;
        memory[15] = 32'd0;
        memory[16] = 32'd0;
        memory[17] = 32'd0;
        memory[18] = 32'd0;
        memory[19] = 32'd0;
        memory[20] = 32'd0;
        memory[21] = 32'd0;
        memory[22] = 32'd0;
        memory[23] = 32'd0;
        memory[24] = 32'd0;
        memory[25] = 32'd0;
        memory[26] = 32'd0;
        memory[27] = 32'd0;
        memory[28] = 32'd0;
        memory[29] = 32'd0;
        memory[30] = 32'd0;
        memory[31] = 32'd0;
        memory[32] = 32'd0;
        memory[33] = 32'd0;
        memory[34] = 32'd0;
        memory[35] = 32'd0;
        memory[36] = 32'd0;
        memory[37] = 32'd0;
        memory[38] = 32'd0;
        memory[39] = 32'd0;
        memory[40] = 32'd0;
        memory[41] = 32'd0;
        memory[42] = 32'd0;
        memory[43] = 32'd0;
        memory[44] = 32'd0;
        memory[45] = 32'd0;
        memory[46] = 32'd0;
        memory[47] = 32'd0;
        memory[48] = 32'd0;
        memory[49] = 32'd0;
        memory[50] = 32'd0;
        memory[51] = 32'd0;
        memory[52] = 32'd0;
        memory[53] = 32'd0;
        memory[54] = 32'd0;
        memory[55] = 32'd0;
        memory[56] = 32'd0;
        memory[57] = 32'd0;
        memory[58] = 32'd0;
        memory[59] = 32'd0;
        memory[60] = 32'd0;
        memory[61] = 32'd0;
        memory[62] = 32'd0;
        memory[63] = 32'd0;
        memory[64] = 32'd0;
        memory[65] = 32'd0;
        memory[66] = 32'd0;
        memory[67] = 32'd0;
        memory[68] = 32'd0;
        memory[69] = 32'd0;
        memory[70] = 32'd0;
        memory[71] = 32'd0;
        memory[72] = 32'd0;
        memory[73] = 32'd0;
        memory[74] = 32'd0;
        memory[75] = 32'd0;
        memory[76] = 32'd0;
        memory[77] = 32'd0;
        memory[78] = 32'd0;
        memory[79] = 32'd0;
        memory[80] = 32'd0;
        memory[81] = 32'd0;
        memory[82] = 32'd0;
        memory[83] = 32'd0;
        memory[84] = 32'd1;
        memory[85] = 32'd1;
        memory[86] = 32'd1;
        memory[87] = 32'd1;
        memory[88] = 32'd1;
        memory[89] = 32'd1;
        memory[90] = 32'd1;
        memory[91] = 32'd1;
        memory[92] = 32'd1;
        memory[93] = 32'd1;
        memory[94] = 32'd1;
        memory[95] = 32'd1;
        memory[96] = 32'd1;
        memory[97] = 32'd1;
        memory[98] = 32'd1;
        memory[99] = 32'd1;
        memory[100] = 32'd1;
        memory[101] = 32'd1;
        memory[102] = 32'd1;
        memory[103] = 32'd1;
        memory[104] = 32'd1;
        memory[105] = 32'd1;
        memory[106] = 32'd1;
        memory[107] = 32'd1;
        memory[108] = 32'd1;
        memory[109] = 32'd1;
        memory[110] = 32'd1;
        memory[111] = 32'd1;
        memory[112] = 32'd1;
        memory[113] = 32'd1;
        memory[114] = 32'd1;
        memory[115] = 32'd1;
        memory[116] = 32'd1;
        memory[117] = 32'd1;
        memory[118] = 32'd1;
        memory[119] = 32'd1;
        memory[120] = 32'd1;
        memory[121] = 32'd1;
        memory[122] = 32'd1;
        memory[123] = 32'd1;
        memory[124] = 32'd1;
        memory[125] = 32'd1;
        memory[126] = 32'd1;
        memory[127] = 32'd1;
        memory[128] = 32'd1;
        memory[129] = 32'd1;
        memory[130] = 32'd1;
        memory[131] = 32'd1;
        memory[132] = 32'd1;
        memory[133] = 32'd1;
        memory[134] = 32'd1;
        memory[135] = 32'd1;
        memory[136] = 32'd1;
        memory[137] = 32'd1;
        memory[138] = 32'd1;
        memory[139] = 32'd1;
        memory[140] = 32'd1;
        memory[141] = 32'd1;
        memory[142] = 32'd1;
        memory[143] = 32'd1;
        memory[144] = 32'd1;
        memory[145] = 32'd1;
        memory[146] = 32'd1;
        memory[147] = 32'd1;
        memory[148] = 32'd1;
        memory[149] = 32'd1;
        memory[150] = 32'd1;
        memory[151] = 32'd1;
        memory[152] = 32'd1;
        memory[153] = 32'd1;
        memory[154] = 32'd1;
        memory[155] = 32'd1;
        memory[156] = 32'd1;
        memory[157] = 32'd1;
        memory[158] = 32'd1;
        memory[159] = 32'd1;
        memory[160] = 32'd1;
        memory[161] = 32'd1;
        memory[162] = 32'd1;
        memory[163] = 32'd1;
        memory[164] = 32'd1;
        memory[165] = 32'd1;
        memory[166] = 32'd1;
        memory[167] = 32'd1;
        memory[168] = 32'd1;
        memory[169] = 32'd1;
        memory[170] = 32'd1;
        memory[171] = 32'd1;
        memory[172] = 32'd1;
        memory[173] = 32'd1;
        memory[174] = 32'd1;
        memory[175] = 32'd1;
        memory[176] = 32'd1;
        memory[177] = 32'd1;
        memory[178] = 32'd1;
        memory[179] = 32'd1;
        memory[180] = 32'd1;
        memory[181] = 32'd1;
        memory[182] = 32'd1;
        memory[183] = 32'd1;
        memory[184] = 32'd1;
        memory[185] = 32'd1;
        memory[186] = 32'd1;
        memory[187] = 32'd1;
        memory[188] = 32'd1;
        memory[189] = 32'd1;
        memory[190] = 32'd1;
        memory[191] = 32'd1;
        memory[192] = 32'd1;
        memory[193] = 32'd1;
        memory[194] = 32'd1;
        memory[195] = 32'd1;
        memory[196] = 32'd1;
        memory[197] = 32'd1;
        memory[198] = 32'd1;
        memory[199] = 32'd1;
        memory[200] = 32'd1;
        memory[201] = 32'd1;
        memory[202] = 32'd1;
        memory[203] = 32'd1;
        memory[204] = 32'd1;
        memory[205] = 32'd1;
        memory[206] = 32'd1;
        memory[207] = 32'd1;
        memory[208] = 32'd1;
        memory[209] = 32'd1;
        memory[210] = 32'd1;
        memory[211] = 32'd1;
        memory[212] = 32'd1;
        memory[213] = 32'd1;
        memory[214] = 32'd1;
        memory[215] = 32'd1;
        memory[216] = 32'd1;
        memory[217] = 32'd1;
        memory[218] = 32'd1;
        memory[219] = 32'd1;
        memory[220] = 32'd1;
        memory[221] = 32'd1;
        memory[222] = 32'd1;
        memory[223] = 32'd1;
        memory[224] = 32'd1;
        memory[225] = 32'd1;
        memory[226] = 32'd1;
        memory[227] = 32'd1;
        memory[228] = 32'd1;
        memory[229] = 32'd1;
        memory[230] = 32'd1;
        memory[231] = 32'd1;
        memory[232] = 32'd1;
        memory[233] = 32'd1;
        memory[234] = 32'd1;
        memory[235] = 32'd1;
        memory[236] = 32'd1;
        memory[237] = 32'd1;
        memory[238] = 32'd1;
        memory[239] = 32'd1;
        memory[240] = 32'd1;
        memory[241] = 32'd1;
        memory[242] = 32'd1;
        memory[243] = 32'd1;
        memory[244] = 32'd1;
        memory[245] = 32'd1;
        memory[246] = 32'd1;
        memory[247] = 32'd1;
        memory[248] = 32'd1;
        memory[249] = 32'd1;
        memory[250] = 32'd1;
        memory[251] = 32'd1;
        memory[252] = 32'd1;
        memory[253] = 32'd1;
        memory[254] = 32'd1;
        memory[255] = 32'd1;
        memory[256] = 32'd1;
        memory[257] = 32'd1;
        memory[258] = 32'd1;
        memory[259] = 32'd1;
        memory[260] = 32'd1;
        memory[261] = 32'd1;
        memory[262] = 32'd1;
        memory[263] = 32'd1;
        memory[264] = 32'd1;
        memory[265] = 32'd1;
        memory[266] = 32'd1;
        memory[267] = 32'd1;
        memory[268] = 32'd1;
        memory[269] = 32'd1;
        memory[270] = 32'd1;
        memory[271] = 32'd1;
        memory[272] = 32'd1;
        memory[273] = 32'd1;
        memory[274] = 32'd1;
        memory[275] = 32'd1;
        memory[276] = 32'd1;
        memory[277] = 32'd1;
        memory[278] = 32'd1;
        memory[279] = 32'd1;
        memory[280] = 32'd1;
        memory[281] = 32'd1;
        memory[282] = 32'd1;
        memory[283] = 32'd1;
        memory[284] = 32'd1;
        memory[285] = 32'd1;
        memory[286] = 32'd1;
        memory[287] = 32'd1;
        memory[288] = 32'd1;
        memory[289] = 32'd1;
        memory[290] = 32'd1;
        memory[291] = 32'd1;
        memory[292] = 32'd1;
        memory[293] = 32'd1;
        memory[294] = 32'd1;
        memory[295] = 32'd1;
        memory[296] = 32'd1;
        memory[297] = 32'd1;
        memory[298] = 32'd1;
        memory[299] = 32'd1;
        memory[300] = 32'd1;
        memory[301] = 32'd1;
        memory[302] = 32'd1;
        memory[303] = 32'd1;
        memory[304] = 32'd1;
        memory[305] = 32'd1;
        memory[306] = 32'd1;
        memory[307] = 32'd1;
        memory[308] = 32'd1;
        memory[309] = 32'd1;
        memory[310] = 32'd1;
        memory[311] = 32'd1;
        memory[312] = 32'd1;
        memory[313] = 32'd1;
        memory[314] = 32'd1;
        memory[315] = 32'd1;
        memory[316] = 32'd1;
        memory[317] = 32'd1;
        memory[318] = 32'd1;
        memory[319] = 32'd1;
        memory[320] = 32'd1;
        memory[321] = 32'd1;
        memory[322] = 32'd1;
        memory[323] = 32'd1;
        memory[324] = 32'd1;
        memory[325] = 32'd1;
        memory[326] = 32'd1;
        memory[327] = 32'd1;
        memory[328] = 32'd1;
        memory[329] = 32'd1;
        memory[330] = 32'd1;
        memory[331] = 32'd1;
        memory[332] = 32'd1;
        memory[333] = 32'd1;
        memory[334] = 32'd1;
        memory[335] = 32'd1;
        memory[336] = 32'd1;
        memory[337] = 32'd1;
        memory[338] = 32'd1;
        memory[339] = 32'd1;
        memory[340] = 32'd0;
        memory[341] = 32'd0;
        memory[342] = 32'd0;
        memory[343] = 32'd0;
        memory[344] = 32'd0;
        memory[345] = 32'd0;
        memory[346] = 32'd0;
        memory[347] = 32'd0;
        memory[348] = 32'd0;
        memory[349] = 32'd0;
        memory[350] = 32'd0;
        memory[351] = 32'd0;
        memory[352] = 32'd0;
        memory[353] = 32'd0;
        memory[354] = 32'd0;
        memory[355] = 32'd0;
        memory[356] = 32'd0;
        memory[357] = 32'd0;
        memory[358] = 32'd0;
        memory[359] = 32'd0;
        memory[360] = 32'd0;
        memory[361] = 32'd0;
        memory[362] = 32'd0;
        memory[363] = 32'd0;
        memory[364] = 32'd0;
        memory[365] = 32'd0;
        memory[366] = 32'd0;
        memory[367] = 32'd0;
        memory[368] = 32'd0;
        memory[369] = 32'd0;
        memory[370] = 32'd0;
        memory[371] = 32'd0;
        memory[372] = 32'd0;
        memory[373] = 32'd0;
        memory[374] = 32'd0;
        memory[375] = 32'd0;
        memory[376] = 32'd0;
        memory[377] = 32'd0;
        memory[378] = 32'd0;
        memory[379] = 32'd0;
        memory[380] = 32'd0;
        memory[381] = 32'd0;
        memory[382] = 32'd0;
        memory[383] = 32'd0;
        memory[384] = 32'd0;
        memory[385] = 32'd0;
        memory[386] = 32'd0;
        memory[387] = 32'd0;
        memory[388] = 32'd0;
        memory[389] = 32'd0;
        memory[390] = 32'd0;
        memory[391] = 32'd0;
        memory[392] = 32'd0;
        memory[393] = 32'd0;
        memory[394] = 32'd0;
        memory[395] = 32'd0;
        memory[396] = 32'd0;
        memory[397] = 32'd0;
        memory[398] = 32'd0;
        memory[399] = 32'd0;
        memory[400] = 32'd0;
        memory[401] = 32'd0;
        memory[402] = 32'd0;
        memory[403] = 32'd0;
        memory[404] = 32'd0;
        memory[405] = 32'd0;
        memory[406] = 32'd0;
        memory[407] = 32'd0;
        memory[408] = 32'd0;
        memory[409] = 32'd0;
        memory[410] = 32'd0;
        memory[411] = 32'd0;
        memory[412] = 32'd0;
        memory[413] = 32'd0;
        memory[414] = 32'd0;
        memory[415] = 32'd0;
        memory[416] = 32'd0;
        memory[417] = 32'd0;
        memory[418] = 32'd0;
        memory[419] = 32'd0;
        memory[420] = 32'd0;
        memory[421] = 32'd0;
        memory[422] = 32'd0;
        memory[423] = 32'd0;
        memory[424] = 32'd0;
        memory[425] = 32'd0;
        memory[426] = 32'd0;
        memory[427] = 32'd0;
        memory[428] = 32'd0;
        memory[429] = 32'd0;
        memory[430] = 32'd0;
        memory[431] = 32'd0;
        memory[432] = 32'd0;
        memory[433] = 32'd0;
        memory[434] = 32'd0;
        memory[435] = 32'd0;
        memory[436] = 32'd0;
        memory[437] = 32'd0;
        memory[438] = 32'd0;
        memory[439] = 32'd0;
        memory[440] = 32'd0;
        memory[441] = 32'd0;
        memory[442] = 32'd0;
        memory[443] = 32'd0;
        memory[444] = 32'd0;
        memory[445] = 32'd0;
        memory[446] = 32'd0;
        memory[447] = 32'd0;
        memory[448] = 32'd0;
        memory[449] = 32'd0;
        memory[450] = 32'd0;
        memory[451] = 32'd0;
        memory[452] = 32'd0;
        memory[453] = 32'd0;
        memory[454] = 32'd0;
        memory[455] = 32'd0;
        memory[456] = 32'd0;
        memory[457] = 32'd0;
        memory[458] = 32'd0;
        memory[459] = 32'd0;
        memory[460] = 32'd0;
        memory[461] = 32'd0;
        memory[462] = 32'd0;
        memory[463] = 32'd0;
        memory[464] = 32'd0;
        memory[465] = 32'd0;
        memory[466] = 32'd0;
        memory[467] = 32'd0;
        memory[468] = 32'd0;
        memory[469] = 32'd0;
        memory[470] = 32'd0;
        memory[471] = 32'd0;
        memory[472] = 32'd0;
        memory[473] = 32'd0;
        memory[474] = 32'd0;
        memory[475] = 32'd0;
        memory[476] = 32'd0;
        memory[477] = 32'd0;
        memory[478] = 32'd0;
        memory[479] = 32'd0;
        memory[480] = 32'd0;
        memory[481] = 32'd0;
        memory[482] = 32'd0;
        memory[483] = 32'd0;
        memory[484] = 32'd0;
        memory[485] = 32'd0;
        memory[486] = 32'd0;
        memory[487] = 32'd0;
        memory[488] = 32'd0;
        memory[489] = 32'd0;
        memory[490] = 32'd0;
        memory[491] = 32'd0;
        memory[492] = 32'd0;
        memory[493] = 32'd0;
        memory[494] = 32'd0;
        memory[495] = 32'd0;
        memory[496] = 32'd0;
        memory[497] = 32'd0;
        memory[498] = 32'd0;
        memory[499] = 32'd0;
        memory[500] = 32'd0;
        memory[501] = 32'd0;
        memory[502] = 32'd0;
        memory[503] = 32'd0;
        memory[504] = 32'd0;
        memory[505] = 32'd0;
        memory[506] = 32'd0;
        memory[507] = 32'd0;
        memory[508] = 32'd0;
        memory[509] = 32'd0;
        memory[510] = 32'd0;
        memory[511] = 32'd0;
        memory[512] = 32'd0;
        memory[513] = 32'd0;
        memory[514] = 32'd0;
        memory[515] = 32'd0;
        memory[516] = 32'd1;
        memory[517] = 32'd1;
        memory[518] = 32'd1;
        memory[519] = 32'd1;
        memory[520] = 32'd1;
        memory[521] = 32'd1;
        memory[522] = 32'd1;
        memory[523] = 32'd1;
        memory[524] = 32'd1;
        memory[525] = 32'd1;
        memory[526] = 32'd1;
        memory[527] = 32'd1;
        memory[528] = 32'd1;
        memory[529] = 32'd1;
        memory[530] = 32'd1;
        memory[531] = 32'd1;
        memory[532] = 32'd1;
        memory[533] = 32'd1;
        memory[534] = 32'd1;
        memory[535] = 32'd1;
        memory[536] = 32'd1;
        memory[537] = 32'd1;
        memory[538] = 32'd1;
        memory[539] = 32'd1;
        memory[540] = 32'd1;
        memory[541] = 32'd1;
        memory[542] = 32'd1;
        memory[543] = 32'd1;
        memory[544] = 32'd1;
        memory[545] = 32'd1;
        memory[546] = 32'd1;
        memory[547] = 32'd1;
        memory[548] = 32'd1;
        memory[549] = 32'd1;
        memory[550] = 32'd1;
        memory[551] = 32'd1;
        memory[552] = 32'd1;
        memory[553] = 32'd1;
        memory[554] = 32'd1;
        memory[555] = 32'd1;
        memory[556] = 32'd1;
        memory[557] = 32'd1;
        memory[558] = 32'd1;
        memory[559] = 32'd1;
        memory[560] = 32'd1;
        memory[561] = 32'd1;
        memory[562] = 32'd1;
        memory[563] = 32'd1;
        memory[564] = 32'd1;
        memory[565] = 32'd1;
        memory[566] = 32'd1;
        memory[567] = 32'd1;
        memory[568] = 32'd1;
        memory[569] = 32'd1;
        memory[570] = 32'd1;
        memory[571] = 32'd1;
        memory[572] = 32'd1;
        memory[573] = 32'd1;
        memory[574] = 32'd1;
        memory[575] = 32'd1;
        memory[576] = 32'd1;
        memory[577] = 32'd1;
        memory[578] = 32'd1;
        memory[579] = 32'd1;
        memory[580] = 32'd1;
        memory[581] = 32'd1;
        memory[582] = 32'd1;
        memory[583] = 32'd1;
        memory[584] = 32'd1;
        memory[585] = 32'd1;
        memory[586] = 32'd1;
        memory[587] = 32'd1;
        memory[588] = 32'd1;
        memory[589] = 32'd1;
        memory[590] = 32'd1;
        memory[591] = 32'd1;
        memory[592] = 32'd1;
        memory[593] = 32'd1;
        memory[594] = 32'd1;
        memory[595] = 32'd1;
        memory[596] = 32'd1;
        memory[597] = 32'd1;
        memory[598] = 32'd1;
        memory[599] = 32'd1;
        memory[600] = 32'd1;
        memory[601] = 32'd1;
        memory[602] = 32'd1;
        memory[603] = 32'd1;
        memory[604] = 32'd1;
        memory[605] = 32'd1;
        memory[606] = 32'd1;
        memory[607] = 32'd1;
        memory[608] = 32'd1;
        memory[609] = 32'd1;
        memory[610] = 32'd1;
        memory[611] = 32'd1;
        memory[612] = 32'd1;
        memory[613] = 32'd1;
        memory[614] = 32'd1;
        memory[615] = 32'd1;
        memory[616] = 32'd1;
        memory[617] = 32'd1;
        memory[618] = 32'd1;
        memory[619] = 32'd1;
        memory[620] = 32'd1;
        memory[621] = 32'd1;
        memory[622] = 32'd1;
        memory[623] = 32'd1;
        memory[624] = 32'd1;
        memory[625] = 32'd1;
        memory[626] = 32'd1;
        memory[627] = 32'd1;
        memory[628] = 32'd1;
        memory[629] = 32'd1;
        memory[630] = 32'd1;
        memory[631] = 32'd1;
        memory[632] = 32'd1;
        memory[633] = 32'd1;
        memory[634] = 32'd1;
        memory[635] = 32'd1;
        memory[636] = 32'd1;
        memory[637] = 32'd1;
        memory[638] = 32'd1;
        memory[639] = 32'd1;
        memory[640] = 32'd1;
        memory[641] = 32'd1;
        memory[642] = 32'd1;
        memory[643] = 32'd1;
        memory[644] = 32'd1;
        memory[645] = 32'd1;
        memory[646] = 32'd1;
        memory[647] = 32'd1;
        memory[648] = 32'd1;
        memory[649] = 32'd1;
        memory[650] = 32'd1;
        memory[651] = 32'd1;
        memory[652] = 32'd1;
        memory[653] = 32'd1;
        memory[654] = 32'd1;
        memory[655] = 32'd1;
        memory[656] = 32'd1;
        memory[657] = 32'd1;
        memory[658] = 32'd1;
        memory[659] = 32'd1;
        memory[660] = 32'd1;
        memory[661] = 32'd1;
        memory[662] = 32'd1;
        memory[663] = 32'd1;
        memory[664] = 32'd1;
        memory[665] = 32'd1;
        memory[666] = 32'd1;
        memory[667] = 32'd1;
        memory[668] = 32'd1;
        memory[669] = 32'd1;
        memory[670] = 32'd1;
        memory[671] = 32'd1;
        memory[672] = 32'd1;
        memory[673] = 32'd1;
        memory[674] = 32'd1;
        memory[675] = 32'd1;
        memory[676] = 32'd1;
        memory[677] = 32'd1;
        memory[678] = 32'd1;
        memory[679] = 32'd1;
        memory[680] = 32'd1;
        memory[681] = 32'd1;
        memory[682] = 32'd1;
        memory[683] = 32'd1;
        memory[684] = 32'd1;
        memory[685] = 32'd1;
        memory[686] = 32'd1;
        memory[687] = 32'd1;
        memory[688] = 32'd1;
        memory[689] = 32'd1;
        memory[690] = 32'd1;
        memory[691] = 32'd1;
        memory[692] = 32'd1;
        memory[693] = 32'd1;
        memory[694] = 32'd1;
        memory[695] = 32'd1;
        memory[696] = 32'd1;
        memory[697] = 32'd1;
        memory[698] = 32'd1;
        memory[699] = 32'd1;
        memory[700] = 32'd1;
        memory[701] = 32'd1;
        memory[702] = 32'd1;
        memory[703] = 32'd1;
        memory[704] = 32'd1;
        memory[705] = 32'd1;
        memory[706] = 32'd1;
        memory[707] = 32'd1;
        memory[708] = 32'd1;
        memory[709] = 32'd1;
        memory[710] = 32'd1;
        memory[711] = 32'd1;
        memory[712] = 32'd1;
        memory[713] = 32'd1;
        memory[714] = 32'd1;
        memory[715] = 32'd1;
        memory[716] = 32'd1;
        memory[717] = 32'd1;
        memory[718] = 32'd1;
        memory[719] = 32'd1;
        memory[720] = 32'd1;
        memory[721] = 32'd1;
        memory[722] = 32'd1;
        memory[723] = 32'd1;
        memory[724] = 32'd1;
        memory[725] = 32'd1;
        memory[726] = 32'd1;
        memory[727] = 32'd1;
        memory[728] = 32'd1;
        memory[729] = 32'd1;
        memory[730] = 32'd1;
        memory[731] = 32'd1;
        memory[732] = 32'd1;
        memory[733] = 32'd1;
        memory[734] = 32'd1;
        memory[735] = 32'd1;
        memory[736] = 32'd1;
        memory[737] = 32'd1;
        memory[738] = 32'd1;
        memory[739] = 32'd1;
        memory[740] = 32'd1;
        memory[741] = 32'd1;
        memory[742] = 32'd1;
        memory[743] = 32'd1;
        memory[744] = 32'd1;
        memory[745] = 32'd1;
        memory[746] = 32'd1;
        memory[747] = 32'd1;
        memory[748] = 32'd1;
        memory[749] = 32'd1;
        memory[750] = 32'd1;
        memory[751] = 32'd1;
        memory[752] = 32'd1;
        memory[753] = 32'd1;
        memory[754] = 32'd1;
        memory[755] = 32'd1;
        memory[756] = 32'd1;
        memory[757] = 32'd1;
        memory[758] = 32'd1;
        memory[759] = 32'd1;
        memory[760] = 32'd1;
        memory[761] = 32'd1;
        memory[762] = 32'd1;
        memory[763] = 32'd1;
        memory[764] = 32'd1;
        memory[765] = 32'd1;
        memory[766] = 32'd1;
        memory[767] = 32'd1;
        memory[768] = 32'd1;
        memory[769] = 32'd1;
        memory[770] = 32'd1;
        memory[771] = 32'd1;
    end
    
    always@(negedge Clk) begin // write process
        case(DataMem)
            2'b00: begin
                        if (MemWrite == 1) begin
                            memory[Address[14:2]] <= WriteData;
                        end
                    end
            2'b01: begin //byte
                        if (MemWrite == 1) begin
                            //memory[Address[11:2]][17+:8] <= 8'b1111111;
                            memory[Address[14:2]][(Address[1:0]*8)+:8] <= WriteData[7:0];
                        end
                   end
            2'b10: begin //
                        if (MemWrite == 1)
                            memory[Address[14:2]][(Address[1:0]*8)+:16] <= WriteData[15:0];
                   end
        endcase
    end
    
          
    always@(MemRead, Address, DataMem) begin
        case(DataMem)
            2'b00: begin
                    if (MemRead == 1)
                        ReadData <= memory[Address[14:2]];
                    else
                        ReadData <= 32'b0;
                   end
            2'b01: begin
                        if (MemRead == 1) begin
                            ReadData = memory[Address[14:2]][(Address[1:0]*8)+:8];
                            if (ReadData[7] == 0)
                                ReadData <= {24'd0, ReadData[7:0]};
                            else
                                ReadData <= {24'd16777215, ReadData[7:0]};     
                        end
                        else
                            ReadData <= 32'b0;
                   end
            2'b10: begin
                       if (MemRead == 1) begin
                           ReadData = memory[Address[14:2]][(Address[1:0]*8)+:16];
                           if (ReadData[15] == 0)
                               ReadData <= {16'd0, ReadData[15:0]};
                           else
                               ReadData <= {16'd65535, ReadData[15:0]};     
                       end
                       else
                           ReadData <= 32'b0;
                   end
        endcase
    end

endmodule
