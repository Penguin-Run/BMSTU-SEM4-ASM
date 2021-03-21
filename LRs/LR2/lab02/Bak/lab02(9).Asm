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
Zapros1   DB    13, 10, 'Input x', 13, 10, 0
Zapros2   DB    13, 10, 'Input y', 13, 10, 0
Zapros3   DB    13, 10, 'Input a', 13, 10, 0
Zapros4   DB    13, 10, 'Input b', 13, 10, 0
Result   DB    'Result='
ResStr   DB    16 DUP (' '), 0
tmp1        SWORD ?
tmp2        SWORD ?
tmp3        SWORD ?
n        SWORD ?


         .DATA?
inbuf    DB    100 DUP (?)
x        SWORD ?
y        SWORD ?
a        SWORD ?
b        SWORD ?
Buffer   DB    10 DUP (?)
first    SWORD ?

         .CODE
Start:   
         ; ввод
         Invoke StdOut,ADDR Zapros1
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer ;результат в EAX
         mov DWORD PTR x, EAX

         Invoke StdOut,ADDR Zapros2
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer ;результат в EAX
         mov DWORD PTR y, EAX

         Invoke StdOut,ADDR Zapros3
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer ;результат в EAX
         mov DWORD PTR a, EAX
         
         Invoke StdOut,ADDR Zapros4
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         Invoke StripLF,ADDR Buffer
         Invoke atol,ADDR Buffer ;результат в EAX
         mov DWORD PTR b, EAX
         
         ; a^3/3
         ;mov BX, 3
         ;mov CX, a
         ;mov AX, a
         ;imul CX
         ;imul CX
         ;idiv BX
         ;mov BX, AX
         
         ; a*x^2
         XOR EAX, EAX
         mov AX, x
         imul AX
         imul a
         mov tmp1, AX
         
         
         
         ; c*(x+3)
         ;mov AX, x
         ;add AX, 3
         ;imul d
         
         ; первое минус второе
         ;sub BX, AX
         
         
         
         mov n, AX
         
         
         ; преобразование
         Invoke dwtoa,n,ADDR ResStr
         
         ; вывод
         Invoke StdOut,ADDR Result

         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

