# My third makefile

# Name of the project
PROJ_NAME=./bin/printy

# .c files
C_SOURCE=$(wildcard ./source/*.c)

# .h files
H_SOURCE=$(wildcard ./source/*.h)

# Object files
OBJ=$(subst .c,.o,$(subst source,objects,$(C_SOURCE)))

# Compiler and linker
CC=clang

# Flags for compiler
CC_FLAGS=-c         \
         -W         \
         -Wall      \
         -ansi      \
         -pedantic

# Command used at clean target
RM = rm -rf

#
# Compilation and linking
#
all: objFolder $(PROJ_NAME)

$(PROJ_NAME): $(OBJ)
	@ echo 'Building binary using $(CC) linker: $@'
	$(CC) $^ -o $@
	@ echo 'Finished building binary: $@'
	@ echo ' '

./objects/%.o: ./source/%.c ./source/%.h
	@ echo 'Building target using $(CC) compiler: $<'
	$(CC) $< $(CC_FLAGS) -o $@
	@ echo ' '

./objects/main.o: ./source/main.c $(H_SOURCE)
	@ echo 'Building target using $(CC) compiler: $<'
	$(CC) $< $(CC_FLAGS) -o $@
	@ echo ' '

objFolder:
	@ mkdir -p bin
	@ mkdir -p objects

clean:
	@ $(RM) ./objects/*.o $(PROJ_NAME) *~
#	@ rmdir objects

.PHONY: all clean
