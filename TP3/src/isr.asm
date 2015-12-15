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

extern screen_pintar
extern game_atender_tick
extern atender_teclado
extern GDT_TSS_IDLE
;;
;; Definición de MACROS
;; -------------------------------------------------------------------------- ;;

%macro ISR 1
global _isr%1

_isr%1:
pushad
xor eax,eax
 str cx
 shr cx,3
 push ecx
 call sched_remover_tarea
 MOV ebx,[GDT_TSS_IDLE]
 shl ebx, 3
 mov [sched_tarea_selector],ebx
 jmp far [sched_tarea_offset]
 pop ecx
 mov eax, %1
 jmp $
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
        ; xchg bx, bx
        call fin_intr_pic1
        sub esp, 4
        call sched_atender_tick
        str cx
        shl ax, 3
        cmp ax, cx
        je .fin
        mov [sched_tarea_selector], ax
        jmp far [sched_tarea_offset]
        .fin:
        add esp, 4
        popad  
        iret
;;
;; Rutina de atención del TECLADO
;; -------------------------------------------------------------------------- ;;
global _isr33
    _isr33:
        pushad
        call fin_intr_pic1
        in al, 0x60
        push eax
        call game_atender_teclado
        ;xchg bx, bx     
        pop eax
        popad  
    iret
;;
;; Rutinas de atención de las SYSCALLS
;; -------------------------------------------------------------------------- ;;
global _isr46:
    _isr46:
        pushad
        call fin_intr_pic1
        push ecx
        push eax
        call atender_pedido
        popad
        iret 

