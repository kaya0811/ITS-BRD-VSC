# Aufgabe_2.1
## Zeile Anw01 bis Anw09:
Allgemein: Ldr=laden, STR = speichern, B = Byte(8 Bit), H = Halfword
- Anw01 -> R0 bekommt die Adresse von VariabaleA 
- Anw02 -> hier wird 1 Byte aus dem Speicher aus R0 (08 Bit) nach R2 geladen
- Anw03 -> lädt 1 Byte von Adresse VariableA+1 nach R3
- Anw04 -> R2 wird um 8 Bit nach links geschoben (mal256)
- Anw05 -> kombiniert R2 und R3 bitweise (or,oder)
- Anw06 -> speichert 2 Byte (Halfword) von R2 zurück in VariableA
- Anw07 -> lädt Konstante in R5 
- Anw08 -> speichert 2 Byte aus R5 nach VariableA
- Anw09 -> R1 bekommt die Adresse von VariableB

## Mit dem Debugger Verständnis von Anw01-Anw06 (Effekt auf die Register R0,R2,R3)
### Anw1
- VariableA DCW 0xBEEF 
-> Im Debugger A=EF, A+1=BE
- Little Endian -> kleinste Adresse = Least Significant Byte (LSB) dann
                   größte Adresse = Most Significant Byte (MSB)
- Register: R0 = Adresse von VariableA
--> R2,R3 keine Veränderung

### Anw2
- Änderung: R0 = A
- R2 = 0x000000EF
--> rest keine Veränderung

### Anw3
- R0 = A
- R2 = 0x000000EF
- R3 = 0x000000BE
--> rest keine Veränderung

### Anw4 
- R0 = A
- R2 = 0x0000EF00
- R3 = 0x000000BE
--> rest keine Veränderung

### Anw5
- R0 = A
- R2 = 0x0000EFBE
- R3 = 0x000000BE

### Anw6
- R0 = A
- R2 = 0x0000EFBE
- R3 = 0x000000BE
--> hier Adressenveränderung: niedriges Byte (BE) kommt auf Adresse A dann
                              hohes Byte (EF) kommt auf Adresse A+1


## Codeabschnitt erweitern (Kommentare: Anw07&Anw08)
- Neue Variable C
    ldr     R4,=VariableC
    ldrb    R2,[R4]
    ldrb    R3,[R4,#1] 
    lsl     R2, #8
    orr     R2, R3
    strh    R2,[R4]
## Veränderung ab Anw09 (möglichst einfache Lösung)
- Wenn man diese auskommentiert, ändert sich nichts
    ;mov     R7, #0x30ED     ; Anw0B
    ;add     R6, R6, R7      ; Anw0C

- So  ähnlich gemacht wie bei der Variable C

    ldr     R1,=VariableB   ; Anw09 ;R1 bekommt die Adresse von VariableB
    ldrh    R6,[R1]         ; Anw0A ;Lädt ein Halfword (16 Bit) aus dem Speicher ab Adresse R1
    ldrb    R7, [R1, #1]    ;Lädt 1 Byte von Adresse R1+1 (Adresse B+1 enthält 0x12)
    lsl     R6, #8          ;Shift Left Logical: schiebt R6 um 8 Bit nach links
    orr     R6, R7          ;Bitweises OR von R6 mit R7
    strh    R6,[R1]         ; Anw0D
    b .                     ; Anw0E
