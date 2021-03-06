; Template for console application
         .586
         .MODEL  flat

         .CONST
MsgExit  DB    "Press Enter to Exit",0AH,0DH,0
newline  DB    0Dh, 0Ah, 0

         .DATA
test_str     DB    "Teeeessssss m", 0 ; max - 255 symbols
space      DB  " "

         ;.DATA?
;inbuf    DB    100 DUP (?)
address_of_result   SDWORD   ?


         .CODE
    public @STR_DEL_REPEATS@4 ;@STR_DEL_REPEATS@8 maybe but in VC char* is 4 bytes i hope

    ; externdef ?PRINT@@YGXPAD@Z:near   -- for 3rd module (from serezhas lab)

    @STR_DEL_REPEATS@4 proc
        push EBP
        mov EBP, ESP


        ; in VC - only 2 register, so ECX is first i guess
        ; so in register (ecx?) should be address of string



        lea esi, [ecx] ; ???? [] because ecx already stores an address ????
        ; mov esi, ecx as an alternative
        mov address_of_result, esi ; store address of the beginning of the result string

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
                    ; TODO: delete instead of putting spaces
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



         ; mov address of the result string in ecx (where result should be)
         mov ecx, address_of_result

         ; call ?PRINT@@YGXPAD@Z   -- for 3rd module (from serezhas lab)

         pop EBP
         ; ret is not needed because nothing should be in stack
     @STR_DEL_REPEATS@4 endp
end
