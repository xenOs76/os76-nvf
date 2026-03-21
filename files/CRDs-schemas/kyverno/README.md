# Kyverno CRDS schemas

- [Kyverno CRDs](https://github.com/kyverno/kyverno/tree/main/config/crds)
- [openapi2jsonschema.py](https://github.com/yannh/kubeconform/blob/master/scripts/openapi2jsonschema.py)
- [Generate JSON Schema from Kubernetes CRD OpenAPI](https://hashbang0.com/2023/04/28/generate-json-schema-from-kubernetes-crd-openapi/)

Create schemas, sample command:

```bash
❯ python ~/.openapi2jsonschema.py https://raw.githubusercontent.com/kyverno/kyverno/refs/heads/main/config/crds/kyverno/kyverno.io_policies.yaml
JSON schema written to policy_v1.json
JSON schema written to policy_v2beta1.json
```
