FUENTE = proyecto
FUENTE_ONLY_FLEX = proyecto

ADD_TEST = ../test/add_test.car
DEL_TEST = ../test/del_test.car
STATS_TEST = ../test/stat_test.car
SEARCH_TEST = ../test/search_test.car
OVERALL_TEST = ../test/overall_test.car
ERROR1_TEST = ../test/error1_test.car
ERROR2_TEST = ../test/error2_test.car
ERROR3_TEST = ../test/error3_test.car
ERROR4_TEST = ../test/error4_test.car

LIB = lfl

all: compile run1 run2 run3 run4 run5 run6

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
	@./$(FUENTE) < $(SEARCH_TEST)

run5:
	@echo "Ejecución de una prueba general:"
	@./$(FUENTE) < $(OVERALL_TEST)

run6:
	@echo "Ejecución de la prueba de detección de errores"
	@./$(FUENTE_ONLY_FLEX) < $(ERROR1_TEST)
	@./$(FUENTE_ONLY_FLEX) < $(ERROR2_TEST)
	@./$(FUENTE_ONLY_FLEX) < $(ERROR3_TEST)
	@./$(FUENTE_ONLY_FLEX) < $(ERROR4_TEST)

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h
