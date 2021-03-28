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

         .DATA
Zapros1   DB    13, 10, 'Input a', 13, 10, 0
Zapros2   DB    13, 10, 'Input b', 13, 10, 0
Zapros3   DB    13, 10, 'Input x', 13, 10, 0
Result   DB    'Result='
ResStr   DB    16 DUP (' '), 0
f        SWORD ?
x        SWORD 5
a        SWORD 4
b        SWORD 3


         .DATA?
inbuf    DB    100 DUP (?)
Buffer   DB    10 DUP (?)
tmp1     SWORD ?
tmp2     SWORD ?


         .CODE
Start:
                 ; ввод
         Invoke StdOut,ADDR Zapros1
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer ;результат в EAX
         mov DWORD PTR a, EAX
         ; почему то a = 0 при вводе
         
                 ; ввод
         Invoke StdOut,ADDR Zapros2
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer ;результат в EAX
         mov DWORD PTR b, EAX
         
                 ; ввод
         Invoke StdOut,ADDR Zapros3
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer ;результат в EAX
         mov DWORD PTR x, EAX
         
         XOR EAX, EAX
         mov AX, x
         imul a
         
         ;cwd
         test AX, 1
         jz chetn
         ; nechetn
         mov AX, x
         imul a
         mov tmp1, AX
         
         mov AX, b
         imul b
         imul b
         mov tmp2, AX
         
         mov AX, tmp1
         sub AX, tmp2
         
         jmp continue
 chetn:  
         mov AX, x
         imul a
         cwd
         XOR EBX, EBX
         mov BX, 2
         idiv BX
 continue:
 
         mov AX, 5
         mov f, AX ;  f выводится в виде знака
         
         ; преобразование
         Invoke dwtoa,f,ADDR ResStr
         
         ; вывод
         Invoke StdOut,ADDR Result

         Invoke StdIn,ADDR Buffer,LengthOf Buffer


         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

