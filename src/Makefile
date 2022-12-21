FUENTE = proyecto
FUENTE_ONLY_FLEX = proyecto

ADD_TEST = ../test/add_test.car
DEL_TEST = ../test/del_test.car
STATS_TEST = ../test/stat_test.car
SEARCH_CAR = ../test/search_test.car
TEST = ../test/test.car

LIB = lfl

all: compile run1 run2 run3 run4 test

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd -Wcounterexamples
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -$(LIB)

run1:
	@echo "Ejecución de la prueba para añadir vehículos:"
	@./$(FUENTE) < $(ADD_TEST)

run2:
	@echo "Ejecución de la prueba para eliminar vehículos:"
	@./$(FUENTE) < $(DEL_TEST)

run3:
	@echo "Ejecución de la prueba para estadísticas:"
	@./$(FUENTE) < $(STATS_TEST)

run4:
	@echo "Ejecución de la prueba para buscar vehículos:"
	@./$(FUENTE) < $(SEARCH_CAR)

test:
	@echo "Ejecución de varias pruebas:"
	@./$(FUENTE) < $(TEST)

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h
