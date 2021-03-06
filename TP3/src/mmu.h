/* ** por compatibilidad se omiten tildes **
================================================================================
 TRABAJO PRACTICO 3 - System Programming - ORGANIZACION DE COMPUTADOR II - FCEN
================================================================================
  definicion de funciones del manejador de memoria
*/

#ifndef __MMU_H__
#define __MMU_H__

#include "defines.h"
#include "game.h"

#define CODIGO_BASE       0X401000

#define MAPA_BASE_FISICA  0x500000
#define MAPA_BASE_VIRTUAL 0x800000
#define KERNEL_CR3 		  0x27000

typedef struct page_table {
    unsigned char   present:1;
    unsigned char   read_write:1;
    unsigned char   user_supervisor:1;
    unsigned char   page_level_write_through:1;
    unsigned char   page_level_cache_disabled:1;
    unsigned char   accessed:1;
    unsigned char   dirty_bit:1;
    unsigned char   page_table_attr_indx:1;
    unsigned char   global:1;
    unsigned char   available_11_9:3;
    unsigned int    base_adress:20;
} __attribute__((__packed__, aligned (4))) page_table;


typedef struct page_directory {
    unsigned char   present:1;
    unsigned char   read_write:1;
    unsigned char   user_supervisor:1;
    unsigned char   page_level_write_through:1;
    unsigned char   page_level_cache_disabled:1;
    unsigned char   accessed:1;
    unsigned char   ignored:1;
    unsigned char   page_size:1;
    unsigned char   global:1;
    unsigned char   available_11_9:3;
    unsigned int    base_adress:20;
} __attribute__((__packed__, aligned (4))) page_directory;


//void mmu_inicializar();
uint mmu_inicializar();
// devuelve la proxima pagina libre del area libre del kernel
uint mmu_proxima_pagina_fisica_libre();

// setea en cero todos los bytes
void mmu_inicializar_pagina(uint * pagina);

// copia los bytes
void mmu_copiar_pagina(uint src, uint dst);

// pide una pagina para usar de directorio. Luego inicializa las entradas que iran con identity mapping.
uint mmu_inicializar_dir_kernel();

// transforma coordenadas (x,y) en direcciones fisicas
uint mmu_xy2fisica(uint x, uint y);

// transforma coordenadas (x,y) en direcciones virtuales
uint mmu_xy2virtual(uint x, uint y);

// crea el directorio, las paginas, copia el codigo e inicializa el stack
uint mmu_inicializar_memoria_perro(perro_t *perro, int index_jugador, int index_tipo);

// debe remapear y copiar el codigo
void mmu_mover_perro(perro_t *perro, int viejo_x, int viejo_y);


void mmu_mapear_pagina  (uint virtual, uint cr3, uint fisica, uint attrs);
uint mmu_unmapear_pagina(uint virtual, uint cr3);


void mmu_inicializar_page_directory(page_directory * dir, uint addr, uint attrs);
void mmu_inicializar_page_table(page_table * tab, uint addr, uint attrs);

#endif	/* !__MMU_H__ */
