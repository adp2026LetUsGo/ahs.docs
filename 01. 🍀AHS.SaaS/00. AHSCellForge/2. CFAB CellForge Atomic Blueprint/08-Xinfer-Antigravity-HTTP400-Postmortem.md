
## **Antigravity, Master Prompts y el incidente HTTP 400 (post‑mortem técnico completo y razonado)**

**Archivo sugerido:**  
`08-Xinfer-Antigravity-HTTP400-Postmortem.docx`

---

## 08.1 Por qué este documento existe

Este documento existe porque ocurrió algo que **no es raro**, pero sí **costoso en tiempo**:

> Un sistema correctamente diseñado, con un prompt técnicamente sólido,  
> falló repetidamente al ejecutarse en Antigravity con un error genérico HTTP 400.

El objetivo de este documento **no es explicar Antigravity**, sino **documentar exactamente qué pasó, qué se pensó, qué se descartó y cuál fue la causa real**, para que:

- no vuelva a ocurrir,
- no se pierda tiempo en diagnósticos equivocados,
- y quede claro **qué tipo de error era y qué tipo de error NO era**.

---

## 08.2 El síntoma inicial

El error aparece de forma repetida, con ligeras variaciones de `TraceID`, pero siempre con el mismo mensaje central:

```
HTTP 400 Bad Request
TextEncodeInput must be Union[TextInputSequence, Tuple[InputSequence, InputSequence]]
Status: INVALID_ARGUMENT
```

Características importantes del síntoma:

- No es un error de compilación.
- No es un error de lógica del prompt.
- No es un error de timeout.
- No es un error explícito de “context too large”.
- No es un error de sintaxis.

Es un **error de entrada**, no de ejecución.

---

## 08.3 Primera hipótesis natural: caracteres especiales

La primera hipótesis fue **razonable**:

> _“El prompt tiene emojis, flechas, cajas Unicode… Antigravity no los soporta.”_

Esto es coherente porque:

- el prompt original era muy largo,
- tenía caracteres decorativos,
- y AG es sensible al encoding.

### Acciones realizadas

- Se creó un script PowerShell para eliminar caracteres no ASCII.
- Se generó un archivo limpio: `Prompt.md`.
- Se verificó explícitamente:

PowerShell

Get-Content Prompt.md | Select-String -Pattern '[^\x00-\x7F]'  

Show more lines

Resultado:

- **No devolvió nada**.

Conclusión:

> El archivo **ya no contiene caracteres fuera de ASCII**.

---

## 08.4 Segunda hipótesis: encoding incorrecto (UTF‑16 / BOM)

Siguiente hipótesis:

> _“Aunque sea ASCII, puede tener BOM o UTF‑16.”_

Acciones:

- Se reescribió el archivo como ASCII puro.
- Luego como UTF‑8 sin BOM:

PowerShell

[System.IO.File]::WriteAllText(  

"Prompt.md",  

$content,  

(New-Object System.Text.UTF8Encoding($false))  

)  

Show more lines

Se verificó:

- tamaño del archivo,
- contenido no vacío,
- ausencia de BOM.

Conclusión:

> El encoding **NO era el problema**.

---

## 08.5 Tercera hipótesis: archivo vacío o truncado

Otra posibilidad razonable:

> _“El script pudo generar un archivo vacío o incompleto.”_

Verificación explícita:

PowerShell

(Get-Content Prompt.md -Raw).Length  

Show more lines

Resultado:

- longitud > 0.

Conclusión:

> El archivo **no estaba vacío**.

---

## 08.6 Punto clave: el error persistía

A pesar de:

- archivo limpio,
- ASCII puro,
- encoding correcto,
- contenido completo,

el error **persistía exactamente igual**.

Esto es el momento más importante del post‑mortem.

Aquí se descarta definitivamente que el problema esté en:

- el contenido,
- la arquitectura,
- el prompt,
- o Xinfer.

---

## 08.7 Relectura del mensaje de error (clave)

Se vuelve al mensaje literal:

> **TextEncodeInput must be Union[TextInputSequence, Tuple[InputSequence, InputSequence]]**

Interpretación correcta:

- Claude esperaba **texto**.
- Claude recibió **algo que no era texto**.

No “texto incorrecto”.  
No “texto demasiado grande”.  
**No texto en absoluto.**

---

## 08.8 Causa real: Antigravity no estaba pasando TEXTO

Aquí se identifica la causa real:

> **Antigravity estaba enviando un objeto (file handle / asset), no el contenido textual del archivo.**

Esto ocurre cuando:

- se sube un archivo,
- pero no se le indica explícitamente a AG que lo lea como texto,
- o se asume que “archivo subido = texto”.

En AG:

- los archivos son **assets**,
- no texto automáticamente.

Si no se usa:

```
@readFile("Prompt.md")
```

AG pasa una referencia, no el contenido.

Claude recibe algo como:

- un objeto,
- una estructura,
- o un buffer binario.

Y responde correctamente:

> INVALID_ARGUMENT

---

## 08.9 Confirmación indirecta de la causa

La causa se confirma indirectamente por varios hechos:

- El mismo contenido funciona en Claude directo (pegado).
- El error no cambia con limpieza ni encoding.
- El error es de tipo “input shape”, no “content”.
- El mensaje no menciona tokens, longitud ni truncamiento.

Todo apunta a:

> **La forma de envío, no el contenido.**

---

## 08.10 Segunda causa concurrente: tamaño del prompt

Aunque la causa principal es el **tipo de input**, aparece una causa secundaria importante:

El Master Prompt tenía:

- ~1196 líneas,
- decenas de miles de tokens.

Antigravity:

- no maneja prompts gigantes en un solo bloque,
- fragmenta internamente,
- y puede terminar pasando estructuras no válidas.

Esto refuerza la solución de:

- dividir el prompt,
- cargarlo en partes.

---

## 08.11 Soluciones correctas identificadas

### Solución mínima correcta

- Subir `Prompt.md` a AG.
- Usar **únicamente**:

```
@readFile("Prompt.md")
```

Sin rutas locales.  
Sin pegado manual.  
Sin suposiciones.

---

### Solución robusta recomendada

- Dividir el prompt en:
    - `Prompt-1.md`
    - `Prompt-2.md`
    - (y si hace falta `Prompt-3.md`)
- En AG:

```
@readFile("Prompt-1.md")
@readFile("Prompt-2.md")
```

Esto evita:

- límites internos,
- fragmentación opaca,
- errores difíciles de diagnosticar.

---

## 08.12 Qué NO era el problema (lista explícita)

Este documento deja constancia clara de que **NO era**:

- ❌ emojis (ya eliminados)
- ❌ Unicode residual
- ❌ encoding
- ❌ BOM
- ❌ prompt vacío
- ❌ error de lógica
- ❌ error de arquitectura
- ❌ error de Xinfer
- ❌ error de C#

Esto es importante para **no volver a recorrer caminos falsos**.

---

## 08.13 Lecciones aprendidas

Lecciones técnicas claras:

1. Antigravity **NO asume texto**.
2. `@readFile()` no es opcional.
3. Prompts grandes deben dividirse.
4. Errores HTTP 400 genéricos pueden esconder errores de forma, no de fondo.
5. No todo error de IA es “problema del prompt”.

---

## 08.14 Impacto real del incidente

Impacto:

- pérdida de tiempo inicial,
- diagnóstico iterativo,
- pero también:
    - clarificación profunda del pipeline,
    - herramientas de limpieza reutilizables,
    - mejor entendimiento de AG.

Este incidente **mejoró el diseño operativo**, no lo empeoró.

---

## 08.15 Cierre del Documento 08

Este documento deja documentado que:

> El problema no fue conceptual ni técnico en Xinfer,  
> sino **operacional en el uso de Antigravity**.

Y deja una regla clara para el futuro:

> **En AG, siempre especificar explícitamente cómo el texto llega al modelo.**

---

### Cierre del ciclo completo

Con este documento:

- se cierra el diseño conceptual,
- se cierra el diseño técnico,
- se cierra el incidente,
- y se deja un historial completo y defendible.