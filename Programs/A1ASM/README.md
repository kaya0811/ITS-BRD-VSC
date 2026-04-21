# Erstes Problem war: Breakpoints setzen, dies ging nur mit einer Änderung der Einstellungen
# Alles in R6 schaltet die Lampen auf on (Theoretisch bräuchten wir in dem Fall nur R6)
# Alles in R7 schaltet die Lampen auf off
# Theoretisch müsste es mit den Binärzahlen gehen, von 0 angefangen und dann in Hex
# Allgemein sind alle geschriebenen Funktione Kommentare richtig (on und off)
# Ich bin mir unsicher, wo ich die Binärzahlen/Hexzahlen eintragen muss
# (Alles auskommentiert außer 2 Zeilen)

# Lösung
-Es soll nur LED 8 und 9 mit einem Befehl leuchten
-Die Summe aus R0:R1:R2 und R3 ist 11000011 in binär und #0xC3 in Hex.
Alle 4 LED's leuchten mit dem Befehl:

MOV     R0, #0xC3        ; alle LED
STRB    R0, [R7]         ; switch off all LED
STRB    R0, [R6]         ; switch on all LED

# Nun R0 für LED 8 und R1 für LED 9 addieren

MOV     R0, #0x03        ; LED D08 und D09
STRB    R0, [R7]         ; LED D08 und D09
STRB    R0, [R6]         ; switch off LED D08 and D9 ; switch on LED D08 and D09