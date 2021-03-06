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
blank  DB    " ", 0
 
         .DATA
Zapros1   DB    13, 10, 'Input element: ', 13, 10, 0
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
         
         ; matrix input
         mov EBX, 0; �������� �� �������
         mov ECX, 6 ; 6 rows
         cycle5:
            push ECX
            Invoke StdOut,ADDR Zapros1
            mov ECX, 3 ;for number of elements in a row (columns)
            ;mov DX, mas[EBX] ; first element of a row
            mov ESI, 0 ; �������� �� ��������
            cycle6:
                ; mov DX, mas[EBX]+[ESI] ; ������� � DX ������� ������� ������
                
                ; input element
                mov tmp_count, ECX
                
                Invoke StdIn,ADDR Buffer,LengthOf Buffer
                Invoke StripLF,ADDR Buffer
                Invoke atol,ADDR Buffer ;result in EAX
                mov SWORD PTR mas[EBX]+[ESI], AX ; ���������� ��������� ����� � ������� ������� �������
                
                ;mov el, DX
                ;Invoke dwtoa, el, ADDR ResStr
                ;Invoke StdOut, ADDR ResStr
                ;Invoke StdOut,ADDR blank
                mov ECX, tmp_count
                
                add ESI, 2 ; move to the next element in a row
                loop cycle6
            Invoke StdOut,ADDR newline
            pop ECX ; ������� �������� �������� �� ������� �� �����
            add EBX, 6 ; ������� �� ����� ������
            loop cycle5 
         
         
         ; ���������� ����� ������ ��������� �������
         mov AX, 0 ; even row numbers sum
         mov EBX, 0; �������� �� �������
         mov ECX, 6 ; 6 rows
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
         
         ; sum into last matrix element
         mov mas[6*3 * 2 - 2], AX
         
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
                Invoke StdOut,ADDR blank
                mov ECX, tmp_count
                
                add ESI, 2 ; move to the next element in a row
                loop cycle4
            Invoke StdOut,ADDR newline
            pop ECX ; ������� �������� �������� �� ������� �� �����
            add EBX, 6 ; ������� �� ����� ������
            loop cycle3 
         

         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

