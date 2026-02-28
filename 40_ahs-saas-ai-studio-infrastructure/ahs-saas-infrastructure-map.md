# 🗺️ AHS.SaaS Infrastructure Map

## 📂 Google Cloud Projects (GCP)
| Project ID           | Purpose                                       | Number    | Status         |
| :------------------- | :-------------------------------------------- | :-------- | :------------- |
| `ahs-pharma-suite`   | Vertical: Pharma industry logic & data.       | 257128... | Active         |
| `ahs-saas-ml-engine` | Horizontal: Machine Learning & ONNX services. | (TBD)     | Initialization |

## 🔑 API Keys (AI Studio)
| Key Name             | Project Linked       | Usage                         | Env |
| :------------------- | :------------------- | :---------------------------- | :-- |
| `Pharma-Gateway-Key` | `ahs-pharma-suite`   | Backend API communication.    | Dev |
| `ML-Training-Key`    | `ahs-saas-ml-engine` | Model training & ONNX export. | Dev |

## 🌐 Endpoints (Local)
- **Gateway API:** `http://localhost:5000`
- **Bento UI:** `http://localhost:5120`