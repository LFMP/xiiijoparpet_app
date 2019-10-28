class CategoriaModel {
  String nome;
  int id;

  CategoriaModel({
    this.nome,
    this.id,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => json == null ? null : CategoriaModel(
    nome: json["nome"] == null ? null : json["nome"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome == null ? null : nome,
    "id": id == null ? null : id,
  };
}