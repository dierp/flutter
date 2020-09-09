class Produto {
  String nome;
  double preco;
  double _preco_de_compra; // Atributo privado

  Produto({this.nome, this.preco});
  // Produto(this.nome, this.preco)
  // Produto(String nome, double preco) {
  //   this.nome = nome;
  //   this.preco = preco;
  // }

  get preco_de_compra {
    return _preco_de_compra;
  }

  set preco_de_compra(double novoPreco) {
    this._preco_de_compra = novoPreco;
  }
}

main() {
  Produto p1 = Produto(nome: 'Arroz', preco: 4.507);
  var p2 = Produto(preco: 5.2, nome: 'Feijão');
  print(
      'O quilo do ${p1.nome} custa R\$${double.parse(p1.preco.toStringAsFixed(2))}');
  print(
      'O quilo do ${p2.nome} custa R\$${double.parse(p2.preco.toStringAsFixed(2))}');
}
