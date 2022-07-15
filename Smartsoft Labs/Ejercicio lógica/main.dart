import 'dart:io';

void main() async {
  File data = File('D:/Smartsoft Labs/Ejercicio lógica/datos.csv');

  List stateMax = ['', 0];
  List stateMin = ['', 0];
  List stateMaxPercentageDeath = ['', 0.0];
  List<String> rowList = [];
  List<String> row = [];
  List<String> states = [];
  String state = '';
  int population = 0;
  int death = 0;
  double percentageDeath = 0;

  if (await data.exists()) {
    var dataReadAsSttring = data.readAsStringSync();
    rowList = dataReadAsSttring.split('\n');
    row = rowList[1].split(',');

    for (int i = 1; i < rowList.length; i++) {
      row = rowList[i].split(',');

      if (row.where((x) => x == state).length == 0) {
        state = row[6];
        states.add(row[6]);
      }

      population = population + int.parse(row[13]);
      death = death + int.parse(row.last);

      if (rowList[i] == rowList.last) {
        percentageDeath = (death / population) * 100;
        states.add(population.toString());
        states.add(death.toString());
        states.add(percentageDeath.toString());
        death = 0;
        population = 0;
        population = 0;
      } else if (row[6] != rowList[i + 1].split(',')[6]) {
        if (population == 0) {
          population = int.parse(row[12]);
        }
        percentageDeath = (death / population) * 100;
        states.add(population.toString());
        states.add(death.toString());
        states.add(percentageDeath.toString());
        death = 0;
        population = 0;
      }
    }

    for (int m = 2; m < states.length; m = m + 4) {
      if (stateMax[1] < int.parse(states[m])) {
        stateMax[0] = states[m - 2];
        stateMax[1] = int.parse(states[m]);
      }
    }
    print('1.	Estado con mayor acumulado a la fecha, Estado: \n         ${stateMax[0]}, con una acumulación de ${stateMax[1]} muertes');
    stateMin[1] = stateMax[1];
    for (int m = 2; m < states.length; m = m + 4) {
      if (stateMin[1] > int.parse(states[m])) {
        stateMin[0] = states[m - 2];
        stateMin[1] = int.parse(states[m]);
      }
    }
    print('2.	Estado con menor acumulado a la fecha, Estado: \n         ${stateMin[0]}, con una acumulación de ${stateMin[1]} muertes');

    print('3.	El porcentaje de muertes vs el total de población por estado');
    for (int m = 3; m < states.length; m = m + 4) {
      if (stateMaxPercentageDeath[1] < double.parse(states[m]) && double.parse(states[m]) < 100) {
        stateMaxPercentageDeath[0] = states[m - 3];
        stateMaxPercentageDeath[1] = double.parse(states[m]);
      }
      print('         Estado: ${states[m - 3]}, porcentaje de muerte: ${states[m]}%');
    }
    print('4.	Cual fue el estado más afectado (explicar por qué):');
    print('         El estado más afectado fue ${stateMaxPercentageDeath[0]} porque su porcentaje de muertes respecto a su población fue de ${stateMaxPercentageDeath[1]}% que es el más alto de todos los estados');
  } else {
    print('No existe el archivo');
  }
}
