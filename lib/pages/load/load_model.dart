import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'load_widget.dart' show LoadWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoadModel extends FlutterFlowModel<LoadWidget> {
  ///  Local state fields for this page.

  int? permissao = 0;

  bool? passwordDefault = false;

  DateTime? dataInicial;

  DateTime? dataFinal;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Load widget.
  List<UsuarioRow>? consultaUsuario;
  // Stores action output result for [Backend Call - API (Quantidade de Leads por periodo)] action in Load widget.
  ApiCallResponse? apiQuantidadeLeadsLoad;
  // Stores action output result for [Backend Call - API (Quantidade Leads Concluido)] action in Load widget.
  ApiCallResponse? apiCountLeadConcluidoLoad;
  // Stores action output result for [Backend Call - API (Quantidade Vendas Realizadas)] action in Load widget.
  ApiCallResponse? apiResultQuantidadeVendasLoad;
  // Stores action output result for [Backend Call - API (Faturamento Mensal)] action in Load widget.
  ApiCallResponse? apiResultFaturamentoMensalLoad;
  // Stores action output result for [Backend Call - Query Rows] action in Load widget.
  List<ConfiguracoesRow>? queryConfiguracaoInicialLoad;
  // Stores action output result for [Backend Call - API (Quantidade de Leads Atendente)] action in Load widget.
  ApiCallResponse? retuurnCountLeadsAtendenteLoad;
  // Stores action output result for [Backend Call - Query Rows] action in Load widget.
  List<LigacoesRow>? queryQuantidadeLigacoes;
  // Stores action output result for [Backend Call - API (Quantidade de Leads concluidos por Atendente)] action in Load widget.
  ApiCallResponse? retornoApiLeadsConcluidosAtendente;
  // Stores action output result for [Backend Call - API (Quantidade de vendas por atendente)] action in Load widget.
  ApiCallResponse? apiReturQuantidadeVendasAtendente;
  // Stores action output result for [Backend Call - API (Relatorio Faturamento)] action in Load widget.
  ApiCallResponse? faturamentoAtendente;
  // Stores action output result for [Backend Call - API (Concluir antigos  dias ou mais)] action in Load widget.
  ApiCallResponse? concluir;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
