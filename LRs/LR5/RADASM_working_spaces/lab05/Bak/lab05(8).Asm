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
test_str     DB    "Teees", 0 ; max - 255 symbols
space      DB  " "

         .DATA?
inbuf    DB    100 DUP (?)
test_str_1     DB    "Test stringaaa wooo md", 0 ; max - 255 symbols

         .CODE
Start:
        Invoke StdOut, ADDR test_str
        Invoke StdOut, ADDR newline
        Invoke StdOut, ADDR newline

        lea esi, test_str
        ; ebx - previous symbol
        ; edx - current cymbol
        mov bl, [esi]  ; load first symbol
        mov ebx, 0
        mov edx, 0
        
        mov eax, 1 ; repeated symbols counter
        mov ecx, 5
        cycle_1:
            add esi, 1 ; move to the next symbol in str
            mov dl, [esi]
            
            
            cmp edx, ebx
            jne diff
                cmp eax, 1
                jne next1
                    lea edi, [esi - 1] ; ���� ����� ������������� ������������������ - ��������� ����� �� ������ � edi
                next1:
                inc eax
                jmp next ; ����� �������� ����� ��� ������ �������� diff
            
            diff:
                cmp eax, 1
                je next
                    ; ������� ������������� ������������������(�������� ������ ��� �������) � �������� ����� � �������
                    push esi
                    push ecx
                    mov ecx, eax
                    cld
                    cycle_2:
                        lea esi, space
                        movsb
                        loop cycle_2
                    pop ecx
                    pop esi
                    
                    mov eax, 1
            
            next:
            ; prev = cur
            mov ebx, edx
            loop cycle_1
            
            
        

; TODO: ������������� ������ ��� ������������� ������������������ ��������� � ����� ������


         Invoke StdOut, ADDR test_str
         Invoke StdOut, ADDR newline
         Invoke StdOut, ADDR newline

         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

