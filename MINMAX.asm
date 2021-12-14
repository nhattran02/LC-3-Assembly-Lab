.ORIG x3000
;R1: save the number of repetitions remaining
;R2: store the minimum value
;R3: store the maximum value
LD R1, SO_LAN_LAP
LD R2, INIT_MIN
LD R3, INIT_MAX

LOOP1   IN
        NOT R4, R0
        ADD R4, R4, #1
        ADD R5, R2, R4
        BRnz NEXT1
        ADD R2, R0, #0
NEXT1   ADD R5, R3, R4
        BRzp    NEXT2
        ADD R3, R0, #0
NEXT2   ADD R1, R1, #-1
        BRp LOOP1
        LEA R0, STR_MIN
        PUTS
        ADD R0, R2, #0
        OUT
        LEA R0, STR_MAX
        PUTS
        ADD R0, R3, #0
        OUT
HALT
STR_MAX .STRINGZ "So lon nhat la: "
STR_MIN .STRINGZ "\nSo be nhat la: "
SO_LAN_LAP .FILL #3
INIT_MIN .FILL #57
INIT_MAX .FILL #48
.END