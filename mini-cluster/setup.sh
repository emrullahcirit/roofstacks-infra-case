#!/bin/bash

_print() {
    echo "===== $@"
}

_fail() {
    echo -e "\nERROR: $@\n"
    exit 1
}

_kubectl_apply() {
    kubectl apply -f $@
}

create_namespace() {
    _print "Namespace Creating"
    kubectl create ns roofstacks-sample ||  _fail "Namespace creation failed"
    _print "Namespace Created"

}

deployment() {
    _print "Deployment Started"
    _kubectl_apply ./infra/deployment.yaml || _fail "Deployment Failed"
    _print "Deployment Completed Successfully"
}

service() {
    _print "Service Creating"
    _kubectl_apply ./infra/service.yaml || _fail "Service Failed"
    _print "Service Created Successfully"
}

backend_config() {
    _print "Backend Config Creating"
    _kubectl_apply ./infra/backend-config.yaml || _fail "Backend Config Failed"
    _print "Backend Config Created Successfully"
}

ingress() {
    _print "Ingress Creating"
    _kubectl_apply ./infra/ingress.yaml || _fail "Ingress Failed"
    _print "Ingress Created Successfully"
}

main() {
    create_namespace
    deployment
    backend_config
    service
    ingress
}

main
