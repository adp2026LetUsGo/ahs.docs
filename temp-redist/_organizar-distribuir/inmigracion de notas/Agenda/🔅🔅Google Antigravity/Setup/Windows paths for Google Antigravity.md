In 2026, the full Windows paths for **Google Antigravity** configuration depend on your specific user profile. Below are the standard paths where these folders are located.

**1. Global Policy & Guardrail Paths**

These affect the agent across every project. Replace `Armando` with your Windows account name.

- **Global Rules File:** `C:\Users\Armando\.gemini\GEMINI.md`
- **Global Configuration Root:** `C:\Users\Armando\.gemini\antigravity\`
- **Global Workflows Directory:** `C:\Users\Armando\.gemini\antigravity\global_workflows\`
- **MCP Security Configuration:** `C:\Users\Armando\.gemini\antigravity\mcp_config.json` 

**2. Workspace-Specific Paths**

These are relative to the root directory of an individual coding project. For a project at `C:\Projects\MyApps\`, the paths would be:

- **Workspace Rules Folder:** `C:\Projects\MyApps\.agent\rules\`
- **Workspace Workflows Folder:** `C:\Projects\MyApps\.agent\workflows\`
- **Workspace Context/Docs:** `C:\Projects\MyApps\.agent\context\` or `C:\Projects\MyApps\.docs\` 

**3. Application & Sandboxing Paths**

- **Default Install Directory:** `C:\Program Files\Antigravity` (Recommended for stability on Windows)
- **Agent Scratch/Temp Directory:** `C:\Users\Armando\.gemini\antigravity\scratch` (A safe zone with full read/write permissions by default) 

**Key Tips for Windows Users**

- **Path Precision:** When using **WSL2** for the development environment, the agent may prefer paths relative to the Linux home directory (e.g., `\\wsl.localhost\Ubuntu\home\user\.gemini\`).
- **Visibility:** Folders starting with a dot (like `.gemini` or `.agent`) are often hidden in Windows File Explorer. Enable "Hidden items" in the View tab to see them.
- **Exclusion:** Ensure the antivirus does not block the `.gemini\antigravity\scratch` folder, as this can cause the agent to fail during automated code generation.