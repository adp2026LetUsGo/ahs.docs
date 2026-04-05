Estos documentos proporcionan una guía técnica avanzada para estructurar un monorepo basado en **arquitectura de celdas** utilizando **.NET 10 y Google AI Studio**. La fuente principal diferencia los **System Instructions**, que definen el comportamiento global y estándares del sistema, de los **Blueprints**, que detallan la lógica de negocio y el dominio específico de cada proyecto. Se recomienda una organización modular donde la documentación se fragmente en archivos semánticos para optimizar el contexto que consumen las herramientas de **Inteligencia Artificial**.

El contenido detalla la creación de flujos de interacción de usuario (**UIF**), especificaciones de secuencia del sistema (**SSS**) y análisis de tareas (**UTA**) integrados en una estructura de carpetas coherente. Además, se incluye una configuración técnica para **VS Code** que permite a agentes como **Antigravity** indexar correctamente los archivos de diseño y código fuente. Finalmente, los textos ofrecen plantillas de código para **Blazor Native AOT** y diagramas de trazabilidad que conectan los requerimientos funcionales con los componentes técnicos.

---
Actúa como un organizador de contenido experto. Analiza todos mis chats subidos y crea un documento nuevo organizado por temas. No resumas la información; mi objetivo es preservar todos los detalles técnicos, anécdotas y explicaciones completas. Transcribe o parafrasea de forma extensa cada punto relevante bajo el encabezado temático correspondiente, manteniendo el contexto original de las conversaciones.

---
A continuación, presento un documento técnico exhaustivo que organiza todos los conocimientos, decisiones arquitectónicas y explicaciones detalladas extraídas de las fuentes y conversaciones. Este documento ha sido estructurado por temas para preservar la integridad de los detalles técnicos y el contexto original.

---

# 📑 Guía Maestra de Arquitectura: Monorepo, .NET 10 AOT y Celdas de Decisión AI

## 1. Google AI Studio: System Instructions vs. Blueprint

En el contexto de Google AI Studio, es fundamental distinguir entre las instrucciones globales y las específicas del proyecto para mantener el orden en un monorepo.

- **System Instructions (El "CÓMO"):** Funcionan a nivel global o de plataforma. Definen la "personalidad", reglas y estándares del sistema de IA. Incluyen el estilo de código (ej. .NET 10, AOT-first), convenciones arquitectónicas (cell-based), formatos de salida (JSON, DTOs), reglas de seguridad y la forma de interactuar con el monorepo. **No deben duplicarse por cada celda**, sino centralizarse (ej. en `/ai/system-instructions.md`) y especializarse por contexto (backend, frontend, infra).
- **Blueprint (El "QUÉ"):** Funciona a nivel de celda o proyecto específico. Cada celda debe tener su propio Blueprint que describa su dominio, endpoints, entidades, reglas de negocio y flujos específicos (SSS, UIF, UTA).
- **Jerarquía de Conexión:** Las instrucciones del sistema fluyen hacia el Blueprint de la celda, y este a su vez define las características (SSS/UIF/UTA) dentro de la celda. Un error común y peligroso es copiar las instrucciones globales dentro de cada blueprint o mezclar reglas globales con lógica de negocio, lo que rompe la claridad y la escalabilidad.

## 2. Modularización y Estructura del Blueprint

Para optimizar el uso de herramientas de IA (como Cursor, Windsurf o AI Studio), el Blueprint no debe ser un solo archivo plano, sino una estructura modular y "composable".

- **Problema del archivo único:** Un `Blueprint.md` masivo genera "token hell", hace que el modelo pierda contexto relevante, mezcla conceptos y dificulta el versionamiento.
- **Ventajas del Blueprint Modular:** Permite un contexto selectivo (la IA carga solo lo necesario), mejora la precisión reduciendo alucinaciones, facilita la reutilización de partes entre celdas y permite una escalabilidad real en monorepos.
- **Estructura Semántica Recomendada:**
    - `00-overview.md`: Visión ejecutiva, propósito y dependencias.
    - `01-domain.md`: Modelo mental del negocio, entidades e invariantes. Es clave para que la IA no rompa la lógica de negocio.
    - `02-use-cases.md`: Acciones del sistema (ej. CreateRiskProfile) con sus inputs y outputs.
    - `03-contracts.md`: Interfaces técnicas, DTOs, endpoints y eventos. Conecta directamente con la necesidad de contratos explícitos en .NET AOT.
    - `04-architecture.md`: Define los límites de la celda, dependencias permitidas, patrones (CQRS) y decisiones específicas para Native AOT (como evitar la reflexión) para prevenir que la IA genere código incompatible.
    - `05-traceability.md`: Enlaza los casos de uso con los flujos, contratos y estados, asegurando consistencia total.

## 3. Organización del Monorepo y Convenciones de Nombres

La claridad en el nombrado de artefactos es crítica para los desarrolladores y las herramientas de IA.

- **Proyectos .NET (Compilables):** Deben usar el prefijo completo (ej. `AHS.Cell.Xinfer.API`, `AHS.Cell.Xinfer.Domain`). Esto indica que generan assemblies, tienen namespaces y participan en el runtime.
- **Documentación (Conocimiento):** Debe mantenerse como un directorio simple llamado `docs/` (preferiblemente en minúsculas). Renombrarlo a algo como `AHS.Cell.Xinfer.Docs` es un error porque simula ser un proyecto ejecutable, confundiendo al tooling y mezclando artefactos de runtime con artefactos de conocimiento.
- **Principio de Intención:** El nombre debe comunicar el tipo de artefacto: código compilable vs. conocimiento (docs), scripts o infraestructura.

## 4. Estructura Interna de `docs/` y Clasificación de Conocimiento

El desorden en la documentación se soluciona clasificando los archivos por el tipo de conocimiento que contienen, lo que facilita el consumo por parte de la IA.

- **Clasificación por tipo:**
    - **Declarativo (`blueprint/`):** Define el qué es el sistema (visión, dominio, contratos).
    - **Conductual (`flows/`):** Describe el comportamiento dinámico (SSS, UIF, UTA, wireframes).
    - **Decisional (`decisions/`):** Contiene los Architecture Decision Records (ADR). Es "oro" para evitar regresiones y dar contexto a la IA sobre por qué se usa AOT o arquitectura de celdas.
    - **Exploratorio (`drafts/`):** Ideas sueltas o archivos incompletos que no deben borrarse pero sí apartarse del núcleo.

## 5. UI Flow Spec: Integración de Wireframes y UIF

Para evitar duplicidad y pérdida de contexto, se recomienda fusionar los wireframes (visual) con el User Interaction Flow (interacción) en una estructura integrada denominada "UI Flow Spec".

- **Estructura por Feature:** Cada flujo de UI debe vivir en su propia carpeta (ej. `flows/ui/risk-evaluation/`) con archivos específicos:
    - `00-overview.md`: Meta del flujo, puntos de entrada y salida, y actores.
    - `01-flow.md`: El flujo paso a paso (UIF real).
    - `02-screens.md`: Wireframes estructurados con elementos, acciones y vínculos a la API.
    - `03-states.md`: Definición de estados críticos de la UI (Carga, Éxito, Error o estados de negocio como NotAcceptable, Risky, Acceptable).
- **Importancia de los Estados:** Modelar los estados como la "fuente de verdad" convierte el frontend en una máquina de estados implícita, lo que reduce la ambigüedad para las herramientas de IA y mejora la estructura en tecnologías como Blazor.

## 6. Stack Tecnológico: .NET 10, Native AOT y C# 14

El uso de Native AOT impone restricciones severas que deben estar reflejadas en la arquitectura.

- **Frontend:** Dado el stack, la opción recomendada es **Blazor Web App (SSR-first)** para mantener la coherencia y compatibilidad con AOT, evitando SPAs externas que rompen la homogeneidad.
- **Restricciones AOT (Críticas):**
    - **Reflexión:** Debe evitarse la reflexión dinámica en runtime (`Type.GetType`, `Activator.CreateInstance`). Solo se permite si está declarada para trimming o soportada por source generators.
    - **Serialización:** Usar `System.Text.Json` exclusivamente con **source generators**. Prohibido el uso de `dynamic` u `object`.
    - **Tipado Fuerte:** Todo comportamiento debe ser determinista y conocido en tiempo de compilación. Los estados deben modelarse como tipos fuertes (records inmutables) en lugar de flags o lógica mutable compleja.
- **Regla de Oro:** "Si no puede resolverse en compile-time, es sospechoso para AOT".

## 7. El Sistema Xinfer: Autonomous Decision Cell

Xinfer es un ejemplo de una "Celda de Decisión Autónoma" diseñada para predecir riesgos de excursión térmica en la industria farmacéutica.

- **Principios de Diseño:** El sistema no es un CRUD; es un sistema que **razona antes de inferir**. Incluye un "Data Readiness Gate" obligatorio: el sistema puede negarse a predecir si los datos no son consistentes (estado `NotAcceptable`).
- **Automatización:** El usuario no selecciona datos históricos ni entrena modelos manualmente; la celda lo gestiona automáticamente basándose en el contexto del embarque y parámetros operativos.
- **Componentes de la Celda:** Orchestrator (el cerebro), Data Readiness Engine (el guardián), Historical Data Selector, Inference Engine y motores de explicación (XAI) y recomendación.

## 8. Integración con Tooling (Antigravity y VS Code)

Para que herramientas como Antigravity funcionen correctamente en un entorno de arquitectura basada en celdas, la configuración del workspace es vital.

- **Indexación Automática:** A diferencia de AI Studio donde el contexto se pega manualmente, Antigravity puede indexar el repositorio local.
- **Configuración del Workspace (`.code-workspace`):**
    - Se debe incluir la carpeta `docs/` en `antigravity.context.includeFolders` para que la IA tenga acceso a los blueprints y flows.
    - Es necesario ajustar `files.exclude` para que `docs` sea visible para la herramienta (setear en `false`), manteniendo limpio el explorador de VS Code pero accesible para el agente de IA.
    - El `maxDepth` debe ser suficiente (ej. 8) para alcanzar subcarpetas profundas como `wireframes/risk-evaluation/`.
- **Trazabilidad en el Workspace:** El flujo de contexto debe estar claro: la IA debe poder navegar desde una tarea de usuario en el blueprint, pasando por el flujo de UI y el estado, hasta llegar al contrato de la API y el DTO en el código C#.