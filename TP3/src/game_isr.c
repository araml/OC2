#include "game.h"
#include "mmu.h"
#include "tss.h"
#include "screen.h"



/// ************** RUTINAS DE ATENCION DE INTERRUPCIONES DE ************** ///
///                              ALTO NIVEL                                ///
///                  (deben ser llamadas desde isr.asm)                    ///
/// ********************************************************************** ///


extern uint debug_mode;

//char hex[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};


// gasta un rato en un ciclo infinito, util para hacer pausas y debuguear
void wait(int pseudosecs)
{
	int count;
	for (count = 0; count < pseudosecs * 1000000; count++) {}
}


uint game_syscall_manejar(uint syscall, uint param1)
{
	// ~ completar llamando a las funciones que haga falta ~
	return 0;
}

// ~~~ debe atender la interrupción de reloj para actualizar la pantalla y terminar si es hora,
// ~~~ recibe el perro que está corriendo actualmente
void game_atender_tick(perro_t *perro)
{

	if (perro != NULL){
		screen_actualizar_reloj_perro(perro);
		//breakpoint();
	}
	mostrar_reloj();
	ultimo_cambio--;
	game_terminar_si_es_hora();


}



#define KB_w        0x11 // 0x91
#define KB_s        0x1f // 0x9f
#define KB_a        0x1e // 0x9e
#define KB_d        0x20 // 0xa0

#define KB_i        0x17 // 0x97
#define KB_k        0x25 // 0xa5
#define KB_j        0x24 // 0xa4
#define KB_l        0x26 // 0xa6


#define KB_q        0x10 // 0x90
#define KB_e        0x12 // 0x92

#define KB_u        0x16 // 0x96
#define KB_o        0x18 // 0x98

#define KB_z        0x2C // ?
#define KB_x        0x2D // ?
#define KB_c        0x2E // ?

#define KB_b        0x30 // ?
#define KB_n        0x31 // ?
#define KB_m        0x32 // ?

#define KB_shiftL   0x2a // 0xaa
#define KB_shiftR   0x36 // 0xb6

#define KB_shiftR   0x36 // 0xb6

#define KB_y        0x15 // 0x96
#define KB_y        0x15 // 0x96

#define KB_p        0x19 // 0x96

void atender_teclado(unsigned char tecla) {

	switch (tecla)
	{
	// ~~~ completar ~~~
	case KB_q: pintar_atender_teclado('q'); break;

	case KB_a: pintar_atender_teclado('a'); break;


	case KB_k: pintar_atender_teclado('k'); break;

	case KB_z: pintar_atender_teclado('z'); break;
	case KB_x: pintar_atender_teclado('x'); break;
	case KB_c: pintar_atender_teclado('c'); break;

	case KB_b: pintar_atender_teclado('b'); break;
	case KB_n: pintar_atender_teclado('n'); break;
	case KB_m: pintar_atender_teclado('m'); break;
	default: break;
	}


}




// ~~~ debe atender la interrupción de teclado, se le pasa la tecla presionada
void game_atender_teclado(unsigned char tecla)
{

	switch (tecla)
	{
	// ~~~ completar ~~~
	//faltan las otras teclas
	case KB_q: game_jugador_lanzar_perro(&jugadorA, TIPO_1, jugadorA.x_cucha, jugadorA.y_cucha); break;
	case KB_e: game_jugador_lanzar_perro(&jugadorA, TIPO_2, jugadorA.x_cucha, jugadorA.y_cucha); break;
	case KB_u: game_jugador_lanzar_perro(&jugadorB, TIPO_1, jugadorB.x_cucha, jugadorB.y_cucha); break;
	case KB_o: game_jugador_lanzar_perro(&jugadorB, TIPO_2, jugadorB.x_cucha, jugadorB.y_cucha); break;

	case KB_w: game_jugador_moverse(&jugadorA,0,  -1); break;
	case KB_a: game_jugador_moverse(&jugadorA, -1,  0); break;
	case KB_s: game_jugador_moverse(&jugadorA, 0,  1); break;
	case KB_d: game_jugador_moverse(&jugadorA, 1,  0); break;

	case KB_i: game_jugador_moverse(&jugadorB,  0, -1); break;
	case KB_j: game_jugador_moverse(&jugadorB,  -1, 0); break;
	case KB_k: game_jugador_moverse(&jugadorB,  0, 1); break;
	case KB_l: game_jugador_moverse(&jugadorB,  1, 0); break;

	case KB_z: game_jugador_dar_orden(&jugadorA, 1); break;
	case KB_x: game_jugador_dar_orden(&jugadorA, 2); break;
	case KB_c: game_jugador_dar_orden(&jugadorA, 3); break;

	case KB_b: game_jugador_dar_orden(&jugadorB, 1); break;
	case KB_n: game_jugador_dar_orden(&jugadorB, 2); break;
	case KB_m: game_jugador_dar_orden(&jugadorB, 3); break;

	case KB_y: atender_debug(); break;	
	
	default: break;
	}

}



void atender_debug(){
    //breakpoint();
    
    if(debug_mode == 0){
		debug_mode = 1;
	} else if(debug_view == 0){
		debug_mode = 0;
	} else {
		game_restaurar_pantalla();
		debug_view = 0;
		debug_mode=0;
	}
	
	//borrar luego
	//print(debug_mode==1 ? "debug  on": "debug off", 70, 5, C_BG_LIGHT_GREY | C_FG_BLACK);
	
	//print(debug_view==1 ? "view  on": "view off", 70, 6, C_BG_LIGHT_GREY | C_FG_BLACK);
	
	
    	
}

uint atender_interrupcion_debug(uint rax){
	//screen_pintar_rect(' ',C_FG_BLACK   | C_FG_WHITE, 6, 26, 30, 25);	
	//int intValue = 182;	
	uchar urax[50] = {'r','a','x','='};	   		
	int i = 5;	
	while(rax!=0){
	    urax[i++] = rax%10+'0';
	    rax/=10; 			
	}

	//uchar c[4] = {'h','o','l','a'};
	//uchar rax[10] = sprintf("%08x",rax);
	if(debug_mode==2){
		//screen_pintar_rect(' ', C_BG_RED   | C_FG_WHITE, 6, 26, 30, 25);			
		pintar_mensaje(urax,C_FG_WHITE,7,27,i+5);		
		return 1;	
	} 
		return 0;
}






