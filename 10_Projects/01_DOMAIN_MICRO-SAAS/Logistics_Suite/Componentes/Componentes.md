`RiskPulse`, `DeltaTChart` y `JourneyTimeline` 
Delta T Visualizer
*XAI (Explainable AI)

*   **Sidebar.razor (300px):** Implementar un "Mode Switcher" (Pharma / Standard / Perishable).
*   **RiskPulse.razor:** Widget principal que muestra el **Score de Riesgo (0-100)** usando un gradiente dinámico (Verde -> Amarillo -> Rojo).
*   **DeltaTChart.razor:** Visualización de la brecha entre la **Temperatura Ambiente vs. Producto**. El "Delta T" debe ser el factor visual crítico.
*   **JourneyTimeline.razor:** Una línea de vida del embarque con 3 estadios:
    1.  **Red Zone (Airside/Customs):** Resaltado con efecto de brillo (glow) si el riesgo es >70%.
    2.  **Middle Mile:** Tracking interurbano.
    3.  **Last Mile:** Enfoque en aperturas de puerta.


*   **`RiskPulse.razor`:** Visualizador circular de riesgo (0-100%) con gradiente dinámico.
    *   **`DeltaTChart.razor`:** Gráfica de diferencial térmico (Ambient vs. Cargo) que resalte el gradiente de riesgo predictivo.
    *   **`JourneyTimeline.razor`:** Línea de vida segmentada en 3 estadios: **Red Zone (Airside)**, **Middle Mile (Transit)** y **Last Mile (Delivery)**, con efectos de brillo (glow) en zonas de alerta.
* 
* 
* GxP Audit Ledger

1.  **The Interactive Sidebar (Control Hub):** El sidebar de 300px no debe ser solo un menú; debe ser un **"Fleet Pulse"**. Debe mostrar micro-indicadores de cuántos embarques están en "Red Zone" en tiempo real, sin cambiar de página.
2.  **The GxP Audit Ledger (Visual Compliance):** La tabla de registros actual suele ser aburrida. Necesitamos un **"Libro de Auditoría"** visualmente impactante, con sellos digitales y estados de color que griten "CFR 21 Part 11 Compliant".
3.  **Micro-Interacciones & Animaciones:** Transiciones suaves entre estados de riesgo, efectos de desenfoque dinámico cuando hay alertas y una tipografía que respire jerarquía visual.


The fleet pulse
Critical Alerts
Stability Index
Transit nodes

![[Pasted image 20260311063558.png]]


Dashboard
Live Map
GxP Audit Trail
Predictive Science
System Logs
Engine Latency 

Pregunta:
GxP Audit Trail = GxP Audit Ledger 

Comparison of Concepts

- **GxP Audit Trail**: This is the standard regulatory term defined by the [FDA (21 CFR Part 11)](https://smartfoodsafe.com/audit-trail-compliance/) and [EU (Annex 11)](https://intuitionlabs.ai/articles/audit-trail-requirements-ai-gxp-compliance). It is a secure, computer-generated, time-stamped electronic record that allows for the reconstruction of events related to the creation, modification, or deletion of an electronic record.
- **GxP Audit Ledger**: This term often describes the underlying **data structure**—particularly in [Blockchain](https://www.pharmaregulatory.in/blockchain-data-integrity-explained-complete-guide-to-regulatory-compliance-audit-trails-and-2025-best-practices/) or [Distributed Ledger Technology (DLT)](https://www.eleapsoftware.com/the-critical-role-of-audit-trails-in-ensuring-data-integrity-and-compliance-in-the-pharmaceutical-biotech-and-medical-device-industry/)—that stores the audit trail. While an audit trail is the _functional requirement_, a ledger is a _technical method_ of achieving an immutable and tamper-evident history of records. ![European Medicines Agency](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAERElEQVRYhc2XX0xbdRTHP+1tSym30JbFYrjY4VgGyZZIREyM25xx2xsJCfpi5MEHfV5CssRkvugLiclefDKLMbwJJMTGxIBLZvRhiCAyXRQYKRtc+WNtC5S23Pb2+tBbuL29VSoY/L71nvPr9/s7v3N+5/zghGGrxlnoGXID3UAXcBYI6KYYsAhMA1NquD9zrAKEnqF24AbQZyCthBgwCtxWw/2/HUmA0DPkAwaBtwHHYcQakAM+BW6q4f5E1QKEnqEuYAQ4XSWxGcvA62q4f/rQAoSeodeAMUA8InkRSaBXDfff/UcB+s7vHSO5UcQVcyRKBOhnPsvRw14Jy0CnMSfsJofB/5Ac/b8HjR/2I6CX2s9UzHaNOodKs1flaa+doM8NaobE1haCuwHcfp7EVBY3Myg57e9E5IALxRI1kt2wIneh0OFZ43xgl1Cjg3qvl7a2szhdLiKRGBFFZmVlkssXX+bSGxdxukV+krN8fn+NL3+Q0cq1OHSud0E/Av2G6zN7ntLWue6+R2ddhIArjQ2or6+nvaMDh8OB0+Wi1u3G5/Px6/wCyWSS2hqB688FGbl5ibsfXMUvuqyi0Kdz7udAN6YbrjUo8qJzGifZkpUtLc8giiJerxe/308wGOR0KIQkSSR3UyW+ly808WFfi5WAgM65H/Jus8dbrz5LfKoZWZZLvufzKg0NDTQ2NpLL5XA5naTTaWx2O6JYV8Zkjz7Eo2VJ2bxmUzfwbTECZ8zWl9qf4v1bt3ihqwub7aBaI5EIgiAQbGqiubmZUChEa2srp0MhRM+BgL1MhuHhYcYnJvBpUasonDFGoKzBBH1u/H4/AwMDyLLM3Nwc8uoqqdQuX4+Pc/XaNSRJIpVKkUrtsrm+TjabRZZ/5/upKWZ+nGVjYwNN03Bh2RwDRgFlSO3lALDZbEiShCRJ5PN5tra2iEajzC8sUFNTQyaTYWN9nXgiQSKRYHtnh53tbdKpg3xQESrR7CdhzGx4+MS6gQmCgMfjwV1bSzKZJB6Ps6co5FSVStWftPmsPseMApbM1i8mV9Asirha7OEmwSkr06JRwJTZ+tWMzIPl+JEFLOXb0GzmGx8oTE8lAkqOIa/BOx/fJ63nQlXQqyaq+niktlp5xHTOggB9hhs1e808ivHmR99VL0LTiGbr+GbnPFpZvwNgtDg3Gq23KTSKEoSnVnnlvQl+eXy449A0eJDwMbZ2jkze8hrO6VwAB/WhzY9F7ed6JeB584q1WJo7E4ssytuItQIBjx01l0XZ20NRFBRFIbqjMPlYY2ReZPbPevLWOwe4o4b7Pyv++FcDSa3LTkugBrHGhpLNsbmd5Y+kVrEMDVjGNJCc+EhWFifdoVdfcJzkvVaTseVB6dPrFQohOyqWKey8bCKuKEAXMQ10Ap9gUR2HQE5f21npTQD/96eZhZDi47SbQj83Pk6XKNxuVT1OTxx/Ae6EqQ2eCrvRAAAAAElFTkSuQmCC)European Medicines Agency +4

SIMO_LATENCY
GxP_Integrity

---------------------------
