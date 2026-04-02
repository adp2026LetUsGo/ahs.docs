## **Diseño UX: una sola pantalla como reflejo del razonamiento del analista (conversación técnica detallada)**

**Archivo sugerido:**  
`06-Xinfer-UX-Single-Screen-Guided-Flow.docx`

---

## 06.1 Por qué hablar de UX en una conversación técnica

En la conversación aparece un punto que podría parecer “menor”, pero no lo es:

> _“Mi intención es que el programa sea una sola pantalla.”_

Esta frase no es una preferencia estética.  
Es una **decisión de diseño profundamente técnica**.

Este documento existe para explicar **por qué una sola pantalla no simplifica el sistema**, sino que **lo vuelve más correcto**.

---

## 06.2 UX típica en sistemas mal diseñados (contrapunto implícito)

Antes de justificar la pantalla única, aparece implícitamente el contrapunto:

Sistemas que:

- tienen múltiples pantallas,
- múltiples pasos,
- dashboards antes de validar datos,
- modelos que “corren” sin preguntar,
- alertas que llegan tarde.

Estos sistemas:

- ocultan razonamiento,
- dispersan la lógica,
- permiten errores silenciosos,
- generan falsa confianza.

Xinfer **no puede comportarse así**, porque su valor está en **evitar errores humanos**, no en facilitar clicks.

---

## 06.3 Punto clave: el analista humano no “navega pantallas”

Una observación importante surge en el razonamiento:

> _El analista humano no piensa en pasos separados; piensa en un solo flujo mental._

Cuando un analista evalúa un embarque, no dice:

- “ahora estoy en la pantalla A”,
- “ahora cambio a la pantalla B”.

Piensa así:

1. ¿Qué es?
2. ¿Dónde va?
3. ¿Cuándo?
4. ¿Cómo lo voy a enviar?
5. ¿Con qué riesgo?
6. ¿Puedo aceptar ese riesgo?

Ese flujo **es continuo**, no fragmentado.

La UX debía reflejar eso.

---

## 06.4 La decisión explícita: una sola pantalla

A partir de ese razonamiento, se formula la decisión:

> _La app debe ser una sola pantalla, con secciones claramente diferenciadas._

No porque sea “simple”, sino porque:

- evita perder contexto,
- evita saltos mentales,
- hace visible el razonamiento,
- reduce errores.

Esta pantalla **no es plana**, es **guiada**.

---

## 06.5 Sección 1: Datos intrínsecos del embarque

Primera sección de la pantalla:

- Producto (ej. insulina)
- Categoría
- Ruta (origen → destino)
- Fecha de salida
- Tipo de empaque

Aquí se aplica una decisión clave discutida previamente:

> _Estos datos definen la identidad del embarque._

Y por diseño:

- no generan riesgo,
- no se cuestionan,
- no se “corrigen”,
- sirven como base fija.

Esto evita que el usuario:

- confunda identidad con riesgo,
- cambie cosas que no debería.

---

## 06.6 Sección 2: Datos ambientales (opcionales)

Aquí aparece otra decisión consciente:

> _Los datos ambientales pueden ser opcionales._

¿Por qué?

- porque pueden inferirse,
- porque no siempre están disponibles,
- porque no deben bloquear el flujo.

Sin embargo:

- cuando se proveen,
- ajustan el riesgo,
- enriquecen el análisis.

La UX refleja esto:

- visibles,
- no obligatorios,
- claramente marcados como “contexto”.

---

## 06.7 Sección 3: Datos operativos (donde aparece el riesgo)

Esta es la sección **más crítica** de la pantalla.

Incluye:

- Carrier
- Hora de salida
- Duración estimada
- Condiciones operativas relevantes

Aquí aparece una decisión UX directamente ligada al razonamiento técnico:

> _El carrier aparece después, no primero._

Porque:

- el carrier **no define el embarque**,
- el carrier **modifica el riesgo**.

Colocarlo aquí:

- refuerza ese concepto,
- educa al usuario,
- evita malas interpretaciones.

---

## 06.8 El botón clave: “Analizar datos operativos”

Este botón es una decisión deliberada y muy importante.

No dice:

- “Predecir”
- “Calcular riesgo”
- “Ejecutar modelo”

Dice:

> **“Analizar datos operativos”**

Esto refleja exactamente lo que pasa en ese momento:

- no se corre ML,
- no se predice,
- no se entrena.

Se ejecuta **Data Readiness**.

La UX hace explícito algo que muchos sistemas esconden.

---

## 06.9 Resultado intermedio: Aceptable / Riesgoso / No aceptable

Después del análisis, la UX muestra un resultado **intermedio**, no final:

- Acceptable
- Risky
- NotAcceptable

Esto es crucial.

El usuario **aún no ve un riesgo numérico**.  
Ve un **juicio sobre su selección**.

Esto reproduce exactamente el comportamiento del analista humano:

> “Con estos datos, sí puedo opinar”  
> “Con estos datos, no puedo opinar”

---

## 06.10 Corrección obligatoria antes de continuar

Si el resultado es **NotAcceptable**:

- el sistema no avanza,
- no hay predicción,
- no hay botón “continuar”.

El usuario **debe corregir**:

- carrier,
- fechas,
- filtros,
- selección implícita de históricos.

Esto no es una limitación UX.  
Es una **protección del usuario**.

---

## 06.11 Automatización invisible: selección de históricos

Cuando los datos son aceptables, ocurre algo importante **sin pedirle nada al usuario**:

- el sistema selecciona históricos,
- aplica filtros,
- verifica volúmenes,
- valida coherencia.

Esta decisión surge directamente del razonamiento previo:

> _El usuario no debería construir datasets manualmente._

La UX refleja esto:

- no hay pantalla de selección de históricos,
- no hay sliders peligrosos,
- no hay checkboxes ambiguos.

El sistema asume la responsabilidad.

---

## 06.12 Entrenamiento automático (si corresponde)

Otra decisión UX clave:

> _El usuario no “lanza” el entrenamiento._

Si corresponde:

- el sistema entrena,
- lo indica,
- muestra la versión,
- explica por qué.

Si no corresponde:

- usa el modelo existente,
- lo informa.

Esto evita:

- uso incorrecto del ML,
- ansiedad del usuario,
- falsas expectativas.

---

## 06.13 Resultado final: riesgo + explicación + acción

Solo después de todo lo anterior, la UX muestra:

- Probabilidad de excursión
- Nivel de riesgo
- Explicación (XAI)
- Recomendaciones concretas

La UX **no muestra números sin contexto**.

Cada resultado:

- es explicable,
- es defendible,
- es accionable.

---

## 06.14 Por qué una sola pantalla reduce errores

La conversación deja clara una conclusión importante:

> _Más pantallas no significan más claridad; a menudo significan más errores._

Una sola pantalla:

- mantiene el contexto,
- muestra el flujo completo,
- hace visible el razonamiento,
- educa al usuario.

Esto no es una decisión estética, es **una decisión de control de riesgo**.

---

## 06.15 Cierre del Documento 06

Este documento demuestra que:

- la UX de Xinfer **no es arbitraria**,
- es una consecuencia directa del razonamiento técnico,
- y reproduce el flujo mental del analista humano.

Xinfer no guía al usuario para “hacer clic”.  
Lo guía para **pensar mejor antes de decidir**.