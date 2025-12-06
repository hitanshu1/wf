/// Standalone InteractiveViewer Example
/// 
/// This is a complete, reusable example that can be copied to any Flutter project.
/// It demonstrates InteractiveViewer with:
/// - Zoom in/out controls with arrow buttons
/// - Split screen functionality (horizontal/vertical)
/// - Pan and zoom gestures
/// - Reset view functionality
/// 
/// To use this in another project:
/// 1. Copy this entire file to your project
/// 2. Import it: import 'path/to/interactive_viewer_standalone_example.dart';
/// 3. Use it: InteractiveViewerExample(child: YourContentWidget())
/// 
/// Example usage:
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'interactive_viewer_example.dart';
/// 
/// void main() {
///   runApp(MyApp());
/// }
/// 
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       title: 'InteractiveViewer Demo',
///       home: Scaffold(
///         appBar: AppBar(title: Text('Demo')),
///         body: InteractiveViewerExample(
///           child: YourContentWidget(),
///           showControls: true,
///           enableSplitScreen: true,
///         ),
///       ),
///     );
///   }
/// }
/// ```

import 'package:flutter/material.dart';

/// A reusable InteractiveViewer widget with zoom controls and split screen functionality
class InteractiveViewerExample extends StatefulWidget {
  /// The child widget to display inside the InteractiveViewer
  final Widget child;
  
  /// Whether to show zoom control buttons
  final bool showControls;
  
  /// Whether to enable split screen functionality
  final bool enableSplitScreen;
  
  /// Minimum zoom scale (default: 0.5)
  final double minScale;
  
  /// Maximum zoom scale (default: 4.0)
  final double maxScale;
  
  /// Initial zoom scale (default: 1.0)
  final double initialScale;
  
  /// Background color of the viewer
  final Color? backgroundColor;
  
  /// Callback when zoom changes
  final ValueChanged<double>? onZoomChanged;
  
  const InteractiveViewerExample({
    super.key,
    required this.child,
    this.showControls = true,
    this.enableSplitScreen = true,
    this.minScale = 0.5,
    this.maxScale = 4.0,
    this.initialScale = 1.0,
    this.backgroundColor,
    this.onZoomChanged,
  });

  @override
  State<InteractiveViewerExample> createState() => _InteractiveViewerExampleState();
}

class _InteractiveViewerExampleState extends State<InteractiveViewerExample> {
  final TransformationController _transformationController = TransformationController();
  bool _isSplitScreen = false;
  SplitScreenMode _splitMode = SplitScreenMode.horizontal;
  double _currentScale = 1.0;

  @override
  void initState() {
    super.initState();
    _currentScale = widget.initialScale;
    _transformationController.value = Matrix4.identity().scaled(widget.initialScale);
    _transformationController.addListener(_onTransformationChanged);
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onTransformationChanged);
    _transformationController.dispose();
    super.dispose();
  }

  void _onTransformationChanged() {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    if (_currentScale != scale) {
      setState(() {
        _currentScale = scale;
      });
      widget.onZoomChanged?.call(scale);
    }
  }

  void _zoomIn() {
    final scale = _currentScale * 1.2;
    _setScale(scale.clamp(widget.minScale, widget.maxScale));
  }

  void _zoomOut() {
    final scale = _currentScale / 1.2;
    _setScale(scale.clamp(widget.minScale, widget.maxScale));
  }

  void _resetView() {
    _setScale(widget.initialScale);
    _transformationController.value = Matrix4.identity()
      ..translate(0.0, 0.0)
      ..scale(widget.initialScale);
  }

  void _setScale(double scale) {
    final matrix = _transformationController.value.clone();
    final currentScale = matrix.getMaxScaleOnAxis();
    final scaleFactor = scale / currentScale;
    
    final focalPoint = Offset(
      MediaQuery.of(context).size.width / 2,
      MediaQuery.of(context).size.height / 2,
    );
    
    matrix.translate(focalPoint.dx, focalPoint.dy);
    matrix.scale(scaleFactor);
    matrix.translate(-focalPoint.dx, -focalPoint.dy);
    
    _transformationController.value = matrix;
  }

  void _toggleSplitScreen() {
    setState(() {
      _isSplitScreen = !_isSplitScreen;
    });
  }

  void _setSplitMode(SplitScreenMode mode) {
    setState(() {
      _splitMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildInteractiveViewer();
    
    if (!widget.enableSplitScreen || !_isSplitScreen) {
      return Stack(
        children: [
          content,
          if (widget.showControls) _buildControls(),
        ],
      );
    }

    return _buildSplitScreen(content);
  }

  Widget _buildInteractiveViewer() {
    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: widget.minScale,
      maxScale: widget.maxScale,
      panEnabled: true,
      scaleEnabled: true,
      boundaryMargin: const EdgeInsets.all(double.infinity),
      child: Container(
        color: widget.backgroundColor ?? Colors.grey[100],
        child: widget.child,
      ),
    );
  }

  Widget _buildSplitScreen(Widget content) {
    if (_splitMode == SplitScreenMode.horizontal) {
      return Row(
        children: [
          Expanded(child: content),
          Container(width: 2, color: Colors.grey[400]),
          Expanded(child: _buildInteractiveViewer()),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(child: content),
          Container(height: 2, color: Colors.grey[400]),
          Expanded(child: _buildInteractiveViewer()),
        ],
      );
    }
  }

  Widget _buildControls() {
    return Positioned(
      top: 16,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Zoom Controls
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Zoom In Button
                _ControlButton(
                  icon: Icons.add,
                  tooltip: 'Zoom In',
                  onPressed: _zoomIn,
                  enabled: _currentScale < widget.maxScale,
                ),
                // Divider
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                // Zoom Out Button
                _ControlButton(
                  icon: Icons.remove,
                  tooltip: 'Zoom Out',
                  onPressed: _zoomOut,
                  enabled: _currentScale > widget.minScale,
                ),
                // Divider
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                // Reset Button
                _ControlButton(
                  icon: Icons.refresh,
                  tooltip: 'Reset View',
                  onPressed: _resetView,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Split Screen Controls
          if (widget.enableSplitScreen) ...[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ControlButton(
                    icon: _isSplitScreen ? Icons.close_fullscreen : Icons.splitscreen,
                    tooltip: _isSplitScreen ? 'Exit Split Screen' : 'Split Screen',
                    onPressed: _toggleSplitScreen,
                    isActive: _isSplitScreen,
                  ),
                  if (_isSplitScreen) ...[
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    _ControlButton(
                      icon: Icons.swap_horiz,
                      tooltip: 'Horizontal Split',
                      onPressed: () => _setSplitMode(SplitScreenMode.horizontal),
                      isActive: _splitMode == SplitScreenMode.horizontal,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    _ControlButton(
                      icon: Icons.swap_vert,
                      tooltip: 'Vertical Split',
                      onPressed: () => _setSplitMode(SplitScreenMode.vertical),
                      isActive: _splitMode == SplitScreenMode.vertical,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
          // Zoom Level Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              '${(_currentScale * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum SplitScreenMode {
  horizontal,
  vertical,
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isActive;

  const _ControlButton({
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.enabled = true,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              size: 20,
              color: enabled
                  ? (isActive ? Colors.blue : Colors.black87)
                  : Colors.grey[400],
            ),
          ),
        ),
      ),
    );
  }
}






