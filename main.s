@Guillermo Sandoval
@Alberto Andres Urizar
.text
.align 2
.global main

@Se hara un ciclo del juego, primero va el jugador 1, luego el jugador 2
@
ciclo:
	bl jugador1
	bl jugador2
	b ciclo

@Salida correcta del sistema
	/*salida correcta*/
	mov R0, #0
	mov R3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr