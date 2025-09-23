import '../models/checkbox_node.dart';

class CheckboxTreesConfig {
  static Map<String, TreeNode> get detailsTree => {
    "det_root": TreeNode(
      key: "det_root",
      title: "Detail",
      treePath: "detail",
      level: 0,
      childKeys: ["det_gen"],
      checkSource: CheckSource.auto,
    ),
    //General leaf
    "det_gen": TreeNode(
      key: "det_gen",
      title: "General",
      treePath: "detail.general",
      level: 1,
      childKeys: [
        "det_gen_iov",
        "det_gen_homeowner",
        "det_gen_formInfo",
        "det_gen_proAddress",
        "det_gen_locality",
        "det_gen_tenure",
        "det_gen_proSize",
        "det_gen_efficiences",
        "det_gen_newProperty",
      ],
      parentKey: "det_root",
      checkSource: CheckSource.auto,
    ),
    "det_gen_iov": TreeNode(
      key: "det_gen_iov",
      title: "Intent of valuation",
      treePath: "detail.general.iot",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_homeowner": TreeNode(
      key: "det_gen_homeowner",
      title: "Homeowner",
      treePath: "detail.general.homeowner",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_formInfo": TreeNode(
      key: "det_gen_formInfo",
      title: "Form Information",
      treePath: "detail.general.formInfo",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_proAddress": TreeNode(
      key: "det_gen_proAddress",
      title: "Property Address",
      treePath: "detail.general.proAddress",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_locality": TreeNode(
      key: "det_gen_locality",
      title: "Locality",
      treePath: "detail.general.locality",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_tenure": TreeNode(
      key: "det_gen_tenure",
      title: "Tenure",
      treePath: "detail.general.tenure",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_proSize": TreeNode(
      key: "det_gen_proSize",
      title: "Property Size",
      treePath: "detail.general.proSize",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_efficiences": TreeNode(
      key: "det_gen_efficiences",
      title: "Efficiencies",
      treePath: "detail.general.efficiences",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_newProperty": TreeNode(
      key: "det_gen_newProperty",
      title: "New Property",
      treePath: "detail.general.newProperty",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
  };

  // Combine all trees
  static Map<String, TreeNode> get allTrees => {...detailsTree};

  static List<String> get generalLeaf => [
    'det_gen_iov',
    'det_gen_tenure',
    'det_gen_proSize',
    'det_gen_efficiences',
    'det_gen_newProperty',
    "det_gen_formInfo",
    "det_gen_homeowner",
    "det_gen_locality",
    "det_gen_proAddress",
  ];
}
