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
newline  DB    0Dh, 0Ah, 0
 
         .DATA
Zapros1   DB    13, 10, 'Input ?', 13, 10, 0
Result   DB    'Result='
ResStr   DB    16 DUP (' '), 0
res      SWORD ?
n        SDWORD ?
el       SWORD ?
mas      SWORD 0, 4, 3, 2, 0, 3, 6, 2, 5, 2, 7, 8, 1, 1, 4, 5, 1, 5 ; 6x3 matrix


         .DATA?
inbuf    DB    100 DUP (?)
Buffer   DB    10 DUP (?)
tmp_count SDWORD ?

         .CODE
Start:
         ; ������:
         ; ���������� ����� ������ ��������� ������ ������ � 
         ; ��������� �� ����� ���������� �������� �������
         
         mov AX, 0 ; even row numbers sum
         mov EBX, 0; �������� �� �������
         mov ECX, 6 ; 6 rows
         
         ; ���������� ����� ������ ��������� �������
         cycle1:
            push ECX
            mov ECX, 3 ;for number of elements in a row (columns)
            ;mov DX, mas[EBX] ; first element of a row
            mov ESI, 0 ; �������� �� ��������
            cycle2:
                mov DX, mas[EBX]+[ESI] ; ������� � DX ������� ������� ������
                test DX, 1
                jz evenNum
                jmp continue
                evenNum:
                    ; ���� ����� ������
                    add AX, DX
                continue:
                add ESI, 2 ; move to the next element in a row
                loop cycle2
            pop ECX ; ������� �������� �������� �� ������� �� �����
            add EBX, 6 ; ������� �� ����� ������
            loop cycle1 
         ; ����� � AX
         mov res, AX
         
         
         ; ����� �������
         mov EBX, 0; �������� �� �������
         mov ECX, 6 ; 6 rows
         cycle3:
            push ECX
            mov ECX, 3 ;for number of elements in a row (columns)
            ;mov DX, mas[EBX] ; first element of a row
            mov ESI, 0 ; �������� �� ��������
            cycle4:
                mov DX, mas[EBX]+[ESI] ; ������� � DX ������� ������� ������
                
                ; output element
                mov tmp_count, ECX
                mov el, DX
                Invoke dwtoa, el, ADDR ResStr
                Invoke StdOut, ADDR ResStr
                mov ECX, tmp_count
                
                add ESI, 2 ; move to the next element in a row
                loop cycle4
            Invoke StdOut,ADDR newline
            pop ECX ; ������� �������� �������� �� ������� �� �����
            add EBX, 6 ; ������� �� ����� ������
            loop cycle3 
         
         Invoke StdOut,ADDR newline
         ; output of sum
         Invoke dwtoa, res, ADDR ResStr
         Invoke StdOut,ADDR Result
         Invoke StdIn,ADDR Buffer,LengthOf Buffer
         

         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

