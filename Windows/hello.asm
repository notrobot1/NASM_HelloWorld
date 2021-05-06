NULL EQU 0
STD_OUTPUT_HANDLE EQU -11
STD_INPUT_HANDLE EQU -10
extern _GetStdHandle@4
extern _WriteFile@20
extern _WriteConsoleA@20
extern _ExitProcess@4
extern _ReadConsoleA@16

global Start

section .data

	Message db "hello from", 0Dh, 0Ah
	MessageLength EQU $-Message

section .bss
	StandardHandle resd 1
	Written resd 1

section .text
	Start:

 	      push STD_OUTPUT_HANDLE
          call _GetStdHandle@4
          mov dword [StandardHandle], EAX
	      push NULL
          push Written
          push MessageLength
          push Message
          push dword [StandardHandle]
          call _WriteFile@20
	Read:
		  push STD_INPUT_HANDLE
          call _GetStdHandle@4
          mov [StandardHandle],eax
          push NULL
          push 1
          push MessageLength
          push dword [StandardHandle]
          call _ReadConsoleA@16

    exit:

        push    NULL
        call    _ExitProcess@4
