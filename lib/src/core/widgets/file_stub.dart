// Stub file for web platform
// This provides a File-like class that matches dart:io.File interface
// but will never be instantiated on web (guarded by kIsWeb check)

class File {
  final String path;
  File(this.path);
  
  // Add any other methods that dart:io.File might have that are used
  // This is just a stub, so these won't actually be called on web
}
