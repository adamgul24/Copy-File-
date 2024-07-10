# Makefile for Copy File Content Using System Calls

# Define variables
ASM = nasm
ASM_FLAGS = -f elf32
LD = ld
LD_FLAGS = -m elf_i386

# Target executable
TARGET = main

# Source files
SRC = main.asm
OBJ = main.o

# Default target
all: $(TARGET)

# Rule to create the object file from assembly source
$(OBJ): $(SRC)
	$(ASM) $(ASM_FLAGS) $< -o $@

# Rule to link the object file and create the executable
$(TARGET): $(OBJ)
	$(LD) $(LD_FLAGS) $< -o $@

# Clean up build files
clean:
	rm -f $(OBJ) $(TARGET)

# Run the program
run: $(TARGET)
	./$(TARGET)
