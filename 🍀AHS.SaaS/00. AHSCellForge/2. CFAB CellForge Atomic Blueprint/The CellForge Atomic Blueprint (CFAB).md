
En el **CFAB**, no hay documentos "de relleno". Cada documento es un "Input" para una de las tres instancias (**C1, C2, AG**). Si un documento no ayuda a generar código o a validar la arquitectura, se elimina.

Aquí tienes la lista completa y exhaustiva del **CFAB**, organizada por el motor de ejecución que la lidera:

---

### Fase 1: Strategic & Runtime (Liderada por C1 - The Architect)

Estos documentos definen el universo donde vivirá el software.

1. **Vision & SaaS Economics (PRD):** Define el problema, el modelo de monetización y los KPIs de negocio.
    
2. **Tenant Isolation Strategy:** Define si el aislamiento es por base de datos, por esquema o por celda física. Es vital para la rentabilidad del SaaS.
    
3. **C4 Level 1: System Context Diagram:** Mapa de cómo el sistema interactúa con actores externos y otros sistemas (ej. Entra ID, Gateways de pago).
    
4. **SLA & Performance Manifest:** Define los límites: Latencia máxima, rendimiento (throughput) y el presupuesto de memoria para Native AOT.
    
5. **Compliance & Regulatory Ledger:** Requerimientos legales (GDPR, HIPAA) que afectan el almacenamiento de datos.
    

---

### Fase 2: Technical Design (Liderada por C2 - The Lead Engineer)

Aquí es donde se diseña la ingeniería determinista.

1. **C4 Level 2: Container Diagram (The Cell Map):** Define las fronteras de cada celda independiente.
    
2. **Contract Registry (Protobuf Specs):** El documento más importante. Define las interfaces gRPC y los mensajes de eventos. **Es la única fuente de verdad.**
    
3. **C4 Level 3: Component Diagram:** Estructura interna de la celda (Internal Services, Repositories, Handlers).
    
4. **Domain Schema (EF Core Compiled Model Spec):** Definición de entidades inmutables y relaciones. No se permite reflexión; todo debe ser explícito para EF Core 10.
    
5. **Event Schema & Catalog:** Lista de eventos asíncronos, sus payloads y quiénes son los suscriptores (Pub/Sub).
    
6. **Use Case Realization (Atomic Flows):** Diagramas de secuencia técnicos que muestran cómo fluye un dato desde el Request hasta la persistencia.
    

---

### Fase 3: Execution & Security (Preparación para AG - The Executor)

Documentos que garantizan que el código generado sea production-ready.

1. **Native AOT Compliance Audit:** Lista de librerías externas (LTS) y validación de que ninguna usa System.Reflection o código dinámico.
    
2. **Identity & Access Blueprint (Entra ID):** Definición de Scopes, Roles y cómo se implementará Azure Workload Identity en los contenedores.
    
3. **Chiseled Container Specification:** Definición de la imagen base (distroless/chiseled), puertos, y variables de entorno mínimas.
    
4. **Observability Pact (OpenTelemetry):** Definición de qué métricas, logs y trazas son obligatorias para que la celda sea "observable por diseño".
    
5. **The Master Prompt (The AG Trigger):** El documento final que consolida los puntos 6 al 15 en instrucciones estructuradas para que **AG** genere los archivos físicos.
    

---

### ¿Cuál es el documento que "gobierna" sobre todos?

En **AHSCellForge**, el documento rey es el **Contract Registry (Protobuf Specs)**.

**¿Por qué?**  
Porque en un mundo de microservicios y celdas aisladas, si el contrato es sólido, el interior de la celda puede evolucionar, pero el sistema no se rompe. Además, Protobuf es nativamente compatible con **Native AOT**, lo que nos permite mantener el binario pequeño y rápido.

### Resumen de uso por instancia:

- **C1** entrega el **PRD y el Tenant Model**.
    
- **C2** consume lo anterior y produce el **Master Prompt**.
    
- **AG** consume el **Master Prompt** y entrega el código fuente en **C# 14**.