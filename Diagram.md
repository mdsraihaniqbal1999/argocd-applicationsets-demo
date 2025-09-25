```mermaid

flowchart TD
     Developer/User pushes ApplicationSet YAML
    A[Developer] --> B[Push ApplicationSet YAML to Git]
    B --> C[GitHub Webhook<br/>Triggers Refresh]
    C --> D[ArgoCD API Server<br/>(Receives Sync Request)]
    
    %% ApplicationSet Controller workflow
    D --> E[ApplicationSet Controller<br/>Watches ApplicationSet CRDs]
    
    subgraph E[ApplicationSet Controller Workflow]
        E1[Reads ApplicationSet Spec] --> E2[Executes Generators<br/>Git/Cluster/List/Matrix]
        E2 --> E3[Applies Template]
        E3 --> E4[Creates/Updates Application CRs]
    end
    
    E4 --> F[Application CR<br/>Cluster: dev, Namespace: app-dev]
    E4 --> G[Application CR<br/>Cluster: staging, Namespace: app-staging]
    E4 --> H[Application CR<br/>Cluster: prod, Namespace: app-prod]
    
    %% Application Controller reconciliation
    F --> I[Application Controller<br/>Sync Engine & Reconciler]
    G --> I
    H --> I
    
    I --> J[Repo Server<br/>Fetches & Renders Manifests]
    K[Application Manifests<br/>Git Repository] --> J
    
    J --> L[Generates Kubernetes Manifests<br/>Kustomize/Helm/YAML]
    L --> M[Compares Desired vs Actual State]
    
    %% Manifests applied to target clusters
    M --> N[Target Cluster API<br/>Development]
    M --> O[Target Cluster API<br/>Staging]
    M --> P[Target Cluster API<br/>Production]
    
    N --> Q[Deployed: app-dev<br/>Status: Synced]
    O --> R[Deployed: app-staging<br/>Status: Synced]
    P --> S[Deployed: app-prod<br/>Status: Synced]
    
    %% Notifications
    D --> T[Notification Controller]
    T --> U[Email Alerts]
    T --> V[Slack Notifications]
    
    %% Styling with color-coded environments
    classDef dev fill:#1e3a1e,stroke:#4CAF50,stroke-width:2px,color:#fff
    classDef staging fill:#3a2e1e,stroke:#FF9800,stroke-width:2px,color:#fff
    classDef prod fill:#3a1e1e,stroke:#F44336,stroke-width:2px,color:#fff
    classDef argo fill:#2d2d2d,stroke:#fff,stroke-width:2px,color:#fff
    classDef git fill:#24292e,stroke:#fff,stroke-width:2px,color:#fff
    
    %% Apply styles
    class F,N,Q dev
    class G,O,R staging
    class H,P,S prod
    class D,E,I,J,T argo
    class B,C,K git


```
