import 'package:joparpet_app/models/api_response.dart';

class InscricaoModel {
  bool pago;
  int cargaHoraria;
  int id;
  int atividadeId;
  int inscritoId;
  int turmaId;
  String usuarioId;
  InscritoModel inscrito;

  InscricaoModel({
    this.pago,
    this.cargaHoraria,
    this.id,
    this.atividadeId,
    this.inscritoId,
    this.turmaId,
    this.usuarioId,
    this.inscrito,
  });

  String get nome => inscrito?.usuario?.nome ?? '';
  String get cpf => inscrito?.usuario?.cpf ?? '';
  String get userId => inscrito?.usuario?.id ?? null;

  String get description => '$cpf / ${pago ? 'Pago' : 'Não pago'}';

  factory InscricaoModel.fromJson(Map<String, dynamic> json) => json == null ? null : InscricaoModel(
    pago: json["pago"] == null ? null : json["pago"],
    cargaHoraria: json["cargaHoraria"] == null ? null : json["cargaHoraria"],
    id: json["id"] == null ? null : json["id"],
    atividadeId: json["atividadeId"] == null ? null : json["atividadeId"],
    inscritoId: json["inscritoId"] == null ? null : json["inscritoId"],
    turmaId: json["turmaId"] == null ? null : json["turmaId"],
    usuarioId: json["usuarioId"] == null ? null : json["usuarioId"],
    inscrito: json["inscrito"] == null ? null :
      InscritoModel.fromJson(json["inscrito"]),
  );

  Map<String, dynamic> toJson() => {
    "pago": pago == null ? null : pago,
    "cargaHoraria": cargaHoraria == null ? null : cargaHoraria,
    "id": id == null ? null : id,
    "atividadeId": atividadeId == null ? null : atividadeId,
    "inscritoId": inscritoId == null ? null : inscritoId,
    "turmaId": turmaId == null ? null : turmaId,
    "usuarioId": usuarioId == null ? null : usuarioId,
    "inscrito": inscrito == null ? null : inscrito.toJson(),
  };
    
  static List<InscricaoModel> fromJsonList(List jsonList) =>
  jsonList == null ? [] : jsonList.map(
    (inscritoJson) => InscricaoModel.fromJson(inscritoJson)).toList();
}

class InscritoModel {
  int id;
  String usuarioId;
  UsuarioModel usuario;

  InscritoModel({
    this.id,
    this.usuarioId,
    this.usuario,
  });

  factory InscritoModel.fromJson(Map<String, dynamic> json) => json == null ? null : InscritoModel(
    id: json["id"] == null ? null : json["id"],
    usuarioId: json["usuarioId"] == null ? null : json["usuarioId"],
    usuario: json["usuario"] == null ? null : 
      UsuarioModel.fromJson(json["usuario"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "usuarioId": usuarioId == null ? null : usuarioId,
    "usuario": usuario == null ? null : usuario.toJson(),
  };
}

class UsuarioModel {
  String nome;
  String email;
  String cpf;
  String id;

  UsuarioModel({
    this.nome,
    this.email,
    this.cpf,
    this.id,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => json == null ? null : UsuarioModel(
    nome: json["nome"] == null ? null : json["nome"],
    email: json["email"] == null ? null : json["email"],
    cpf: json["cpf"] == null ? null : json["cpf"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome == null ? null : nome,
    "email": email == null ? null : email,
    "cpf": cpf == null ? null : cpf,
    "id": id == null ? null : id,
  };

}

class ListInscricaoModel extends APIResponse{
  List<InscricaoModel> inscricoes;

  ListInscricaoModel({
  statusCode,
  this.inscricoes
  }) : super(statusCode: statusCode);

  factory ListInscricaoModel.fromJson(List jsonList) => jsonList == null ? 
  ListInscricaoModel() :
  ListInscricaoModel(inscricoes: InscricaoModel.fromJsonList(jsonList));
}