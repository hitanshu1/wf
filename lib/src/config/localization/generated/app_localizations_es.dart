// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get welcome => 'Bienvenido';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String hello_user(Object name) {
    return 'Hola $name';
  }

  @override
  String get project => 'Proyecto';

  @override
  String get search => 'Buscar';

  @override
  String get debug => 'Depurar';

  @override
  String get device => 'Dispositivo';

  @override
  String get projects => 'Proyectos';

  @override
  String get project_description =>
      'Rastrea flujos de trabajo en curso, revisa el progreso de tickets y accede a repositorios.';

  @override
  String get active_projects => 'Proyectos Activos';

  @override
  String get pending_reviews => 'Revisiones Pendientes';

  @override
  String get deploy_ready => 'Listo para Desplegar';

  @override
  String get recent_activity => 'Actividad Reciente';

  @override
  String get merged_feature => 'Fusión feature/payment-intent';

  @override
  String get qa_approved => 'QA aprobó el asistente de incorporación';

  @override
  String get scheduled_release => 'Lanzamiento programado 2.3.0';

  @override
  String get search_workspace => 'Buscar Espacio de Trabajo';

  @override
  String get search_description =>
      'Encuentra código, diseños o documentos al instante con búsqueda federada de proyectos.';

  @override
  String get indexed_services => 'Servicios Indexados';

  @override
  String get saved_queries => 'Consultas Guardadas';

  @override
  String get ai_smart_results => 'Resultados Inteligentes IA';

  @override
  String get recent_searches => 'Búsquedas Recientes';

  @override
  String get error_boundary => 'implementación de límite de error';

  @override
  String get dark_theme_tokens => 'tokens de tema oscuro';

  @override
  String get deployment_checklist => 'lista de verificación de despliegue';

  @override
  String get debug_console => 'Consola de Depuración';

  @override
  String get debug_description =>
      'Inspecciona registros, rastrea puntos de interrupción y monitorea diagnósticos en tiempo de ejecución.';

  @override
  String get active_breakpoints => 'Puntos de Interrupción Activos';

  @override
  String get warnings => 'Advertencias';

  @override
  String get last_build => 'Última Compilación';

  @override
  String get latest_logs => 'Últimos Registros';

  @override
  String get info_auth_service =>
      '[INFO] Servicio de autenticación inicializado';

  @override
  String get warn_missing_locale =>
      '[ADVERTENCIA] Se detectaron cadenas de localización faltantes';

  @override
  String get debug_experiment_flag =>
      '[DEBUG] Bandera de experimento habilitada: checkout_redesign';

  @override
  String get connected_devices => 'Dispositivos Conectados';

  @override
  String get device_description =>
      'Gestiona sesiones de simulador, dispositivos físicos y objetivos de depuración remota.';

  @override
  String get online_devices => 'Dispositivos En Línea';

  @override
  String get simulators => 'Simuladores';

  @override
  String get remote_sessions => 'Sesiones Remotas';

  @override
  String get device_feed => 'Feed de Dispositivos';

  @override
  String get pixel_hot_reload => 'Pixel 8 • Recarga en caliente exitosa';

  @override
  String get iphone_screenshot => 'iPhone 15 • Captura de pantalla capturada';

  @override
  String get qa_tablet_crash => 'Tableta QA • Registro de fallo cargado';

  @override
  String get project_inspector => 'Inspector de Proyecto';

  @override
  String get status => 'Estado';

  @override
  String get health => 'Salud';

  @override
  String get stable => 'Estable';

  @override
  String get deploys_24h => 'Despliegues (24h)';

  @override
  String get open_issues => 'Problemas Abiertos';

  @override
  String get quick_actions => 'Acciones Rápidas';

  @override
  String get create_ticket => 'Crear ticket';

  @override
  String get open_pipeline => 'Abrir pipeline';

  @override
  String get switch_branch => 'Cambiar rama';

  @override
  String get demo_code => 'Código de Demostración';

  @override
  String get notes => 'Notas';

  @override
  String get notes_description =>
      'Usa este panel para mostrar información del proyecto, estado de CI, o asignar acciones de seguimiento a colaboradores.';

  @override
  String get code_snippet_description =>
      'Usa este fragmento para conectar el nuevo StepButton a tus acciones de flujo de trabajo.';
}
