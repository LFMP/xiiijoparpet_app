
import 'package:joparpet_app/models/api_response.dart';
import 'package:joparpet_app/utils/date.dart';

class EventoModel{
    String nome;
    DateTime anoEvento;
    String descricao;
    DateTime dataInicio;
    DateTime dataFim;
    bool hasDadoAdicional;
    bool gratuito;
    bool aceitandoAjudante;
    String foto;
    DateTime inicioInscricoes;
    DateTime fimInscricoes;
    String linkPagamento;
    String mensagemPagamento;
    int id;

    EventoModel({
        this.nome,
        this.anoEvento,
        this.descricao,
        this.dataInicio,
        this.dataFim,
        this.hasDadoAdicional,
        this.gratuito,
        this.aceitandoAjudante,
        this.foto,
        this.inicioInscricoes,
        this.fimInscricoes,
        this.linkPagamento,
        this.mensagemPagamento,
        this.id,
    });

    String get description => 
      '${DateFormatter.simpleFormat(dataInicio)} à ${DateFormatter.simpleFormat(dataFim)}';

    factory EventoModel.fromJson(Map<String, dynamic> json) => json == null ? null : EventoModel(
        nome: json["nome"] == null ? null : json["nome"],
        anoEvento: json["anoEvento"] == null ? null : DateTime.parse(json["anoEvento"]),
        descricao: json["descricao"] == null ? null : json["descricao"],
        dataInicio: json["dataInicio"] == null ? null : DateTime.parse(json["dataInicio"]),
        dataFim: json["dataFim"] == null ? null : DateTime.parse(json["dataFim"]),
        hasDadoAdicional: json["hasDadoAdicional"] == null ? null : json["hasDadoAdicional"],
        gratuito: json["gratuito"] == null ? null : json["gratuito"],
        aceitandoAjudante: json["aceitandoAjudante"] == null ? null : json["aceitandoAjudante"],
        foto: json["foto"] == null ? null : json["foto"],
        inicioInscricoes: json["inicioInscricoes"] == null ? null : DateTime.parse(json["inicioInscricoes"]),
        fimInscricoes: json["fimInscricoes"] == null ? null : DateTime.parse(json["fimInscricoes"]),
        linkPagamento: json["linkPagamento"] == null ? null : json["linkPagamento"],
        mensagemPagamento: json["mensagemPagamento"] == null ? null : json["mensagemPagamento"],
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nome": nome == null ? null : nome,
        "anoEvento": anoEvento == null ? null : anoEvento.toIso8601String(),
        "descricao": descricao == null ? null : descricao,
        "dataInicio": dataInicio == null ? null : dataInicio.toIso8601String(),
        "dataFim": dataFim == null ? null : dataFim.toIso8601String(),
        "hasDadoAdicional": hasDadoAdicional == null ? null : hasDadoAdicional,
        "gratuito": gratuito == null ? null : gratuito,
        "aceitandoAjudante": aceitandoAjudante == null ? null : aceitandoAjudante,
        "foto": foto == null ? null : foto,
        "inicioInscricoes": inicioInscricoes == null ? null : inicioInscricoes.toIso8601String(),
        "fimInscricoes": fimInscricoes == null ? null : fimInscricoes.toIso8601String(),
        "linkPagamento": linkPagamento == null ? null : linkPagamento,
        "mensagemPagamento": mensagemPagamento == null ? null : mensagemPagamento,
        "id": id == null ? null : id,
    };

    static List<EventoModel> fromJsonList(List jsonList) =>
    jsonList == null ? [] : jsonList.map(
      (eventJson) => EventoModel.fromJson(eventJson)).toList();
}

class ListEventoModel extends APIResponse{
  List<EventoModel> events;

  ListEventoModel({
    statusCode,
    this.events
  }) : super(statusCode: statusCode);

  factory ListEventoModel.fromJson(List jsonList) => jsonList == null ?
    ListEventoModel() :
    ListEventoModel(events: EventoModel.fromJsonList(jsonList));
}