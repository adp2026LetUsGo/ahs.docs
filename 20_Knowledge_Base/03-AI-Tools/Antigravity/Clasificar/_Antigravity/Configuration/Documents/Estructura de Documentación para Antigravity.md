
Para **Antigravity**, la división de documentos no solo es posible, sino que es la forma **nativa** en la que el sistema procesa el contexto, ya que está diseñado para entender repositorios masivos.

Aquí te detallo cómo estructurar esos documentos específicamente para el flujo de trabajo en **Antigravity**:

---

## Estructura de Documentación para Antigravity

A diferencia de Cursor, Antigravity tiene una capacidad de razonamiento sobre el "grafo" del código mucho más profunda. Por ello, la división debe ser **semántica**:

### 1. `blueprint.md` (El Requerimiento Maestro)

En Antigravity, este documento actúa como el ancla de diseño. Aquí no das instrucciones de "clic", sino definiciones de estado.

- **Contenido:** Definición de APIs, contratos de datos y dependencias de infraestructura de Google (si aplica).
    
- **Uso:** La IA lo usa para asegurar que cualquier código nuevo no rompa el diseño del sistema.
    

### 2. `interaction_flows.md` (Los Casos de Uso)

Aquí es donde pones los **Use Cases**. Antigravity es excelente transformando narrativa en lógica de componentes.

- **Contenido:** Describe la experiencia de usuario paso a paso.
    
- **Ejemplo:** "Cuando el usuario interactúa con el componente `Search`, el sistema debe activar el flujo de pre-fetch definido en `blueprint.md`".
    

### 3. `implementation_guidelines.md` (El Estilo)

Antigravity es muy estricto con los estándares de ingeniería.

- **Contenido:** Reglas de testing (ej. "Toda nueva función debe tener un test unitario en la carpeta `/tests`"), patrones de diseño preferidos y manejo de errores.
    

---

## ¿Por qué dividirlo así en Antigravity?

1. **Context Window Management:** Aunque Antigravity maneja ventanas de contexto enormes, dividir la información permite que cuando pidas un cambio en la UI, la IA solo "preste atención" al documento de Casos de Uso y no se distraiga con la configuración profunda de la base de datos a menos que sea necesario.
    
2. **Referenciación Cruzada:** Puedes pedirle a Antigravity: _"Implementa la funcionalidad X siguiendo el `blueprint.md` pero asegurando que el flujo de usuario coincida con el caso de uso descrito en `interaction_flows.md`"_.
    
3. **Mantenimiento:** Si cambias una regla de negocio (Requerimiento), solo tocas un archivo y dejas que la IA propague los cambios en el código basándose en esa única fuente de verdad.
    

---

### Mi recomendación para iniciar en Antigravity:

Empieza creando una carpeta llamada `/docs_context` en la raíz de tu proyecto y coloca ahí estos archivos. Cuando inicies el chat o la tarea con la IA de Antigravity, dile:

> _"Actúa como un ingeniero senior. Lee todos los archivos en `/docs_context` para entender la arquitectura y los flujos de usuario antes de proponer cualquier cambio en el código."_

**¿Quieres que te ayude a redactar el contenido de uno de estos archivos (como el Blueprint o el Interaction Flow) para el proyecto específico que tienes en mente?**