import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/models/workflow_node.dart';

abstract class WorkflowEvent extends Equatable {
  const WorkflowEvent();

  @override
  List<Object?> get props => [];
}

class AddNodeEvent extends WorkflowEvent {
  final WorkflowNode node;

  const AddNodeEvent(this.node);

  @override
  List<Object?> get props => [node];
}

class RemoveNodeEvent extends WorkflowEvent {
  final String nodeId;

  const RemoveNodeEvent(this.nodeId);

  @override
  List<Object?> get props => [nodeId];
}

class UpdateNodePositionEvent extends WorkflowEvent {
  final String nodeId;
  final Offset position;

  const UpdateNodePositionEvent(this.nodeId, this.position);

  @override
  List<Object?> get props => [nodeId, position];
}

class SelectNodeEvent extends WorkflowEvent {
  final WorkflowNode? node;

  const SelectNodeEvent(this.node);

  @override
  List<Object?> get props => [node];
}

class AddConnectionEvent extends WorkflowEvent {
  final String fromNodeId;
  final String toNodeId;
  final String connectionType;

  const AddConnectionEvent({
    required this.fromNodeId,
    required this.toNodeId,
    this.connectionType = 'default',
  });

  @override
  List<Object?> get props => [fromNodeId, toNodeId, connectionType];
}

class RemoveConnectionEvent extends WorkflowEvent {
  final String connectionId;

  const RemoveConnectionEvent(this.connectionId);

  @override
  List<Object?> get props => [connectionId];
}

class SetDraggingEvent extends WorkflowEvent {
  final bool isDragging;

  const SetDraggingEvent(this.isDragging);

  @override
  List<Object?> get props => [isDragging];
}

class UpdatePanOffsetEvent extends WorkflowEvent {
  final Offset offset;

  const UpdatePanOffsetEvent(this.offset);

  @override
  List<Object?> get props => [offset];
}

class UpdateScaleEvent extends WorkflowEvent {
  final double scale;

  const UpdateScaleEvent(this.scale);

  @override
  List<Object?> get props => [scale];
}

class ClearWorkflowEvent extends WorkflowEvent {}

class UpdateAnimationValueEvent extends WorkflowEvent {
  final double animationValue;

  const UpdateAnimationValueEvent(this.animationValue);

  @override
  List<Object?> get props => [animationValue];
}