import 'dart:io';

import 'package:canvas_package/kuick_canvas.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../graph/grid_styles.dart';
import '../graph/node_flow_controller.dart';
import '../graph/node_flow_editor.dart';
import '../graph/node_flow_theme.dart';
import '../model/kuick_node_data_model.dart';
import '../nodes/node.dart';
import '../nodes/node_widget.dart';
import '../ports/port.dart';

class KuickCanvas<T> extends StatefulWidget {
  final NodeFlowController<T> controller;
  final List<KuickNode<T>> initialNodes;
  final Widget Function(BuildContext, Node<T>) nodeBuilder;
  final double gridSize;
  final NodeFlowTheme theme;
  final double portSize;
  final SystemMouseCursor? cursorStyle;
  final ValueChanged<bool>? onCanvasDraggingChanged;

  const KuickCanvas({
    super.key,
    required this.controller,
    required this.initialNodes,
    required this.nodeBuilder,
    required this.gridSize,
    this.portSize = 24,
    required this.theme,
    this.cursorStyle,
    this.onCanvasDraggingChanged,
  });

  @override
  State<KuickCanvas<T>> createState() => _KuickCanvasState<T>();
}

class _KuickCanvasState<T> extends State<KuickCanvas<T>> {
  @override
  void initState() {
    super.initState();
    // add initial nodes after first frame so editor is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addInitialNodes();
    });
  }

  void _addInitialNodes() {

    final nodesById = <String, KuickNode<T>>{
      for (final node in widget.initialNodes)
        if ((node.id ?? '').isNotEmpty) node.id!: node,
    };

    for (final n in widget.initialNodes) {
      final width = (n.width ?? 100).toDouble();
      final height = (n.height ?? 100).toDouble();
      widget.controller.addNode(
        Node<T>(
          id: n.id ?? "",
          type: n.type ?? "",
          data: n.data as T,
          nodeShape: n.nodeShape,
          size: Size((n.width ?? 100).toDouble(), (n.height ?? 100).toDouble()),
          position: Offset((n.x ?? 0).toDouble(), (n.y ?? 0).toDouble()),
          inputPorts: [
            _createPort("in_top", PortPosition.top, height.toInt(), width.toInt()),
            _createPort("in_bottom", PortPosition.bottom, height.toInt(), width.toInt()),
            _createPort("in_left", PortPosition.left, height.toInt(), width.toInt()),
            _createPort("in_right", PortPosition.right, height.toInt(), width.toInt()),
          ],
          outputPorts: [
            _createPort("out_top", PortPosition.top, height.toInt(), width.toInt(), multi: true),
            _createPort("out_bottom", PortPosition.bottom, height.toInt(), width.toInt(), multi: true),
            _createPort("out_left", PortPosition.left, height.toInt(), width.toInt(), multi: true),
            _createPort("out_right", PortPosition.right, height.toInt(), width.toInt(), multi: true),
          ],
        ),
      );
    }

    // create connections after nodes added; schedule on next frame to be safe
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var n in widget.initialNodes) {
        final parentId = n.id ?? "";
        final children = n.children;
        for (var rawChild in (children?.bottom ?? <Bottom>[])) {
          try {
          var direction =  _portsFromDirection("bottom");
            widget.controller.createConnection(
              parentId,
              direction.parentPortId,
              rawChild.serverId!,
              direction.childPortId,
            );
          } catch (e) {
            debugPrint('Initial connection failed: $e');
          }
        }
        for (var rawChild in (children?.left ?? <Bottom>[])) {
          try {
          var direction =  _portsFromDirection("left");
            widget.controller.createConnection(
              parentId,
              direction.parentPortId,
              rawChild.serverId!,
              direction.childPortId,
            );
          } catch (e) {
            debugPrint('Initial connection failed: $e');
          }
        }
        for (var rawChild in (children?.right ?? <Bottom>[])) {
          try {
          var direction =  _portsFromDirection("right");
            widget.controller.createConnection(
              parentId,
              direction.parentPortId,
              rawChild.serverId!,
              direction.childPortId,
            );
          } catch (e) {
            debugPrint('Initial connection failed: $e');
          }
        }
        for (var rawChild in (children?.top ?? <Bottom>[])) {
          try {
          var direction =  _portsFromDirection("top");
            widget.controller.createConnection(
              parentId,
              direction.parentPortId,
              rawChild.serverId!,
              direction.childPortId,
            );
          } catch (e) {
            debugPrint('Initial connection failed: $e');
          }
        }
      }
    });
  }

  _ConnectionPorts _inferConnectionDirection(
    KuickNode<T>? parent,
    KuickNode<T>? child,
    double fallbackWidth,
    double fallbackHeight,
  ) {
    if (parent == null || child == null) {
      return const _ConnectionPorts(parentPortId: "out_bottom", childPortId: "in_top");
    }

    final parentWidth = (parent.width ?? fallbackWidth).toDouble();
    final parentHeight = (parent.height ?? fallbackHeight).toDouble();
    final childWidth = (child.width ?? fallbackWidth).toDouble();
    final childHeight = (child.height ?? fallbackHeight).toDouble();

    final parentCenter = Offset(
      (parent.x ?? 0).toDouble() + parentWidth / 2,
      (parent.y ?? 0).toDouble() + parentHeight / 2,
    );
    final childCenter = Offset(
      (child.x ?? 0).toDouble() + childWidth / 2,
      (child.y ?? 0).toDouble() + childHeight / 2,
    );

    final dx = childCenter.dx - parentCenter.dx;
    final dy = childCenter.dy - parentCenter.dy;
    const horizontalThreshold = 60.0;
    const verticalThreshold = 60.0;

    if (dx.abs() >= horizontalThreshold) {
      return dx >= 0
          ? const _ConnectionPorts(parentPortId: "out_right", childPortId: "in_left")
          : const _ConnectionPorts(parentPortId: "out_left", childPortId: "in_right");
    }

    if (dy.abs() >= verticalThreshold) {
      return dy >= 0
          ? const _ConnectionPorts(parentPortId: "out_bottom", childPortId: "in_top")
          : const _ConnectionPorts(parentPortId: "out_top", childPortId: "in_bottom");
    }

    // Default to bottom if movement is minimal.
    return const _ConnectionPorts(parentPortId: "out_bottom", childPortId: "in_top");
  }

  _ConnectionPorts _portsFromDirection(String direction) {
    switch (direction) {
      case 'top':
        return const _ConnectionPorts(parentPortId: "out_top", childPortId: "in_bottom");
      case 'bottom':
        return const _ConnectionPorts(parentPortId: "out_bottom", childPortId: "in_top");
      case 'left':
        return const _ConnectionPorts(parentPortId: "out_left", childPortId: "in_right");
      case 'right':
        return const _ConnectionPorts(parentPortId: "out_right", childPortId: "in_left");
    }
    return const _ConnectionPorts(parentPortId: "out_bottom", childPortId: "in_top");
  }

  Port _createPort(
      String id,
      PortPosition pos,
      int height,
      int width, {
        bool multi = false,
      }) {
    Offset offset;
    switch (pos) {
      case PortPosition.top:
      case PortPosition.bottom:
        offset = Offset(width / 2, 0);
        break;
      default:
        offset = Offset(0, height / 2 );
    }

    return Port(
      id: id,
      name: id,
      position: pos,
      offset: offset,
      multiConnections: multi,
      isConnectable: true,
      showLabel: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseTheme = widget.theme;
    final customTheme = baseTheme.copyWith(
      gridStyle: GridStyles.lines,
      gridSize: widget.gridSize,
      gridColor: Colors.grey,
      gridThickness: 0.008,
      backgroundColor: widget.theme == NodeFlowTheme.light ? Color(0xFFDADADA) : Color(0xFF696969),
      nodeTheme: baseTheme.nodeTheme,
      cursorStyle: widget.cursorStyle ?? baseTheme.cursorStyle,
      nodeCursorStyle: widget.cursorStyle ?? baseTheme.nodeCursorStyle,
      portTheme: baseTheme.portTheme.copyWith(
        size: 1,
        borderWidth: 0,
        color: Colors.transparent,
        connectedColor: Colors.transparent,
        snappingColor: Colors.transparent,
      ),
    );

    return Scaffold(
      body: Listener(
        onPointerSignal: _handlePointerSignal,
        child: NodeFlowEditor<T>(
          controller: widget.controller,
          theme: customTheme,
          enableConnectionCreation: false,
          enableZooming: false,
          scrollToZoom: false,
          onCanvasPanStateChanged: widget.onCanvasDraggingChanged,
          nodeContainerBuilder: (context, node, content) => NodeWidget(
            backgroundColor: Colors.transparent,
            borderColor: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            selectedBackgroundColor: Colors.transparent,
            selectedBorderColor: Colors.transparent,
            selectedBorderWidth: 0,
            borderWidth: 0,
            // shape: getNodeShape(node.nodeShape ?? KuickNodeShape.rectangle),
            padding: EdgeInsets.zero,
            key: ValueKey(node.id),
            node: node,
            child: content,
          ),
          nodeBuilder: widget.nodeBuilder,
        ),
      ),
    );
  }

  static const double _scrollSensitivity = 1.0;
  static const double _zoomSensitivity = 0.002;

  void _handlePointerSignal(PointerSignalEvent event) {
    // Accept either PointerScrollEvent (mouse wheel / two-finger scroll)
    // or PointerScaleEvent (pinch-to-zoom or platform-transformed scale events).
    if (event is PointerScrollEvent) {
      final shiftPressed = _isAnyModifierPressed(const [
        LogicalKeyboardKey.shiftLeft,
        LogicalKeyboardKey.shiftRight,
      ]);
      final metaPressed = _isAnyModifierPressed(const [
        LogicalKeyboardKey.metaLeft,
        LogicalKeyboardKey.metaRight,
      ]);
      final ctrlPressed = _isAnyModifierPressed(const [
        LogicalKeyboardKey.controlLeft,
        LogicalKeyboardKey.controlRight,
      ]);
      if (metaPressed || ctrlPressed) {
        _zoomWithScroll(event);
      } else {
        _panWithScroll(event, shiftPressed: shiftPressed);
      }
      return;
    }

    if (event is PointerScaleEvent) {
      final metaPressed = _isAnyModifierPressed(const [
        LogicalKeyboardKey.metaLeft,
        LogicalKeyboardKey.metaRight,
      ]);
      final ctrlPressed = _isAnyModifierPressed(const [
        LogicalKeyboardKey.controlLeft,
        LogicalKeyboardKey.controlRight,
      ]);

      if (metaPressed || ctrlPressed) {
        _zoomWithScale(event);
      } else {
        _zoomWithScale(event);
      }
      return;
    }
  }

  void _panWithScroll(PointerScrollEvent event, {required bool shiftPressed}) {
    double dx = event.scrollDelta.dx;
    double dy = event.scrollDelta.dy;

    if (shiftPressed) {
      dx += dy;
      dy = 0;
    }

    final delta = Offset(dx, dy) * _scrollSensitivity;
    if (delta == Offset.zero) return;

    widget.controller.panBy(-delta);
  }

  void _zoomWithScroll(PointerScrollEvent event) {
    final viewport = widget.controller.viewport;

    // Figma-like zoom curve
    final zoomFactor = 1 - (event.scrollDelta.dy * _zoomSensitivity);

    if (zoomFactor == 1.0) return;

    final minZoom = widget.controller.config.minZoom.value;
    final maxZoom = widget.controller.config.maxZoom.value;

    final targetZoom = (viewport.zoom * zoomFactor)
        .clamp(minZoom, maxZoom)
        .toDouble();

    if (targetZoom == viewport.zoom) return;

    // Cursor-centered zoom
    final focalGraphPoint = widget.controller.screenToWorld(
      event.localPosition,
    );

    final newX = event.localPosition.dx - focalGraphPoint.dx * targetZoom;
    final newY = event.localPosition.dy - focalGraphPoint.dy * targetZoom;

    widget.controller.setViewport(
      viewport.copyWith(x: newX, y: newY, zoom: targetZoom),
    );
  }

  void _zoomWithScale(PointerScaleEvent event) {
    final viewport = widget.controller.viewport;

    final scaleFactor = event.scale;
    if (scaleFactor == 1.0 || scaleFactor == 0.0) return;

    final minZoom = widget.controller.config.minZoom.value;
    final maxZoom = widget.controller.config.maxZoom.value;

    var targetZoom = (viewport.zoom * scaleFactor)
        .clamp(minZoom, maxZoom)
        .toDouble();
    if (targetZoom == viewport.zoom) return;

    final e = event as dynamic;
    Offset focal;
    try {
      final v = e.focalPoint;
      if (v is Offset) {
        focal = v;
      } else {
        throw Exception('not offset');
      }
    } catch (_) {
      try {
        final v = e.localPosition;
        if (v is Offset) {
          focal = v;
        } else {
          throw Exception('not offset');
        }
      } catch (_) {
        try {
          final v = e.position;
          if (v is Offset) {
            focal = v;
          } else {
            focal = Offset.zero;
          }
        } catch (_) {
          focal = Offset.zero;
        }
      }
    }
    final focalGraphPoint = widget.controller.screenToWorld(focal);

    final newX = focal.dx - focalGraphPoint.dx * targetZoom;
    final newY = focal.dy - focalGraphPoint.dy * targetZoom;

    widget.controller.setViewport(
      viewport.copyWith(x: newX, y: newY, zoom: targetZoom),
    );
  }

  bool _isAnyModifierPressed(List<LogicalKeyboardKey> keys) {
    final pressed = HardwareKeyboard.instance.logicalKeysPressed;
    return keys.any(pressed.contains);
  }
}

class _ConnectionPorts {
  final String parentPortId;
  final String childPortId;

  const _ConnectionPorts({
    required this.parentPortId,
    required this.childPortId,
  });
}


