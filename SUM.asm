.ORIG x3000
IN 
LD R1,ASCII_0 
NOT R1,R1
ADD R1,R1,#1
ADD R2,R0,R1 
IN
ADD R3,R0,R1 
ADD R4,R2,R3 
LD R0,DIA_CHI_LUU 
STR R2,R0,#0 
STR R3,R0,#1
STR R4,R0,#2
LEA R0,STROUT 
PUTS 
LD R1,ASCII_0
ADD R5,R4,#-10 
BRzp XUAT_2_CHU_SO
ADD R0,R4,R1 
OUT
BR KET_THUC
XUAT_2_CHU_SO ADD R0,R1,#1 
ADD R0,R5,R1 
OUT
KET_THUC HALT
ASCII_0 .FILL #48
DIA_CHI_LUU .FILL x4000
STROUT .STRINGZ "Tong cua hai so la:"
.END