import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kuick_workflow/src/core/widgets/interactive_viewer_example.dart' show TransformProvider;

/// A draggable box widget that can be moved around on a canvas
class DraggableBox extends StatefulWidget {
  final String id;
  final Offset initialPosition;
  final Color color;
  final String label;
  final IconData icon;
  final ValueChanged<Offset>? onPositionChanged;

  const DraggableBox({
    super.key,
    required this.id,
    required this.initialPosition,
    required this.color,
    required this.label,
    required this.icon,
    this.onPositionChanged,
  });

  @override
  State<DraggableBox> createState() => _DraggableBoxState();
}

class _DraggableBoxState extends State<DraggableBox> {
  late Offset _position;
  bool _isDragging = false;
  Offset? _dragStartPosition;
  Offset? _dragStartLocalPosition;

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition;
  }

  void _handlePointerDown(PointerDownEvent event) {
    setState(() {
      _isDragging = true;
      _dragStartPosition = _position;
      _dragStartLocalPosition = event.localPosition;
    });
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (_isDragging && _dragStartPosition != null && _dragStartLocalPosition != null) {
      final delta = event.localPosition - _dragStartLocalPosition!;
      
      // Get the transform from the provider to account for zoom
      final transformProvider = TransformProvider.of(context);
      final scale = transformProvider?.scale ?? 1.0;
      
      // Adjust delta by scale to maintain consistent dragging
      final adjustedDelta = delta / scale;
      
      setState(() {
        _position = _dragStartPosition! + adjustedDelta;
      });
      
      widget.onPositionChanged?.call(_position);
    }
  }

  void _handlePointerUp(PointerUpEvent event) {
    setState(() {
      _isDragging = false;
      _dragStartPosition = null;
      _dragStartLocalPosition = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: Listener(
        onPointerDown: _handlePointerDown,
        onPointerMove: _handlePointerMove,
        onPointerUp: _handlePointerUp,
        child: MouseRegion(
          cursor: _isDragging ? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
          child: Transform.scale(
            scale: _isDragging ? 1.05 : 1.0,
            child: Container(
              width: 150,
              height: 120,
              decoration: BoxDecoration(
                color: _isDragging ? widget.color.withOpacity(0.9) : widget.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isDragging ? Colors.blue : Colors.black26,
                  width: _isDragging ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isDragging ? 0.3 : 0.15),
                    blurRadius: _isDragging ? 12 : 8,
                    offset: Offset(0, _isDragging ? 6 : 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    size: 32,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// TransformProvider is imported from interactive_viewer_example.dart

