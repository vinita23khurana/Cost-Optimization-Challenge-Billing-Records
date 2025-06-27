# 📦 Cost Optimization Challenge: Managing Billing Records in Azure Serverless Architecture
This project implements a cost-optimized, serverless architecture in Azure for managing billing records. It reduces Cosmos DB costs by tiering data into hot and cold storage, archiving rarely accessed records to Azure Blob Storage while maintaining API compatibility and availability.

/
 ├── main.tf
 ├── variables.tf
 ├── outputs.tf
 ├── modules/
 │   ├── cosmos/
 │   │   └── cosmos.tf
 │   ├── storage/
 │   │   └── blob.tf
 │   ├── function/
 │   │   └── function_app.tf
 └── README.md

## 📌 Problem Statement
Billing records are stored in Azure Cosmos DB.

Each record is up to 300 KB, and the system holds over 2 million records.

Records older than 90 days are rarely accessed but must remain available.

Cosmos DB costs have escalated due to storage and throughput needs.

# 🎯 Solution Overview
Hot Data (< 3 months): Stored in Cosmos DB.

Cold Data (> 3 months): Archived to Azure Blob Storage.

Read-through Azure Function: If data is missing in Cosmos DB, it fetches from Blob Storage seamlessly—no API changes.

Cosmos DB is configured with TTL = 90 days to auto-delete archived records.

# 🧱 Infrastructure (Provisioned via Terraform)
Azure Cosmos DB with TTL & throughput

Azure Blob Storage for archived billing records

Azure Function App (Python-based) with read-through fallback

Modular Terraform setup with reusable components

# 📁 Repository Structure
bash
Copy
Edit
.
├── main.tf                # Root Terraform file
├── modules/
│   ├── cosmos/            # Cosmos DB setup
│   ├── storage/           # Blob Storage setup
│   └── function/          # Azure Function App with fallback logic
├── function_code/         # Python code for read-through logic
├── diagrams/              # Architecture diagram
└── README.md              # This file
# 🧪 How It Works
Billing records are written to Cosmos DB as usual.

An Azure Data Factory (or Durable Function) job archives records older than 90 days to Blob Storage.

Cosmos DB automatically purges them using TTL.

On read, the API first checks Cosmos DB. If not found, it transparently fetches the record from Blob Storage.

# 🚀 Deployment
bash
Copy
Edit
# Initialize and deploy Terraform infrastructure
terraform init
terraform apply
After deployment, the Azure Function is ready to serve both hot and cold data paths.

Function code is deployed from function_code/ directory (via zip or Azure CLI).

✅ Solution Highlights
✅ No downtime

✅ No API contract changes

✅ Significant cost reduction

✅ Simple to deploy and maintain

# 📊 Architecture Diagram

# 🔐 Security & Extensions
Secure access using Managed Identities (optional).

Blob data can be compressed (e.g., GZip) or stored in Parquet for further cost reduction.

Integrate with Azure Monitor for audit and performance tracking.

# 🧩 Tools Used
Azure Cosmos DB

Azure Blob Storage

Azure Functions (Python)

Terraform (Infrastructure-as-Code)
