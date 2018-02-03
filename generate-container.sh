#!/bin/bash -x

if [[ ! -e ${0%%/*}/generate-environment ]]; then
    echo ${0%%/*}/generate-environment not found
    exit 1
fi

function timestamp
{
    date +%Y.%m.%d.%H.%M.%s
}
. ${0%%/*}/generate-environment

timestamp
mkdir -p ${0%%/*}/appl
cp ${0%%/*}/bin/${APPL} ${0%%/*}/appl/
applytmpl < template.Dockerfile.tmpl       > appl/Dockerfile
applytmpl < template.service.tmpl          > appl/${APPL}.service
applytmpl < template.service-setup.tmpl    > appl/${APPL}-setup.service
applytmpl < template-start.sh.tmpl         > appl/${APPL}-start.sh
applytmpl < template.journal.service.tmpl  > appl/journal.service
applytmpl < template-setup.sh.tmpl         > appl/${APPL}-setup.sh
applytmpl < template.environment.tmpl      > appl/${APPL}.environment
applytmpl < template.deployment.yaml.tmpl  > appl/${APPL}-deployment.yaml
applytmpl < template.entrypoint.sh.tmpl    > appl/entrypoint.sh

timestamp
cd appl
echo docker build --no-cache --force-rm --rm --tag ${DOCKER_USER}/${IMAGE} .
docker build --no-cache --force-rm --rm --tag ${DOCKER_USER}/${IMAGE} .
docker push ${DOCKER_USER}/${IMAGE}
timestamp
