---

# 📘 DOCUMENTO 01

## **Xinfer – Arquitectura, Cell-Based Design y Master Prompts**

**Archivo sugerido:**  
`01-Xinfer-Architecture-and-Prompts.docx`

---

## 1. Contexto del proyecto

**Xinfer** es un _Cell autónomo_ dentro del ecosistema **AHS..SaaS**, diseñado para **predecir excursiones térmicas (out-of-spec)** en embarques sensibles (especialmente pharma), **antes de que ocurran**, permitiendo acciones preventivas.

El diseño se basa en:

- Micro‑SaaS
- Cell‑Based Architecture
- Control Tower
- Total autonomía por Cell
- Uso de IA solo como _motor de inferencia_, no como “caja negra”
- Cumplimiento GxP / trazabilidad

---

## 2. Principios arquitectónicos clave

### 2.1 Cell‑Based Architecture (CBA)

Xinfer no es un microservicio genérico.  
Es una **Cell soberana**, lo que implica:

- Tiene **su propio dominio**
- Tiene **sus propios contratos**
- Tiene **su propio esquema de base de datos**
- Tiene **su propio ciclo de vida**
- Puede ejecutarse:
    - de forma aislada
    - o orquestada por el Control Tower

No comparte base de datos ni lógica con otras Cells.

---

### 2.2 Autonomía total (Silo Cell)

Xinfer **es dueño absoluto** de:

- Lógica de negocio
- Validaciones de Data Readiness
- Detección de divergencias
- Selección de históricos
- Decisión de reentrenamiento
- Motor de predicción
- Recomendaciones
- Persistencia de datos
- Versionado de modelos

Esto evita:

- dependencias implícitas
- coupling entre módulos
- efectos colaterales

---

## 3. Modelo mental: cómo piensa Xinfer

Xinfer replica el **flujo mental de un analista logístico real**, no el de un científico de datos abstracto.

El orden es **estricto**:

1. Entender qué se va a embarcar
2. Validar si los datos permiten análisis
3. Detectar divergencias con el pasado
4. Seleccionar históricos compatibles
5. Decidir si el modelo necesita reentrenarse
6. (Solo si aplica) reentrenar
7. Calcular riesgo
8. Explicar por qué
9. Recomendar acciones

Este orden **nunca se rompe**.

---

## 4. Identidad del embarque vs factores de riesgo

Una decisión clave del diseño:

### ✅ Identidad del embarque

Definida por:

- Producto
- Ruta
- Tipo de empaque
- Fecha de salida

Esto **no cambia**.

### ⚠️ Factores de riesgo (modificadores)

- Carrier
- Hora de salida
- Duración estimada
- Condiciones ambientales

El **carrier NO define el embarque**.  
El carrier **modifica el riesgo**.

Esto es crítico para:

- Data Readiness
- Comparaciones históricas
- What‑If analysis

---

## 5. Flujo de datos principal

### 5.1 Entrada

El usuario ingresa en **una sola pantalla**:

1. Datos intrínsecos del embarque
2. Datos ambientales (opcional)
3. Datos operativos

---

### 5.2 Data Readiness (antes de predecir)

Xinfer **NUNCA predice** si los datos no son aceptables.

Ejemplos de bloqueos:

- Dataset < 5 registros
- Pharma + Passive + >48h
- Empaque incompatible con estación
- Datos críticos faltantes

Resultado posible:

- Acceptable
- Risky
- NotAcceptable

---

## 6. Históricos y entrenamiento

### 6.1 Uso de históricos

Los históricos se usan para:

- Entrenar modelos
- Detectar patrones
- Evaluar estabilidad

NO se usan directamente para predecir un embarque nuevo.

---

### 6.2 Entrenamiento del modelo

El modelo **NO se reentrena en cada ejecución**.

Se reentrena solo si:

- No existe modelo
- Hay suficientes nuevos registros
- Cambió la estación
- Aparecen rutas/carriers nuevos
- Se degrada la precisión
- Ha pasado demasiado tiempo

Esto replica **ML en producción real**.

---

## 7. Motor de predicción (visión general)

Xinfer utiliza un motor determinista + ML híbrido:

- 14 factores de riesgo (XAI DNA)
- Pesos explícitos
- Penalizaciones claras (ej. Passive +15%)
- Sin cajas negras
- Resultado explicable

Salida:

- RiskScore (0–100)
- RiskLevel
- Ventana segura
- Tiempo pesimista a excursión
- Explicación factor por factor

---

## 8. Recomendaciones

Las recomendaciones:

- No son generadas por IA creativa
- Son reglas auditables
- Deterministas
- GxP‑friendly

Ejemplos:

- Cambiar carrier
- Mejorar empaque
- Cambiar horario
- Escalar a QA
- No despachar

---

## 9. Prompts y rol de la IA

### 9.1 Claude

Claude actúa como:

- Arquitecto
- Analista logístico
- Generador de prompts
- Diseñador de Cells

Claude **NO ejecuta código**.

---

### 9.2 Antigravity (AG)

AG actúa como:

- Ejecutor
- Generador de proyectos
- Constructor de código
- Aplicador de constraints AOT
- Generador de tests

Claude genera el **Master Prompt**.  
AG lo ejecuta.

---

## 10. Master Prompt como contrato

El Master Prompt de Xinfer es:

- Un contrato técnico
- Una especificación ejecutable
- Una fuente de verdad
- Un blueprint reproducible

Por eso:

- Es largo
- Es explícito
- Es estricto
- No debe resumirse
- No debe “optimizarse”

---

## 11. Conclusión del Documento 01

Xinfer no es un experimento de IA.  
Es un **componente productivo, auditable y autónomo**, diseñado con mentalidad de:

- logística real
- ML en producción
- arquitectura enterprise
- micro‑SaaS escalable

Este documento establece **la base conceptual** sobre la que se apoyan:

- scripts
- debugging
- decisiones de encoding
- diagnóstico de errores
- resolución final