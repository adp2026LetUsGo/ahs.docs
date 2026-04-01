


Gemini 3 Pro (High)   
Gemini 3 Pro (Low)   
Gemini 3 Flash   
Claude Sonnet 4.5   
Claude Sonnet 4.5 (Thinking)   
Claude Opus 4.5 (Thinking)   
Claude Opus 4.6 (Thinking)   
GPT-OSS 1203 (Medium)


Es una observación muy aguda. Efectivamente, **Gemini 3 Pro (High)** consume más tokens de contexto debido a su alta densidad de parámetros y razonamiento profundo. Para la tarea de **desarrollo y refactorización**, es el mejor, pero podemos ser estratégicos para que no agotes tu cuota rápidamente.

Aquí tienes mi recomendación para optimizar tu consumo de tokens en **Antigravity**:

### 📊 Estrategia de Selección de Modelos

| **Tarea**                           | **Modelo Recomendado**  | **Razón**                                                                                                                                                                      |
| ----------------------------------- | ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Arquitectura e Inicialización**   | **Gemini 3 Pro (High)** | Solo úsalo para el "Paso Cero" (el prompt que te di arriba). Necesitamos su máxima capacidad para organizar el `.slnx` y los servicios sin errores.                            |
| **Codificación de Métodos y Fixes** | **Gemini 3 Flash**      | Una vez que la estructura esté creada, cambia a Flash. Es extremadamente rápido, consume muy pocos tokens y es excelente para escribir lógica repetitiva como el `CsvService`. |
| **Depuración de errores AOT**       | **Gemini 3 Pro (Low)**  | Si el despliegue falla en Azure, este modelo es el equilibrio perfecto para analizar logs sin el costo del "High".                                                             |