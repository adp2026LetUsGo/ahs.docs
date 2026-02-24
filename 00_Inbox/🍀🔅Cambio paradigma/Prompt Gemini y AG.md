
Dominio
Copilot=Product Traceability & Condition Monitoring
- productos sensibles
- controles de temperatura
- químicos sometidos a parámetros
- alimentos pasteurizados
- medicamentos con cadena de frío
- aceites con control térmico

Solo cambia el _perfil de reglas_.
Bounded Context:
Lechería
La lechería **no es un dominio**, es un **Subdominio Especializado (Specialized Subdomain)**.

---

Core (Invariantes comunes)
Conceptos que nunca cambian:

- `Measurement(Value, Unit, Timestamp)`
- `Sensor`
- `Threshold(min, max, gracePeriod)`
- `Excursion`
- `AuditHashChain`
- `LocationChange`
- `Batch`
- `TransportEvent`
- `Alert`

---
Policies (Reglas específicas por producto)
Aquí defines lo que cambia:
- **MilkPolicy**
    
    - 2–4 °C
    - Pasteurización: 72 °C × 15 s
    - Conteo bacteriológico
- **CookingOilPolicy**
    
    - < 25 °C almacenamiento
    - Sensible a luz / oxidación
- **VaccinePolicy**
    
    - 2–8 °C
    - Shock térmico prohibido

No duplicas nada en el Core.  
Solo cambias la política.

---


Gemini=Validated Traceability

- **Sensor Measurement:** Valor, Unidad, Timestamp, Calibración.
    
- **Audit Trail:** El hashing encadenado que diseñamos.
    
- **Excursion:** Cuando algo sale de un rango definido.
    
- **Threshold (Umbral):** Min/Max permitido y tiempo de gracia.