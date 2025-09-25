```mermaid

flowchart TD
    A[Developer] --> B[Push ApplicationSet YAML to Git]
    B --> C[GitHub Webhook Triggers Refresh]
    C --> D[ArgoCD API Server (Receives Sync Request)]
    
    D --> E[ApplicationSet Controller Watches ApplicationSet CRDs]
    
    subgraph E[ApplicationSet Controller Workflow]
        E1[Reads ApplicationSet Spec] --> E2[Executes Generators: Git/Cluster/List/Matrix]
        E2 --> E3[Applies Template]
        E3 --> E4[Creates/Updates Application CRs]
    end
    
    E4 --> F[Application CR: Cluster dev, Namespace app-dev]
    E4 --> G[Application CR: Cluster staging, Namespace app-staging]
    E4 --> H[Application CR: Cluster prod, Namespace app-prod]
    
    F --> I[Application Controller: Sync Engine & Reconciler]
    G --> I
    H --> I
    
    I --> J[Repo Server Fetches & Renders Manifests]
    K[Application Manifests Git Repository] --> J
    
    J --> L[Generates Kubernetes Manifests: Kustomize/Helm/YAML]
    L --> M[Compares Desired vs Actual State]
    
    M --> N[Target Cluster API: Development]
    M --> O[Target Cluster API: Staging]
    M --> P[Target Cluster API: Production]
    
    N --> Q[Deployed: app-dev Status Synced]
    O --> R[Deployed: app-staging Status Synced]
    P --> S[Deployed: app-prod Status Synced]
    
    D --> T[Notification Controller]
    T --> U[Email Alerts]
    T --> V[Slack Notifications]
    
    classDef dev fill:#1e3a1e,stroke:#4CAF50,stroke-width:2px,color:#fff
    classDef staging fill:#3a2e1e,stroke:#FF9800,stroke-width:2px,color:#fff
    classDef prod fill:#3a1e1e,stroke:#F44336,stroke-width:2px,color:#fff
    classDef argo fill:#2d2d2d,stroke:#fff,stroke-width:2px,color:#fff
    classDef git fill:#24292e,stroke:#fff,stroke-width:2px,color:#fff
    
    class F,N,Q dev
    class G,O,R staging
    class H,P,S prod
    class D,E,I,J,T argo
    class B,C,K git


```
