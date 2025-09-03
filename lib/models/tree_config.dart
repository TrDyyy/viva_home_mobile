import '../models/checkbox_node.dart';

class CheckboxTreesConfig {
  // Property Survey Trees
  static Map<String, TreeNode> get propertyTrees => {
    // Main Property Tree
    'prop_main': TreeNode(
      key: 'prop_main',
      title: 'Property Details',
      treePath: 'property.main',
      level: 0,
      childKeys: ['prop_general', 'prop_external'],
      checkSource: CheckSource.auto,
    ),
    
    // General Information Branch
    'prop_general': TreeNode(
      key: 'prop_general',
      title: 'General Information',
      treePath: 'property.main.general',
      level: 1,
      parentKey: 'prop_main',
      childKeys: ['prop_type', 'prop_size'],
      checkSource: CheckSource.auto,
    ),
    'prop_type': TreeNode(
      key: 'prop_type',
      title: 'Property Type',
      treePath: 'property.main.general.type',
      level: 2,
      parentKey: 'prop_general',
      checkSource: CheckSource.manual,
    ),
    'prop_size': TreeNode(
      key: 'prop_size',
      title: 'Property Size',
      treePath: 'property.main.general.size',
      level: 2,
      parentKey: 'prop_general',
      checkSource: CheckSource.manual,
    ),

    // External Features Branch
    'prop_external': TreeNode(
      key: 'prop_external',
      title: 'External Features',
      treePath: 'property.main.external',
      level: 1,
      parentKey: 'prop_main',
      childKeys: ['prop_garden', 'prop_parking'],
      checkSource: CheckSource.auto,
    ),
    'prop_garden': TreeNode(
      key: 'prop_garden',
      title: 'Garden',
      treePath: 'property.main.external.garden',
      level: 2,
      parentKey: 'prop_external',
      checkSource: CheckSource.manual,
    ),
    'prop_parking': TreeNode(
      key: 'prop_parking',
      title: 'Parking',
      treePath: 'property.main.external.parking',
      level: 2,
      parentKey: 'prop_external',
      checkSource: CheckSource.manual,
    ),
  };

  // Services Trees
  static Map<String, TreeNode> get serviceTrees => {
    'serv_main': TreeNode(
      key: 'serv_main',
      title: 'Services & Utilities',
      treePath: 'services.main',
      level: 0,
      childKeys: ['serv_utilities', 'serv_maintenance'],
      checkSource: CheckSource.auto,
    ),
    'serv_utilities': TreeNode(
      key: 'serv_utilities',
      title: 'Utilities',
      treePath: 'services.main.utilities',
      level: 1,
      parentKey: 'serv_main',
      checkSource: CheckSource.manual,
    ),
    'serv_maintenance': TreeNode(
      key: 'serv_maintenance',
      title: 'Maintenance',
      treePath: 'services.main.maintenance',
      level: 1,
      parentKey: 'serv_main',
      checkSource: CheckSource.manual,
    ),
  };

  // Combine all trees
  static Map<String, TreeNode> get allTrees => {
    ...propertyTrees,
    ...serviceTrees,
  };

  // Helper methods for specific use cases
  static List<String> get propertyLeafNodes => [
    'prop_type', 'prop_size', 'prop_garden', 'prop_parking',
  ];

  static List<String> get serviceLeafNodes => [
    'serv_utilities', 'serv_maintenance',
  ];

  // Get nodes by category
  static List<String> getNodesByCategory(String category) {
    switch (category) {
      case 'property':
        return propertyLeafNodes;
      case 'services':
        return serviceLeafNodes;
      default:
        return [];
    }
  }
}