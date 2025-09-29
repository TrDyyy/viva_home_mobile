import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viva_home_mobile/cubits/checkbox_tree_cubit.dart';
import 'package:viva_home_mobile/models/tree_config.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/utils/custom_button.dart';
import 'package:viva_home_mobile/utils/custom_checkbox_group.dart';
import 'package:viva_home_mobile/utils/radio_group.dart';
import 'package:viva_home_mobile/utils/validation.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';
import 'package:viva_home_mobile/widgets/form_widget.dart';

class ExternalFormPage extends StatefulWidget {
  const ExternalFormPage({super.key});

  @override
  State<ExternalFormPage> createState() => _ExternalFormPageState();
}

class _ExternalFormPageState extends State<ExternalFormPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {};
  bool _hasInitialized = false;
  bool? isPropertyAltered;
  bool? isLoftConverted;
  bool? isPlanningCertified;
  bool? hasRemovedStructures;

  List<String> selectedOutbuildings = [];

  // check state
  bool hasProType = false;
  bool hasProStyle = false;
  bool hasPropertyAge = false;
  bool hasLoftConverted = false;
  bool hasPropertyAltered = false;

  bool hasRoofMaterial = false;
  bool hasWallMaterial = false;

  bool shouldCheckDwelling() => hasProStyle && hasProType;
  bool shouldCheckAlteredAndLoft() {
    // Case 1: both No
    if (isPropertyAltered == false && isLoftConverted == false) {
      return true;
    }
    // Case 2: Property Yes, Loft No
    if (isPropertyAltered == true && isLoftConverted == false) {
      return hasPropertyAltered;
    }
    // Case 3: Property No, Loft Yes
    if (isPropertyAltered == false && isLoftConverted == true) {
      return hasLoftConverted;
    }
    // Case 4: both Yes
    if (isPropertyAltered == true && isLoftConverted == true) {
      return hasPropertyAltered && hasLoftConverted;
    }
    return false;
  }

  bool shouldCheckPropertyAltered() =>
      shouldCheckAlteredAndLoft() &&
      isPlanningCertified != null &&
      hasRemovedStructures != null;

  bool shouldCheckConstruction() => hasWallMaterial && hasRoofMaterial;

  void _updateNodeWithConditions(String nodeKey) {
    late bool shouldCheck;

    switch (nodeKey) {
      case "det_ext_dwellingType":
        shouldCheck = shouldCheckDwelling();
        break;
      case "det_ext_propertyAge":
        shouldCheck = hasPropertyAge;
        break;
      case "det_ext_alterations":
        shouldCheck = shouldCheckPropertyAltered();
        break;
      case "det_ext_construction":
        shouldCheck = shouldCheckConstruction();
        break;
      case "det_ext_outbuildings":
        shouldCheck = shouldCheckDwelling();
        break;
      default:
        shouldCheck = false;
    }
    context.read<GlobalTreeManager>().toggleNode(nodeKey, shouldCheck);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInitialized) {
      context.read<GlobalTreeManager>().initializeNodes(
        CheckboxTreesConfig.allTrees,
      );
      _hasInitialized = true;
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint("Form data: $formData");
      // TODO: call API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form submitted successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fix errors before submitting")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePageWidget(
      config: PageConfig(
        title: 'External',
        isAppBarVisible: true,
        customBody: Form(
          key: _formKey,
          child: FormSection(
            children: [
              // Dwelling type
              FormFieldWrapper(
                label: "Dwelling type",
                nodeKey: "det_ext_dwellingType",
                child: Column(
                  children: [
                    buildComboBoxField(
                      label: "Property type:",
                      items: [
                        "House",
                        "Bungalow",
                        "Maisonette",
                        "Purpose built",
                        "Flat",
                        "Converted flat",
                        "Studio flat",
                        "Other",
                      ],
                      onChanged: (val) {
                        setState(
                          () => hasProType = val != null && val.isNotEmpty,
                        );
                        _updateNodeWithConditions("det_ext_dwellingType");
                      },
                      validator: ValidationUtils.required,
                      onSaved: (val) => formData["dwellingType"] = val,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildOtherSpecifyField(context: context),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildComboBoxField(
                      label: "Property style:",
                      items: [
                        "Terrace",
                        "Semi-Detached",
                        "Semi-Detached Link",
                        "Detached",
                        "Detached Link",
                        "Other",
                      ],
                      onChanged: (val) {
                        setState(
                          () => hasProStyle = val != null && val.isNotEmpty,
                        );
                        _updateNodeWithConditions("det_ext_dwellingType");
                      },
                      validator: ValidationUtils.required,
                      onSaved: (val) => formData["dwellingStyle"] = val,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildOtherSpecifyField(context: context),
                  ],
                ),
              ),

              // Property Age
              FormFieldWrapper(
                label: "Property Age",
                nodeKey: "det_ext_propertyAge",
                child: buildComboBoxField(
                  label: "Date of build (If Known):",
                  items: ["1961", "1962", "1963", "Unknown"],
                  onChanged: (val) {
                    setState(
                      () => hasPropertyAge = val != null && val.isNotEmpty,
                    );
                    _updateNodeWithConditions("det_ext_propertyAge");
                  },
                  validator: ValidationUtils.required,
                  onSaved: (val) => formData["propertyAge"] = val,
                ),
              ),

              // Alterations
              FormFieldWrapper(
                label: "ALTERATIONS",
                nodeKey: "det_ext_alterations",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRadioField<bool>(
                      context: context,
                      label: "Is the property altered?",
                      options: [
                        RadioOption<bool>(value: true, label: "Yes"),
                        RadioOption<bool>(value: false, label: "No"),
                      ],
                      groupValue: isPropertyAltered,
                      onChanged: (value) {
                        setState(() {
                          isPropertyAltered = value;
                          if (value == false) {
                            hasPropertyAltered = false;
                          }
                        });
                        _updateNodeWithConditions("det_ext_alterations");
                      },
                      onSaved: (val) => formData["is_property_altered"] = val,
                      validator: ValidationUtils.validateRequiredOption<bool>,
                    ),
                    if (isPropertyAltered == true) ...[
                      buildCustomTextField(
                        label: "If 'Yes' please specify:",
                        hintText: "...",
                        onChanged: (val) {
                          setState(
                            () => hasPropertyAltered = val!.trim().isNotEmpty,
                          );
                          _updateNodeWithConditions("det_ext_alterations");
                        },
                        onSaved: (val) =>
                            formData["property_alterations"] = val,
                      ),
                    ],
                    buildRadioField<bool>(
                      context: context,
                      label: "Has the loft been converted?",
                      options: [
                        RadioOption<bool>(value: true, label: "Yes"),
                        RadioOption<bool>(value: false, label: "No"),
                      ],
                      groupValue: isLoftConverted,
                      onChanged: (value) {
                        setState(() {
                          isLoftConverted = value;
                          if (value == false) {
                            hasLoftConverted = false;
                          }
                        });
                        _updateNodeWithConditions("det_ext_alterations");
                      },
                      onSaved: (val) => formData["is_loft_converted"] = val,
                      validator: ValidationUtils.validateRequiredOption<bool>,
                    ),
                    if (isLoftConverted == true) ...[
                      buildCustomTextField(
                        label: "If 'Yes' please specify:",
                        hintText: "...",
                        onChanged: (val) {
                          setState(
                            () => hasLoftConverted = val!.trim().isNotEmpty,
                          );
                          _updateNodeWithConditions("det_ext_alterations");
                        },
                        onSaved: (val) => formData["loft_conversion"] = val,
                      ),
                    ],
                    buildRadioField<bool>(
                      context: context,
                      label:
                          "Do you have the relevant planning permission or building regulation certificates? (If applicable)",
                      options: [
                        RadioOption<bool>(value: true, label: "Yes"),
                        RadioOption<bool>(value: false, label: "No"),
                      ],
                      groupValue: isPlanningCertified,
                      onChanged: (value) {
                        setState(() => isPlanningCertified = value);
                        _updateNodeWithConditions("det_ext_alterations");
                      },
                      onSaved: (val) => formData["is_planning_certified"] = val,
                      validator: ValidationUtils.validateRequiredOption<bool>,
                    ),
                    buildRadioField<bool>(
                      context: context,
                      label:
                          "Have any Integral structures eg. chimey breasts / load bearing walls been removed?",
                      options: [
                        RadioOption<bool>(value: true, label: "Yes"),
                        RadioOption<bool>(value: false, label: "No"),
                      ],
                      groupValue: hasRemovedStructures,
                      onChanged: (value) {
                        setState(() => hasRemovedStructures = value);
                        _updateNodeWithConditions("det_ext_alterations");
                      },
                      onSaved: (val) =>
                          formData["has_removed_structures"] = val,
                      validator: ValidationUtils.validateRequiredOption<bool>,
                    ),
                  ],
                ),
              ),

              // Construction
              FormFieldWrapper(
                label: "Construction",
                nodeKey: "det_ext_construction",
                child: Column(
                  children: [
                    buildComboBoxField(
                      label: "Wall's material:",
                      items: [
                        "Terrace",
                        "Solid Brick",
                        "Solid Stone",
                        "Concrete",
                        "Timber frame",
                        "Injected cavity brick wall",
                        "Other",
                      ],
                      onChanged: (val) {
                        setState(
                          () => hasWallMaterial = val != null && val.isNotEmpty,
                        );
                        _updateNodeWithConditions("det_ext_construction");
                      },
                      validator: ValidationUtils.required,
                      onSaved: (val) => formData["wallMaterial"] = val,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildOtherSpecifyField(context: context),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildComboBoxField(
                      label: "Roof’s material:",
                      items: ["Tile", "Slate", "Asphalt", "Felt", "Other"],
                      onChanged: (val) {
                        setState(
                          () => hasRoofMaterial = val != null && val.isNotEmpty,
                        );
                        _updateNodeWithConditions("det_ext_construction");
                      },
                      validator: ValidationUtils.required,
                      onSaved: (val) => formData["roofMaterial"] = val,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildOtherSpecifyField(context: context),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                  ],
                ),
              ),

              // Outbuildings
              FormFieldWrapper(
                label: "Outbuildings",
                nodeKey: "det_ext_outbuildings",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCheckboxField<String>(
                      context: context,
                      label: "Do you have any outbuildings?",
                      options: [
                        CheckboxOption(
                          value: "single_garage",
                          label: "Single garage",
                        ),
                        CheckboxOption(
                          value: "double_garage",
                          label: "Double garage",
                        ),
                        CheckboxOption(
                          value: "parking",
                          label: "Parking space",
                        ),
                        CheckboxOption(
                          value: "no_parking",
                          label: "No parking available",
                        ),
                        CheckboxOption(value: "pool", label: "Swimming pools"),
                        CheckboxOption(value: "shed", label: "Shed"),
                        CheckboxOption(
                          value: "other",
                          label: "Other 'specify below'",
                        ),
                      ],
                      values: selectedOutbuildings,
                      onChanged: (newValues) {
                        setState(() => selectedOutbuildings = newValues);
                        _updateNodeWithConditions("det_ext_outbuildings");
                      },
                      validator: ValidationUtils.validateRequiredOption,
                      onSaved: (values) => formData["outbuildings"] = values,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildOtherSpecifyField(context: context),
                  ],
                ),
              ),

              // Action buttons
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding(context, SizeCategory.small),
                  vertical:
                      AppSizes.padding(context, SizeCategory.xxxlarge) * 2,
                ),
                child: Column(
                  children: [
                    CustomButton(
                      text: "Save & Next",
                      onPressed: _handleSubmit,
                      backgroundColor: AppColors.darkTeal,
                      foregroundColor: AppColors.white,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    CustomButton(
                      text: "Back",
                      onPressed: () => Navigator.of(context).pop(),
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.darkTeal,
                      borderColor: AppColors.accent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
