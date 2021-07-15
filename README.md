
# How to build image
```
## build docker image
image_name="itri-go/scipy-notebook:latest"
docker build -t "$image_name" .
```
# Run Container 
### run as deamon 
```
container_name="scipy-notebook-01"
image_name="itri-go/scipy-notebook:latest"
docker run -d --name ${container_name} \
    -v "${PWD}":/home/jovyan/work  \
    -p 8888:8888 \
    -e GRANT_SUDO=yes --user root \
    ${image_name} 
```