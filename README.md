# [![repo logo][]][Kicksware url]

<p align="center">
	<a href="https://kicksware.com">
		<img src="https://img.shields.io/website?label=Visit%20website&down_message=unavailable&up_color=teal&up_message=kicksware.com%20%7C%20online&url=https%3A%2F%2Fkicksware.com">
	</a>
</p>

[![commit activity badge]][repo commit activity]&nbsp;
[![kubernetes badge]](https://kubernetes.io)&nbsp;
[![gitlab badge]](https://ci.kicksware.com/kicksware/kicksware-gateway)&nbsp;
[![gateway pipeline]](https://ci.kicksware.com/kicksware/gateway/-/commits/master)&nbsp;
[![license badge]](https://www.gnu.org/licenses/agpl-3.0)

## Overview

_**Kicksware gateway**_ is a unified cloud-native networking solution that brings modern HTTP\TCP\UDP reverse proxy and load balancer together with Kubernetes ingress controller and Service Mesh  in one simply deployable and configurable project.

For the achievement of all the above goals it actually takes just one piece of software, but what an excellent one though - it's [**Træfik**][traefik] by [**Containous**][containous]!

## Usecase

For such complex, distributed, diverse microservice-based software infrastructure like Kicksware it's important to be able to route all traffic from the outside into the internal mesh of numerous microservices as well ensure their efficient inner communication.

Currently, Kicksware's networking profile has total of 18 subdomains. Almost all of them require a secure TLS connection using auto-signing certificates. However, manage system with this level of complexity isn't as hard as it seems with Traefik.

Reason for this is its _simplicity_ that is achieved by cleverly _hiding a great deal of complexity_. The same as Go (programming language on which its written) Traefik is made with intended simplicity in mind, therefor it's easy to use it. But to achieve this Traefik is actually [handles a lot hidden process][traefik features] from dynamically routing request to their target services, to auto-signing TLS certificates with an ACME provider (like Let’s Encrypt).

## Configuration

However, even such an autonomous program as Traefik needs to be configured to fit into the system it applied to.

Happily, it's not a hard thing to do, all its needed is to define both router endpoint rule and target server, but even this step can be omitted if proxy configuration is bonded directly to service definition, like in `docker-compose` service config or Kubernetes ingress route where only service name is required.

As will be described in further sections Kicksware can be deployed using docker-compose and K8s methods. For both of them Traefik provides efficient way to configure itself.

For [Docker][traefik docker], [Rancher][traefik rancher], and a [few more container orchestration platforms][traefik others] label-based configuration is available.
As for Kubernetes thare

As for Kubernetes, there're 2 methods of doing this:

1. By using a native [ingress controller][traefik ingress] with the [corresponding class][k8s ingress class].
2. Since version 1.16 of Kubernetes alternative and in fact, more flexible way was introduced with [`CustomResourceDefinitions (CRD)`][k8s crd]. Traefik defines its [own kind resources][traefik crd] to configure all three HTTP\TCP\UDP [ingressroutes][traefik ingress], middleware, services, and TLS options.

[![traefik browser][]][Kicksware url]

## Requirements

As designed Kicksware gateway solution must be deployed at the very beginning. Therefore, in every next deployment Traefik would be already there to dynamically process and expose newly created services.

## Deployment

Kicksware gateway can be deployed using following methods:

1. **Docker Compose file**

   This method require single dedicated server with installed both [`docker`][docker-compose] and [`docker-compose`][docker-compose] utilities.

   Compose [configuration file][compose config] can be found in root of the project. This file already contains setting for reverse proxy routing and load balancing.

   Gitlab CI deployment pipeline [configuration file][ci compose config] for compose method can be found in `.gitlab` directory.

2. **Kubernetes Helm charts**

   Deployment to Kubernetes cluster is the default and desired way.

   For more flexible and easier deployment [Helm package manager][helm] is used. It provides a simple, yet elegant way to write pre-configured, reusable Kubernetes resources configuration using YAML and Go Templates (or Lua scripts). Helm packages are called `charts`.

   Traefik ingress [deployment chart][helm chart] directory can be found in root of the project.

   Helm chart configuration already contains configuration of [Traefik IngressRoute][traefik ingressroute] [Custom Resource Definition (CRD)][k8s crd] for reverse proxy routing and load balancing.

   Gitlab CI deployment pipeline [configuration file][ci k8s config] for K8s method can be found in the root of the project.

## Wrap Up

So if you're enjoying reading about Traefik implementation in the Kicksware system, consider leaving a star on it's GitHub repository, and while you there do the same to this repo if you please.

## License

Licensed under the [GNU AGPL-3.0][license file].

[repo logo]: https://ci.kicksware.com/kicksware/gateway/-/raw/master/assets/repo-logo.png
[kicksware url]: https://kicksware.com

[Website badge]: https://img.shields.io/website?label=Visit%20website&down_message=unavailable&up_color=teal&up_message=kicksware.com%20%7C%20online&url=https%3A%2F%2Fkicksware.com
[commit activity badge]: https://img.shields.io/github/commit-activity/m/timoth-y/kicksware-gateway?label=Commit%20activity&color=teal
[repo commit activity]: https://github.com/timoth-y/kicksware-gateway/graphs/commit-activity
[lines counter]: https://img.shields.io/tokei/lines/github/timoth-y/kicksware-gateway?color=teal&label=Lines
[license badge]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg?color=teal
[kubernetes badge]: https://img.shields.io/badge/DevOps-Kubernetes-informational?style=flat&logo=kubernetes&logoColor=white&color=316DE6
[gitlab badge]: https://img.shields.io/badge/CI-Gitlab_CE-informational?style=flat&logo=gitlab&logoColor=white&color=FCA326
[gateway pipeline]: https://ci.kicksware.com/kicksware/gateway/badges/master/pipeline.svg?key_text=Gateway%20|%20pipeline&key_width=115

[traefik]: https://traefik.io/traefik
[containous]: https://traefik.io/about-us
[traefik features]: https://github.com/traefik/traefik#Features

[docker-desktop]: https://docs.docker.com/desktop/
[docker-compose]: https://docs.docker.com/compose/
[compose config]: https://github.com/timoth-y/kicksware-gateway/blob/master/docker-compose.yml
[ci compose config]: https://github.com/timoth-y/kicksware-gateway/blob/master/.gitlab/.gitlab-ci.compose.yml
[ci k8s config]: https://github.com/timoth-y/kicksware-gateway/blob/master/.gitlab-ci.yml

[traefik docker]: https://docs.traefik.io/providers/docker
[traefik rancher]: https://docs.traefik.io/providers/rancher
[traefik others]: https://docs.traefik.io/providers/overview/

[traefik browser]: https://ci.kicksware.com/kicksware/gateway/-/raw/master/assets/traefik-browser.png

[k8s crd]: https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/
[k8s ingress class]: https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/
[traefik ingress]: https://docs.traefik.io/providers/kubernetes-ingress/
[traefik crd]: https://docs.traefik.io/reference/dynamic-configuration/kubernetes-crd/
[traefik ingressroute]: https://docs.traefik.io/providers/kubernetes-crd/

[helm]: https://helm.sh/
[helm chart]: https://github.com/timoth-y/kicksware-gateway/tree/master/webapp-chart

[license file]: https://github.com/timoth-y/kicksware-gateway/blob/master/LICENSE
