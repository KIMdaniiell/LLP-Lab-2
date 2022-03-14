%include "colon.inc"
global _start

%define BUFFER_SIZE 254+1	; до 254 символов и еще 1 - null-terminator

section .bss
buffer: resb BUFFER_SIZE

section .data
%include "words.inc"

section .rodata
welcome_message: db "Введите ключ:", 10, 0
eobuffer_message: db "В буффере недостаточно места!", 10, 0
no_entry_message: db "Вхождение не найдено.", 10, 0

section .text
    %include "lib.inc"
    extern find_word

; Читает строку размером не более 255 символов 
; в буфер с stdin. Пытается найти вхождение
; в словаре. Если оно найдено, выводит в stdout
; значение по этому ключу. Иначе выдает сообщение
; об ошибке в stderr.
    _start:
        .welcome:
	    mov rdi, welcome_message
	    call print_string

	.reading_string:
	    mov rdi, buffer
	    mov rsi, BUFFER_SIZE
	    call read_sequence
	    test rax, rax
	    jz .out_of_buffer

	.searching_entry:
	    mov rdi, rax
	    mov rsi, DICT_POINTER
	    call find_word
	    test rax, rax
	    jz .not_found
	    jmp .success

	    

	.out_of_buffer:
	    add rsp, BUFFER_SIZE
	    mov rdi, eobuffer_message
	    call print_error			
	    call exit
	.not_found:
	    add rsp, BUFFER_SIZE
	    mov rdi, no_entry_message
	    call print_error			
	    call exit
	.success:
	    add rax, 8
	    push rax
	    call string_length
	    pop rdi
	    add rdi, rax 
	    inc rdi
	    call print_string
	    call print_newline
    call exit





