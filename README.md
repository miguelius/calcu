# Analizador sintáctico con programas en Lex y Yacc

Durante el curso estudiamos gramáticas regulares, gramáticas independientes del contexto, la tabla de símbolos, las 3 etapas del compilador: análisis léxico, sintáctico y semántico.

Tenemos una calculadora sencilla que resuelve operaciones y permite definir variables.

Esta calculadora está hecha con dos herramientas que permiten construir scanners y parsers más generales que lo que vimos en el TP.

## Lex & Bison

Existe una herramienta llamada Lex que nos permite mediante ER consturir un scanner. En combinación con yacc (yet another compiler compiler) podemos construir un lexer y un parser y definirle la semántica que necesiten nuestro programa.

La implementación de yacc que usamos es bison.

Al igual que en Lex, un programa en Yacc se divide en 3 partes:

```bison
declaraciones
%%
reglas de producción
%%
código adicional
```

Vamos a estudiarlas.

### Declaraciones

La primera parte puede contener:

- Especificaciones escritas en el lenguaje destino, definidas entre%{ y %} (cada símbolo colocado al principio de
una línea)
- Declaraciones de tokens, con la palabra clave %token
- El tipo del terminal, con la palabra reservada %union
- Información sobre las prioridades de los operadores y su asociatividad.
- El axioma de la gramática, o símbolo inicial, usando la palabra reservada%start (si no se especifica, el axioma es la primera regla de la segunda parte del archivo).

La variable yylval, declarada mplicitamente en el tipo %union es importante ya que contiene la descripción del último token leído.

### Reglas de producción

Acá es donde ocurre la magia. Es donde yacc verifica las construcciones y permite interpretar el código. Puede contener:

- Declaraciones y/o definiciones encerradas entre %{ y %}.
- Reglas de producción de la gramática.

Las reglas de producción se definen así:

```
expresion_no_terminal:
    cuerpo_1 { sentencias acciones 1 }
    | cuerpo_2 { sentencias acciones 2 }
    | ...
    :
    | cuerpo_n { sentencias acciones n }
    ;
```

### Código adicional

Esta parte contiene código adicional. En nuestro caso debe contener la funciónmain() que debe llamar a la función yyparse(), y una función yyerror(char *mensaje), que será llamada cuando ocurra un error de sintáxis.

## La actividad

### Requisitos

Para hacer el trabajo necesitamos:

- gcc o clang
- flex
- bison
- make

### Puesta en marcha

Clonamos el repositorio y corremos:

```
bison -d calcu.y
flex -ocalcu.c calcu.l
```

Si estoy en Windows: ¡agregar \. delante de los nombres de archivo calcu. y calcu.l!

Verificamos que existan los archivos calcu.tab.c, calcu.tab.h y calcu.c.

Si existen, podemos compilar nuestro programa:

```
gcc calcu.tab.c calcu.c -o calcu -lm 
```

Y luego podemos verificar si tenemos un archivo calcu (en windows calcu.exe)

Lo corremos y le enviamos operaciones.

### Calcu

Calcu es una calculadora simple que acepta variables. Estas variables son letras de la 'a' a la 'z'

Supongamos que le enviamos la siguiente entrada:

```
x = 3
y = x + 2
```

Calcu va a devolver:
```
3
5
```

Podemos definir un archivo de operaciones.calcu donde le adjuntamos varias operaciones. Se usa así:

```
./calcu < operaciones.calcu
```

### Tareas

#### Recupero primer parcial

Actualmente acepta 01 001 y 1 como el mismo número el 1. La idea es que haya una única representación.

1. ¿Dónde se define qué acepta cómo número?
2. ¿Qué palabra le da a esa clasificación o categoría léxica?
3. Corregirla para que no acepte números que empiecen con 0. 1 es válido, 01 o 001 no.
4. Las variables son letras minúsculas. Identifique la categoría léxica y nombre que lada.
5. Haga las modificaciones necesarias para que acepte mayúsculas.
6. La Unidad de Ciencia Básicas ama calcu pero nos dijo que es confuso que a y A no sean la misma variable. Arreglelo para que considere ambas opciones iguales.
7. Siguiendo la gramática sintáctica en calcu.y derive las siguientes expresiones:
- 1/2
- (1+3)/0
8. ¿Qué tipo de gramáticas están definidas en calcu.l?
9. ¿Qué tipo de gramáticas están definidas en calcu.y?

#### Recupero tp / segundo parcial

Calcu almacena valores. Por lo que en algún lado debe haber algún lugar donde guarda los valores para poder operar y mostrarlos.
La Unidad de Ciencias Básicas (UCB) nos pide que incorporemos la operación "elevado a": 

Si hacemos
- x = 2^3

Calcu debe guardar el resultado de la expresión 2^3 en x (que era 8 la última vez que revisamos).

La UCB ama a calcu pero nos dice que debería verificar si vamos a dividir por 0.

Otra mejora que reportaron es que solo trabaja con división entera pero al llamar a 2/3 se obtiene 0. Esto confunde a los estudiantes.

1. ¿Dónde guarda los valores calcu?
2. ¿Con que elemento del proceso de compilación se relaciona este elemento?
3. ¿Qué archivo configura al scanner?
4. ¿Qué archivo configura al parser?
5. Implemente la operación "elevado a la"
6. Implemente la verificación del denominador 0 en la división.
7. ¿A qué etapa corresponde la validación del punto 6?
8. Indique qué cambios hay que hacer en calcu.l para que calcu acepte numeros de tipo double.
8. ¿Y en calcu.y para que calcu acepte numeros de tipo double?
10. Implemente los cambios de 8 y 9. ¿Qué pasa ahora al dividir 2/3?

### Recupero las dos evaluaciones

Hacer todos los puntos anteriores.

## Forma de entrega

Modificar el archivo RESOLUCION.md con tus datos y las respuestas en las secciones dispuestas a tal fin y comentarios que creas pertinentes. Además debe estar el código, debe compilar y funcionar.

Borrar las que no correspondan.

## Fecha

Cuando lo tengás.

Fecha límite: 16/12/2024 19:00

## Corrección

Se realizará una breve defensa y se aclararán los puntos y se asignara una nota que será el resultado de lo entregado y las respuestas en la defensa.

Fechas de defensa:

- Lunes 2/12 19:00 hs - Campus
- Lunes 9/12 19:00 hs - Campus
- Lunes 16/12 19:00 hs - Campus

¡Éxitos!
