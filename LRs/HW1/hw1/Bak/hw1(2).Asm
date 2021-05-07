; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    "Press Enter to Exit",0AH,0DH,0
Zapros   DB    13, 10, 'Input number of letter count and then letter itself:', 13, 10, 0
Result_caption   DB    'Result = ', 0
newline  DB    0Dh, 0Ah, 0

         .DATA
n        SDWORD     3
ResStr   DB    16 DUP (' '), 0
acc      SDWORD  0
result   DB    40  DUP ('r')
let      DB    10 DUP (?)


         .DATA?
inbuf    DB    100 DUP (?)
Buffer   DB    10 DUP (?)



         .CODE
Start:
        ; ввод первой буквы и числа
        ; записывание этой буквы в строку
        ; ввод второй буквы итд...
        ;...
        ;вывод итоговой строки
        
        ; set edi to the beginning of the result str
        lea edi, result
        
        mov ECX, 0
        
        while_loop:
            push ECX
            push edi
            
            ; break if letters count is 40 or more
            mov EDX, acc
            cmp EDX, 40
            jge output
            
            
            ; n input
             Invoke StdOut,ADDR Zapros
             Invoke StdIn,ADDR Buffer,LengthOf Buffer
             Invoke StripLF,ADDR Buffer
             Invoke atol,ADDR Buffer ;результат в EAX
             mov SDWORD PTR n, EAX
             
             ; accumulate letters count
             add acc, EAX
             
             ; letter input
             Invoke StdIn,ADDR let,LengthOf let
             Invoke StripLF,ADDR let
             
             pop edi
             mov ECX, n
             cld
             for_loop:
                 ; put letter in result str n times
                 lea esi, let
                 movsb
                 loop for_loop
                 
             pop ECX
             loop while_loop
         
         output:
         Invoke StdOut, ADDR result
         Invoke StdOut, ADDR newline


         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

