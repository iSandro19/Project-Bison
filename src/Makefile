FUENTE = proyecto
FUENTE_ONLY_FLEX = proyecto

ADD_TEST = ../test/add_test.csv

LIB = lfl

all: compile run1 clean

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -$(LIB)

run1:
	@echo "Ejecución de la prueba para añadir vehículos:"
	@./$(FUENTE) < $(PRUEBA)

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h
