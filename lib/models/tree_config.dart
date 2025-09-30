import '../models/checkbox_node.dart';

class CheckboxTreesConfig {
  static Map<String, CheckBoxTreeNode> get detailsTree => {
    "det_root": CheckBoxTreeNode(
      key: "det_root",
      title: "Detail",
      treePath: "detail",
      level: 0,
      childKeys: ["det_gen", "det_ext", "det_int", "det_serv", "det_add"],
      checkSource: CheckSource.auto,
    ),
    //General leaf
    "det_gen": CheckBoxTreeNode(
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
    "det_gen_iov": CheckBoxTreeNode(
      key: "det_gen_iov",
      title: "Intent of valuation",
      treePath: "detail.general.iot",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_homeowner": CheckBoxTreeNode(
      key: "det_gen_homeowner",
      title: "Homeowner",
      treePath: "detail.general.homeowner",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_formInfo": CheckBoxTreeNode(
      key: "det_gen_formInfo",
      title: "Form Information",
      treePath: "detail.general.formInfo",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_proAddress": CheckBoxTreeNode(
      key: "det_gen_proAddress",
      title: "Property Address",
      treePath: "detail.general.proAddress",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_locality": CheckBoxTreeNode(
      key: "det_gen_locality",
      title: "Locality",
      treePath: "detail.general.locality",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_tenure": CheckBoxTreeNode(
      key: "det_gen_tenure",
      title: "Tenure",
      treePath: "detail.general.tenure",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_proSize": CheckBoxTreeNode(
      key: "det_gen_proSize",
      title: "Property Size",
      treePath: "detail.general.proSize",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_efficiences": CheckBoxTreeNode(
      key: "det_gen_efficiences",
      title: "Efficiencies",
      treePath: "detail.general.efficiences",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),
    "det_gen_newProperty": CheckBoxTreeNode(
      key: "det_gen_newProperty",
      title: "New Property",
      treePath: "detail.general.newProperty",
      level: 2,
      parentKey: "det_gen",
      checkSource: CheckSource.auto,
    ),

    // External leaf
    "det_ext": CheckBoxTreeNode(
      key: "det_ext",
      title: "External",
      treePath: "detail.external",
      level: 1,
      childKeys: [
        "det_ext_dwellingType",
        "det_ext_propertyAge",
        "det_ext_alterations",
        "det_ext_construction",
        "det_ext_outbuildings",
      ],
      parentKey: "det_root",
      checkSource: CheckSource.auto,
    ),
    "det_ext_dwellingType": CheckBoxTreeNode(
      key: "det_ext_dwellingType",
      title: "Dwelling type",
      treePath: "detail.external.dwellingType",
      level: 2,
      parentKey: "det_ext",
      checkSource: CheckSource.auto,
    ),
    "det_ext_propertyAge": CheckBoxTreeNode(
      key: "det_ext_propertyAge",
      title: "Property Age",
      treePath: "detail.external.propertyAge",
      level: 2,
      parentKey: "det_ext",
      checkSource: CheckSource.auto,
    ),
    "det_ext_alterations": CheckBoxTreeNode(
      key: "det_ext_alterations",
      title: "Alterations",
      treePath: "detail.external.alterations",
      level: 2,
      parentKey: "det_ext",
      checkSource: CheckSource.auto,
    ),
    "det_ext_construction": CheckBoxTreeNode(
      key: "det_ext_construction",
      title: "Construction",
      treePath: "detail.external.construction",
      level: 2,
      parentKey: "det_ext",
      checkSource: CheckSource.auto,
    ),
    "det_ext_outbuildings": CheckBoxTreeNode(
      key: "det_ext_outbuildings",
      title: "Outbuildings",
      treePath: "detail.external.outbuildings",
      level: 2,
      parentKey: "det_ext",
      checkSource: CheckSource.auto,
    ),

    //Internal leaf
    "det_int": CheckBoxTreeNode(
      key: "det_int",
      title: "Internal",
      treePath: "detail.internal",
      level: 1,
      childKeys: ["det_int_floors"],
      parentKey: "det_root",
      checkSource: CheckSource.auto,
    ),
    "det_int_floors": CheckBoxTreeNode(
      key: "det_int_floors",
      title: "Floors",
      treePath: "detail.internal.floors",
      level: 2,
      parentKey: "det_int",
      checkSource: CheckSource.auto,
    ),

    //Setting leaf
    "det_serv": CheckBoxTreeNode(
      key: "det_serv",
      title: "Services",
      treePath: "detail.services",
      level: 1,
      childKeys: [
        "det_serv_propServ",
        "det_serv_additional_features",
      ],
      parentKey: "det_root",
      checkSource: CheckSource.auto,
    ),
    "det_serv_propServ": CheckBoxTreeNode(
      key: "det_serv_propServ",
      title: "Services",
      treePath: "detail.services.services",
      level: 2,
      parentKey: "det_serv",
      checkSource: CheckSource.auto,
    ),
    "det_serv_additional_features": CheckBoxTreeNode(
      key: "det_serv_additional_features",
      title: "Additional Features",
      treePath: "detail.services.additional_features",
      level: 2,
      parentKey: "det_serv",
      checkSource: CheckSource.auto,
    ),
  };

  // Combine all trees
  static Map<String, CheckBoxTreeNode> get allTrees => {...detailsTree};

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

  static List<String> get externalLeaf => [
    'det_ext_dwellingType',
    'det_ext_propertyAge',
    'det_ext_alterations',
    'det_ext_construction',
    'det_ext_outbuildings',
  ];
}
