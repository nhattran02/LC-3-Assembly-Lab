.ORIG X3000

LDI R1, X
LDI R2, Y

NOT R3, R2
ADD R3, R3, #1
ADD R4, R1, R3
STI R4, DIF

ADD R3, R1, #0
BRzp ZP 
NOT R4, R1
ADD R4, R4, #1
STI R4, ABSX
BR NEXT
ZP STI R3, ABSX

NEXT:
ADD R3, R2, #0
BRzp ZP1 
NOT R4, R2
ADD R4, R4, #1
STI R4, ABSY
BR NEXT1
ZP1 STI R3, ABSY

NEXT1:
LDI R3, ABSX	;R3=ABS(R1)=ABS(X)
LDI R4, ABSY	;R4=ABS(R2)=ABS(Y)
NOT R5, R4
ADD R5, R5, #1
ADD R5, R3, R5	;R5=R3-R4
BRp POSITIVE 
ADD R5, R5, #0
BRn NEGATIVE
AND R6, R6, #0
STI R6, GREATER
BR END

NEGATIVE:
AND R6, R6, #0
ADD R6, R6, #2
STI R6, GREATER 


BR END 
POSITIVE:
AND R6, R6, #0
ADD R6, R6, #1
STI R6, GREATER

END HALT
DIF .FILL 	X3122
ABSX .FILL 	X3123
ABSY .FILL 	X3124
GREATER .FILL 	X3125
X .FILL x3120
Y .FILL x3121
.END