global find_word

section .text
%include "lib.inc"

; Принимает два аргумента:
; - указатель на нуль-терминированную строку
; - указатель на начало словаря
; find_word пройдет по всему словарю в поисках подходящего ключа. 
; Если подходящее вхождение найдено, вернет адрес начала вхождения
; в словарь (не значение), иначе вернет 0.
; -> rdi - ключ ( указатель на нуль-терминированную строку )
; -> rsi - словарь ( указатель на начало словаря )
; <- rax - указатель на начало вхождения / 0
find_word:
    .loop:
        test rsi, rsi		
        jz .end_of_dict		

        push rdi
        push rsi
        add rsi, 8		; первые 8 байт во вхождении занимает адрес следующего вхождения
        call string_equals
        pop rsi
        pop rdi

        test rax, rax
        jnz .success

        mov rsi, [rsi]
        jmp .loop

    .end_of_dict:
        xor rax, rax
        ret
    .success:
        mov rax, rsi
        ret
