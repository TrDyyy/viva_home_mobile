import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viva_home_mobile/cubits/checkbox_tree_cubit.dart';
import 'package:viva_home_mobile/models/tree_config.dart';
import '../../widgets/checkbox_individual_widget.dart';

class TreePage extends StatefulWidget {
  const TreePage({super.key});

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  @override
  void initState() {
    super.initState();
    _initializeTreeData();
  }

  void _initializeTreeData() {
    // Sử dụng config để load tất cả trees
    context.read<GlobalTreeManager>().initializeNodes(
      CheckboxTreesConfig.allTrees
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flexible Checkbox Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Traditional tree view
            _buildSection('Traditional Tree View', [
              const IndividualCheckboxWidget.asTreeNode(nodeKey: 'prop_main'),
              const SizedBox(height: 10),
              const IndividualCheckboxWidget.asTreeNode(nodeKey: 'serv_main'),
            ]),

            const Divider(height: 40),

            // Example 2: Individual scattered checkboxes
            _buildSection('Scattered Individual Checkboxes', [
              const Text('Random selection from different trees:'),
              const SizedBox(height: 10),
              const IndividualCheckboxWidget.detailed(nodeKey: 'prop_type'),
              const IndividualCheckboxWidget.standalone(
                nodeKey: 'serv_utilities',
                showPath: true,
              ),
              const IndividualCheckboxWidget.standalone(
                nodeKey: 'prop_garden',
                customTitle: Text('🌳 Garden Feature'),
              ),
              const IndividualCheckboxWidget.standalone(nodeKey: 'serv_maintenance'),
            ]),

            const Divider(height: 40),

            // Example 3: Custom layout
            _buildSection('Custom Form Layout', [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Property Features:', 
                          style: TextStyle(fontWeight: FontWeight.bold)),
                        ...CheckboxTreesConfig.getNodesByCategory('property').take(2).map(
                          (nodeKey) => IndividualCheckboxWidget.standalone(nodeKey: nodeKey),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Services:', 
                          style: TextStyle(fontWeight: FontWeight.bold)),
                        ...CheckboxTreesConfig.getNodesByCategory('services').map(
                          (nodeKey) => IndividualCheckboxWidget.standalone(nodeKey: nodeKey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),

            const Divider(height: 40),

            // Example 4: Parent nodes with count
            _buildSection('Parent Nodes with Children Count', [
               IndividualCheckboxWidget.standalone(
                nodeKey: 'prop_main',
                showRelationships: true,
                showChildrenCount: true,
              ),
               IndividualCheckboxWidget.standalone(
                nodeKey: 'serv_main',
                showRelationships: true,
                showChildrenCount: true,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 10),
        ...children,
      ],
    );
  }
}