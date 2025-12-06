import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/models/workflow_node.dart';
import 'workflow_event.dart';
import 'workflow_state.dart';

class WorkflowBloc extends Bloc<WorkflowEvent, WorkflowState> {
  late AnimationController _animationController;

  WorkflowBloc() : super(const WorkflowState()) {
    on<AddNodeEvent>(_onAddNode);
    on<RemoveNodeEvent>(_onRemoveNode);
    on<UpdateNodePositionEvent>(_onUpdateNodePosition);
    on<SelectNodeEvent>(_onSelectNode);
    on<AddConnectionEvent>(_onAddConnection);
    on<RemoveConnectionEvent>(_onRemoveConnection);
    on<SetDraggingEvent>(_onSetDragging);
    on<UpdatePanOffsetEvent>(_onUpdatePanOffset);
    on<UpdateScaleEvent>(_onUpdateScale);
    on<ClearWorkflowEvent>(_onClearWorkflow);
    on<UpdateAnimationValueEvent>(_onUpdateAnimationValue);
  }

  void setAnimationController(AnimationController controller) {
    _animationController = controller;
    _animationController.addListener(() {
      add(UpdateAnimationValueEvent(_animationController.value));
    });
  }

  void _onAddNode(AddNodeEvent event, Emitter<WorkflowState> emit) {
    final updatedNodes = List<WorkflowNode>.from(state.nodes)..add(event.node);
    emit(state.copyWith(nodes: updatedNodes));
  }

  void _onRemoveNode(RemoveNodeEvent event, Emitter<WorkflowState> emit) {
    final updatedNodes = state.nodes.where((node) => node.id != event.nodeId).toList();
    final updatedConnections = state.connections
        .where((conn) => conn.fromNodeId != event.nodeId && conn.toNodeId != event.nodeId)
        .toList();

    final clearSelectedNode = state.selectedNode?.id == event.nodeId;

    emit(state.copyWith(
      nodes: updatedNodes,
      connections: updatedConnections,
      clearSelectedNode: clearSelectedNode,
    ));
  }

  void _onUpdateNodePosition(UpdateNodePositionEvent event, Emitter<WorkflowState> emit) {
    final updatedNodes = state.nodes.map((node) {
      if (node.id == event.nodeId) {
        return node.copyWith(position: event.position);
      }
      return node;
    }).toList();

    emit(state.copyWith(nodes: updatedNodes));
  }

  void _onSelectNode(SelectNodeEvent event, Emitter<WorkflowState> emit) {
    // Deselect all nodes first
    final updatedNodes = state.nodes.map((node) => node.copyWith(isSelected: false)).toList();

    // Select the target node if provided
    if (event.node != null) {
      final nodeIndex = updatedNodes.indexWhere((n) => n.id == event.node!.id);
      if (nodeIndex != -1) {
        updatedNodes[nodeIndex] = updatedNodes[nodeIndex].copyWith(isSelected: true);
      }
    }

    emit(state.copyWith(
      nodes: updatedNodes,
      selectedNode: event.node,
    ));
  }

  void _onAddConnection(AddConnectionEvent event, Emitter<WorkflowState> emit) {
    // Check if connection already exists
    final exists = state.connections.any((conn) =>
    conn.fromNodeId == event.fromNodeId &&
        conn.toNodeId == event.toNodeId &&
        conn.connectionType == event.connectionType);

    if (!exists) {
      final connection = Connection.create(
        fromNodeId: event.fromNodeId,
        toNodeId: event.toNodeId,
        connectionType: event.connectionType,
      );

      final updatedConnections = List<Connection>.from(state.connections)..add(connection);
      emit(state.copyWith(connections: updatedConnections));
    }
  }

  void _onRemoveConnection(RemoveConnectionEvent event, Emitter<WorkflowState> emit) {
    final updatedConnections = state.connections
        .where((conn) => conn.id != event.connectionId)
        .toList();
    emit(state.copyWith(connections: updatedConnections));
  }

  void _onSetDragging(SetDraggingEvent event, Emitter<WorkflowState> emit) {
    emit(state.copyWith(isDragging: event.isDragging));
  }

  void _onUpdatePanOffset(UpdatePanOffsetEvent event, Emitter<WorkflowState> emit) {
    emit(state.copyWith(panOffset: event.offset));
  }

  void _onUpdateScale(UpdateScaleEvent event, Emitter<WorkflowState> emit) {
    final clampedScale = event.scale.clamp(0.5, 2.0);
    emit(state.copyWith(scale: clampedScale));
  }

  void _onClearWorkflow(ClearWorkflowEvent event, Emitter<WorkflowState> emit) {
    emit(const WorkflowState());
  }

  void _onUpdateAnimationValue(UpdateAnimationValueEvent event, Emitter<WorkflowState> emit) {
    emit(state.copyWith(animationValue: event.animationValue));
  }

  @override
  Future<void> close() {
    _animationController.dispose();
    return super.close();
  }
}