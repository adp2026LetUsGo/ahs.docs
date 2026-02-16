---
title: RAG — Concepts
created: 2026-02-05
updated: 2026-02-05
tags: [rag]
---

# RAG — Concepts

Core pipeline, retrieval quality, chunking.

#rag 

Aquí tienes una explicación **completa, clara y actualizada** de **Retrieval Augmented Generation (RAG)**, basada en fuentes verificadas.

---

# 🧠 ¿Qué es RAG (Retrieval-Augmented Generation)?

**RAG** es una arquitectura de inteligencia artificial que combina **modelos generativos (LLMs)** con **sistemas de recuperación de información** para producir respuestas **más precisas, actualizadas y basadas en datos reales**.

En vez de confiar solo en lo que el modelo aprendió durante su entrenamiento (que tiene un corte temporal), RAG **busca información relevante en bases de datos externas**, la añade al prompt y luego genera la respuesta.  
Esto reduce alucinaciones y mejora la exactitud. [[bing.com]](https://bing.com/search?q=Retrieval+Augmented+Generation+concept+definition+RAG+AI+overview), [[geeksforgeeks.org]](https://www.geeksforgeeks.org/nlp/what-is-retrieval-augmented-generation-rag/)

---

# 🔍 ¿Por qué existe RAG?

Los LLMs tienen limitaciones claras:

- Su conocimiento es **estático** (limitado a su fecha de corte).
- Pueden **inventar información** cuando no saben algo (alucinaciones).
- No manejan bien datos internos de una empresa.

RAG soluciona todo esto al **inyectar información verdadera, actualizada y específica del dominio antes de generar la respuesta**. [[aws.amazon.com]](https://aws.amazon.com/what-is/retrieval-augmented-generation/)

---

# ⚙️ ¿Cómo funciona RAG?

El flujo típico de RAG consta de 6 pasos:

1. **Preparación de datos externos**
    
    - Documentos, PDFs, bases de datos, APIs.
    - Se dividen en “chunks” manejables. [[geeksforgeeks.org]](https://www.geeksforgeeks.org/nlp/what-is-retrieval-augmented-generation-rag/)
2. **Embeddings (vectorización)**
    
    - Cada fragmento se convierte en un vector semántico.
    - Se almacenan en una **base vectorial**. [[geeksforgeeks.org]](https://www.geeksforgeeks.org/nlp/what-is-retrieval-augmented-generation-rag/)
3. **Encoding de la consulta**
    
    - La pregunta del usuario también se convierte en un vector. [[bing.com]](https://bing.com/search?q=Retrieval+Augmented+Generation+concept+definition+RAG+AI+overview)
4. **Retrieval (búsqueda semántica)**
    
    - El sistema encuentra los documentos más relevantes. [[paloaltonetworks.com]](https://www.paloaltonetworks.com/cyberpedia/what-is-retrieval-augmented-generation)
5. **Prompt Augmentation**
    
    - Se inserta la información encontrada junto a la pregunta original. [[paloaltonetworks.com]](https://www.paloaltonetworks.com/cyberpedia/what-is-retrieval-augmented-generation)
6. **Generación**
    
    - El LLM responde con la información recuperada. [[bing.com]](https://bing.com/search?q=Retrieval+Augmented+Generation+concept+definition+RAG+AI+overview)

Este pipeline es el corazón del enfoque RAG.

---

# ⭐ Beneficios principales

### ✔ 1. **Acceso a información actualizada**

Puede usar datos recientes o en tiempo real. [[geeksforgeeks.org]](https://www.geeksforgeeks.org/nlp/what-is-retrieval-augmented-generation-rag/)

### ✔ 2. **Menos alucinaciones**

Reduce errores y mejora precisión porque fundamenta sus respuestas en fuentes reales. [[en.wikipedia.org]](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)

### ✔ 3. **Especialización sin fine‑tuning**

Puedes usar documentos internos (finanzas, medicina, legal, contabilidad) sin retrenar el modelo. [[geeksforgeeks.org]](https://www.geeksforgeeks.org/nlp/what-is-retrieval-augmented-generation-rag/)

### ✔ 4. **Costos mucho menores que fine‑tuning**

Solo se actualiza la base externa, no el LLM entero. [[ibm.com]](https://www.ibm.com/think/topics/retrieval-augmented-generation)

### ✔ 5. **Transparencia**

Permite citar las fuentes usadas por el sistema. [[en.wikipedia.org]](https://en.wikipedia.org/wiki/Retrieval-augmented_generation)

---

# 🆚 RAG vs Fine‑Tuning

|Tema|RAG|Fine‑Tuning|
|---|---|---|
|**Objetivo**|Añadir información externa actualizada|Enseñar comportamientos o estilos nuevos|
|**Costo**|Bajo|Alto|
|**Actualización**|Simple: actualizar documentos|Compleja: entrenar de nuevo|
|**Evita alucinaciones**|Sí|No necesariamente|
|**Aprende hechos nuevos**|Sí (vía fuentes externas)|No recomendado|

Fuentes: [[geeksforgeeks.org]](https://www.geeksforgeeks.org/nlp/what-is-retrieval-augmented-generation-rag/), [[ibm.com]](https://www.ibm.com/think/topics/retrieval-augmented-generation)

---

# 🛠️ ¿Cuándo usar RAG?

- Cuando necesitas información **actual** (noticias, precios, inventario).
- Cuando quieres integrar **datos internos** (documentación, reportes, políticas de empresa).
- Cuando quieres precisión sin entrenar modelos costosos.
- Para aplicaciones donde la transparencia es clave.

Ejemplos reales:

- Chatbots corporativos.
- Análisis de documentos legales/financieros.
- Sistemas de soporte técnico.
- Micro‑SaaS con datos propios, como **ShopWatch**.

---

# 🧩 Ejemplo breve (muy simplificado)

1. Usuario pregunta:  
    **“¿Por qué está caída mi tienda Shopify?”**
    
2. El sistema busca logs, reportes o artículos relevantes.
    
3. Inserta en el prompt:  
    “Contexto encontrado: _HTTP 503 desde Cloudflare durante 12 minutos_.”
    
4. El LLM genera la respuesta basada en ese contexto.
    

---

# ¿Quieres que te prepare un **diagrama estilo corporate azul** explicando RAG para tus proyectos?

O si prefieres, puedo hacerte un **mini‑cookbook RAG para ShopWatch**.