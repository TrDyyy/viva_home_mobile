import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viva_home_mobile/cubits/checkbox_tree_cubit.dart';
import 'package:viva_home_mobile/models/tree_config.dart';
import 'package:viva_home_mobile/utils/constants.dart';
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
  List<String> selectedGuaranteesAreas = [];
  List<String> selectedPropertyWarranties = [];
  String? centralHeating;
  bool? hasBoiler;
  bool? hasBoilerServiced;
  bool? hasBoilerReplaced;
  bool? hasBoilerUnderGuarantee;

  bool hasDate = false;
  bool hasBoilerGuaranteeExpiryDate = false;

  bool? isDampProofCourse;
  bool hasWallInsulationExpiryDate = false;

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

  bool shouldCheckGuarantees() =>
      selectedGuaranteesAreas.isNotEmpty && isDampProofCourse == false ||
      (hasWallInsulationExpiryDate == true);
  void _updateNodeWithConditions(String nodeKey) {
    late bool shouldCheck;

    switch (nodeKey) {
      case "det_serv_propServ":
        shouldCheck = shouldCheckPropServices();
        break;
      case "det_serv_guarantees":
        shouldCheck = shouldCheckGuarantees();
        break;
      case "det_serv_warranties":
        shouldCheck = selectedPropertyWarranties.isNotEmpty;
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
            onPressed: _handleSubmit,
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
              SizedBox(height: AppSizes.padding(context, SizeCategory.large)),
              FormFieldWrapper(
                label: "Guarantees",
                nodeKey: "det_serv_guarantees",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCheckboxField<String>(
                      context: context,
                      isVertical: true,
                      label:
                          'Please select all applicable areas you have under guarantee?',
                      options: [
                        CheckboxOption(value: "windows", label: "Windows"),
                        CheckboxOption(value: "doors", label: "Doors"),
                        CheckboxOption(
                          value: "log_multi_flue_burner",
                          label: "Log / Multi flue burner",
                        ),
                        CheckboxOption(
                          value: "roof_insulation",
                          label: "Roof Insulation",
                        ),
                        CheckboxOption(
                          value: "hetas_building_regulations",
                          label: "Hetas / Building regulations",
                        ),
                        CheckboxOption(
                          value: "wall_insulation",
                          label: "Wall Insulation",
                        ),
                        CheckboxOption(
                          value: "planning_permission",
                          label: "Planning permission",
                        ),
                        CheckboxOption(
                          value: "building_regulations",
                          label: "Building regulations",
                        ),
                        CheckboxOption(
                          value: "timber_treatment",
                          label: "Timber Treatment",
                        ),
                        CheckboxOption(
                          value: "injection_cavity",
                          label: "Injection Cavity",
                        ),
                        CheckboxOption(
                          value: "other",
                          label: "Other 'specify below'",
                        ),
                      ],
                      values: selectedGuaranteesAreas,
                      onChanged: (values) {
                        setState(() => selectedGuaranteesAreas = values);
                        _updateNodeWithConditions("det_serv_guarantees");
                      },
                      validator: ValidationUtils.validateRequiredOption,
                      onSaved: (values) => formData["guarantee_areas"] = values,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildOtherSpecifyField(
                      context: context,
                      onSaved: (value) =>
                          formData['other_specify_guarantees'] = value,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    CustomContainerWidget(
                      label: 'Wall Insulation',
                      children: [
                        buildRadioField(
                          context: context,
                          label: 'Damp Proof course?',
                          options: [
                            RadioOption(value: true, label: "Yes"),
                            RadioOption(value: false, label: "No"),
                          ],
                          groupValue: isDampProofCourse,
                          onChanged: (val) {
                            setState(() {
                              isDampProofCourse = val;
                            });
                            _updateNodeWithConditions("det_serv_guarantees");
                          },
                          validator: ValidationUtils.validateRequiredOption,
                          onSaved: (val) =>
                              formData["is_damp_proof_course"] = val,
                        ),
                        if (isDampProofCourse == true) ...[
                          SizedBox(
                            height: AppSizes.padding(
                              context,
                              SizeCategory.medium,
                            ),
                          ),
                          buildCustomDateField(
                            label: "If ‘Yes’ - Give Expiry of guarantee",
                            mode: DateInputMode.mmyy,
                            onChanged: (date) {
                              setState(() {
                                hasWallInsulationExpiryDate = date != null;
                              });
                              _updateNodeWithConditions("det_serv_guarantees");
                            },
                            onSaved: (date) {
                              formData["wall_insulation_expiry_date"] = date;
                            },
                            validator: ValidationUtils.requiredDateTime,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.padding(context, SizeCategory.medium)),
              FormFieldWrapper(
                label: "Warranties",
                nodeKey: "det_serv_warranties",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCheckboxField<String>(
                      context: context,
                      isVertical: true,
                      label:
                          'Please select applicable warranties for the property:',
                      options: [
                        CheckboxOption(value: "NHBC", label: "NHBC"),
                        CheckboxOption(
                          value: "zurich_municipal",
                          label: "Zurich Municipal",
                        ),
                        CheckboxOption(
                          value: "architect_certificate",
                          label: "Architect Certificate",
                        ),
                        CheckboxOption(
                          value: "premier_guarantee",
                          label: "Premier Guarantee",
                        ),
                        CheckboxOption(
                          value: "no_warranty",
                          label: "No Warranty",
                        ),
                        CheckboxOption(
                          value: "other",
                          label: "Other 'specify below'",
                        ),
                      ],
                      values: selectedPropertyWarranties,
                      onChanged: (values) {
                        setState(() => selectedPropertyWarranties = values);
                        _updateNodeWithConditions("det_serv_warranties");
                      },
                      validator: ValidationUtils.validateRequiredOption,
                      onSaved: (values) =>
                          formData["property_warranties"] = values,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    buildOtherSpecifyField(
                      context: context,
                      onSaved: (value) =>
                          formData['other_specify_guarantees'] = value,
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
