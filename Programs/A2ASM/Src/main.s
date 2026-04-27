; (C) COPYRIGHT HAW-Hamburg 
;* File Name          : main.s
;* Author             : Martin Becke
;* Version            : V1.0
;* Date               : 01.06.2021
;* Description        : This is a simple main to demonstrate data transfer
;                     : and manipulation.
;                     : 
;
;**
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker - In this context it set the entry point,too

ConstByteA  EQU 0xaffe

; We need some data to work on
    AREA DATA, DATA, align=2
VariableA   DCW 0xbeef
VariableB   DCW 0x1234
VariableC   DCW 0xaffe

;* We need minimal memory setup of InRootSection placed in Code Section 
    AREA  |.text|, CODE, READONLY, ALIGN = 3
    ALIGN
main
    BL initITSboard             ; needed by the board to setup
;* swap memory - Is there another, at least optimized approach?
    ldr     R0,=VariableA   ; Anw01 R0 bekommt die Adresse von VariableA
    ldrb    R2,[R0]         ; Anw02 lädt 1 Byte von Adresse A in R2 -> R2 = 0xEF
    ldrb    R3,[R0,#1]      ; Anw03 lädt 1 Byte von Adresse A+1 in R3 -> R3 = 0xBE
    lsl     R2, #8          ; Anw04 verschiebt R2 um 8 Bit nach links -> 0xEF wird zu 0xEF00
    orr     R2, R3          ; Anw05 verbindet beide Bytes: 0xEF00 OR 0xBE = 0xEFBE
    strh    R2,[R0]         ; Anw06 schreibt 16 Bit (0xEFBE) zurück nach VariableA
                            ; wegen Little Endian wird gespeichert als:
                            ; A = 0xBE und A+1 = 0xEF

;* const in var
    mov     R5,#ConstByteA  ; Anw07
    strh    R5,[R2]         ; Anw08

    ldr     R4,=VariableC
    ldrb    R2,[R4]
    ldrb    R3,[R4,#1] 
    lsl     R2, #8
    orr     R2, R3
    strh    R2,[R4]

;* Change value from x1234 to x4321
    ldr     R1,=VariableB   ; Anw09 ;R1 bekommt die Adresse von VariableB
    ldrh    R6,[R1]         ; Anw0A ;Lädt ein Halfword (16 Bit) aus dem Speicher ab Adresse R1
    ldrb    R7, [R1, #1]    ;Lädt 1 Byte von Adresse R1+1 (Adresse B+1 enthält 0x12)
    lsl     R6, #8          ;Shift Left Logical: schiebt R6 um 8 Bit nach links
    orr     R6, R7          ;Bitweises OR von R6 mit R7
    ;mov     R7, #0x30ED     ; Anw0B
    ;add     R6, R6, R7      ; Anw0C
    strh    R6,[R1]         ; Anw0D
    b .                     ; Anw0E

    ALIGN
    END