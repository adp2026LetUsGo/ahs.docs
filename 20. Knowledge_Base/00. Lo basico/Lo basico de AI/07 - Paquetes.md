
Revisar donde los guarde

Te entrego **ambos paquetes** listos para usar:

- **Memory Pack (Global)** → texto breve y estable para guardar en la **Memoria de Gemini**.
- **Prompt Pack (Universal)** → plantillas reutilizables para tus sesiones (Architect Mode) que producen **blueprints listos para Antigravity** (Agentic Phase).

> Nota: Estos contenidos **no mezclan proyectos**; sólo fijan tus **preferencias globales** y tu **filosofía de trabajo 2026**. Todo lo específico de FinTechBook, Micro‑SaaS o ShopWatch lo pones **en el prompt del día**, no en la memoria.

---

## 🔵 1) **MEMORY PACK — Global (para guardar en la Memoria de Gemini)**

Pega **cada bloque** en “Saved info / Memory” de Gemini.  
Son concisos, atemporales y no contaminan entre proyectos.

### Bloque A — **Modo de trabajo**

```
I use Gemini exclusively in ARCHITECT MODE. 
Gemini designs system blueprints; Antigravity executes them in the AGENTIC PHASE. 
All outputs must be implementation-ready for Antigravity: agent roles, tool definitions, RAG/Graph RAG design, long-context usage, guardrails, permissions, auditability, and evaluation plans.
```

### Bloque B — **Preferencias técnicas globales (2026)**

```
Preferred stack: 
- RAG for factual grounding
- Optional Graph RAG for multi-hop relational reasoning
- Agents with ReAct + tool/function calling and workflow orchestration
- Long-context models (1M–2M tokens) for full-doc/code analysis
- Fine-tuning only for style, tone, and formatting (not for facts)
- Continuous evals (groundedness, reasoning, format, injection resilience)
- Guardrails, least-privilege permissions, structured JSON outputs
- Model routing: Flash for simple tasks, Pro/Thinking for complex reasoning
```

### Bloque C — **Estilo de entrega**

```
Always return architecture in clear, structured sections with bullet points, numbered steps, and short, testable checklists.
Prefer English for technical deliverables and use a corporate/Microsoft-blue visual style for any diagrams.
```

> **Listo.** Con estos tres bloques, Gemini recordará permanentemente tu **modo Architect → Agentic**, tu **stack general 2026** y tu **estilo**. El resto (lo específico de cada proyecto, módulo o agente) lo pondrás en los prompts.

---

## 🟦 2) **PROMPT PACK — Universal (para pedir blueprints listos para Antigravity)**

Usa estas plantillas cuando te sientes a trabajar en cualquier proyecto.  
Cada una trae una **versión estándar** (rápida) y una **versión estructurada** (con JSON/YAML opcional para Antigravity).

---

### 🔹 Prompt U1 — **Blueprint universal rápido (cualquier proyecto)**

You are now operating in ARCHITECT MODE.

Your output will be executed by Antigravity in the AGENTIC PHASE.

  

Context (fill these lines per session):

- Project name: <name>

- Goal for today: <e.g., “diagnostic agent v1”, “RAG pipeline for policies”, “reporting workflow”>

- Constraints: <latency/cost/compliance/etc.>

- Data sources (if any): <docs, APIs, logs>

  

Deliver:

1) Ideal 2026 AI design for this goal (RAG, Graph RAG if helpful, long-context usage, agents + tools, model routing).

2) Agent definitions (role, loop, termination, memory policy).

3) Tool definitions (name, purpose, inputs schema, outputs schema, constraints).

4) Workflow steps (numbered, deterministic).

5) Safety & evals (guardrails, permissions, tests to run before prod).

6) Handoff checklist for Antigravity.

  

Do NOT execute actions; only produce a blueprint ready for Antigravity.

Return the answer in English with clear sections and concise bullet points.

---

### 🔹 Prompt U2 — **Blueprint estructurado con objetos (JSON-ready)**

You are in ARCHITECT MODE.

Antigravity will ingest your output. Produce BOTH:

(A) a human-readable overview and

(B) machine-readable specs (JSON) at the end.

  

Context (fill in):

- Project: <name>

- Objective: <what to build today>

- Inputs/Docs: <optional list>

  

Sections required:

1. Architecture Overview (why RAG vs Graph RAG, long-context role, agents & tools overview, routing strategy).

2. Detailed Workflow (steps 1..N, with success/failure paths).

3. Safety & Evals (guardrails, permissions, audit logs, tests).

4. Handoff Notes (how Antigravity should wire everything).

  

Then output the machine spec:

  

```json

{

  "project": "<name>",

  "objective": "<...>",

  "llm_routing": {

    "simple_tasks_model": "Gemini Flash",

    "reasoning_model": "Gemini Pro/Thinking"

  },

  "retrieval": {

    "type": "vector_rag",

    "embeddings": "<preferred>",

    "graph_rag": {

      "enabled": <true|false>,

      "entities": ["<entity>", "<entity>"],

      "relations": ["<rel>", "<rel>"]

    },

    "long_context": { "enabled": true, "window_tokens": "1M+" }

  },

  "agents": [

    {

      "name": "<AgentName>",

      "purpose": "<what it does>",

      "loop": ["observe","think","act","reflect","stop"],

      "tools_allowed": ["<ToolA>", "<ToolB>"],

      "termination": "<condition>",

      "memory_policy": "<none|episodic|task>"

    }

  ],

  "tools": [

    {

      "name": "<ToolA>",

      "purpose": "<why>",

      "input_schema": { "...": "..." },

      "output_schema": { "...": "..." },

      "constraints": ["rate_limit:x", "timeout:ms", "least_privilege"]

    }

  ],

  "workflows": [

    {

      "name": "<WorkflowName>",

      "steps": [

        {"id": 1, "action": "retrieve", "params": {...}},

        {"id": 2, "action": "agent_call", "agent": "<AgentName>", "tool": "<ToolA>"},

        {"id": 3, "action": "validate_output", "policy": "json-schema:<schemaId>"},

        {"id": 4, "action": "eval_pack_run", "tests": ["groundedness","format","injection"]}

      ]

    }

  ],

  "safety": {

    "guardrails": ["structured_json","pii_filter","content_policy"],

    "permissions": ["read:docs","call:<ToolA>"],

    "audit": ["log:inputs_outputs","trace:agent_decisions"]

  },

  "evals": {

    "pre_deploy": ["groundedness","reasoning","format"],

    "runtime_sampling": ["drift","latency","cost"]

  },

  "handoff_checklist": [

    "Create vector indices",

    "Configure KG if graph_rag.enabled",

    "Register tools",

    "Bind agent-to-tool permissions",

    "Install eval packs",

    "Enable audit/telemetry"

  ]

}

Return both parts (overview + JSON) in English.

````

---

### 🔹 Prompt U3 — **Generador de agentes (plantilla express)**

```md
ARCHITECT MODE → Output for Antigravity.

Design a single agent for <goal>.
Provide:
- Name, Purpose
- Inputs/Outputs expectations
- Loop (observe/think/act/reflect/stop)
- Tools allowed (strict list)
- Error handling policy
- Termination criteria
- Minimal eval pack

Then provide the JSON spec for registration in Antigravity with the same fields.
````

---

### 🔹 Prompt U4 — **RAG/Graph RAG designer (rápido y neutral)**

ARCHITECT MODE → RAG/Graph RAG design for <goal>.

  

Deliver:

1) Chunking & embeddings strategy

2) Index layout (namespaces, metadata)

3) Retrieval policy (k, rerank, filters)

4) Long-context interplay (what to load directly vs retrieve)

5) Graph RAG (entities, relations, queries/traversals) — optional

6) Safety (citation requirement, hallucination checks)

7) Antigravity handoff steps

  

Be concise and production-oriented.

---

### 🔹 Prompt U5 — **Guardrails + Evals pack (catálogo base)**

ARCHITECT MODE → Produce a guardrails & evals pack for <goal>.

  

Return:

- Risks & mitigations

- Guardrail policies (input filters, output validators, JSON schema IDs)

- Permission map (agent → tools)

- Audit plan (what to log/retain)

- Evals: pre-deploy tests + runtime sampling

- Handoff checklist for Antigravity

---

## 🧩 Cómo usarlos juntos (flujo simple)

1. **Memoria global** ya grabada → Gemini arranca en tu filosofía Architect 2026.
2. **Elige un Prompt del Pack** (U1/U2/U3/U4/U5) según lo que vayas a diseñar hoy.
3. **Completa 4–5 líneas de contexto** (nombre del proyecto, objetivo, restricciones).
4. **Recibes blueprint + JSON** → lo llevas a Antigravity (Agentic Phase).
5. **Iteras**: si algo requiere más detalle (p.ej., herramientas), usa U3; si el RAG necesita más diseño, usa U4; si vas a cerrar seguridad y evaluación, usa U5.

---

## ✅ Siguientes pasos opcionales

- Te preparo **variantes “strict-JSON”** (sin texto humano, sólo objetos) si Antigravity importa directamente specs.
- Genero **esquemas JSON Schema** para validar entradas/salidas de herramientas.
- Creo **un documento de “Runbook”** (Markdown) para tu monorepo con este Prompt Pack y guía de uso.

¿Quieres que entregue también las **versiones strict‑JSON** y los **JSON Schemas base** para herramientas/agents/evals, para que lo pegues sin tocar en Antigravity?