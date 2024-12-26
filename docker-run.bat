@echo off
echo Stopping and removing any existing container...
docker stop strapi-local
docker rm strapi-local

echo Running a new container from the strapi-dev image...
docker run -it ^
  --detach ^
  --name strapi-local ^
  --expose 1337 ^
  strapi-dev

echo Showing logs for the container...
docker logs --tail 10 -f strapi-local
