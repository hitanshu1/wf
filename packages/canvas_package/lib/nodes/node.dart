import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import '../ports/capsule_half.dart';
import '../ports/port.dart';
import '../shared/json_converters.dart';
import 'node_shape.dart';

enum KuickNodeShape{
  circle,
  rectangle,
  hexagonVertical,
  hexagonHorizontal,
  chatBubble,
  diamond
}

extension KuickNodeShapeX on KuickNodeShape {
  static KuickNodeShape fromJson(String? value) {
    if (value == null) return KuickNodeShape.rectangle;

    return KuickNodeShape.values.firstWhere(
          (e) => e.name == value,
      orElse: () => KuickNodeShape.rectangle,
    );
  }

  String toJson() => name;
}

class Node<T> {
  Node({
    required this.id,
    required this.type,
    required Offset position,
    required this.data,
    this.nodeShape = KuickNodeShape.rectangle,
    Size? size,
    List<Port> inputPorts = const [],
    List<Port> outputPorts = const [],
    int initialZIndex = 0,
  }) : size = Observable(size ?? const Size(150, 100)),
        position = Observable(position),
        visualPosition = Observable(position),
        zIndex = Observable(initialZIndex),
        selected = Observable(false),
        dragging = Observable(false),
        inputPorts = ObservableList.of(inputPorts),
        outputPorts = ObservableList.of(outputPorts);

  final String id;

  final String type;

  final Observable<Size> size;

  final KuickNodeShape? nodeShape;

  final ObservableList<Port> inputPorts;

  final ObservableList<Port> outputPorts;

  final T data;

  final Observable<Offset> position;

  final Observable<int> zIndex;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Observable<bool> selected;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Observable<bool> dragging;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final Observable<Offset> visualPosition;

  int get currentZIndex => zIndex.value;

  set currentZIndex(int value) => runInAction(() => zIndex.value = value);

  bool get isSelected => selected.value;

  set isSelected(bool value) => runInAction(() => selected.value = value);

  bool get isDragging => dragging.value;

  set isDragging(bool value) => runInAction(() => dragging.value = value);

  void setVisualPosition(Offset snappedPosition) {
    runInAction(() {
      visualPosition.value = snappedPosition;
    });
  }

  Offset getVisualPortPosition(
      String portId, {
        required double portSize,
        EdgeInsets padding = EdgeInsets.zero,
        NodeShape? shape,
      }) {
    final port = [
      ...inputPorts,
      ...outputPorts,
    ].cast<Port?>().firstWhere((p) => p?.id == portId, orElse: () => null);

    if (port == null) {
      throw ArgumentError('Port $portId not found');
    }

    if (shape != null) {
      final insetSize = Size(
        size.value.width - padding.left - padding.right,
        size.value.height - padding.top - padding.bottom,
      );

      final anchors = shape.getPortAnchors(insetSize);
      final anchor = anchors.firstWhere(
            (a) => a.position == port.position,
        orElse: () => _fallbackAnchor(port.position, insetSize),
      );

      return Offset(padding.left, padding.top) +
          anchor.offset +
          port.offset -
          Offset(portSize / 2, portSize / 2);
    }

    switch (port.position) {
      case PortPosition.left:
        return Offset(port.offset.dx, port.offset.dy);
      case PortPosition.right:
        return Offset(
          size.value.width - portSize + port.offset.dx,
          port.offset.dy,
        );
      case PortPosition.top:
        return Offset(port.offset.dx, port.offset.dy);
      case PortPosition.bottom:
        return Offset(
          port.offset.dx,
          size.value.height - portSize + port.offset.dy,
        );
    }
  }

  PortAnchor _fallbackAnchor(PortPosition position, [Size? shapeSize]) {
    final effectiveSize = shapeSize ?? size.value;
    final centerX = effectiveSize.width / 2;
    final centerY = effectiveSize.height / 2;

    switch (position) {
      case PortPosition.left:
        return PortAnchor(
          position: PortPosition.left,
          offset: Offset(0, centerY),
          normal: const Offset(-1, 0),
        );
      case PortPosition.right:
        return PortAnchor(
          position: PortPosition.right,
          offset: Offset(effectiveSize.width, centerY),
          normal: const Offset(1, 0),
        );
      case PortPosition.top:
        return PortAnchor(
          position: PortPosition.top,
          offset: Offset(centerX, 0),
          normal: const Offset(0, -1),
        );
      case PortPosition.bottom:
        return PortAnchor(
          position: PortPosition.bottom,
          offset: Offset(centerX, effectiveSize.height),
          normal: const Offset(0, 1),
        );
    }
  }

  Offset getPortPosition(
      String portId, {
        required double portSize,
        EdgeInsets? padding,
        NodeShape? shape,
      }) {
    final portHalfSize = portSize / 2;

    final effectivePadding = shape != null
        ? (padding ?? const EdgeInsets.all(4.0))
        : EdgeInsets.zero;

    return visualPosition.value +
        getVisualPortPosition(
          portId,
          portSize: portSize,
          padding: effectivePadding,
          shape: shape,
        ) +
        Offset(portHalfSize, portHalfSize);
  }

  CapsuleFlatSide getPortCapsuleSide(String portId) {
    final port = [
      ...inputPorts,
      ...outputPorts,
    ].cast<Port?>().firstWhere((p) => p?.id == portId, orElse: () => null);

    if (port == null) {
      throw ArgumentError('Port $portId not found');
    }

    switch (port.position) {
      case PortPosition.left:
        return CapsuleFlatSide.left;
      case PortPosition.right:
        return CapsuleFlatSide.right;
      case PortPosition.top:
        return CapsuleFlatSide.top;
      case PortPosition.bottom:
        return CapsuleFlatSide.bottom;
    }
  }

  void addInputPort(Port port) {
    runInAction(() {
      inputPorts.add(port);
    });
  }

  void addOutputPort(Port port) {
    runInAction(() {
      outputPorts.add(port);
    });
  }

  bool removeInputPort(String portId) {
    return runInAction(() {
      final index = inputPorts.indexWhere((port) => port.id == portId);
      if (index >= 0) {
        inputPorts.removeAt(index);
        return true;
      }
      return false;
    });
  }

  bool removeOutputPort(String portId) {
    return runInAction(() {
      final index = outputPorts.indexWhere((port) => port.id == portId);
      if (index >= 0) {
        outputPorts.removeAt(index);
        return true;
      }
      return false;
    });
  }

  bool removePort(String portId) {
    return removeInputPort(portId) || removeOutputPort(portId);
  }

  bool updateInputPort(String portId, Port updatedPort) {
    return runInAction(() {
      final index = inputPorts.indexWhere((port) => port.id == portId);
      if (index >= 0) {
        inputPorts[index] = updatedPort;
        return true;
      }
      return false;
    });
  }

  bool updateOutputPort(String portId, Port updatedPort) {
    return runInAction(() {
      final index = outputPorts.indexWhere((port) => port.id == portId);
      if (index >= 0) {
        outputPorts[index] = updatedPort;
        return true;
      }
      return false;
    });
  }

  bool updatePort(String portId, Port updatedPort) {
    return updateInputPort(portId, updatedPort) ||
        updateOutputPort(portId, updatedPort);
  }

  List<Port> get allPorts => [...inputPorts, ...outputPorts];

  Port? findPort(String portId) {
    try {
      return inputPorts.firstWhere((port) => port.id == portId);
    } catch (_) {
      try {
        return outputPorts.firstWhere((port) => port.id == portId);
      } catch (_) {
        return null;
      }
    }
  }

  bool containsPoint(Offset point, {double portSize = 11.0}) {
    return Rect.fromLTWH(
      position.value.dx,
      position.value.dy,
      size.value.width,
      size.value.height,
    ).contains(point);
  }

  Rect getBounds({double portSize = 11.0}) {
    return Rect.fromLTWH(
      position.value.dx,
      position.value.dy,
      size.value.width,
      size.value.height,
    );
  }

  void dispose() {}

  factory Node.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return Node<T>(
      id: json['id'] as String,
      type: json['type'] as String,
      position: json['position'] != null
          ? const OffsetConverter().fromJson(json['position'])
          : Offset.zero,

      // ⭐ ENUM PARSING HERE
      nodeShape: KuickNodeShapeX.fromJson(json['nodeShape'] as String?),

      data: fromJsonT(json['data']),
      size: json['size'] != null
          ? const SizeConverter().fromJson(json['size'])
          : null,
      inputPorts: (json['inputPorts'] as List<dynamic>?)
          ?.map((e) => Port.fromJson(Map<String, dynamic>.from(e)))
          .toList() ??
          const [],
      outputPorts: (json['outputPorts'] as List<dynamic>?)
          ?.map((e) => Port.fromJson(Map<String, dynamic>.from(e)))
          .toList() ??
          const [],
      initialZIndex: (json['zIndex'] as num?)?.toInt() ?? 0,
    )
      ..position.value = json['position'] != null
          ? const OffsetConverter().fromJson(json['position'])
          : Offset.zero
      ..zIndex.value = (json['zIndex'] as num?)?.toInt() ?? 0
      ..selected.value = (json['selected'] as bool?) ?? false;
  }


  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => {
    'id': id,
    'type': type,
    'nodeShape': nodeShape?.toJson(),
    'size': const SizeConverter().toJson(size.value),
    'inputPorts': inputPorts.map((e) => e.toJson()).toList(),
    'outputPorts': outputPorts.map((e) => e.toJson()).toList(),
    'data': toJsonT(data),
    'position': const OffsetConverter().toJson(position.value),
    'zIndex': zIndex.value,
    'selected': selected.value,
  };

}
