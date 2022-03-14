%define DICT_POINTER 0

; %1 - ключ
; %2 - имя метки, по которой будет находится соответствие
%macro colon 2
    %%new_entry:
        dq DICT_POINTER			; адрес следующей пары
	db %1, 0			; ключ
       	%define DICT_POINTER %%new_entry
	%2:				; соответствие
%endmacro

