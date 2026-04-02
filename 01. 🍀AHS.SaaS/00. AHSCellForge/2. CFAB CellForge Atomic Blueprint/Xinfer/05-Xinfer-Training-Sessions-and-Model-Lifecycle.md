# 📘 DOCUMENTO 05

## **Entrenamiento, sesiones y ciclo de vida del modelo (razonamiento técnico detallado, S1–S11)**

**Archivo sugerido:**  
`05-Xinfer-Training-Sessions-and-Model-Lifecycle.docx`

---

## 05.1 Por qué este documento es necesario

Este documento existe porque, en la conversación, aparece una **confusión natural pero peligrosa**:

> _“Si entra un nuevo embarque, ¿hay que volver a entrenar el modelo?”_

Esta pregunta parece técnica, pero en realidad es **conceptual**.  
Responderla mal lleva a:

- modelos inestables,
- costos innecesarios,
- sobreajuste,
- comportamientos erráticos,
- sistemas imposibles de explicar.

Este documento fija **cómo debe comportarse Xinfer respecto al entrenamiento**, sin ambigüedades.

---

## 05.2 Separación fundamental: entrenamiento vs pronóstico

Uno de los primeros puntos que se aclaran explícitamente es este:

> **El entrenamiento y el pronóstico NO son el mismo momento ni usan los mismos datos.**

Se establece con claridad:

- El **entrenamiento** usa:
    
    - históricos de embarques **ya finalizados**,
    - con resultado conocido (hubo o no excursión).
- El **pronóstico** usa:
    
    - únicamente los datos del **nuevo embarque**,
    - antes de que ocurra.

Esta separación no es opcional; es estructural.

---

## 05.3 Error común a evitar: reentrenar siempre

Aquí aparece una afirmación clave en la conversación:

> _“Si el modelo ya fue entrenado, no es necesario entrenarlo otra vez.”_

Esto se contrasta con la intuición errónea:

- “Si hay un embarque nuevo, reentreno”
- “Si hay datos nuevos, reentreno”
- “Más entrenamiento = mejor modelo”

Se aclara con firmeza:

> **Reentrenar por cada nuevo embarque es un error de diseño.**

Razones discutidas:

- estadísticamente débil,
- computacionalmente caro,
- introduce ruido,
- hace el sistema impredecible,
- rompe la trazabilidad.

---

## 05.4 El concepto de sesiones (S1–S11)

Para eliminar cualquier ambigüedad, se construye un **ejemplo concreto**, paso a paso.

### Sesión S1

- Hay **40 embarques históricos**.
- Se ejecuta Data Readiness.
- Se entrena el modelo por primera vez.
- Se crea **Modelo v1**.
- Se agrega el embarque 41 (nuevo).

Importante:

- El embarque 41 **NO entra al entrenamiento** aún.

---

### Sesión S2

- Total en base: 41 embarques.
- Se usa **Modelo v1** para pronosticar el embarque 42.
- Se guarda el resultado real cuando finaliza.

No hay reentrenamiento.

---

### Sesiones S3 a S10

- El proceso se repite:
    - se usa el mismo modelo,
    - se agregan embarques nuevos,
    - se acumulan resultados reales.

Al final de S10:

- Total: 50 embarques.
- Modelo sigue siendo **v1**.

Este comportamiento es **intencional**.

---

### Sesión S11

Aquí ocurre algo distinto:

- Ya hay suficientes embarques nuevos.
- El sistema evalúa:
    - cantidad,
    - cambios,
    - estabilidad.

Conclusión:

> _Ahora sí tiene sentido reentrenar._

Se entrena con los 50 embarques. Se crea **Modelo v2**. El embarque 51 se pronostica con **v2**.

---

## 05.5 Quién decide cuándo reentrenar

Una pregunta explícita aparece en la conversación:

> _“¿El que decide entrenar es el analista?”_

La respuesta se construye en dos niveles:

1. **El sistema decide** usando criterios objetivos.
2. **El analista valida o acepta**, no decide arbitrariamente.

Esto evita:

- decisiones emocionales,
- reentrenamientos innecesarios,
- falta de consistencia.

---

## 05.6 Criterios reales para reentrenar

Se enumeran criterios claros y codificables:

- No existe modelo aún.
- Se alcanzó un umbral de nuevos embarques.
- Aparecen rutas nuevas.
- Aparecen carriers no vistos.
- Cambia la estación (invierno → verano).
- Se degrada la precisión.
- Ha pasado demasiado tiempo desde el último entrenamiento.

Estos criterios **NO son teóricos**; reflejan prácticas reales.

---

## 05.7 Qué pasa si no se reentrena

Se aclara algo importante:

> _No reentrenar inmediatamente NO es un problema._

De hecho:

- es lo normal,
- es lo deseable,
- es lo estable.

Mientras:

- el contexto no cambie,
- el modelo siga siendo representativo,

el modelo puede usarse **muchas veces**.

---

## 05.8 Impacto en costos y arquitectura

Este enfoque tiene consecuencias directas:

- Menos consumo de recursos.
- Entrenamientos predecibles.
- Modelos versionados.
- Mejor auditabilidad.
- Mayor confianza del usuario.

Esto encaja perfectamente con:

- micro‑SaaS,
- costos bajos,
- Oracle OCI / Firebase inicial,
- escalado posterior.

---

## 05.9 Relación con Data Readiness

Data Readiness actúa como **protector del entrenamiento**:

- evita entrenar con datos mal mezclados,
- evita degradar el modelo,
- define cuándo los datos nuevos son “entrenables”.

Sin Data Readiness:

- el ciclo de entrenamiento se rompe.

---

## 05.10 Qué NO hace Xinfer respecto al entrenamiento

Este documento deja claro que Xinfer:

- NO reentrena en tiempo real.
- NO ajusta el modelo con cada embarque.
- NO aprende “on the fly”.
- NO es un sistema online learning.

Esto es una **decisión consciente**, no una limitación.

---

## 05.11 Cómo se comunica esto al usuario

El sistema puede mostrar mensajes como:

- “Modelo actual: v1”
- “Último entrenamiento: 40 embarques”
- “Nuevos embarques desde entonces: 10”
- “Reentrenamiento recomendado: Sí / No”

Esto refuerza:

- transparencia,
- confianza,
- comprensión del sistema.

---

## 05.12 Cierre del Documento 05

Este documento responde definitivamente a:

> _“¿Cuándo y por qué se entrena el modelo?”_

Respuesta final:

> **Cuando hay razones objetivas para hacerlo, no cuando simplemente hay datos nuevos.**

Xinfer no es un modelo nervioso.  
Es un sistema **estable, predecible y responsable**.