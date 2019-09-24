docker build -f Dockerfile \
	-t luis/solargraph:shell \
	-t luis/solargraph:latest \
	-t luis/solargraph:$(git rev-parse --short HEAD) \
	.
#docker push luis/solargraph:latest
#docker push luis/solargraph:$(git rev-parse --short HEAD)
