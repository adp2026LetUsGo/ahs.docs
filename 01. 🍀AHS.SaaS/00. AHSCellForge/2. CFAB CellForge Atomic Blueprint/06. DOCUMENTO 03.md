

## **Cómo trabaja un analista logístico en la práctica y cómo eso se traduce al sistema**

**Archivo sugerido:**  
`03-Xinfer-How-a-Logistics-Analyst-Really-Works.docx`

---

## 03.1 Por qué este documento es necesario

Después de aclarar:

- que no hay telemetría en vuelo,
- que los data loggers se leen al final,
- y que el pronóstico es **pre‑despacho**,

surge una pregunta inevitable:

> _“Entonces, ¿cómo toman decisiones hoy los analistas logísticos sin IA?”_

Este documento existe para **responder esa pregunta**, porque **toda la lógica de Xinfer** se apoya en **replicar y automatizar ese proceso humano**.

Sin este documento, decisiones como:

- Data Readiness,
- filtros automáticos,
- bloqueo de pronósticos,
- reentrenamiento por lotes,

parecen “caprichos técnicos”.  
Con este documento, se entiende que **son traducciones directas del trabajo humano real**.

---

## 03.2 El punto de partida del analista: nunca el modelo, siempre el contexto

Una de las primeras correcciones conceptuales que aparece en la conversación es esta:

> _El analista NO empieza preguntándose “¿qué modelo uso?”_

Empieza preguntándose:

- ¿Qué producto voy a enviar?
- ¿Qué tan sensible es?
- ¿Por dónde va?
- ¿En qué época del año?
- ¿Con qué empaque?
- ¿Con quién lo voy a enviar?

Esto parece trivial, pero es **fundamental**.

El analista **no piensa en features**, piensa en **riesgo operativo**.

---

## 03.3 El histórico como memoria, no como dataset abstracto

Otra aclaración importante surge cuando se habla de históricos.

El analista **no ve el histórico como “filas en una base de datos”**.  
Lo ve como:

- “¿Cómo se ha comportado esta ruta?”
- “¿Este carrier suele retrasarse?”
- “¿Este empaque aguanta el verano?”
- “¿Qué pasó la última vez que intentamos esto?”

Esto lleva a una observación clave que aparece explícitamente en la conversación:

> _No todo el histórico es relevante para el caso actual._

Por eso:

- no se usan datos de hace años,
- no se mezclan rutas sin pensar,
- no se mezclan estaciones.

---

## 03.4 Ventanas de datos: la práctica real

Cuando se pregunta:

> _“¿Se usan solo los últimos embarques?”_

La respuesta que se construye es práctica, no académica:

- Se usan **ventanas móviles**.
- El tamaño depende del volumen y estabilidad.
- El objetivo es **representatividad**, no cantidad.

Ejemplos discutidos:

- últimos 5–10 embarques en rutas de bajo volumen,
- último mes en rutas frecuentes,
- últimos 3–6 meses en rutas estables.

Esto justifica:

- por qué el sistema debe filtrar,
- por qué no se carga todo,
- por qué “más datos” puede ser peor.

---

## 03.5 El error humano más común: mezclar cosas distintas

Aquí aparece uno de los puntos más importantes de toda la conversación.

Se reconoce explícitamente que el analista humano **comete errores**, y el más común es:

> _Mezclar datos que no deberían mezclarse._

Ejemplos reales discutidos:

- Carrier A (premium) + Carrier B (problemático).
- Embarques de invierno + verano.
- Rutas cortas templadas + rutas largas tropicales.
- Empaques distintos como si fueran equivalentes.

Esto lleva a una observación crítica:

> _Un pronóstico hecho con datos mal mezclados es peor que no hacer pronóstico._

---

## 03.6 El nacimiento natural del “Data Readiness” desde lo humano

Aquí ocurre un punto de inflexión en la conversación.

La pregunta deja de ser:

- “¿Qué tan bueno es el modelo?”

y pasa a ser:

- “¿Tiene sentido el dataset que voy a usar?”

Esto NO es ML.  
Es **criterio humano previo**.

Se verbaliza algo muy importante:

> _La app debería analizar el criterio del usuario antes de pronosticar._

Esto es exactamente lo que hace un analista senior:

- revisa,
- cuestiona,
- corrige,
- y solo entonces opina.

---

## 03.7 Diferencia explícita: calidad técnica vs criterio operativo

En la conversación se aclara una distinción que luego se vuelve central:

### Calidad técnica del dato:

- valores faltantes,
- tipos incorrectos,
- rangos inválidos.

### Criterio operativo del dataset:

- coherencia de rutas,
- coherencia de estaciones,
- coherencia de carriers,
- volumen adecuado.

Un dataset puede estar “perfecto” técnicamente y **ser inútil para el análisis**.

Esta distinción justifica:

- una capa separada,
- previa al pronóstico,
- con lógica propia.

---

## 03.8 ¿El analista “bloquea” decisiones? Sí.

Otra idea importante que aparece es esta:

> _El analista no siempre calcula un riesgo; a veces bloquea la decisión._

Ejemplos:

- “Con estos datos no puedo opinar.”
- “Esto no es comparable.”
- “Hay que separar estos casos.”
- “Esto hay que revisarlo antes.”

Esto justifica que el sistema:

- pueda devolver **NotAcceptable**,
- obligue al usuario a corregir,
- no “fuerce” un número.

Este comportamiento **no es hostil**, es **profesional**.

---

## 03.9 De analista humano a sistema: qué se automatiza

A partir de todo lo anterior, se establece qué hace Xinfer:

- No reemplaza al analista.
- No decide por el cliente.
- No “optimiza” mágicamente.

Lo que hace es:

> **Automatizar el razonamiento previo del analista humano**, de forma consistente y reproducible.

Esto incluye:

- validaciones,
- advertencias,
- sugerencias,
- bloqueos,
- y solo después, inferencia.

---

## 03.10 Implicaciones directas en el diseño del sistema

Este documento justifica directamente:

- la existencia de Data Readiness,
- la separación entre entrenamiento y predicción,
- la lógica de filtros automáticos,
- la UX guiada,
- el rol del carrier como modificador,
- el reentrenamiento no automático,
- la estructura Cell autónoma.

Nada de esto surge “porque sí”.  
Surge porque **así trabaja un analista real**.

---

## 03.11 Cierre del Documento 03

Este documento responde definitivamente a la pregunta implícita:

> _“¿Por qué Xinfer hace tantas validaciones antes de predecir?”_

La respuesta es simple:

> Porque **un analista humano responsable haría exactamente lo mismo**.

Xinfer no es un modelo que “escupe números”.  
Es un sistema que **razona antes de inferir**.