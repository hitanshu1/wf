class KuickPath {
  final String name;
  final String path;

  const KuickPath(this.name, {String? path}) : path = path ?? '/$name';
}

/// ---------------------------------------------------
/// Routes: Centralized route definitions
/// ---------------------------------------------------
///
class KuickRoutes {
  static const KuickPath builder = KuickPath("builder");
  static const KuickPath home = KuickPath("home");
  static const KuickPath setting = KuickPath("settings");
  static const KuickPath history = KuickPath("history");
  static const KuickPath group = KuickPath("group");
  static const KuickPath logout = KuickPath("logout");
  static const KuickPath widget = KuickPath("widget");
  static const KuickPath keyboard = KuickPath("keyboard");
  static const KuickPath dashboard = KuickPath("dashboard");
  static const KuickPath workflow = KuickPath("workflow");

  static const KuickPath search = KuickPath("search");
  static const KuickPath debug = KuickPath("debug");
  static const KuickPath device = KuickPath("device");
  static const KuickPath interactiveViewer = KuickPath("interactive-viewer");
  static const KuickPath workspace = KuickPath("workspaces",);
  static const KuickPath workspaceDetails = KuickPath("workspace",path: '/:workspaceId');
  static const KuickPath projectDetails = KuickPath("projectDetails", path: ':projectId');
  static const KuickPath unknown = KuickPath("unknown");
}

