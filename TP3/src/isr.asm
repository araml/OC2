; ** por compatibilidad se omiten tildes **
; ==============================================================================
; TRABAJO PRACTICO 3 - System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
; ==============================================================================
; definicion de rutinas de atencion de interrupciones

%include "imprimir.mac"

BITS 32

sched_tarea_offset:     dd 0x00
sched_tarea_selector:   dw 0x00

;; PIC
extern fin_intr_pic1

;; Sched
extern sched_atender_tick
extern sched_tarea_actual
extern sched_remover_tarea

extern screen_pintar
extern game_atender_tick
;extern GDT_TSS_IDLE
extern game_atender_teclado
extern game_atender_pedido
extern pintar_pantalla_debug;
extern atender_interrupcion_debug;
extern debug_mode
extern debug_view
extern game_imprimir_info_debug
extern game_guardar_pantalla 

%define GDT_TSS_IDLE 14
;;
;; Definición de MACROS
;; -------------------------------------------------------------------------- ;;

%macro ISR 1
global _isr%1

_isr%1:
pushad
cmp dword [debug_mode], 0
je .seguir
call game_guardar_pantalla
	mov eax, [esp]
    pushf 									
    push eax
    call game_imprimir_info_debug
    popf
   mov ebx,GDT_TSS_IDLE

shl ebx,3
mov [sched_tarea_selector],ebx
jmp far [sched_tarea_offset]						
    jmp .final
.seguir:	
 str cx
 shr cx,3
 push ecx
 call sched_remover_tarea
 mov ebx, GDT_TSS_IDLE
 shl ebx, 3
 mov [sched_tarea_selector],ebx
 jmp far [sched_tarea_offset]
 pop ecx
 .final:
popad
iret
%endmacro

;;
;; Datos
;; -------------------------------------------------------------------------- ;;
; Scheduler

;;
;; Rutina de atención de las EXCEPCIONES
;; -------------------------------------------------------------------------- ;;
ISR 0
ISR 1
ISR 2
ISR 3
ISR 4
ISR 5
ISR 6
ISR 7
ISR 8
ISR 9
ISR 10
ISR 11
ISR 12
ISR 13
ISR 14
ISR 15
ISR 16
ISR 17
ISR 18
ISR 19

;;
;; Rutina de atención del RELOJ
;; -------------------------------------------------------------------------- ;;
global _isr32
    _isr32:
        pushad
        call fin_intr_pic1
        cmp dword [debug_mode],0
        je .continuar
        cmp dword [debug_view], 1
		je .fin
		.continuar:
        
        call sched_atender_tick
        ;xor ecx, ecx
        str cx
        shl ax, 3
        cmp ax, cx
        je .fin
        mov [sched_tarea_selector], ax
        jmp far [sched_tarea_offset]
        .fin:
        
        popad  
        iret
;;
;; Rutina de atención del TECLADO
;; -------------------------------------------------------------------------- ;;
global _isr33
    _isr33:
        pushad
        call fin_intr_pic1
        ;xchg bx, bx         
        in al, 0x60
            push eax
            call game_atender_teclado
            pop eax
        .continuar: 
        popad  
        iret
;;
;; Rutinas de atención de las SYSCALLS
;; -------------------------------------------------------------------------- ;;
global _isr70:
    _isr70:
        push ecx
        push edx
        push ebx
        push ebp
        push esi
        push edi

        push ecx
        push eax
        call game_atender_pedido
        jmp 0x70:0
        add esp, 8

        pop edi
        pop esi
        pop ebp
        pop ebx
        pop edx
        pop ecx
        iret    




