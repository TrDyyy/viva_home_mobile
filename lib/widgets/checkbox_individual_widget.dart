import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viva_home_mobile/cubits/checkbox_tree_cubit.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import '../models/checkbox_node.dart';

class IndividualCheckboxWidget extends StatelessWidget {
  final String nodeKey;
  final Widget? customTitle;
  final EdgeInsets? padding;
  final bool showtitle;

  const IndividualCheckboxWidget({
    super.key,
    required this.nodeKey,
    this.customTitle,
    this.padding,
    this.showtitle = true,
  });

  const IndividualCheckboxWidget.standalone({
    super.key,
    required this.nodeKey,
    this.customTitle,
    this.padding,
    this.showtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalTreeManager, GlobalTreeState>(
      builder: (context, state) {
        final node = state.allNodes[nodeKey];
        if (node == null) {
          return Text('Node $nodeKey not found');
        }
        return _buildNodeRow(context, node);
      },
    );
  }

  Widget _buildNodeRow(BuildContext context, CheckBoxTreeNode node) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Checkbox(
            value: node.isChecked,
            checkColor: AppColors.white,
            fillColor: WidgetStateProperty.all(node.isChecked ? AppColors.primaryTeal : AppColors.transparent),
            onChanged: node.isEnabled && node.checkSource == CheckSource.manual
                ? (value) => context.read<GlobalTreeManager>().toggleNode(nodeKey, value ?? false)
                : null,
          ),
          if (showtitle)
            Expanded(
              child: customTitle ?? Text(node.title!, style: Theme.of(context).textTheme.bodyMedium),
            ),
        ],
      ),
    );
  }
}