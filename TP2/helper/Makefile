# ************************************************************************* #
# Organizacion del Computador II                                            #
#                                                                           #
#   Trabajo Practico 2                                                      #
#                                                                           #
# ************************************************************************* #
CFLAGS=-Wall -Wextra -pedantic -ggdb -std=c99

BUILD_DIR = ../build
BIN = tp2

OBJS          = libbmp.o imagenes.o
OBJS_CON_PATH = $(addprefix $(BUILD_DIR)/, $(OBJS))
BMPDIFF       = $(BUILD_DIR)/bmpdiff


# .PHONY: all clean libbmp bmpdiff

all: $(OBJS_CON_PATH) bmpdiff

lib: all

$(BUILD_DIR)/%.o: %.c
	$(CC) $(OPTFLAGS) $(CFLAGS) -c -o $@ $<

bmpdiff: bmpdiff.c $(OBJS_CON_PATH)
	$(CC) $(OPTFLAGS) $(CFLAGS) bmpdiff.c $(OBJS_CON_PATH) -o $(BMPDIFF)


clean:
	rm -f $(OBJS_CON_PATH) $(BMPDIFF)
