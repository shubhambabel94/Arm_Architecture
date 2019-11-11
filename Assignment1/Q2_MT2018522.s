  area ToFindGreatest, CODE, READONLY
       EXPORT __main
       ENTRY 
__main  FUNCTION
   mov   r0, #0 ; initialization to 0 | this register stores the greatest value after program compilation 
   mov   r1, #7 ; first no
   mov   r2, #9 ; second no
   mov   r3, #2 ; third no 
  
comparator1  
    cmp   r1, r2  ; compare r1 and r2
    bge  label1   ; if r1>=r2 then branch to label1
    blt  label2   ; if r1<r2 then branch to label2
   
comparator2
   cmp r0, r3      ; compare r0 and r3
   bge stop        ; if r0>=r3 then r0 has greatest value and branch to stops the execution 
   blt label3      ; if r0<r3 then r3 is greatest so branch to label 3
   
label1
   mov   r0, r1    ; move r1 to r0
   b   comparator2 ; branch to comparator2 

label2
    mov r0, r2     ; move r2 to r0  
    b  comparator2 ; branch to comparator2 
  
label3
    mov r0, r3     ; as r3 is greatest so r3 moves to r0

stop B stop ; stop program
     ENDFUNC
     END