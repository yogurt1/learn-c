SRC = $(patsubst src/%,%,$(wildcard src/*.c))
OBJ = $(patsubst %,obj/%,$(SRC:.c=.o))
DEPS = $(patsubst %,obj/%,$(SRC:.c=.d))
BIN = app
#CC = gcc --std=c11
CC = gcc --std=c11
LD = ld
#CFLAGS += -Wall -Wextra -g -pipe -Wpedantic -Werror
CFLAGS += -Wall -g -pipe 
#LDFLAGS +=
DEPFLAGS = -MT $@ -MMD -MP -MF obj/$*.Td

vpath %.c src
vpath %.h src
vpath %.d obj
vpath %.o obj

all: build
build: $(BIN)
watch:
	@(watch make build run -s)
clean:
	@rm -f $(OBJ) $(DEPS) $(BIN) *~ core
run: build
	@./$(BIN)

$(BIN): $(OBJ)
	@$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $^

obj/%.o: %.c
obj/%.o: %.c obj/%.d
	@$(CC) $(DEPFLAGS) $(CFLAGS) -c $< -o $@
	@mv -f obj/$*.Td obj/$*.d

obj/%.d: ;
.PRECIOUS: obj/%.d
#	@$(CC) -MM -MP $< > $@
#depend: $(DEPS)

-include $(DEPS)
.PHONY: all test build clean watch depend
