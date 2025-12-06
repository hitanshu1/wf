// Conditional export: uses the web implementation when compiled for web,
// otherwise uses a stub that does nothing (so mobile/desktop builds stay OK).
export 'browser_history_stub.dart' if (dart.library.html) 'browser_history_web.dart';
