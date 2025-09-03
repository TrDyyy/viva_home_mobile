import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viva_home_mobile/models/checkbox_node.dart';

class GlobalTreeState {
  final Map<String, TreeNode> allNodes;
  GlobalTreeState({required this.allNodes});

  GlobalTreeState copyWith({Map<String, TreeNode>? allNodes}) {
    return GlobalTreeState(allNodes: allNodes ?? this.allNodes);
  }
}

class GlobalTreeManager extends Cubit<GlobalTreeState> {
  GlobalTreeManager() : super(GlobalTreeState(allNodes: {}));

  void initializeNodes(Map<String, TreeNode> nodes) {
    emit(GlobalTreeState(allNodes: nodes));
  }

  void toggleNode(String nodeKey, bool isChecked) {
    final updatedNodes = Map<String, TreeNode>.from(state.allNodes);
    final node = updatedNodes[nodeKey];
    if (node == null || !node.isEnabled) return;

    //Update current node
    updatedNodes[nodeKey] = node.copyWith(isChecked: isChecked);

    // Update parent based on children states
    if (node.parentKey != null) {
      _updateParent(updatedNodes, node.parentKey!);
    }

    if (isChecked && node.childKeys.isNotEmpty) {
      _updateChildren(updatedNodes, node.childKeys, true);
    } else if (!isChecked && node.childKeys.isNotEmpty) {
      _updateChildren(updatedNodes, node.childKeys, false);
    }

    emit(GlobalTreeState(allNodes: updatedNodes));
  }

  void _updateChildren(
    Map<String, TreeNode> nodes,
    List<String> childKeys,
    bool isChecked,
  ) {
    for (final childKey in childKeys) {
      final child = nodes[childKey];
      if (child == null) continue;
      
      if (child.checkSource == CheckSource.manual) {
        nodes[childKey] = child.copyWith(isChecked: isChecked);
      }
      _updateChildren(nodes, child.childKeys, isChecked);
    }
  }

  void _updateParent(Map<String, TreeNode> nodes, String parentKey) {
    final parent = nodes[parentKey];
    if (parent == null || parent.checkSource != CheckSource.auto) return;
    final childrenStates = parent.childKeys
        .map((childKey) => nodes[childKey]?.isChecked ?? false)
        .toList();

    if (childrenStates.isEmpty) return;
    // Parent is checked only if all children are checked
    final shouldCheck = childrenStates.every((checked) => checked);
    if (parent.isChecked != shouldCheck) {
      nodes[parentKey] = parent.copyWith(isChecked: shouldCheck);
    }

    if (parent.parentKey != null) {
      _updateParent(nodes, parent.parentKey!);
    }
  }

  TreeNode? getNode(String nodeKey) {
    return state.allNodes[nodeKey];
  }

  List<TreeNode> getNodesByKeys(List<String> nodeKeys) {
    return nodeKeys
        .map((key) => state.allNodes[key])
        .whereType<TreeNode>()
        .toList();
  }
}
