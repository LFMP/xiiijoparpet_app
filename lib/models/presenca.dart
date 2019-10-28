// Models
import 'package:joparpet_app/models/api_response.dart';

class PresencaModel extends APIResponse{
  final DateTime dataPresenca;
  final String responsavelPresencaId;
  final int diaId;
  final int inscricaoId;

  PresencaModel({
    statusCode,
    this.dataPresenca,
    this.responsavelPresencaId,
    this.diaId,
    this.inscricaoId,
  }) : super(statusCode: statusCode);

  factory PresencaModel.fromJson(Map<String, dynamic> json) => json == null ? PresencaModel() : PresencaModel(
    dataPresenca: json["dataPresenca"] == null ? null :
      DateTime.parse(json["dataPresenca"]),
    responsavelPresencaId: json["responsavelPresencaId"] == null ? null :
      json["responsavelPresencaId"],
    diaId: json["diaId"] == null ? null : json["diaId"],
    inscricaoId: json["inscricaoId"] == null ? null : json["inscricaoId"],
  );

  Map<String, dynamic> toJson() => {
    "dataPresenca": dataPresenca == null ? null : 
      dataPresenca.toIso8601String().toString(),
    "responsavelPresencaId": responsavelPresencaId == null ? null : 
      responsavelPresencaId.toString(),
    "diaId": diaId == null ? null : diaId.toString(),
    "inscricaoId": inscricaoId == null ? null : inscricaoId.toString(),
  };

  static List<PresencaModel> fromJsonList(List jsonList) =>
    jsonList == null ? [] : jsonList.map(
      (presencaJson) => PresencaModel.fromJson(presencaJson)
    ).toList();
}