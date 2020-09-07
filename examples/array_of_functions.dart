import 'calculations.dart';

main() {
  do_calculation(int value1, int value2, String operator) {
    // if (operator == 'sum') {
    //   return value1 + value2;
    // } else if (operator == 'subtraction') {
    //   return value1 - value2;
    // } else if (operator == 'multiplication') {
    //   return value1 * value2;
    // } else if (operator == 'division') {
    //   return value1 / value2;
    // }

    // var math_operations = {
    //   'sum': () => value1 + value2,
    //   'subtraction': () => value1 - value2,
    //   'multiplication': () => value1 * value2,
    //   'division': () => value1 / value2
    // };
    // return math_operations[operator]();

    var math_operations = {
      'sum': sum,
      'subtraction': subtraction,
      'multiplication': multiplication,
      'division': division
    };
    return math_operations[operator](value1, value2);
  }

  print(do_calculation(5, 10, 'sum'));
  print(do_calculation(5, 10, 'subtraction'));
  print(do_calculation(5, 10, 'multiplication'));
  print(do_calculation(5, 10, 'division'));
}
