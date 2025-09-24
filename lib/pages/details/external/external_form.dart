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

final _formKey = GlobalKey<FormState>();
final Map<String, dynamic> formData = {};

class _ExternalFormPageState extends State<ExternalFormPage> {
  bool _hasInitialized = false;
  bool? isPropertyAltered;
  bool? isLoftConverted;
  List<String> selectedOutbuildings = [];

  // check state
  bool hasProType = false;
  bool hasProStyle = false;
  bool hasPropertyAge = false;
  bool hasAlterations = false;
  bool hasConstruction = false;
  bool hasOutbuildings = false;

  bool shouldCheckDwelling() => hasProStyle && hasProType;

  void _updateNodeWithConditions(String nodeKey) {
    late bool shouldCheck;

    switch (nodeKey) {
      case "det_ext_dwellingType":
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
                  ],
                ),
              ),

              // Property Age
              FormFieldWrapper(
                label: "Property Age",
                nodeKey: "det_ext_propertyAge",
                child: buildComboBoxField(
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
                    setState(() => hasProStyle = val != null && val.isNotEmpty);
                    _updateNodeWithConditions("det_ext_dwellingType");
                  },
                  validator: ValidationUtils.required,
                  onSaved: (val) => formData["dwellingStyle"] = val,
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
                        setState(() => isPropertyAltered = value);
                        _updateNodeWithConditions("det_ext_alterations");
                      },
                      onSaved: (val) => formData["is_property_altered"] = val,
                      validator: ValidationUtils.validateRequiredOption<bool>,
                    ),
                    if (isPropertyAltered == true)
                      buildCustomTextField(
                        label: "If 'Yes' please specify:",
                        hintText: "...",
                        onChanged: (val) {
                          setState(
                            () => hasAlterations = val!.trim().isNotEmpty,
                          );
                        },
                        onSaved: (val) => formData["alterations"] = val,
                      ),
                    buildRadioField<bool>(
                      context: context,
                      label: "Has the loft been converted?",
                      options: [
                        RadioOption<bool>(value: true, label: "Yes"),
                        RadioOption<bool>(value: false, label: "No"),
                      ],
                      groupValue: isLoftConverted,
                      onChanged: (value) {
                        setState(() => isLoftConverted = value);
                        _updateNodeWithConditions("det_ext_alterations");
                      },
                      onSaved: (val) => formData["is_property_altered"] = val,
                      validator: ValidationUtils.validateRequiredOption<bool>,
                    ),
                    if (isLoftConverted == true) ...[
                      buildCustomTextField(
                        label: "If 'Yes' please specify:",
                        hintText: "...",
                        onChanged: (val) {
                          setState(
                            () => hasAlterations = val!.trim().isNotEmpty,
                          );
                        },
                        onSaved: (val) => formData["alterations"] = val,
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
                      groupValue: isPropertyAltered,
                      onChanged: (value) {
                        setState(() => isPropertyAltered = value);
                        _updateNodeWithConditions("det_ext_alterations");
                      },
                      onSaved: (val) => formData["is_property_altered"] = val,
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
                      groupValue: isPropertyAltered,
                      onChanged: (value) {
                        setState(() => isPropertyAltered = value);
                        _updateNodeWithConditions("det_ext_alterations");
                      },
                      onSaved: (val) => formData["is_property_altered"] = val,
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
                      label: "Main construction material:",
                      items: [
                        "Brick",
                        "Stone",
                        "Concrete",
                        "Timber Frame",
                        "Steel Frame",
                        "Other",
                      ],
                      onChanged: (val) {
                        setState(
                          () => hasConstruction = val != null && val.isNotEmpty,
                        );
                        _updateNodeWithConditions("det_ext_construction");
                      },
                      validator: ValidationUtils.required,
                      onSaved: (val) => formData["construction"] = val,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildOtherSpecifyField(context: context),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
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
                  ],
                ),
              ),

              // Outbuildings
              FormFieldWrapper(
                label: "Outbuildings",
                nodeKey: "det_ext_outbuildings",
                child: buildCheckboxField<String>(
                  context: context,
                  customLabelText: true,
                  options: const [
                    CheckboxOption(
                      value: "single_garage",
                      label: "Single garage",
                    ),
                    CheckboxOption(
                      value: "double_garage",
                      label: "Double garage",
                    ),
                    CheckboxOption(value: "parking", label: "Parking space"),
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
                  values: selectedOutbuildings, // List<String>
                  onChanged: (newValues) {
                    setState(() => selectedOutbuildings = newValues);
                    _updateNodeWithConditions("det_gen_outbuilding");
                  },
                  validator: (values) {
                    return ValidationUtils.validateRequiredOption(values);
                  },
                  onSaved: (values) => formData["outbuildings"] = values,
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
