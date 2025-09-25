```mermaid

flowchart TD
    %% Developer section
    subgraph DEV [Developer]
        A[Developer] --> B[Push ApplicationSet YAML to Git]
    end

    %% Git/GitHub section
    subgraph GIT [Git / Webhook]
        B --> C[GitHub Webhook Trigger]
        C --> D[ArgoCD Repo Server refreshes Git]
    end

    %% ApplicationSet Controller section
    subgraph ASC [ApplicationSet Controller]
        E[Watches ApplicationSet CRs independently] 
        E --> F[Detect Git changes via Repo Server (indirect)]
        F --> G[Read ApplicationSet Spec]
        G --> H[Execute Generators (Git/Cluster/List/Matrix)]
        H --> I[Apply Template]
        I --> J[Create or Update Application CRs]
    end

    %% Generated Application CRs
    subgraph APP_CR [Generated Applications]
        J --> K[Application CR: dev]
        J --> L[Application CR: staging]
        J --> M[Application CR: prod]
    end

    %% Application Controller section
    subgraph AC [Application Controller]
        N[Watches Application CRs independently]
        K --> N
        L --> N
        M --> N
        N --> O[Detect new/updated Applications]
        O --> P[Fetch and Render Manifests (Repo Server)]
        Q[Git Repository with Manifests] --> P
        P --> R[Compare Desired vs Actual State]
    end

    %% Cluster deployment section
    subgraph CLUSTERS [Target Clusters]
        R --> S[Deploy to Dev Cluster]
        R --> T[Deploy to Staging Cluster]
        R --> U[Deploy to Prod Cluster]

        S --> V[app-dev deployed / Synced]
        T --> W[app-staging deployed / Synced]
        U --> X[app-prod deployed / Synced]
    end

    %% Notification Controller section
    subgraph NOTIF [Notification Controller]
        Y[Watches Application events independently]
        V --> Y
        W --> Y
        X --> Y
        Y --> Z[Send Email or Slack Alerts]
    end


```
