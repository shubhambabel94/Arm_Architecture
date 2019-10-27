  area myfirst, CODE, READONLY
       EXPORT __main
       ENTRY 
__main  FUNCTION	
    	
        MOV R0, #15   ;to store a 
        MOV R1 , #10  ;to store b 
WLOOP                ;while loop
   CMP R0, R1        ;while(a!=b) 
   BNE LOOP1         ;while loop executed if a!=b | branch to loop1
   BEQ stop          ; if a=b then stop execution
		
LOOP1                
  CMP R0, R1         ;checking condition if a>b 
  BGT SUBT1          ;if a>b then branch to subt1
  BLT SUBT2          ;if a<b then branch to subt2 

SUBT1
  SUB R0,R0,R1       ; a=a-b
  B WLOOP            ; branch back to while loop  

SUBT2
  SUB R1,R1,R0       ; b=b-a
  B WLOOP			 ; branch back to Wloop	
                     
stop B stop          ; stop program
     ENDFUNC
     END
