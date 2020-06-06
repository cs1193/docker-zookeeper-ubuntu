build-zookeeper-images:
		docker build --build-arg base_image=cs1193/adoptopenjdk-8 -t cs1193/zookeeper-base -f ./images/zookeeper/zookeeper.Dockerfile .
