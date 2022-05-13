# Assignment 3

## Category
- EC2 Instance

```
Now our network is in place let's start setting up servers, only in availability zone A
    - Create server in Database subnet
        - Setup nginx in this server, it should run on 2 ports
            - 27017
                - Content would be hello from mongo
            - 3306
                - Content would be hello from MySQL
    - Create server in Middleware subnet
        - Setup nginx in this server, it should run on 3 ports
            - 9200
                - Content would be hello from ES
            - 6379
                - Content would be hello from redis
            - 9092
                - Content would be hello from kafka
    - Create server in Application subnet
        - Setup nginx in this server, it should run on 5 ports, but it will use the middleware & db subnets servers to get the required content
            - 8080
                - Content would be hello from mongo
            - 8081
                - Content would be hello from MySQL
            - 8082
                - Content would be hello from ES
            - 8083
                - Content would be hello from redis
            - 8084
                - Content would be hello from kafka
            - 8085
                - Content would be hello from Application Server
    - Create servers in public Subnet
        - It should support below URL
            - opstree.com
                - Content would be hello from frontend server
            - application.opstree.com
                - Content would be hello from application server  
            - mongo.opstree.com
                - Content would be hello from mongo server  
            - mysql.opstree.com
                - Content would be hello from MySQL server  
            - mysql.opstree.com
                - Content would be hello from ES server  
            - mysql.opstree.com
                - Content would be hello from redis server  
            - mysql.opstree.com
                - Content would be hello from kafka server  
```

## Expectation
- AWS Infra diagram
- Application Flow Diagram
- Complete setup on AWS

## How to validate

### prerequisite
- commands utils
    - awscli
    - bc
    - yq
    - toilet
    - lolcat
    - boxes

### Use below command to run

```
./validation.sh -a X.X.X.X -r ./<LOCATION/TO/RULE/YAML> -n "Ninja Name" -o <ORG>
```

### Example

```
./validation.sh -a 127.0.0.1 -r ./rules.yaml -n "Ravinder Singh" -o MyGurukulam
```


### OUTPUT

```
                                         /\             /\
                                        |`\\_,--="=--,_//`|
                                        \ ."  :'. .':  ". /
                                       ==)  _ :  '  : _  (==
                                         |>/O\   _   /O\<|
                                         | \-"~` _ `~"-/ |
                                        >|`===. \_/ .===`|<
                                  .-"-.   \==='  |  '===/   .-"-.
 .-------------------------------{'. '`}---\,  .-'-.  ,/---{.'. '}-------------------------------.
  )                              `"---"`     `~-===-~`     `"---"`                              (
 (                                                                                               )
  )         m    m          mmm                       #             ""#                         (
 (          ##  ## m   m  m"   " m   m   m mm  m   m  #   m  m   m    #     mmm   mmmmm          )
  )         # ## # "m m"  #   mm #   #   #"  " #   #  # m"   #   #    #    "   #  # # #         (
 (          # "" #  #m#   #    # #   #   #     #   #  #"#    #   #    #    m"""#  # # #          )
  )         #    #  "#     "mmm" "mm"#   #     "mm"#  #  "m  "mm"#    "mm  "mm"#  # # #         (
 (                  m"                                                                           )
  )                ""                                                                           (
 '-----------------------------------------------------------------------------------------------'

                              +-------------------------------+
                              | Abhyarthi:     Ravinder Singh |
                              +-------------------------------+

                        +--------------------------+----------+
                        | Address                  | Status   |
                        +--------------------------+----------+
                        | opstree.com              | Valid    |
                        | application.opstree.com  | Invalid  |
                        | mongo.opstree.com        | Invalid  |
                        | mysql.opstree.com        | Invalid  |
                        | es.opstree.com           | Invalid  |
                        | redis.opstree.com        | Invalid  |
                        | kafka.opstree.com        | Invalid  |
                        +--------------------------+----------+

```