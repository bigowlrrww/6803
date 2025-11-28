CC      = gcc
AR      = ar
CFLAGS  = -I. -O0 -g
RM      = rm -f

# Library
TARGET-libMC6803E = libMC6803E.a
OBJS-libMC6803E   = Image.o MC6803E_ALU.o MC6803E_Memory.o MC6803E_Core.o

# Test program
TARGET-test = MC6803_TEST
OBJS-test   = MC6803_TEST.o

all: $(TARGET-libMC6803E) $(TARGET-test)

# Build static library
$(TARGET-libMC6803E): $(OBJS-libMC6803E)
	$(AR) rcs $@ $(OBJS-libMC6803E)

# Build test program
$(TARGET-test): $(OBJS-test) $(TARGET-libMC6803E)
	$(CC) $(CFLAGS) $(OBJS-test) $(TARGET-libMC6803E) -o $@

# Compile object files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean
clean:
	if exist *.o del /Q *.o
	if exist *.a del /Q *.a
	if exist $(TARGET-test).exe del /Q $(TARGET-test).exe