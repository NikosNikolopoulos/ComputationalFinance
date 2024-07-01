cd ..

docker build -t jupyter-app -f docker/Dockerfile .

docker run -p 8080:8080 jupyter-app