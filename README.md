---
#### kubernetes test configure package

`github.com/davidwalter0/kubernetes-systemd-base-test`

The rationale for this repo has two parts

- test systemd use in kubernetes applications
- make the logs visible for kubernetes logs command when run via
  systemd services


This includes a minimal amd64 golang binary, bin/echo

This uses a text template tool `github.com/davidwalter0/applytmpl` and
the kubernetes service assumes a loadbalancer in the service
definition setup like `github.com/davidwalter0/loadbalancer` which
works for running in a private dev vagrant setup or similar
configuration.

```
go get -u github.com/davidwalter0/applytmpl
git clone github.com/davidwalter0/k8s-systemd-base-example
cd k8s-systemd-base-example
```

Update the configuration file generate-environment.example and or
export the environment variables in the generate-environment
configuration script Update *MAINTAINER*, *MAINTAINER_EMAIL* and
*DOCKER_USER* Then run

```
./generate-container.sh
```

After configuring kubernetes you should be able to run

```
. generate-environment # set the APPL env variable
kubectl apply -f appl/${APPL}-deployment.yaml
```

