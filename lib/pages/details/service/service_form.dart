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
import 'package:viva_home_mobile/widgets/custom_date_field.dart';
import 'package:viva_home_mobile/widgets/form_widget.dart';

class ServiceFormPage extends StatefulWidget {
  const ServiceFormPage({super.key});

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

final _formKey = GlobalKey<FormState>();
final Map<String, dynamic> formData = {};

class _ServiceFormPageState extends State<ServiceFormPage> {
  bool _hasInitialized = false;
  List<String> selectedServices = [];
  String? centralHeating;
  bool? hasBoiler;
  bool? hasBoilerServiced;
  bool? hasBoilerReplaced;
  bool? hasBoilerUnderGuarantee;

  bool hasDate = false;
  bool hasBoilerGuaranteeExpiryDate = false;

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

  bool shouldCheckPropServices() =>
      selectedServices.isNotEmpty &&
          centralHeating != null &&
          hasBoiler == false ||
      (hasDate == true &&
          hasBoilerGuaranteeExpiryDate == true &&
          hasBoilerReplaced != null &&
          hasBoilerUnderGuarantee != null &&
          hasBoilerServiced != null);

  void _updateNodeWithConditions(String nodeKey) {
    late bool shouldCheck;

    switch (nodeKey) {
      case "det_serv_propServ":
        shouldCheck = shouldCheckPropServices();
        break;
      default:
        shouldCheck = false;
    }
    context.read<GlobalTreeManager>().toggleNode(nodeKey, shouldCheck);
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
        title: 'Services & Guarantees',
        isAppBarVisible: true,
        customBody: Form(
          key: _formKey,
          child: FormSection(
            children: [
              FormFieldWrapper(
                label: "Services",
                nodeKey: "det_serv_propServ",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCheckboxField<String>(
                      isVertical: true,
                      context: context,
                      label:
                          "Please select all services provided to the property:",
                      options: [
                        CheckboxOption(value: "mains_gas", label: "Mains gas"),
                        CheckboxOption(
                          value: "electricity",
                          label: "Electricity",
                        ),
                        CheckboxOption(value: "oil", label: "Oil"),
                        CheckboxOption(
                          value: "multi_flue",
                          label: "Multi flue",
                        ),
                        CheckboxOption(
                          value: "air_source",
                          label: "Air source",
                        ),
                        CheckboxOption(value: "lpg", label: "LPG"),
                        CheckboxOption(
                          value: "heat_source_pumps",
                          label: "Heat source pumps",
                        ),
                        CheckboxOption(
                          value: "pellet_stoves",
                          label: "Pellet Stoves",
                        ),
                        CheckboxOption(value: "open_fire", label: "Open fire"),
                        CheckboxOption(
                          value: "under_floor",
                          label: "Under floor",
                        ),
                        CheckboxOption(
                          value: "other",
                          label: "Other 'specify below'",
                        ),
                      ],
                      values: selectedServices,
                      onChanged: (newValues) {
                        setState(() => selectedServices = newValues);
                      },
                      validator: ValidationUtils.validateRequiredOption,
                      onSaved: (values) => formData["services"] = values,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildOtherSpecifyField(
                      context: context,
                      onSaved: (value) =>
                          formData['other_specify_services'] = value,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildRadioField(
                      label: 'Central heating:',
                      context: context,
                      options: [
                        RadioOption(value: "Yes", label: "Yes"),
                        RadioOption(value: "Partial", label: "Partial"),
                        RadioOption(value: "None", label: "None"),
                      ],
                      groupValue: centralHeating,
                      onChanged: (val) => {
                        setState(() => centralHeating = val),
                        _updateNodeWithConditions("det_serv_propServ"),
                      },
                      validator: ValidationUtils.validateRequiredOption,
                      onSaved: (val) => formData["central_heating"] = val,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    CustomContainerWidget(
                      showLabel: false,
                      children: [
                        buildRadioField(
                          context: context,
                          label: 'Do you have a boiler?',
                          options: [
                            RadioOption(value: true, label: "Yes"),
                            RadioOption(value: false, label: "No"),
                          ],
                          groupValue: hasBoiler,
                          onChanged: (val) => {
                            setState(() => hasBoiler = val),
                            _updateNodeWithConditions("det_serv_propServ"),
                          },
                          validator: ValidationUtils.validateRequiredOption,
                          onSaved: (val) => formData["has_boiler"] = val,
                        ),
                        if (hasBoiler == true) ...[
                          Text(
                            "If ‘YES’ please complete the following questions below:",
                          ),
                          SizedBox(
                            height: AppSizes.padding(
                              context,
                              SizeCategory.medium,
                            ),
                          ),
                          buildRadioField(
                            context: context,
                            label: 'Has your boiler been serviced?',
                            options: [
                              RadioOption(value: true, label: "Yes"),
                              RadioOption(value: false, label: "No"),
                            ],
                            groupValue: hasBoilerServiced,
                            onChanged: (val) => {
                              setState(() => hasBoilerServiced = val),
                              _updateNodeWithConditions("det_serv_propServ"),
                            },
                            validator: ValidationUtils.validateRequiredOption,
                            onSaved: (val) =>
                                formData["has_boiler_serviced"] = val,
                          ),
                          buildRadioField(
                            context: context,
                            label: 'Has your boiler been replaced recently?',
                            options: [
                              RadioOption(value: true, label: "Yes"),
                              RadioOption(value: false, label: "No"),
                            ],
                            groupValue: hasBoilerReplaced,
                            onChanged: (val) => {
                              setState(() => hasBoilerReplaced = val),
                              _updateNodeWithConditions("det_serv_propServ"),
                            },
                            validator: ValidationUtils.validateRequiredOption,
                            onSaved: (val) =>
                                formData["has_boiler_replaced"] = val,
                          ),
                          buildRadioField(
                            context: context,
                            label: 'Is your boiler under guarantee?',
                            options: [
                              RadioOption(value: true, label: "Yes"),
                              RadioOption(value: false, label: "No"),
                            ],
                            groupValue: hasBoilerUnderGuarantee,
                            onChanged: (val) => {
                              setState(() => hasBoilerUnderGuarantee = val),
                              _updateNodeWithConditions("det_serv_propServ"),
                            },
                            validator: ValidationUtils.validateRequiredOption,
                            onSaved: (val) =>
                                formData["has_boiler_under_guarantee"] = val,
                          ),
                          SizedBox(
                            height: AppSizes.padding(
                              context,
                              SizeCategory.medium,
                            ),
                          ),
                          buildCustomDateField(
                            label:
                                "Boiler Guarantee expiry date (If applicable):",
                            mode: DateInputMode.mmyy,
                            onChanged: (date) {
                              setState(() {
                                hasBoilerGuaranteeExpiryDate = date != null;
                                _updateNodeWithConditions("det_serv_propServ");
                              });
                            },
                            onSaved: (date) {
                              formData["boiler_guarantee_expiry_date"] = date;
                            },
                            validator: ValidationUtils.requiredDateTime,
                          ),
                          SizedBox(
                            height: AppSizes.padding(
                              context,
                              SizeCategory.medium,
                            ),
                          ),
                          buildCustomDateField(
                            label: "Date of last service:",
                            mode: DateInputMode.ddmmyy,
                            onChanged: (date) {
                              setState(() {
                                hasDate = date != null;
                                _updateNodeWithConditions("det_serv_propServ");
                              });
                            },
                            onSaved: (date) {
                              formData["date_last_service"] = date;
                            },
                            validator: ValidationUtils.requiredDateTime,
                          ),
                        ],
                      ],
                    ),
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
