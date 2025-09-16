# azure-k8s-devsecops
AZURE DEVSECOPS IMPLEMENTATION


terraform plan -var-file="azure.tfvars"

terraform apply -var-file="azure.tfvars"

terraform apply -var-file="azure.tfvars" -auto-approve

terraform destroy -var-file="azure.tfvars"
terraform destroy -var-file="azure.tfvars" -auto-approve

terraform plan -out=plan.out

**workflow with `terraform plan -out`** 

This affords the opportunity to validate a plan without immediately applying it, and then apply/destroy in a controlled way:

---

### 1. Initialize (only needed first time / after provider changes)

```bash
terraform init
```

---

### 2. Create a saved execution plan (no changes applied yet)

```bash
terraform plan -var-file="azure.tfvars" -out=plan.out
```

* This will generate a binary plan file called `plan.out`.
* Nothing is created or destroyed yet.
* You can safely review the proposed changes.

---

### 3. Apply the saved plan

```bash
terraform apply plan.out
```

* This ensures you’re applying exactly what you reviewed.
* Prevents “drift” if variables or files change between plan and apply.

---

### 4. Destroy resources safely

You can also save a destroy plan first:

```bash
terraform plan -destroy -var-file="azure.tfvars" -out=destroy.out
```

Then apply it:

```bash
terraform apply destroy.out
```

---

✅ This pattern is especially useful in **production or CI/CD pipelines**, where you want to approve a reviewed plan before execution.

ssh -i ~/.ssh/laredo_id_rsa devsecops@172.166.111.25
