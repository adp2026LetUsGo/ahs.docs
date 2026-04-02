# 📘 DOCUMENTO 01

## **Telemetría, data loggers y la realidad operativa en pharma (conversación técnica detallada)**

**Archivo sugerido:**  
`01-Xinfer-Telemetry-DataLoggers-and-Operational-Reality.docx`

---

## 01.1 Por qué este documento es necesario

Este documento existe porque, en la conversación, hubo un **desfase inicial entre el modelo mental y la realidad operativa**, y ese desfase **condicionó muchas preguntas posteriores**.

Sin cerrar bien este punto, conceptos como:

- Data Readiness
- históricos
- pronóstico “before it arrives”
- reentrenamiento
- arquitectura  
    parecen arbitrarios.

Aquí se documenta **cómo se corrige ese modelo mental**, paso a paso.

---

## 01.2 El punto de partida: “pensé en barcos”

En un momento clave de la conversación aparece esta afirmación:

> _“Mi error de concepción es que pensé en barcos, no en medicamentos exclusivamente.”_

Esto no es un error trivial.  
Es un **error de dominio**, muy común cuando se piensa en logística de forma genérica.

Cuando se piensa en barcos, implícitamente se asume:

- trayectos largos (días o semanas),
- conectividad intermitente pero existente,
- contenedores con sensores activos,
- transmisión periódica,
- capacidad de reaccionar durante el viaje.

Ese modelo mental **no aplica a pharma aérea**.

---

## 01.3 Cambio explícito de dominio: “para esta demo solo pharma”

Al acotar el dominio a **pharma**, se producen varias consecuencias inmediatas:

1. El transporte principal es:
    
    - aéreo internacional,
    - terrestre de corta duración.
2. Durante el vuelo:
    
    - **no hay transmisión de datos**,
    - no hay intervención posible,
    - no hay telemetría continua.
3. El sensor típico:
    
    - es un **data logger**,
    - registra temperatura cada X minutos,
    - **almacena**, no transmite.

Este cambio redefine **qué datos existen y cuándo existen**.

---

## 01.4 La pregunta clave: ¿telemetría o logger que guarda?

Al analizar un histórico generado automáticamente (40 mediciones cada 2 minutos), surge la duda legítima:

> _“Eso es usando telemetría o esos datos pudieron ser obtenidos por algún instrumento que no transmitía pero sí guardaba?”_

La respuesta técnica es clara:

- **Ese patrón es completamente compatible con un data logger sin transmisión**.
- En pharma, ese es el **caso más común**.

Ejemplos reales (implícitos, no citados):

- USB loggers
- BLE loggers
- dispositivos que se descargan al final del viaje

Conclusión conversacional explícita:

> No hay que asumir telemetría solo porque hay series temporales densas.

---

## 01.5 Implicación directa: cuándo se puede actuar

Este punto es crítico para el propósito del producto.

Si:

- los datos se descargan **al final**,
- y no se transmiten,

entonces:

- **no se puede actuar durante el vuelo**,
- **no se puede “corregir” una excursión en tiempo real**.

Esto obliga a una reformulación del objetivo:

> La única intervención posible es **ANTES de que el embarque salga**.

Esto conecta directamente con el “before it arrives” del use case inicial.

---

## 01.6 Qué significa realmente “before it arrives” en pharma

A partir de esta aclaración, el significado real se redefine así:

“Before it arrives” significa:

- antes de que llegue al destino,
- pero también **antes de que salga**,
- usando información conocida **antes del despacho**.

No significa:

- streaming,
- dashboards en vivo,
- alertas durante el vuelo.

Este punto **cierra definitivamente** la discusión sobre telemetría para este producto.

---

## 01.7 El rol real de los históricos de data loggers

Una vez aceptado que los data loggers se leen al final, se redefine su rol:

Los históricos sirven para:

- aprender patrones,
- entender comportamientos por ruta,
- entender comportamientos por carrier,
- evaluar empaques,
- evaluar estaciones.

No sirven para:

- intervención directa,
- control en tiempo real,
- corrección durante el viaje.

Esto es clave para justificar:

- el uso de ML offline,
- el entrenamiento por lotes,
- la necesidad de ventanas históricas.

---

## 01.8 Segunda pregunta práctica: cuántos embarques se usan

Aquí aparece otra pregunta operativa importante:

> _“En la práctica, se almacenan o utilizan el último embarque o los últimos N?”_

La respuesta se construye con razonamiento práctico:

- Un solo embarque **no representa nada**.
- Todos los embarques históricos **mezclan condiciones obsoletas**.
- Se usa una **ventana móvil**.

Ejemplos discutidos:

- últimos 5 embarques,
- último mes,
- últimos 3 meses,
- últimos N registros por ruta.

Esto empieza a perfilar la lógica de selección automática.

---

## 01.9 El problema que emerge: el usuario puede mezclar mal

En este punto surge una preocupación muy concreta:

> _“El usuario podría elegir carriers con performance muy distinta, rutas distintas, estaciones distintas.”_

Esto no es hipotético.  
Es exactamente lo que **hace mal un usuario no experto**.

Ejemplos implícitos:

- mezclar verano e invierno,
- mezclar carriers “premium” con carriers problemáticos,
- mezclar rutas tropicales con rutas templadas.

Aquí aparece un quiebre conceptual importante.

---

## 01.10 Nacimiento del concepto de validación previa

A partir de esta preocupación se formula algo nuevo:

> _La app debería analizar el criterio del usuario antes de pronosticar._

No el pronóstico.  
No el modelo.  
Sino **la selección de datos**.

Este es el momento en que:

- se deja de pensar solo en ML,
- y se empieza a pensar en **razonamiento previo**.

Este razonamiento no es matemático todavía; es **operativo**.

---

## 01.11 Diferencia entre “calidad de datos” y “compatibilidad”

Aquí se hace una distinción explícita:

- Calidad de datos:
    
    - nulls,
    - formatos,
    - rangos inválidos.
- Compatibilidad de datos:
    
    - misma estación,
    - rutas comparables,
    - carriers comparables,
    - volúmenes razonables.

El sistema puede tener datos “limpios” pero **conceptualmente incorrectos** para pronosticar.

Esto justifica que la validación previa sea un **módulo propio**.

---

## 01.12 Conclusión operativa de este documento

Este documento cierra con una conclusión implícita pero firme:

- Xinfer **no es** un sistema de telemetría.
- Xinfer **no es** un sistema de monitoreo en tiempo real.
- Xinfer **sí es** un sistema de:
    - análisis previo,
    - inferencia de riesgo,
    - automatización del criterio humano,
    - basado en históricos post‑viaje.

Todo lo que sigue (Data Readiness, modelo, UX, Cell, prompts) **depende de esta conclusión**.

---

### Cierre del DOCUMENTO 01

Este documento existe para que no vuelva a aparecer la pregunta:

> “¿Por qué no hacemos esto en tiempo real?”

La respuesta está aquí, documentada con razonamiento técnico y operativo.