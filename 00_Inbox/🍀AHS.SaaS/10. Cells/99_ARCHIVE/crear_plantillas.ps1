# 1. Definir rutas
$vaultPath = "C:\Users\armando\Documents\_AHS\vaults\AHS_Ecosystem_Hub"
$templatePath = "$vaultPath\.templates"

if (-not (Test-Path $templatePath)) { 
    New-Item -Path $templatePath -ItemType Directory -Force | Out-Null 
}

# 2. CONTENIDO DE PLANTILLA BC (Usando un array de strings para evitar errores de terminador)
$bcContent = @(
'---',
'type: Bounded Context',
'domain: {{folderName}}',
'status: discovery',
'tech_stack: [.NET 10, C# 14, Native AOT]',
'infrastructure: Azure Container Apps',
'---',
'# 🧩 Contexto: {{title}}',
'',
'## 📖 Definición (Lenguaje Ubicuo)',
'- **Término Clave**: Definición técnica/negocio.',
'',
'## ⚖️ Reglas de Dominio (Business Logic)',
'> Reglas críticas para este contexto (ej. umbrales de temperatura, criticidad de riesgo).',
'1. ',
'2. ',
'',
'## 🏗️ Implementación Técnica (.NET 10)',
'- **Namespace**: AHS.Logistics.{{title}}',
'- **AOT Check**: [ ] Source Generators configurados.',
'- **Data Persistence**: Azure SQL / Cosmos DB.',
'',
'## 🔗 Referencias Core',
'- [[00_CORE/AOT_Patterns/Serialization_Context|Source Gen Serialization]]',
'- [[00_CORE/Azure_Architecture/Connectivity_Standards|Estándares Azure]]',
'',
'## 📝 Notas de Desarrollo'
)

# 3. CONTENIDO DE PLANTILLA CORE
$coreContent = @(
'---',
'type: Core Pattern',
'area: Shared Infrastructure',
'compatibility: .NET 10 AOT',
'---',
'# 💎 Core Pattern: {{title}}',
'',
'## 🎯 Propósito',
'¿Por qué este patrón es compartido entre Logística, Medical y Shopify?',
'',
'## 🚀 Código AOT-Friendly (C# 14)',
'```csharp',
'// Implementación optimizada',
'```',
'',
'## 🌍 Dependencias de Suites',
'- [[01_DOMAIN_MICRO-SAAS/Logistics_Suite/BC_predictive-risk|Predictive Risk]]',
'- [[01_DOMAIN_MICRO-SAAS/Logistics_Suite/BC_temp-excursions|Temp Excursions]]',
'- [[01_DOMAIN_MICRO-SAAS/Logistics_Suite/BC_warehouse|Warehouse]]'
)

# 4. GUARDAR ARCHIVOS
$bcContent | Out-File -FilePath "$templatePath\T_BoundedContext.md" -Encoding utf8
$coreContent | Out-File -FilePath "$templatePath\T_CorePattern.md" -Encoding utf8

Write-Host "`n✅ ¡Felicidades Armando! Plantillas creadas sin errores de sintaxis." -ForegroundColor Green