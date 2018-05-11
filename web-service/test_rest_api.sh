#!/bin/bash

config_server='{"id":"cloud-config-server","port":"9999"}'
eureka_server='{"id":"cloud-eureka-server","port":"8761"}'
hystrix_dashboard='{"id":"cloud-hystrix-dashboard","port":"8080"}'
service_gateway='{"id":"cloud-gateway","port":"8888"}'

curl -X PUT -H "Content-Type: application/json" -d $config_server http://localhost:8080/services/
curl -X PUT -H "Content-Type: application/json" -d $eureka_server http://localhost:8080/services/
curl -X PUT -H "Content-Type: application/json" -d $hystrix_dashboard http://localhost:8080/services/
curl -X PUT -H "Content-Type: application/json" -d $service_gateway http://localhost:8080/services/

curl -X PUT -H "Content-Type: application/json" -d "{\"id\":\"config-to-eureka\",
                                                     \"name\":\"get-eureka-config\",
                                                     \"serviceFrom\":$config_server,
                                                     \"serviceTo\":$eureka_server}" http://localhost:8080/dataflow/
curl -X PUT -H "Content-Type: application/json" -d "{\"id\":\"config-to-hystrix\",
                                                     \"name\":\"get-hystrix-config\",
                                                     \"serviceFrom\":$config_server,
                                                     \"serviceTo\":$hystrix_dashboard}" http://localhost:8080/dataflow/
curl -X PUT -H "Content-Type: application/json" -d "{\"id\":\"config-to-gateway\",
                                                     \"name\":\"get-gateway-config\",
                                                     \"serviceFrom\":$config_server,
                                                     \"serviceTo\":$service_gateway}" http://localhost:8080/dataflow/
