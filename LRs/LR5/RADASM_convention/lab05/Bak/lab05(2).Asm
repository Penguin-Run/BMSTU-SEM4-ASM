; Template for console application
         .586
         .MODEL  flat

         .CONST
MsgExit  DB    "Press Enter to Exit",0AH,0DH,0
newline  DB    0Dh, 0Ah, 0

         .DATA
test_str     DB    "Teeeessssss m", 0 ; max - 255 symbols
space      DB  " "

         .DATA?
;inbuf    DB    100 DUP (?)
test_str_1     DB    "Test stringaaa wooo md", 0 ; max - 255 symbols


         .CODE
        ; todo: delete instead of putting spaces

        ;Invoke StdOut, ADDR test_str
        ;Invoke StdOut, ADDR newline
        ;Invoke StdOut, ADDR newline

        lea esi, test_str
        ; ebx - previous symbol
        ; edx - current cymbol
        mov ebx, 0
        mov edx, 0
        mov bl, [esi]  ; load first symbol
        
        mov eax, 1 ; repeated symbols counter
        mov ecx, 256 ; should be on 1 more than string length to solve the case with repeat at the end
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
            
            

         ;Invoke StdOut, ADDR test_str ; ����� ������-����������
         ;Invoke StdOut, ADDR newline
         ;Invoke StdOut, ADDR newline

         XOR    EAX,EAX
         ;Invoke StdOut,ADDR MsgExit
         ;Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         ;Invoke ExitProcess,0
         End
         

