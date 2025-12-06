
import 'dart:html' as html;

/// Pushes [path] into browser history (web only).
void pushUrl(String path) {
  try {
    html.window.history.pushState(null, '', path);
  } catch (_) {}
}

/// Append [idSegment] to the `/project` path, preserving existing segments.
/// Example: `/project/chat_message` -> `/project/chat_message/ai_agent`
void pushUrlAppend(String idSegment) {
  try {
    final path = html.window.location.pathname ?? '';
    const base = '/project';

    List<String> segments = [];

    final projectIndex = path.indexOf(base);
    if (projectIndex >= 0) {
      final after = path.substring(projectIndex + base.length);
      if (after.isNotEmpty) {
        segments = after.split('/').where((s) => s.isNotEmpty).toList();
      }
    }

    segments.add(idSegment);
    final newPath = '$base/${segments.join('/')}';
    html.window.history.pushState(null, '', newPath);
  } catch (_) {}
}
