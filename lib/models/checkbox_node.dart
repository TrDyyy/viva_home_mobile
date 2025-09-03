enum CheckSource { manual, auto }

class TreeNode {
  final String key;
  final String title;
  final bool isEnabled;
  final CheckSource checkSource; // Source of the check (manual, comboBox, etc.)
  final bool isChecked;
  final String? parentKey;
  final List<String> childKeys;
  final String treePath;
  final int level;

  TreeNode({
    required this.key,
    required this.title,
    this.isEnabled = true,
    this.checkSource = CheckSource.manual,
    this.isChecked = false,
    this.parentKey,
    this.childKeys = const [],
    required this.treePath,
    this.level = 0,
  });

  TreeNode copyWith({
    String? key,
    String? title,
    bool? isChecked,
    bool? isEnabled,
    CheckSource? checkSource,
    String? parentKey,
    List<String>? childKeys,
    String? treePath,
    int? level,
  }) {
    return TreeNode(
      key: key ?? this.key,
      title: title ?? this.title,
      isChecked: isChecked ?? this.isChecked,
      isEnabled: isEnabled ?? this.isEnabled,
      checkSource: checkSource ?? this.checkSource,
      parentKey: parentKey ?? this.parentKey,
      childKeys: childKeys ?? this.childKeys,
      treePath: treePath ?? this.treePath,
      level: level ?? this.level,
    );
  }

  // Helper methods
  String get treeId => treePath.split('.').first;
  bool get isRoot => parentKey == null;
  bool get hasChildren => childKeys.isNotEmpty;
  bool get isLeaf => childKeys.isEmpty;
}
