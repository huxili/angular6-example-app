#
# Make file for building docker image. Install GnuMake for Windows 
# to build under Windows.
#  
# By Huxi LI, 2017, Paris
#
# Make: 
#      $ make [-e GROUP=GroupName]  
#
# ___________________
GROUP = $(USER)

ifdef $(GROUP)
  	NAME = $(GROUP)/angular6
else 
	NAME = huxili/angular6
endif


build: build-image-with-cache
dev: dev-image-with-cache
build-nocache: build-image-no-cache
start: run-test-image
starti: run-test-image-interactive
rm: remove-test-container
sh: run-container-shell
log: container-logs

build-image-no-cache:
	docker build --no-cache=true -t $(NAME) .
build-image-with-cache:
	docker build -t $(NAME) .
dev-image-with-cache:
	docker build --target builder -t "$(NAME):dev" .
run-test-image: 
	docker rm -f angular6-example1-test 2>/dev/null || true 
	docker run -it -d --rm -p 80:80 --name angular6-example1-test "$(NAME)"
run-test-image-interactive: 
	docker rm -f angular6-example1-test 2>/dev/null || true 
	docker run -it --rm -p 80:80 --name angular6-example1-test "$(NAME)"
remove-test-container:
	docker rm -f angular6-example1-test
run-container-shell:
	docker rm -f angular6-example1-test /bin/sh
container-logs:
	docker logs angular6-example1-test
