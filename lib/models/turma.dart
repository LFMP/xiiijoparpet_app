// Models
import 'package:joparpet_app/models/api_response.dart';

class TurmaModel {
  int quantidadeMaxInscritos;
  int quantidadeAtualInscritos;
  int id;
  String nome;
  bool limited;
  int atividadeId;
  List<DiaModel> dias;
  DiaModel today;

  TurmaModel(
      {this.id,
      this.quantidadeMaxInscritos,
      this.quantidadeAtualInscritos,
      this.nome,
      this.limited,
      this.atividadeId,
      this.dias}) {
    final now = DateTime.now();
    this.today = dias.firstWhere(
        (day) => day.dia.difference(now).inDays == 0 && day.dia.day == now.day,
        orElse: () => null);
  }

  String get description =>
      quantidadeMaxInscritos == null || quantidadeMaxInscritos == 1
          ? 'Inscritos: $quantidadeAtualInscritos'
          : 'Inscritos: $quantidadeAtualInscritos/$quantidadeMaxInscritos';

  factory TurmaModel.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : TurmaModel(
          quantidadeMaxInscritos: json["quantidadeMaxInscritos"] == null
              ? null
              : json["quantidadeMaxInscritos"],
          quantidadeAtualInscritos: json["quantidadeAtualInscritos"] == null
              ? null
              : json["quantidadeAtualInscritos"],
          nome: json["nome"] == null ? null : json["nome"],
          limited: json["limited"] == null ? null : json["limited"],
          atividadeId: json["atividadeId"] == null ? null : json["atividadeId"],
          dias: json['dias'] == null ? [] : DiaModel.fromJsonList(json['dias']),
          id: json['id'] == null ? null : json['id']);

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "quantidadeMaxInscritos":
            quantidadeMaxInscritos == null ? null : quantidadeMaxInscritos,
        "quantidadeAtualInscritos":
            quantidadeAtualInscritos == null ? null : quantidadeAtualInscritos,
        "nome": nome == null ? null : nome,
        "limited": limited == null ? null : limited,
        "atividadeId": atividadeId == null ? null : atividadeId,
        "dias": dias == null || dias.isEmpty
            ? []
            : dias.map((dia) => dia.toJson()).toList()
      };

  static List<TurmaModel> fromJsonList(List jsonList) => jsonList == null
      ? []
      : jsonList.map((turmaJson) => TurmaModel.fromJson(turmaJson)).toList();
}

class ListTurmaModel extends APIResponse {
  List<TurmaModel> turmas;

  ListTurmaModel({statusCode, this.turmas}) : super(statusCode: statusCode);

  factory ListTurmaModel.fromJson(List jsonList) => jsonList == null
      ? ListTurmaModel()
      : ListTurmaModel(turmas: TurmaModel.fromJsonList(jsonList));
}

class DiaModel {
  int cargaHoraria;
  DateTime dia;
  int id;
  int turmaId;

  DiaModel({
    this.cargaHoraria,
    this.dia,
    this.id,
    this.turmaId,
  });

  factory DiaModel.fromJson(Map<String, dynamic> json) => json == null
      ? null
      : DiaModel(
          cargaHoraria:
              json["cargaHoraria"] == null ? null : json["cargaHoraria"],
          dia: json["dia"] == null ? null : DateTime.parse(json["dia"]),
          id: json["id"] == null ? null : json["id"],
          turmaId: json["turmaId"] == null ? null : json["turmaId"],
        );

  Map<String, dynamic> toJson() => {
        "cargaHoraria": cargaHoraria == null ? null : cargaHoraria,
        "dia": dia == null ? null : dia.toIso8601String(),
        "id": id == null ? null : id,
        "turmaId": turmaId == null ? null : turmaId
      };

  static List<DiaModel> fromJsonList(List jsonList) => jsonList == null
      ? []
      : jsonList.map((diaJson) => DiaModel.fromJson(diaJson)).toList();
}
