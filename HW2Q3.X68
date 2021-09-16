*-----------------------------------------------------------
* Title      : HW2Q3
* Written by : Helina Azer
* Date       : 4/20/2021
* Description: Input a OneByte value and get the address, sum and carryBit
*-----------------------------------------------------------
startAddress    EQU $6000
endAddress      EQU $8000

oneByte         DS.B 8
foundAt         DS.L 1  
sum             DS.W 1
carryBit        DS.W 1

CR              EQU  $0D 
LF              EQU  $0A
MESSAGE         DC.b 'Enter a one-byte value: ',0
ONEBYTERESULT   DC.B LF, CR,'oneByte: ', 0
FOUNDATRESULT   DC.B LF, CR,'foundAt: ', 0
SUMRESULT       DC.B LF, CR,'sum: ', 0
CARRYBITRESULT  DC.B LF, CR,'carryBit: ', 0

    ORG    $1000
    
START:
  
    LEA         MESSAGE,A1                          ; load first message         
    MOVE.B      #14,D0                              ; move #14 to D0
    TRAP        #15                                 ; TRAP #15               
    MOVE.B      #5,D0                               ; move #4 to D0
    TRAP        #15                                 ; TRAP #15 
    MOVE.l      D1,oneByte                          ; move one byte inputed by user into D1
    MOVE.b      #oneByte,$6000                      ; move oneByte into address $6000
    MOVEA.L     #startAddress, A4                          ; assign address $6000 to A4
    MOVE.L      $6000,foundAt                       
    CLR.W       sum                                 ; clear sum
    CLR.W       carryBit                            ; Clear carry bit
    
LOOP:  
           
    MOVE.B      (A4),D1                             ; move A4 into D1         
    CMP.B       #oneByte, D1        
    BEQ         FOUND                               ; branch if equal to found
    ADDA.W      #$1,A4         
    CMPA.L      #$8001, A4                          ; compare A4 to 80001
    BRA         LOOP                                ; branch to loop
        
FOUND:  

    MOVE.L      A4,foundAt                          ; Move Addr1 to the address found
    BRA         CONTINUE                            ; branch to continue
    
CONTINUE:
    MOVEA.L     foundAt, A4                         ; Move addr1 to A4 
    CLR.W       D1                                  ; Clear D1
    CLR.W       D3                                  ; Clear D3
 
SECONDLOOP:

    MOVE.B      (A4)+, D2
    ADD.W       D2, sum
    BCS         CARRY
    ADD.W       #1, D1
    CMP.W       #511, D1
    BGT         FINISH
    BRA         SECONDLOOP                          ; branch to second loop
    
CARRY:

    MOVE.W      #1, carryBit                        ; move 1 to Carrybit
    BRA         SECONDLOOP                          ; branch to add loop
    
FINISH

    LEA         ONEBYTERESULT, A1                   ; move one byte result into A1
    MOVE.B      #14, D0                             ; move task 14 into D0
    TRAP        #15                                 ; display contents of A1
    MOVEA.L     oneByte, A1                         ; move address of addr1 into A1
    MOVE.W      A1, D1                              ; move address of A1 into D1
    MOVE.B      #3, D0                              ; move task3 into D0
    TRAP        #15                                 ; Trap 15
    
    LEA         FOUNDATRESULT, A1                   ; move found at result into A1
    MOVE.B      #14, D0                             ; move task 14 into D0
    TRAP        #15                                 ; trap 15, display content
    MOVEA.L     foundAt, A1                         ; move address of addr1 into A1
    MOVE.W      A1, D1                              ; move address of A1 into D1    
    MOVE.B      #3, D0                              ; move task 3 into D0
    TRAP        #15                                 ; display contents of D1
     
    LEA         SUMRESULT, A1                       ; move sum result into A1
    MOVE.B      #14, D0                             ; move task 14 into D0 for Trap 15
    TRAP        #15                                 ; display contents of A1
    MOVE.W      sum, D1                             ; move Addsum into D1
    MOVE.B      #3, D0                              ; move task 3 into D0    
    TRAP        #15                                 ; trap 15, display content
  
    LEA         CARRYBITRESULT, A1                  ; move carry bit result into A1
    MOVE.B      #14, D0                             ; move task 14 into D0
    TRAP        #15                                 ; trap 15, display content
    MOVE.W      CarryBit, D1                        ; move carry bit into D1
    MOVE.B      #3, D0                              ; Move task 3 into D0
    TRAP        #15                                 ; trap 15, display content  
   
    SIMHALT                                         ; halt simulator
    END         START                               ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
