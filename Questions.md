# ArgoCD ApplicationSets Interview Questions

A comprehensive collection of interview questions covering ArgoCD ApplicationSets from basic concepts to expert-level architectural design patterns.

## Easy (Fundamental & Basic)
These questions test basic understanding of what ApplicationSets are and why they are used.

1. **Conceptual:** What is the core problem that ArgoCD ApplicationSets solve?

2. **Conceptual:** How does an ApplicationSet differ from a standard ArgoCD Application?

3. **Conceptual:** Explain ApplicationSets in your own words.

4. **Terminology:** What are the two main components of an ApplicationSet YAML manifest?

5. **Terminology:** What is a generator in the context of ApplicationSets?

6. **Terminology:** What is the purpose of the template field?

7. **Basic Usage:** What is the simplest type of generator, and what is its use case?

8. **Basic Usage:** How does ArgoCD know when to create/update Applications from an ApplicationSet?

9. **Setup:** What must be enabled in the ArgoCD installation for ApplicationSets to work?

10. **Setup:** What Kubernetes resource kind is an ApplicationSet? (argoproj.io/v1alpha1)

## Medium (Practical Implementation & Configuration)
These questions test the ability to configure, use, and troubleshoot common ApplicationSet patterns.

1. **Generators:** Describe the purpose and a use case for the List generator.

2. **Generators:** Describe the purpose and a use case for the Git generator.

3. **Generators:** What does the path.basename variable refer to in a Git generator?

4. **Generators:** How would you use a Cluster generator to deploy an application to all clusters labeled with env: prod?

5. **Generators:** What is the primary advantage of using a Matrix generator over multiple separate ApplicationSets?

6. **Template Syntax:** In the template, what will the application name be if you use name: 'app-{{cluster}}-{{path.basename}}' and the generators provide cluster: us-west and path: apps/nginx?

7. **Sync & Policy:** What does adding syncPolicy: { automated: { selfHeal: true } } do in the ApplicationSet template?

8. **Sync & Policy:** What is the effect of including the CreateNamespace=true sync option in the template?

9. **Project Structure:** Your Git repo has directories for 10 microservices. How would you structure an ApplicationSet to deploy all of them to a staging namespace?

10. **Troubleshooting:** You create an ApplicationSet, but no child Applications appear in the ArgoCD UI. What are the first two things you would check?

11. **Troubleshooting:** An Application is created but is stuck in a Missing or Unknown health state. What is a likely cause?

12. **Best Practices:** Why is it a bad idea to store secrets directly in the manifests managed by a Git generator?

## Advanced (Complex Patterns, Security, & Optimization)
These questions test deep architectural knowledge, security considerations, and the ability to design complex deployments.

1. **Advanced Generators:** How would you use the SCM Provider generator to automatically create preview environments for every open GitHub Pull Request in a repository?

2. **Advanced Generators:** Describe a scenario where you would use a Pull Request generator instead of an SCM Provider generator.

3. **Matrix Complexity:** What is a potential downside of using a Matrix generator that combines a large Git generator (50 apps) with a large Cluster generator (10 clusters)? How would you mitigate this risk?

4. **Strategy & Architecture:** You need to deploy a core set of "platform" apps (e.g., monitoring, logging) to every cluster, and a set of "business" apps only to specific clusters. Would you use one ApplicationSet or multiple? Justify your design.

5. **Strategy & Architecture:** How can you manage different configurations (e.g., values.yaml for Helm) for the same application across different environments (dev, staging, prod) using ApplicationSets?

6. **Security & RBAC:** How do you restrict which teams or users can create or modify ApplicationSet resources in a multi-tenant ArgoCD setup?

7. **Security & RBAC:** Your ApplicationSet needs to deploy to a private Git repository. How do you provide the credentials securely?

8. **Performance:** What happens if the Git repository configured in a Git generator becomes unreachable for an extended period? How does the ApplicationSet controller behave?

9. **Customization:** How can you use the values field in a generator (like List) to dynamically set Helm values or Kustomize parameters in the template?

10. **GitOps Flow:** In a perfect GitOps workflow, does a CI pipeline push deployments to the cluster or does it update the Git source for the ApplicationSet to pull from? Explain the difference and the security implication.

11. **Debugging:** A developer reports that their Application is constantly being reverted by ArgoCD. You discover they have been using kubectl edit to change things quickly. How do you explain the problem and what is the correct solution?

12. **Alternative Patterns:** When might you choose to use the traditional "App-of-Apps" pattern over an ApplicationSet? What are the limitations of that choice?

## Expert-Level (Design & Deep Dive)
These are open-ended design questions that involve combining multiple concepts and justifying architectural decisions.

1. **Design Challenge:** Design an ApplicationSet setup for a company with 3 environments (dev, staging, prod), 2 regions (us, eu), and 20 microservices. The prod environment requires manual approval via a PR to a different Git repo before deploying. How do you structure your generators and repos?

2. **Design Challenge:** How would you implement a canary deployment strategy using Argo Rollouts, where the canary and baseline versions are managed dynamically via an ApplicationSet?

3. **Deep Dive:** Explain the reconciliation loop of the ApplicationSet controller. What is the sequence of events from when a new commit is made to a watched Git repo to when a new Application is synced?

4. **Deep Dive:** How does the ApplicationSet controller avoid performance issues or API throttling when managing hundreds or thousands of generated Applications?

5. **Beyond Kubernetes:** ApplicationSets primarily generate ArgoCD Applications, which deploy to Kubernetes. How could you leverage the pattern to provision cloud resources (e.g., in AWS) using a tool like Terraform or Crossplane?

6. **Future Evolution:** What are some limitations of the current ApplicationSet design, and what features would you propose for a future version?

---

## Contributing

Feel free to contribute additional questions or improvements to existing ones via pull requests.

## License

This collection is available under MIT License.
