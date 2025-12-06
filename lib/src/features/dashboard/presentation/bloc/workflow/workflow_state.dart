import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/models/node_templates.dart';
import '../../../data/models/workflow_node.dart';

class WorkflowState extends Equatable {
  final List<WorkflowNode> nodes;
  final List<Connection> connections;
  final WorkflowNode? selectedNode;
  final bool isDragging;
  final Offset panOffset;
  final double scale;
  final double animationValue;

  const WorkflowState({
    this.nodes = const [],
    this.connections = const [],
    this.selectedNode,
    this.isDragging = false,
    this.panOffset = Offset.zero,
    this.scale = 1.0,
    this.animationValue = 0.0,
  });

  List<WorkflowNode> get availableNodes => NodeTemplates.getAvailableNodes();

  WorkflowState copyWith({
    List<WorkflowNode>? nodes,
    List<Connection>? connections,
    WorkflowNode? selectedNode,
    bool? isDragging,
    Offset? panOffset,
    double? scale,
    double? animationValue,
    bool clearSelectedNode = false,
  }) {
    return WorkflowState(
      nodes: nodes ?? this.nodes,
      connections: connections ?? this.connections,
      selectedNode: clearSelectedNode ? null : (selectedNode ?? this.selectedNode),
      isDragging: isDragging ?? this.isDragging,
      panOffset: panOffset ?? this.panOffset,
      scale: scale ?? this.scale,
      animationValue: animationValue ?? this.animationValue,
    );
  }

  @override
  List<Object?> get props => [
    nodes,
    connections,
    selectedNode,
    isDragging,
    panOffset,
    scale,
    animationValue,
  ];
}