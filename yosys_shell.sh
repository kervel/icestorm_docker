docker build -t ice40 yosys_docker
docker run -it --rm -v $PWD/data:/data ice40
