class Repository {
  static const API_URL = 'https://www.din.uem.br/pet/api';

  static const API_USUARIOS = '$API_URL/Usuarios';
  static const API_USUARIOS_LOGIN = '$API_USUARIOS/login/?include=user';

  static const API_PRESENCA = '$API_URL/Presencas';
  static const API_EVENTOS =
      '$API_URL/Eventos?filter={"where": {"dataFim": {"gte": "2019-10-27T03:00:00.000Z"}}}';
  static const API_ATIVIDADES =
      '$API_URL/Eventos/\$/Atividades?filter={"include":[{"relation":"categoria"},{"relation":"turmas","scope":{"include":{"relation":"dias"}}}],"limit":0}';
  static const API_TURMAS =
      '$API_URL/Atividades/\$/Turmas?filter={"include":"dias"}';
  static const API_INSCRICOES =
      '$API_URL/Inscricoes?filter={"where":{"and":[{"turmaId": \$},{"atividadeId":\$}]},"limit":0}';
}
