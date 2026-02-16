
1. **Versiones strict‑JSON** (sin texto humano) para que Antigravity pueda **ingerir directamente** especificaciones de **Agentes**, **Herramientas**, **Workflows**, **RAG/Graph RAG**, **Seguridad/Guardrails**, **Evaluaciones** y **Checklist de Handoff**.
2. **JSON Schemas base** para validar entradas/salidas de herramientas, contratos de agentes y pasos de workflow.
3. Un **Runbook (Markdown)** para tu monorepo con instrucciones de uso del Prompt Pack y los artefactos.

> **Nota**: Son _globales_ y reutilizables (no incluyen datos específicos de FinTechBook ni Micro‑SaaS). Cuando los uses, completa los campos marcados con `"<...>"` o `TODO:`.

---

## 1) Strict‑JSON specs (universales, listos para Antigravity)

> Separados por secciones para que puedas pegarlos en módulos distintos si Antigravity importa por dominio (agents/tools/workflows/etc.). Si tu importador soporta un **manifiesto único**, usa el bloque **`manifest.json`** al final.

### 1.1 `agents.json`

{

  "version": "2026-02",

  "agents": [

    {

      "name": "<AgentName>",

      "description": "<Short purpose statement>",

      "capabilities": ["reasoning", "tool_use", "rag", "validation"],

      "loop": ["observe", "think", "act", "reflect", "stop"],

      "routing_hint": "pro_or_thinking",

      "memory_policy": {

        "type": "none",

        "retention": "ephemeral",

        "notes": "Architected for deterministic runs"

      },

      "tools_allowed": ["<ToolA>", "<ToolB>"],

      "policies": {

        "guardrails": ["structured_json", "pii_filter", "content_policy"],

        "permissions": ["use:<ToolA>", "use:<ToolB>"],

        "audit": ["trace:decisions", "log:inputs_outputs"]

      },

      "termination": {

        "type": "goal_reached_or_max_steps",

        "max_steps": 12,

        "goal_test": "output.valid == true"

      },

      "eval_pack": {

        "pre_deploy": ["groundedness", "format_valid", "injection_resilience"],

        "runtime_sampling": ["drift", "latency", "cost"],

        "success_criteria": {

          "groundedness": ">=0.95",

          "format_valid": "100%",

          "latency_p95_ms": "<=2000"

        }

      },

      "outputs_contract": {

        "format": "json",

        "schema_id": "agent.output.v1"

      }

    }

  ]

}

---

### 1.2 `tools.json`

{

  "version": "2026-02",

  "tools": [

    {

      "name": "<ToolA>",

      "purpose": "<What the tool does>",

      "endpoint": {

        "type": "function",

        "identifier": "ToolA.Invoke"

      },

      "input_schema": {

        "$schema": "[https://json-schema.org/draft/2020-12/schema](https://json-schema.org/draft/2020-12/schema)",

        "$id": "tool.ToolA.input.v1",

        "type": "object",

        "required": ["request_id", "payload"],

        "properties": {

          "request_id": { "type": "string", "minLength": 1 },

          "payload": {

            "type": "object",

            "properties": {

              "query": { "type": "string" },

              "filters": { "type": "object", "additionalProperties": true }

            },

            "required": ["query"]

          }

        },

        "additionalProperties": false

      },

      "output_schema": {

        "$schema": "[https://json-schema.org/draft/2020-12/schema](https://json-schema.org/draft/2020-12/schema)",

        "$id": "tool.ToolA.output.v1",

        "type": "object",

        "required": ["request_id", "status", "data"],

        "properties": {

          "request_id": { "type": "string" },

          "status": { "type": "string", "enum": ["ok", "error"] },

          "data": { "type": "object", "additionalProperties": true },

          "error": { "type": "object", "nullable": true, "additionalProperties": true }

        },

        "additionalProperties": false"

      },

      "constraints": {

        "rate_limit_per_min": 120,

        "timeout_ms": 8000,

        "idempotent": true,

        "permissions_required": ["use:<ToolA>"]

      }

    }

  ]

}

---

### 1.3 `retrieval.json` (RAG / Long‑context / Graph RAG)

{

  "version": "2026-02",

  "retrieval": {

    "vector_rag": {

      "enabled": true,

      "embeddings": {

        "provider": "gemini",

        "model": "<embedding-model-or-variant>"

      },

      "chunking": {

        "strategy": "semantic",

        "target_tokens": 400,

        "overlap_tokens": 60

      },

      "index_layout": {

        "namespaces": ["docs", "logs", "policies"],

        "metadata": ["source", "timestamp", "category", "hash"]

      },

      "query": {

        "top_k": 6,

        "filters": [],

        "rerank": { "enabled": true, "model": "<reranker-or-gemini-ranking>" }

      }

    },

    "long_context": {

      "enabled": true,

      "window_tokens": ">=1M",

      "usage_policy": "Load large specs/manuals directly; prefer RAG for dynamic facts"

    },

    "graph_rag": {

      "enabled": false,

      "graph": {

        "type": "knowledge_graph",

        "store": "<neo4j|nebula|tigergraph|other>",

        "entities": [],

        "relations": [],

        "queries": []

      },

      "strategy": "neighborhood_traversal_or_community_summaries"

    },

    "grounding_rules": {

      "require_citations": true,

      "reject_if_no_context": true

    }

  }

}

---

### 1.4 `workflows.json`

{

  "version": "2026-02",

  "workflows": [

    {

      "name": "<WorkflowName>",

      "description": "<Short description>",

      "steps": [

        { "id": 1, "action": "retrieve", "params": { "namespace": "docs", "top_k": 6 } },

        { "id": 2, "action": "agent_call", "params": { "agent": "<AgentName>", "tool": "<ToolA>" } },

        { "id": 3, "action": "validate_output", "params": { "schema_id": "agent.output.v1" } },

        { "id": 4, "action": "eval_pack_run", "params": { "tests": ["groundedness", "format_valid", "injection_resilience"] } },

        { "id": 5, "action": "emit", "params": { "channel": "stdout|webhook|queue", "format": "json" } }

      ],

      "on_error": [

        { "action": "emit", "params": { "channel": "stderr", "format": "json" } }

      ]

    }

  ]

}

---

### 1.5 `safety.json` (Guardrails / Permisos / Auditoría)

{

  "version": "2026-02",

  "safety": {

    "guardrails": [

      "structured_json_only",

      "json_schema_validation",

      "pii_detection_and_redaction",

      "policy_filter:content",

      "prompt_injection_defense"

    ],

    "permissions": {

      "agents": {

        "<AgentName>": ["use:<ToolA>", "use:<ToolB>"]

      }

    },

    "audit": {

      "logging": {

        "inputs": true,

        "outputs": true,

        "tool_calls": true,

        "llm_thoughts": "metadata_only"

      },

      "retention_days": 90,

      "pii_masking": true

    }

  }

}

---

### 1.6 `evals.json`

{

  "version": "2026-02",

  "evals": {

    "pre_deploy": [

      { "name": "groundedness", "metric": "f1", "target": 0.95 },

      { "name": "format_valid", "metric": "pass_rate", "target": 1.0 },

      { "name": "injection_resilience", "metric": "pass_rate", "target": 0.98 }

    ],

    "runtime_sampling": [

      { "name": "reasoning_consistency", "metric": "score", "target": 0.9, "sample_rate": 0.1 },

      { "name": "latency_p95", "metric": "ms", "target": 2000 },

      { "name": "cost_per_task", "metric": "usd", "target": "<=target_value" }

    ]

  }

}

---

### 1.7 `handoff_checklist.json`

{

  "version": "2026-02",

  "handoff_checklist": [

    "Create/update vector indices and namespaces",

    "Register tools and attach JSON Schemas",

    "Bind agent permissions to tools",

    "Enable guardrails and content policies",

    "Configure audit & telemetry sinks",

    "Install eval packs: pre_deploy + runtime_sampling",

    "Run smoke tests and confirm schema validation",

    "Promote workflow to staging, then production"

  ]

}

---

### 1.8 **Manifiesto único** (opcional) — `manifest.json`

> Úsalo si Antigravity soporta importar **todo** desde un sólo archivo.

{

  "type": "antigravity.manifest",

  "version": "2026-02",

  "includes": {

    "agents": "agents.json",

    "tools": "tools.json",

    "retrieval": "retrieval.json",

    "workflows": "workflows.json",

    "safety": "safety.json",

    "evals": "evals.json",

    "handoff": "handoff_checklist.json"

  }

}

---

## 2) JSON Schemas base (contratos universales)

> Puedes ponerlos en `schemas/` y referenciarlos por `schema_id`.

### 2.1 `schemas/agent.output.v1.schema.json`

{

  "$schema": "[https://json-schema.org/draft/2020-12/schema",](https://json-schema.org/draft/2020-12/schema%22,)

  "$id": "agent.output.v1",

  "title": "Agent Output Contract v1",

  "type": "object",

  "required": ["request_id", "result", "citations", "meta"],

  "properties": {

    "request_id": { "type": "string", "minLength": 1 },

    "result": { "type": "object", "additionalProperties": true },

    "citations": {

      "type": "array",

      "items": {

        "type": "object",

        "required": ["source", "evidence"],

        "properties": {

          "source": { "type": "string" },

          "evidence": { "type": "string" }

        },

        "additionalProperties": false

      }

    },

    "meta": {

      "type": "object",

      "required": ["grounded"],

      "properties": {

        "grounded": { "type": "boolean" },

        "confidence": { "type": "number", "minimum": 0, "maximum": 1 },

        "elapsed_ms": { "type": "integer", "minimum": 0 }

      },

      "additionalProperties": true

    }

  },

  "additionalProperties": false

}

---

### 2.2 `schemas/workflow.step.v1.schema.json`

{

  "$schema": "[https://json-schema.org/draft/2020-12/schema",](https://json-schema.org/draft/2020-12/schema%22,)

  "$id": "workflow.step.v1",

  "title": "Workflow Step v1",

  "type": "object",

  "required": ["id", "action", "params"],

  "properties": {

    "id": { "type": "integer", "minimum": 1 },

    "action": {

      "type": "string",

      "enum": [

        "retrieve",

        "agent_call",

        "validate_output",

        "eval_pack_run",

        "emit"

      ]

    },

    "params": { "type": "object", "additionalProperties": true }

  },

  "additionalProperties": false

}

---

### 2.3 `schemas/tool.input.generic.v1.schema.json`

{

  "$schema": "[https://json-schema.org/draft/2020-12/schema",](https://json-schema.org/draft/2020-12/schema%22,)

  "$id": "tool.input.generic.v1",

  "title": "Generic Tool Input v1",

  "type": "object",

  "required": ["request_id", "payload"],

  "properties": {

    "request_id": { "type": "string", "minLength": 1 },

    "payload": { "type": "object", "additionalProperties": true }

  },

  "additionalProperties": false

}

---

### 2.4 `schemas/tool.output.generic.v1.schema.json`

{

  "$schema": "[https://json-schema.org/draft/2020-12/schema",](https://json-schema.org/draft/2020-12/schema%22,)

  "$id": "tool.output.generic.v1",

  "title": "Generic Tool Output v1",

  "type": "object",

  "required": ["request_id", "status", "data"],

  "properties": {

    "request_id": { "type": "string" },

    "status": { "type": "string", "enum": ["ok", "error"] },

    "data": { "type": "object", "additionalProperties": true },

    "error": { "type": "object", "nullable": true, "additionalProperties": true }

  },

  "additionalProperties": false

}

---

### 2.5 `schemas/retrieval.policy.v1.schema.json`

{

  "$schema": "[https://json-schema.org/draft/2020-12/schema",](https://json-schema.org/draft/2020-12/schema%22,)

  "$id": "retrieval.policy.v1",

  "title": "Retrieval Policy v1",

  "type": "object",

  "required": ["vector_rag", "long_context", "grounding_rules"],

  "properties": {

    "vector_rag": { "type": "object", "additionalProperties": true },

    "long_context": { "type": "object", "additionalProperties": true },

    "graph_rag": { "type": "object", "nullable": true, "additionalProperties": true },

    "grounding_rules": {

      "type": "object",

      "required": ["require_citations", "reject_if_no_context"],

      "properties": {

        "require_citations": { "type": "boolean" },

        "reject_if_no_context": { "type": "boolean" }

      }

    }

  },

  "additionalProperties": false

}

---

## 3) Runbook (Markdown) — para tu monorepo

Guárdalo como:  
`/docs/AI-Runbook-2026.md`

# AHS — AI Runbook 2026 (Architect → Agentic)

  

This runbook standardizes how we design with **Gemini (Architect Mode)** and execute with **Antigravity (Agentic Phase)** using a single, global memory.

  

---

  

## 1. Philosophy

- **Architect Mode (Gemini)**: design only — agents, tools, RAG/Graph RAG, workflows, safety, evals. 

- **Agentic Phase (Antigravity)**: execute with guardrails, permissions, auditing, and continuous evaluations.

  

---

  

## 2. Memory (Global)

Keep only cross-project preferences. 

- Architect Mode → Antigravity handoff 

- 2026 stack: RAG, optional Graph RAG, long-context, agents, tool calling 

- Fine-tuning only for style/format 

- Guardrails + evals 

- Model routing: Flash vs Pro/Thinking 

- Style: English + corporate/Microsoft-blue

  

> Do NOT store project-specific facts in memory.

  

---

  

## 3. Prompt Pack (Universal)

Use these prompts directly with Gemini:

  

- **U1**: Quick blueprint 

- **U2**: Blueprint + JSON objects (for Antigravity ingestion) 

- **U3**: Single agent designer 

- **U4**: RAG / Graph RAG designer 

- **U5**: Guardrails + Evals pack

  

> Fill the session context (project name, today’s goal, constraints, data sources).

  

---

  

## 4. Artifacts & File Layout

/ai/ agents.json tools.json retrieval.json workflows.json safety.json evals.json handoff_checklist.json manifest.json (optional) /schemas/ agent.output.v1.schema.json tool.input.generic.v1.schema.json tool.output.generic.v1.schema.json retrieval.policy.v1.schema.json workflow.step.v1.schema.json

```

---

## 5. Import Flow (Antigravity)
1. **Validate** JSON files against schemas.  
2. **Import** `manifest.json` or the individual files.  
3. **Bind permissions** (safety.json → agents/tools).  
4. **Provision retrieval** (vector indices; enable long-context; optionally configure Graph RAG).  
5. **Install eval packs** (pre_deploy + runtime).  
6. **Run smoke tests** (workflow minimal path; schema validation must pass).  
7. **Promote to staging** → **Run evals** → **Promote to production**.

---

## 6. Quality Gates
- `format_valid`: 100%  
- `groundedness`: ≥ 0.95  
- `injection_resilience`: ≥ 0.98  
- `latency_p95`: ≤ 2000 ms  
- **All outputs** must comply with `agent.output.v1`.

---

## 7. Operating Notes
- Prefer **RAG** for dynamic knowledge; use **long-context** for large, static materials.  
- Adopt **Graph RAG** only when multi-hop relational reasoning adds real value.  
- Keep tools **small**, **typed**, **idempotent**; return deterministic JSON.  
- Everything must be **auditable** and **reproducible**.

---

## 8. Change Management
- Any change in agents/tools/workflows requires:
  - Update JSON specs  
  - Re-run pre_deploy evals  
  - Signed-off checklist in PR  
  - Tagged release

---

## 9. Incident Response (AI)
- On eval regression: auto-demote agent or route to Flash/Pro fallback.  
- On policy breach: revoke permission; open security ticket; attach audit logs.

---

## 10. Appendix
- Prompt Pack (U1..U5) kept in `/docs/prompts/`.
- Schemas versioned with `$id` and semantic tags.
```

---

## 4) ¿Cómo integrar esto con tu **Memory Pack** y **Prompt Pack**?

- **Memory Pack** (ya entregado en el mensaje anterior): colócalo en la memoria de Gemini.
- **Prompt Pack** (U1..U5): mantenlo en `/docs/prompts/` y úsalo en cada sesión.
- Cuando Gemini te dé el **blueprint + JSON**,
    - **pega** el JSON en los archivos correspondientes (`agents.json`, `tools.json`, etc.)
    - corre la **validación** contra los **JSON Schemas**
    - y ejecuta el **handoff checklist** en Antigravity.

---

## 5) ¿Quieres que te entregue un **paquete ZIP** con esta estructura y archivos precreados?

Puedo generarlo tal cual para que lo descargues y sólo edites los campos `"<...>"`. Además, si necesitas **variantes** (p.ej., `graph_rag.enabled=true` con plantillas de entidades/relaciones), te los agrego.