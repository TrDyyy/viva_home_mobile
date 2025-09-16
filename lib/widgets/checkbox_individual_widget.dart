import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viva_home_mobile/cubits/checkbox_tree_cubit.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import '../models/checkbox_node.dart';

class IndividualCheckboxWidget extends StatelessWidget {
  final String nodeKey;
  final bool showPath;
  final bool showRelationships;
  final Widget? customTitle;
  final EdgeInsets? padding;
  final bool? showtitle;

  // Tree display options
  final bool showAsTree;
  final bool expandChildren;
  final bool showChildrenCount;
  final double indentation;

  const IndividualCheckboxWidget({
    super.key,
    required this.nodeKey,
    this.showPath = false,
    this.showRelationships = false,
    this.customTitle,
    this.padding,
    this.showAsTree = false,
    this.expandChildren = false,
    this.showChildrenCount = false,
    this.indentation = 16.0,
    this.showtitle = true,
  });

  const IndividualCheckboxWidget.asTreeNode({
    super.key,
    required this.nodeKey,
    this.expandChildren = true,
    this.indentation = 16.0,
    this.showtitle = true,
  }) : showPath = false,
       showRelationships = false,
       customTitle = null,
       padding = null,
       showAsTree = true,
       showChildrenCount = true;

  const IndividualCheckboxWidget.standalone({
    super.key,
    required this.nodeKey,
    this.showPath = false,
    this.showRelationships = false,
    this.customTitle,
    this.padding,
    this.showChildrenCount = false,
    this.showtitle = true,
  }) : showAsTree = false,
       expandChildren = false,
       indentation = 0.0;

  const IndividualCheckboxWidget.detailed({
    super.key,
    required this.nodeKey,
    this.customTitle,
    this.padding,
    this.showtitle = true,
  }) : showPath = true,
       showRelationships = true,
       showAsTree = false,
       expandChildren = false,
       showChildrenCount = true,
       indentation = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalTreeManager, GlobalTreeState>(
      builder: (context, state) {
        final node = state.allNodes[nodeKey];

        if (node == null) {
          return Text('Node $nodeKey not found');
        }

        if (showAsTree && node.hasChildren) {
          return _buildTreeView(context, node, state);
        } else {
          return _buildStandaloneView(context, node, state);
        }
      },
    );
  }

  // Tree view
  Widget _buildTreeView(
    BuildContext context,
    TreeNode node,
    GlobalTreeState state,
  ) {
    return Column(
      children: [
        _buildNodeRow(context, node, state),
        if (expandChildren && node.hasChildren)
          ...node.childKeys.map(
            (childKey) => Padding(
              padding: EdgeInsets.only(left: indentation),
              child: IndividualCheckboxWidget.asTreeNode(
                nodeKey: childKey,
                indentation: indentation,
              ),
            ),
          ),
      ],
    );
  }

  // Standalone view
  Widget _buildStandaloneView(
    BuildContext context,
    TreeNode node,
    GlobalTreeState state,
  ) {
    return _buildNodeRow(context, node, state);
  }

  // Core node row widget
  Widget _buildNodeRow(
    BuildContext context,
    TreeNode node,
    GlobalTreeState state,
  ) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Checkbox(
            value: node.isChecked,
            checkColor: AppColors.white,
            fillColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primaryTeal; 
              }
              return AppColors.transparent; 
            }),
            onChanged: node.isEnabled && node.checkSource == CheckSource.manual
                ? (value) => context.read<GlobalTreeManager>().toggleNode(
                    nodeKey,
                    value ?? false,
                  )
                : null,
          ),
          if (showtitle == true) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child:
                            customTitle ??
                            Text(
                              node.title!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                      ),
                      if (showChildrenCount && node.hasChildren)
                        _buildChildrenCountBadge(node),
                    ],
                  ),
                  if (showPath) _buildPathInfo(context, node),
                  if (showRelationships)
                    _buildRelationshipInfo(context, node, state),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Children count badge
  Widget _buildChildrenCountBadge(TreeNode node) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '${node.childKeys.length}',
        style: const TextStyle(
          fontSize: 10,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPathInfo(BuildContext context, TreeNode node) {
    return Text(
      'Path: ${node.treePath} (Level ${node.level})',
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
    );
  }

  Widget _buildRelationshipInfo(
    BuildContext context,
    TreeNode node,
    GlobalTreeState state,
  ) {
    final parentTitle = node.parentKey != null
        ? state.allNodes[node.parentKey!]?.title ?? 'Unknown'
        : 'Root';

    final childrenCount = node.childKeys.length;

    return Text(
      'Parent: $parentTitle | Children: $childrenCount',
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
    );
  }
}
