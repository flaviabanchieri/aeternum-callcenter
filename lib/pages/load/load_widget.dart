import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'load_model.dart';
export 'load_model.dart';

class LoadWidget extends StatefulWidget {
  const LoadWidget({super.key});

  @override
  State<LoadWidget> createState() => _LoadWidgetState();
}

class _LoadWidgetState extends State<LoadWidget> {
  late LoadModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.consultaUsuario = await UsuarioTable().queryRows(
        queryFn: (q) => q.eq(
          'user',
          currentUserUid,
        ),
      );
      if ((_model.consultaUsuario != null &&
              (_model.consultaUsuario)!.isNotEmpty) !=
          true) {
        GoRouter.of(context).prepareAuthEvent();
        await authManager.signOut();
        GoRouter.of(context).clearRedirectLocation();

        return;
      }
      _model.permissao = valueOrDefault<int>(
        _model.consultaUsuario?.first?.permissao,
        0,
      );
      _model.passwordDefault = _model.consultaUsuario?.first?.passwordDefault;
      safeSetState(() {});
      FFAppState().permissao = valueOrDefault<int>(
        _model.permissao,
        0,
      );
      FFAppState().UsuarioNome = valueOrDefault<String>(
        _model.consultaUsuario?.first?.nome,
        'Nome Usuário',
      );
      FFAppState().FotoUsuario = valueOrDefault<String>(
        _model.consultaUsuario?.first?.foto,
        'Null',
      );
      FFAppState().pagina = Pagina.dashboard;
      FFAppState().update(() {});
      if (_model.permissao == 1) {
        _model.dataInicial = functions.montarData(
            1, functions.mesAtual(), functions.anoAtual(), false);
        _model.dataFinal = functions.montarData(
            functions.retornaUltimoDiaMes(
                functions.mesAtual(), functions.anoAtual()),
            functions.mesAtual(),
            functions.anoAtual(),
            true);
        safeSetState(() {});
        _model.apiQuantidadeLeadsLoad =
            await QuantidadeDeLeadsPorPeriodoCall.call(
          dataInicial: _model.dataInicial?.toString(),
          dataFinal: _model.dataFinal?.toString(),
        );

        _model.apiCountLeadConcluidoLoad =
            await QuantidadeLeadsConcluidoCall.call(
          dataInicial: _model.dataInicial?.toString(),
          dataFinal: functions
              .montarData(
                  functions.retornaUltimoDiaMes(
                      functions.mesAtual(), functions.anoAtual()),
                  functions.mesAtual(),
                  functions.anoAtual(),
                  true)
              ?.toString(),
        );

        _model.apiResultQuantidadeVendasLoad =
            await QuantidadeVendasRealizadasCall.call(
          dataInicial: _model.dataInicial?.toString(),
          dataFinal: functions
              .montarData(
                  functions.retornaUltimoDiaMes(
                      functions.mesAtual(), functions.anoAtual()),
                  functions.mesAtual(),
                  functions.anoAtual(),
                  true)
              ?.toString(),
        );

        _model.apiResultFaturamentoMensalLoad =
            await FaturamentoMensalCall.call(
          dataInicial: _model.dataInicial?.toString(),
          dataFinal: functions
              .montarData(
                  functions.retornaUltimoDiaMes(
                      functions.mesAtual(), functions.anoAtual()),
                  functions.mesAtual(),
                  functions.anoAtual(),
                  true)
              ?.toString(),
        );

        FFAppState().totalLeadGestor =
            (_model.apiQuantidadeLeadsLoad?.jsonBody ?? '');
        FFAppState().totalConcluidoGestor =
            (_model.apiCountLeadConcluidoLoad?.jsonBody ?? '');
        FFAppState().totalRealizadasGestor =
            (_model.apiResultQuantidadeVendasLoad?.jsonBody ?? '');
        FFAppState().totalFaturamentoGestor = valueOrDefault<double>(
          getJsonField(
            (_model.apiResultFaturamentoMensalLoad?.jsonBody ?? ''),
            r'''$''',
          ),
          0.0,
        );
        FFAppState().update(() {});
        if (_model.passwordDefault!) {
          context.goNamedAuth('AlterarSenha', context.mounted);

          return;
        } else {
          context.pushNamedAuth('HomePageGestor', context.mounted);

          return;
        }
      } else {
        if (_model.permissao == 2) {
          if (_model.passwordDefault!) {
            context.goNamedAuth('AlterarSenha', context.mounted);
          } else {
            _model.dataInicial = functions.montarData(
                1, functions.mesAtual(), functions.anoAtual(), false);
            _model.dataFinal = functions.montarData(
                functions.retornaUltimoDiaMes(
                    functions.mesAtual(), functions.anoAtual()),
                functions.mesAtual(),
                functions.anoAtual(),
                true);
            safeSetState(() {});
            _model.queryConfiguracaoInicialLoad =
                await ConfiguracoesTable().queryRows(
              queryFn: (q) => q.eq(
                'mes_ano',
                functions.mesAnoAtual(),
              ),
            );
            _model.retuurnCountLeadsAtendenteLoad =
                await QuantidadeDeLeadsAtendenteCall.call(
              dataInicial: _model.dataInicial?.toString(),
              dataFinal: _model.dataFinal?.toString(),
              atendente: currentUserUid,
            );

            _model.queryQuantidadeLigacoes = await LigacoesTable().queryRows(
              queryFn: (q) => q.eq(
                'user_id',
                currentUserUid,
              ),
            );
            _model.retornoApiLeadsConcluidosAtendente =
                await QuantidadeDeLeadsConcluidosPorAtendenteCall.call(
              dataInicial: _model.dataInicial?.toString(),
              dataFinal: _model.dataFinal?.toString(),
              atendente: currentUserUid,
            );

            _model.apiReturQuantidadeVendasAtendente =
                await QuantidadeDeVendasPorAtendenteCall.call(
              dataInicial: _model.dataInicial?.toString(),
              dataFinal: _model.dataFinal?.toString(),
              atendente: currentUserUid,
            );

            _model.faturamentoAtendente = await RelatorioFaturamentoCall.call(
              dataInicial: valueOrDefault<String>(
                _model.dataInicial?.toString(),
                '01/01/2001',
              ),
              dataFinal: _model.dataFinal?.toString(),
              usuario: currentUserUid,
            );

            FFAppState().valorMetaDashboard = valueOrDefault<double>(
              _model.queryConfiguracaoInicialLoad?.first?.valorMetaMensal,
              0.0,
            );
            FFAppState().totalLead =
                (_model.retuurnCountLeadsAtendenteLoad?.jsonBody ?? '');
            FFAppState().totalLigacoesAtendente = valueOrDefault<int>(
              _model.queryQuantidadeLigacoes?.length,
              0,
            );
            FFAppState().totalRealizados = valueOrDefault<int>(
              (_model.retornoApiLeadsConcluidosAtendente?.jsonBody ?? ''),
              0,
            );
            FFAppState().totalVendasAtendente = valueOrDefault<int>(
              (_model.apiReturQuantidadeVendasAtendente?.jsonBody ?? ''),
              0,
            );
            FFAppState().totalFaturamentoAtendente = valueOrDefault<int>(
              (_model.faturamentoAtendente?.jsonBody ?? ''),
              0,
            );
            FFAppState().update(() {});
            _model.concluir = await ConcluirAntigosDiasOuMaisCall.call();

            context.goNamedAuth('HomePage', context.mounted);
          }

          return;
        } else {
          if (_model.permissao == 3) {
            context.goNamedAuth('CadastroUsuarios', context.mounted);

            return;
          } else {
            return;
          }
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();

                        context.goNamedAuth('Login', context.mounted);
                      },
                      child: Lottie.asset(
                        'assets/jsons/Animation_-_Loading.json',
                        width: 266.0,
                        height: 200.0,
                        fit: BoxFit.contain,
                        animate: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
