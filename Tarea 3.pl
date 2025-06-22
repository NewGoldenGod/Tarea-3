% Hechos: Base de conocimiento con platos y calorías

entrada(paella, 200).
entrada(gazpacho, 150).
entrada(pasta, 300).
entrada(ensalada_cesar, 180).
entrada(sopa_de_verduras, 120).

principal(filete_de_cerdo, 400).
principal(pollo_asado, 280).
principal(bisteck_a_lo_pobre, 500).
principal(trucha, 160).
principal(bacalao, 300).
principal(salmon_a_la_plancha, 350).
principal(lasagna, 450).

postre(flan, 200).
postre(naranja, 50).
postre(nueces, 500).
postre(yogurt, 100).
postre(helado, 250).

% Punto de entrada principal

principal :-
    write('SISTEMA DE GESTIÓN DE CALORÍAS - "MI MEJOR COMIDA"'), nl,
    menu.

% Menú interactivo
menu :-
    repeat,
    nl,
    write('-------- MENÚ --------'), nl,
    write('1. Calcular calorías de un menú específico'), nl,
    write('2. Mostrar combinaciones bajas en calorías'), nl,
    write('3. Salir'), nl,
    write('Seleccione una opción (1-3): '), read(Opcion),
    (Opcion == 1 -> calcular_calorias_menu, fail;
     Opcion == 2 -> mostrar_combinaciones_bajas, fail;
     Opcion == 3 -> write('Saliendo del sistema. ¡Hasta pronto!'), nl, !;
     write('Opción no válida. Intente nuevamente.'), nl, fail).

% Cálculo de calorías del menú personalizado

calcular_calorias_menu :-
    write('Entradas: paella, gazpacho, pasta, ensalada_cesar, sopa_de_verduras.');
    write('Ingrese una entrada: '), read(Entrada),
    validar_entrada(Entrada, CalE),
    
    
	write('Platos principales: filete_de_cerdo, pollo_asado, bistec_a_lo_pobre, trucha, bacalao, salmon_a_la_plancha, lasagna.');
    write('Ingrese un plato principal: '), read(Principal),
    validar_principal(Principal, CalP),
    
	write('Postres: flan, naranja, nueces, yogur, helado.');
    write('Ingrese un postre: '), read(Postre),
    validar_postre(Postre, CalPo),

    Total is CalE + CalP + CalPo,
    nl,
    write('--- RESUMEN DEL MENÚ ---'), nl,
    write('Entrada: '), write(Entrada), write(' ('), write(CalE), write(' cal)'), nl,
    write('Principal: '), write(Principal), write(' ('), write(CalP), write(' cal)'), nl,
    write('Postre: '), write(Postre), write(' ('), write(CalPo), write(' cal)'), nl,
    write('TOTAL: '), write(Total), write(' calorías'), nl.

% Validadores con control de errores

validar_entrada(E, C) :-
    entrada(E, C), !.
validar_entrada(_, _) :-
    write('Entrada no válida. Intente de nuevo.'), nl,
    calcular_calorias_menu, fail.

validar_principal(P, C) :-
    principal(P, C), !.
validar_principal(_, _) :-
    write('Plato principal no válido. Intente de nuevo.'), nl,
    calcular_calorias_menu, fail.

validar_postre(P, C) :-
    postre(P, C), !.
validar_postre(_, _) :-
    write('Postre no válido. Intente de nuevo.'), nl,
    calcular_calorias_menu, fail.

% Mostrar combinaciones bajo un límite calórico

mostrar_combinaciones_bajas :-
    write('Ingrese el máximo de calorías deseado: '), read(Limite),
    nl,
    write('--- MENÚS BAJOS EN CALORÍAS ---'), nl,
    buscar_combinacion(Limite),
    !.

buscar_combinacion(Limite) :-
    entrada(E, CE),
    principal(P, CP),
    postre(PO, CPO),
    Total is CE + CP + CPO,
    Total =< Limite,
    nl,
    write('* Entrada: '), write(E), write(' ('), write(CE), write(' cal)'), nl,
    write('  Principal: '), write(P), write(' ('), write(CP), write(' cal)'), nl,
    write('  Postre: '), write(PO), write(' ('), write(CPO), write(' cal)'), nl,
    write('  TOTAL: '), write(Total), write(' calorías'), nl,
    fail.
buscar_combinacion(_).
