main() {
  // Strings
  int a = 1;
  a = 4;

  const int b = 5;
  // b = 6; // wrong

  const String nome = 'Diego';
  var substr = nome.substring(1);
  print('Substring: $substr');
  var replace = nome.replaceAll('o', 'OOOO');
  print('Replace: $replace');

  final int c = 5;
  // c = 6; // wrong

  // key Value lists
  // var notas = {
  Map<String, double> notas = {
    'Ana': 9.1,
    'Bia': 8.7,
    'Carla': 7.8,
    'Diego': 6.5
  };

  // for (var chave in notas.keys) {
  //   print('Chave: $chave');
  // }

  // for (var valor in notas.values) {
  //   print('Valor: $valor');
  // }
  print('For:');
  for (var reg in notas.entries) {
    print('${reg.key} = ${reg.value}');
  }

  print('Foreach:');
  notas.forEach((key, value) {
    print('$key = $value');
  });

  print('containsKey:');
  print(notas.containsKey('Diego'));

  // print(notas.putIfAbsent('Diego', () => {'Diego': 5.5}));

  print('Remove Diego:');
  notas.remove('Diego');
  print(notas);

  // print('Add Diego:');
  // notas.addAll({'Diego'.5.4});
  // print(notas);
}
