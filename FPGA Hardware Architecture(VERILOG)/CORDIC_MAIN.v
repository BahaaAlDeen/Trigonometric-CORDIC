`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:18:12 12/16/2019 
// Design Name: 
// Module Name:    CORDIC_MAIN 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CORDIC_MAIN(clk,rst,rad,COS,SIN);

input clk,rst;
output reg signed [31:0] COS,SIN;
input signed  [31:0] rad;

reg signed  [31:0] ScalingFactor,c90,c180,c270,c360;

reg signed  [31:0] angle,x,y,z,s,S;

reg signed  [63:0] ANGLE,op1,op2,op3,Z; //32.32

reg signed  [95:0] op11,op22,X,Y; //48.48

integer k,i;

wire signed [31:0] inv_tan [0:12];

assign inv_tan[00] = 2949120;//45
assign inv_tan[01] = 1740970;//26.5651
assign inv_tan[02] = 919876; //14.0362
assign inv_tan[03] = 466944; //7.1250
assign inv_tan[04] = 234376; //3.5763
assign inv_tan[05] = 117302; //1.7899 
assign inv_tan[06] = 58667;  //0.8952
assign inv_tan[07] = 29333;  //0.4476
assign inv_tan[08] = 14666;  //0.2238
assign inv_tan[09] = 7333;   //0.1119
assign inv_tan[10] = 3670;   //0.0560
assign inv_tan[11] = 1835;   //0.0280
assign inv_tan[12] = 917;    //0.0140

wire signed [31:0] two_power [0:12];

assign two_power[00] = 65536;//1
assign two_power[01] = 32768;//0.5000
assign two_power[02] = 16384;//0.2500
assign two_power[03] = 8192; //0.1250
assign two_power[04] = 4096; //0.0625
assign two_power[05] = 2051; //0.0313 
assign two_power[06] = 1022; //0.0156
assign two_power[07] = 511;  //0.0078
assign two_power[08] = 255;  //0.0039
assign two_power[09] = 131;  //0.0020
assign two_power[10] = 63;   //9.7656e-04
assign two_power[11] = 31;   //4.8828e-04
assign two_power[12] = 15;   //2.4414e-04



//two_power=[1 0.5000 0.2500 0.1250 0.0625 0.0313 0.0156 0.0078 0.0039 0.0020 9.7656e-04 4.8828e-04 2.4414e-04];
//
//inv_tan=[45 26.5651 14.0362 7.1250 3.5763 1.7899 0.8952 0.4476 0.2238 0.1119 0.0560 0.0280 0.0140];

always @(posedge clk ) begin  


if (rst==1)begin //initialization 1

ScalingFactor=39793; //0.6072; fix((0.6072)*2^16);  16.16;
c90=5898240;         //90;     fix((90)*2^16);      16.16;
c180=11796480;       //180;    fix((180)*2^16);     16.16;
c270=17694720;       //270;    fix((270)*2^16);     16.16;
c360=23592960;       //360;    fix((360)*2^16);     16.16;


x=ScalingFactor;   //input x
y=0;               //input y

s=65536;   //initialized sigma; 16.16;
k=0;
i=0;





end        //initialization 1

else begin //initialization 2

////////////////////////////////////////// initialized values for recursive clock
x=ScalingFactor;   //input x
y=0;               //input y

s=65536;   //initialized sigma; 16.16;
k=0;
i=0;
//////////////////////////////////////////  initialized values for recursive clock


ANGLE=rad*3754937;    //input angle; rad*57.2958; 16.16*16.16=32.32
angle=ANGLE[47:16];   //[47-32:31-16]  16.16


if (angle<0)begin //if 1
   
    angle =-angle;
    k=2;
    
end // if 1


while (angle>c360)begin // while
    
    angle=angle-c360; //angle=angle-360;
    
end // while


if (angle<=c360 && angle>=0)   begin // if 2
    if (0<angle && angle<c90) begin // if 3
    z=angle;  
	 end // if 3
    else if (c90<angle && angle<c180) begin // if 3.1
    z=c180-angle;    
	 end// if 3.1
    else if (c180<angle && angle<c270)begin // if 3.2
    z=angle-c180; 
	 end// if 3.2
    else if (c270<angle && angle<c360)begin // if 3.3
    z=c360-angle;  
	 end    // if 3.4
    else if (angle==0 || angle==c90 || angle==c180 || angle==c270 || angle==c360)begin // if 3.5
    z=angle;
    k=1;
    end   // if 3.5
end // if 2


for (i=1;i<=13;i=i+1) begin //for

        if (k==1)begin //if 4
            i=14;
        end //if 4

		  op1=s*y;  //32.32
		  op11=op1*two_power[i-1]; //48.48
        X={{32{x[31]}},x,{32{x[0]}}}-op11;   //48.48
		  
		  op2=s*x; //32.32
		  op22=op2*two_power[i-1]; //48.48
        Y={{32{y[31]}},y,{32{y[0]}}}+op22;  //48.48
		  
		  op3=s*inv_tan[i-1]; //32.32
        Z={{16{z[31]}},z,{16{z[0]}}}-op3; //32.32

        if (Z>0)begin //if 5
            S=65536;
		  end //if 5
        else begin  //if 5.1
            S=-65536; 
        end //if 5.1

        s=S;
        x=X[63:32]; //16.16
        y=Y[63:32]; //16.16
        z=Z[47:16]; //16.16

end //for
    

 
    if (0<angle && angle<c90)begin //if 6
    x=x;
    y=y;
	 end //if 6
    else if (c90<angle && angle<c180)begin //if 6.1
    x=-x;
    y=y;
	 end //if 6.1
    else if (c180<angle && angle<c270)begin //if 6.2
    x=-x;
    y=-y;
	 end //if 6.2
    else if (c270<angle && angle<c360)begin //if 6.3
    x=x;
    y=-y; 
	 end //if 6.3
    else if (angle==0||angle==c360)begin //if 6.4
    x=65536;
    y=0;  
	 end //if 6.4
    else if (angle==c90)begin //if 6.5
    x=0;
    y=65536;    
	 end //if 6.5
    else if (angle==c180)begin //if 6.6
    x=-65536;
    y=0;    
	 end //if 6.6
    else if (angle==c270)begin //if 6.7
    x=0;
    y=-65536;
    end //if 6.7
 
        
    
if (k==2) begin  //if 7
    COS=x;

    
    SIN=-y;

end //if 7
else begin //if 7.1
    COS=x;

    SIN=y;


end //if 7.1

k=0;


end //initialization 2


end //always

endmodule
