import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum NodeType {
  trigger,
  action,
  condition,
  success,
  failure,
}

NodeType _nodeTypeFromString(String? s) {
  switch (s) {
    case 'trigger':
      return NodeType.trigger;
    case 'action':
      return NodeType.action;
    case 'condition':
      return NodeType.condition;
    case 'success':
      return NodeType.success;
    case 'failure':
      return NodeType.failure;
    default:
      return NodeType.action;
  }
}

class WorkflowNode extends Equatable {
  final String id;
  final NodeType type;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Offset position;
  final Size size;
  final List<String> inputs;
  final List<String> outputs;
  final Map<String, dynamic> config;
  final bool isSelected;

  const WorkflowNode({
    required this.id,
    required this.type,
    required this.title,
    this.subtitle = '',
    required this.icon,
    required this.color,
    this.position = Offset.zero,
    this.size = const Size(200, 80),
    this.inputs = const [],
    this.outputs = const [],
    this.config = const {},
    this.isSelected = false,
  });

  factory WorkflowNode.create({
    required NodeType type,
    required String title,
    String subtitle = '',
    required IconData icon,
    required Color color,
    Offset position = Offset.zero,
  }) {
    final uuid = Uuid();
    return WorkflowNode(
      id: uuid.v4(),
      type: type,
      title: title,
      subtitle: subtitle,
      icon: icon,
      color: color,
      position: position,
    );
  }

  factory WorkflowNode.fromJson(Map<String, dynamic> json) {
    final pos = json['position'] ?? {};
    double dx = 0, dy = 0;
    if (pos is Map) {
      dx = (pos['dx'] is num) ? (pos['dx'] as num).toDouble() : 0.0;
      dy = (pos['dy'] is num) ? (pos['dy'] as num).toDouble() : 0.0;
    }

    final uuid = Uuid();
    return WorkflowNode(
      id: json['id']?.toString() ?? uuid.v4(),
      type: _nodeTypeFromString(json['type']?.toString()),
      title: json['label']?.toString() ?? json['title']?.toString() ?? '',
      subtitle: json['subTitle']?.toString() ?? '',
      icon: Icons.extension,
      color: Colors.blue,
      position: Offset(dx, dy),
      config: json,
    );
  }

  WorkflowNode copyWith({
    String? id,
    NodeType? type,
    String? title,
    String? subtitle,
    IconData? icon,
    Color? color,
    Offset? position,
    Size? size,
    List<String>? inputs,
    List<String>? outputs,
    Map<String, dynamic>? config,
    bool? isSelected,
  }) {
    return WorkflowNode(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      position: position ?? this.position,
      size: size ?? this.size,
      inputs: inputs ?? this.inputs,
      outputs: outputs ?? this.outputs,
      config: config ?? this.config,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        subtitle,
        icon,
        color,
        position,
        size,
        inputs,
        outputs,
        config,
        isSelected,
      ];
}

class Connection extends Equatable {
  final String id;
  final String fromNodeId;
  final String toNodeId;
  final String fromPort;
  final String toPort;
  final Color color;
  final String connectionType;

  const Connection({
    required this.id,
    required this.fromNodeId,
    required this.toNodeId,
    this.fromPort = 'output',
    this.toPort = 'input',
    required this.color,
    this.connectionType = 'default',
  });

  factory Connection.create({
    required String fromNodeId,
    required String toNodeId,
    String connectionType = 'default',
  }) {
    final uuid = Uuid();
    return Connection(
      id: uuid.v4(),
      fromNodeId: fromNodeId,
      toNodeId: toNodeId,
      connectionType: connectionType,
      color: _getConnectionColor(connectionType),
    );
  }

  static Color _getConnectionColor(String connectionType) {
    switch (connectionType) {
      case 'true':
        return Colors.green;
      case 'false':
        return Colors.red;
      case 'chat_model':
        return Colors.purple;
      case 'memory':
        return Colors.teal;
      case 'tool':
        return Colors.orange;
      default:
        return Colors.grey[600]!;
    }
  }

  @override
  List<Object?> get props => [
        id,
        fromNodeId,
        toNodeId,
        fromPort,
        toPort,
        color,
        connectionType,
      ];
}