        .ORIG x3000
        LD R1, ASCII_0M
        IN 
        ADD R2, R0, R1  ;R2: FIRST NUM
        IN 
        ADD R3, R0, R1  ;R3: SECOND NUM

        ;CALCULATE
        AND R4, R4, #0  ;INITALIZE R4
LOOP    ADD R2, R2, #-1
        BRn TACH_SO
        ADD R4, R4, R3
        BR LOOP 

TACH_SO AND R2, R2, #0  ;INITALIZE R2
LOOP2   ADD R4, R4, #-10
        BRn NEXT
        ADD R2, R2, #1
        BR LOOP2
NEXT    ADD R3, R4, #10
        LD R1, ASCII_0
        ADD R2, R2, #0
        BRz DON_VI
        ADD R0, R2, R1
        OUT
DON_VI  ADD R0, R3, R1
        OUT
        HALT
ASCII_0     .FILL #48
ASCII_0M    .FILL #-48
.END