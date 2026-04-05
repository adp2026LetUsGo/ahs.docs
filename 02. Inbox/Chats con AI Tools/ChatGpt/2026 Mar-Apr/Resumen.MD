Este documento organiza de manera temática y detallada todos los aspectos técnicos, arquitectónicos y filosóficos discutidos en las fuentes, preservando el contexto original y las explicaciones completas para su uso como referencia técnica o manifesto de ingeniería.

---

### 1. Perfil de Ingeniería y Filosofía "AOT-First"

El perfil de desarrollo definido se aleja de los stacks genéricos para centrarse en una **filosofía de ejecución restringida y determinista**,. Esta identidad se basa en sistemas que son **AOT-first, mínimos, seguros por diseño y compuestos por unidades independientes**.

*   **Identidad de Ingeniería:** No se define simplemente como un "desarrollador de .NET", sino como un **ingeniero de sistemas que diseña entornos de ejecución deterministas, mínimos y seguros**,.
*   **Principios del Manifesto:** Se rechaza la complejidad innecesaria en favor de lo **explícito sobre lo implícito**, lo determinista sobre lo dinámico y lo mínimo sobre lo cargado de funcionalidades. Se establece que cada dependencia es un riesgo, cada abstracción tiene un costo y cada decisión en tiempo de ejecución debe ser predecible.
*   **Objetivos Permanentes:** Los pilares son maximizar el rendimiento (tiempo de arranque, uso de memoria y throughput) y garantizar la seguridad por defecto mediante el mínimo privilegio y una superficie de ataque reducida,. Se prioriza mantener la compatibilidad total con **Native AOT**, minimizando dependencias y optimizando la Observabilidad y auditabilidad.

### 2. Arquitectura Basada en Celdas (Cell-Based Architecture)

La **Arquitectura Basada en Celdas** es el modelo de firma para este ecosistema, definiendo celdas como unidades de ejecución totalmente auto contenidas,.

*   **Definición de Celda:** Una celda es una unidad que posee su propio dominio, datos y lógica, sin compartir bases de datos con otras celdas. Debe ser construible y desplegable de forma independiente.
*   **Comunicación:** La interacción entre celdas ocurre estrictamente a través de **contratos gRPC explícitos y versionados**,,. Se eliminan los mecanismos de descubrimiento en tiempo de ejecución y el acoplamiento oculto a través de librerías internas compartidas,.
*   **Principios Core:** 
    *   **Aislamiento primero:** Sin memoria o bases de datos compartidas.
    *   **Comportamiento determinista:** Cada celda se comporta de manera predecible bajo las mismas entradas.
    *   **Superficie de ejecución mínima:** Las celdas corren sobre contenedores "Chiseled".
*   **Reglas de Decisión:** Se crea una nueva celda solo si el dominio es independiente, requiere un escalado diferente o necesita una frontera de seguridad distinta. Se rechaza cualquier cambio que rompa las restricciones de AOT o introduzca estado compartido.

### 3. Stack Tecnológico Principal (.NET 10 & Chiseled)

El stack es altamente de opinión y moderno, optimizado para la era de la computación en la nube de alta eficiencia,.

*   **Framework y Lenguaje:** **.NET 10** (con mentalidad Native AOT desde el inicio), **C# 14** y **EF Core 10** utilizando únicamente **Compiled Models** para evitar la reflexión en tiempo de ejecución,,.
*   **Contenedores Chiseled:** El estándar de runtime no es un contenedor Docker clásico, sino **Chiseled Containers**. Estos no tienen shell ni gestor de paquetes, lo que reduce drásticamente la superficie de ataque, disminuye el tamaño de la imagen y permite un arranque ultra rápido (crítico para AOT). Docker se utiliza únicamente como herramienta de construcción y desarrollo, no como filosofía de runtime.
*   **Identidad y Seguridad en Azure:** Integración profunda con **Microsoft Entra ID** para autenticación y **Azure Workload Identity** para la identidad de servicio a servicio, eliminando secretos compartidos y utilizando tokens de vida corta,.

### 4. Artefactos de Análisis y Diseño (UTA, UIF, SSS)

Se establecen tres capas de artefactos complementarios para la trazabilidad completa del sistema,.

*   **User Task Analysis (UTA):** Describe **qué hace el usuario** paso a paso para lograr un objetivo, centrándose en el flujo mental y las decisiones humanas sin mencionar el sistema internamente,.
*   **User Interaction Flow (UIF):** Describe **cómo el usuario navega** dentro del sistema, centrándose en pantallas (UI), eventos de interacción y transiciones,. Para herramientas de IA, el UIF es el artefacto más importante para generar frontend, ya que define rutas y componentes.
*   **System Sequence Specification (SSS):** Define **qué mensajes intercambian el usuario y el sistema** en orden temporal. Es el artefacto más técnico y el que mejor entienden las herramientas de IA (Cursor, Windsurf) para generar código de backend y APIs, ya que establece contratos claros de entrada y salida,.

### 5. Caso de Estudio: Sistema "Xinfer" (Célula de Decisión)

**Xinfer** se define como una célula de decisión autónoma para predecir el riesgo de excursión térmica en logística farmacéutica antes del despacho,.

*   **Lógica de "Pensar antes de actuar":** A diferencia de un predictor simple, Xinfer introduce un **Data Readiness Gate obligatorio**,. Si el sistema determina que los datos son inconsistentes o insuficientes (estado *NotAcceptable*), **se niega a predecir** y bloquea el flujo,,.
*   **Flujo de Trabajo:** 
    1. El usuario envía el contexto del embarque y parámetros operativos.
    2. El sistema evalúa la compatibilidad del dataset (*EvaluateDatasetCompatibility*).
    3. Si es aceptable, el sistema selecciona automáticamente los datos históricos relevantes sin intervención del usuario,.
    4. El sistema decide si reentrenar el modelo o usar uno existente,.
    5. Se genera la predicción, una explicación de IA (XAI) y recomendaciones accionables (ej. cambiar de carrier o ajustar hora de salida),.

### 6. Organización del Monorepo y Documentación Modular

Se rechaza el uso de un único documento "mega blueprint" en favor de una estructura fragmentada y composable que optimiza el contexto para las herramientas de IA,.

*   **Jerarquía de Instrucciones:**
    *   **System Instructions (Global):** Define el "CÓMO" (estándares de código .NET 10, reglas de seguridad, convenciones de celdas),.
    *   **Cell Blueprint (Local):** Define el "QUÉ" de una celda específica (dominio, entidades, casos de uso),.
*   **Estructura del Directorio `docs/`:** Debe residir dentro de cada celda pero sin usar prefijos de proyectos .NET (ej. `Xinfer/docs/` en lugar de `AHS.Cell.Xinfer.Docs`) para evitar confusiones con artefactos compilables,.
    *   `blueprint/`: Contiene `overview.md`, `domain.md` (modelo mental), `use-cases.md`, `contracts.md` y `architecture.md` (decisiones AOT específicas),.
    *   `flows/`: Contiene las especificaciones SSS, UIF y UTA. Se recomienda integrar wireframes y UIF en una carpeta por feature para que la IA entienda estados visuales y lógicos conjuntamente.
    *   `decisions/`: Registros de Decisiones Arquitectónicas (ADR) para mantener la historia de por qué se eligieron ciertos patrones,.

### 7. Estrategia de IA y Entorno de Desarrollo (VS Code)

Para maximizar el uso de herramientas como **Cursor** y **Antigravity**, el repositorio debe estar indexado semánticamente,.

*   **Configuración de Workspace:** Se utiliza un archivo `.code-workspace` que define carpetas por roles (System, Cell, Infra, Control, Agent).
*   **Indexación en Antigravity:** Es fundamental incluir la carpeta `docs/` en `antigravity.context.includeFolders` y establecer `files.exclude` en `false` para la documentación,. Esto permite que el motor de búsqueda vectorial de la herramienta proporcione contexto de los blueprints al generar código.
*   **Trazabilidad en Prompts:** Al tener una estructura `Task → UI → System → DTO`, las herramientas de IA pueden generar componentes Razor o servicios de C# que respeten todas las capas de diseño sin alucinaciones,.

### 8. Implementación Técnica y Restricciones de Runtime

La implementación en **C# 14** y **Blazor** debe ser rigurosa para asegurar la compatibilidad con **Native AOT**,.

*   **Modelado de Estados:** Los estados de la UI (como *NotAcceptable*, *Risky*, *Acceptable*) se modelan como una jerarquía de **records sellados e inmutables**,. Esto permite usar **pattern matching** en los componentes de Razor para un renderizado determinista y seguro,.
*   **Restricción de Reflexión:** Se debe evitar el uso de reflexión dinámica en tiempo de ejecución (`Activator.CreateInstance`, `Type.GetType`). La serialización debe realizarse mediante **Source Generators** de `System.Text.Json` y los DTOs deben ser explícitos, evitando tipos `dynamic` u `object`.
*   **Estructura del Proyecto:** El backend de la celda actúa como el **Motor de Decisión**, mientras que el frontend en Blazor es un **Renderizador de Estados** orientado a contratos tipados.