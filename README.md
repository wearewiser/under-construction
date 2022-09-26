# Under Construction

Placeholder web page for websites under construction.

## Running Locally

### From Code

```bash
git clone github.com/wearewiser/under-construction
docker build -t example:1.0.0 .
docker run -it --name example --rm -p 3000:3000 example:1.0.0
```
> **Note**
>
> Requires NPM/NPX installed on your local machine.

### Docker

```bash
docker run -dit -p 8080:80 gcr.io/wiser-mainframe/under-construction:1.0.0
```
> **Note**
>
> Requires Docker Desktop installed on your local machine.

or, you can run by creating a deployment with the image specified:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
  labels:
    run: example
  name: example
  namespace: default
spec:
  selector:
    matchLabels:
      run: example
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        run: example
    spec:
      containers:
      - image: gcr.io/wiser-mainframe/under-construction:1.0.0
        imagePullPolicy: Always
        name: example
        ports:
        - containerPort: 80
          protocol: TCP
        resources:
          limits:
            cpu: 20m
            memory: 64Mi
          requests:
            cpu: 10m
            memory: 32Mi
```
