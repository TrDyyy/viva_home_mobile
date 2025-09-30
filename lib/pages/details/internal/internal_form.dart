import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viva_home_mobile/cubits/checkbox_tree_cubit.dart';
import 'package:viva_home_mobile/models/tree_config.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/utils/custom_button.dart';
import 'package:viva_home_mobile/utils/radio_group.dart';
import 'package:viva_home_mobile/utils/validation.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';
import 'package:viva_home_mobile/widgets/form_widget.dart';

class InternalFormPage extends StatefulWidget {
  const InternalFormPage({super.key});

  @override
  State<InternalFormPage> createState() => _InternalFormPageState();
}

final _formKey = GlobalKey<FormState>();
final Map<String, dynamic> formData = {};

class _InternalFormPageState extends State<InternalFormPage> {
  final List<int> floors = [];
  int _nextFloorId = 0;
  bool _hasInitialized = false;
  bool? hasCertificates;
  bool? isCellarTanked;
  bool? hasRequiredCertificates;

  // Track floor values for checkbox node state
  Map<int, bool> floorHasValues = {};

  bool shouldCheckListFloors() {
    if (floors.isEmpty) return false;
    for (int floorId in floors) {
      if (floorHasValues[floorId] != true) {
        return false;
      }
    }
    return true;
  }

  bool shouldCheckFloors() => shouldCheckListFloors() &&
      hasCertificates != null &&
      isCellarTanked == false || (isCellarTanked == true && hasRequiredCertificates != null);

  void _updateNodeWithConditions(String nodeKey) {
    late bool shouldCheck;

    switch (nodeKey) {
      case "det_int_floors":
        shouldCheck = shouldCheckFloors();
        break;
      default:
        shouldCheck = false;
    }
    context.read<GlobalTreeManager>().toggleNode(nodeKey, shouldCheck);
  }

  void updateFloorValue(int floorId, bool hasValue) {
    setState(() {
      floorHasValues[floorId] = hasValue;
    });
    _updateNodeWithConditions("det_int_floors");
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

  void addFloorField() {
    setState(() {
      floors.add(_nextFloorId);
      floorHasValues[_nextFloorId] = false;
      _nextFloorId++;
    });
    context.read<GlobalTreeManager>().toggleNode("det_int_floors", false);
  }

  void removeFloor(int floorId) {
    setState(() {
      floors.remove(floorId);
      floorHasValues.remove(floorId);
      formData.remove('floor_$floorId');
    });
    _updateNodeWithConditions("det_int_floors");
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
              // Floors
              FormFieldWrapper(
                label: "Floors",
                nodeKey: "det_int_floors",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormFieldGroup(label:'Add exisiting floors:', items: [
                      Text("Please add all floors present in the property. Starting from the lowest level eg. Cellar / Basement, Ground, Floor 1, Loft.",style: TextStyle(fontSize: AppSizes.font(context, SizeCategory.medium), color: AppColors.dark)),
                    ]),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: floors.length,
                      separatorBuilder: (_, __) => SizedBox(
                        height: AppSizes.padding(context, SizeCategory.medium),
                      ),
                      itemBuilder: (context, index) => AddFloorWidget(
                        key: ValueKey(floors[index]),
                        index: floors[index],
                        onDelete: () => removeFloor(floors[index]),
                        onValueChanged: (hasValue) =>
                            updateFloorValue(floors[index], hasValue),
                      ),
                    ),
                    CustomButton(
                      text: "New Floor",
                      onPressed: () => addFloorField(),
                      backgroundColor: AppColors.lightGray,
                      foregroundColor: AppColors.dark,
                      icon: DottedBorder(
                        options: RectDottedBorderOptions(
                          dashPattern: [6, 3],
                          strokeWidth: 1,
                          padding: EdgeInsets.all(
                            AppSizes.padding(context, SizeCategory.small) * 0.2,
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.large),
                    ),
                    CustomContainerWidget(
                      label: "Converted Loft",
                      children: [
                        buildRadioField(
                          label:
                              'Do you have the relevant planning permission or building regulation certificates? (If applicable)',
                          options: [
                            RadioOption(value: true, label: 'Yes'),
                            RadioOption(value: false, label: 'No'),
                          ],
                          groupValue: hasCertificates,
                          onChanged: (value) {
                            setState(() {
                              hasCertificates = value;
                            });
                            _updateNodeWithConditions("det_int_floors");
                          },
                          context: context,
                          validator:
                              ValidationUtils.validateRequiredOption<bool>,
                          onSaved: (value) {
                            formData['has_certificates'] = value;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.large),
                    ),
                    CustomContainerWidget(
                      label: "Cellar / Basement",
                      children: [
                        buildRadioField(
                          label: 'If you have a cellar is it tanked?',
                          options: [
                            RadioOption(value: true, label: 'Yes'),
                            RadioOption(value: false, label: 'No'),
                          ],
                          groupValue: isCellarTanked,
                          onChanged: (value) {
                            setState(() {
                              isCellarTanked = value;
                              if(isCellarTanked == false)
                              {
                                hasRequiredCertificates = null;
                              }
                            });
                            _updateNodeWithConditions("det_int_floors");
                          },
                          validator:
                              ValidationUtils.validateRequiredOption<bool>,
                          context: context,
                          onSaved: (value) {
                            formData['is_cellar_tanked'] = value;
                          },
                        ),
                        if (isCellarTanked == true)
                          buildRadioField(
                            context: context,
                            label:
                                'If ‘Yes’ - Do you have the relevant planning permission or building regulation certificates? ',
                            options: [
                              RadioOption(value: true, label: 'Yes'),
                              RadioOption(value: false, label: 'No'),
                            ],
                            groupValue: hasRequiredCertificates,
                            onChanged: (value) {
                              setState(() {
                                hasRequiredCertificates = value;
                              });
                              _updateNodeWithConditions("det_int_floors");
                            },
                            validator:
                                ValidationUtils.validateRequiredOption<bool>,
                            onSaved: (value) {
                              formData['has_required_certificates'] = value;
                            },
                          ),
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

class AddFloorWidget extends StatelessWidget {
  final int index;
  final VoidCallback? onDelete;
  final Function(bool)? onValueChanged;

  const AddFloorWidget({
    super.key,
    required this.index,
    this.onDelete,
    this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.padding(context, SizeCategory.small),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray),
          borderRadius: BorderRadius.circular(
            AppSizes.radius(context, SizeCategory.medium),
          ),
          color: AppColors.lightGray,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.padding(context, SizeCategory.medium),
            vertical: AppSizes.padding(context, SizeCategory.large),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Floor Title:",
                    style: TextStyle(
                      fontSize: AppSizes.font(context, SizeCategory.large),
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkTeal,
                    ),
                  ),
                  if (onDelete != null)
                    GestureDetector(
                      onTap: onDelete,
                      child: Text(
                        "Delete Floor",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: AppSizes.padding(context, SizeCategory.medium)),
              buildComboBoxField(
                customLabelText: true,
                items: [
                  "Cellar / Basement",
                  "Ground",
                  "Floor 1",
                  "Floor 2",
                  "Floor 3",
                  "Loft (Not Converted)",
                  "Loft (Converted)",
                  "Floor title",
                ],
                onChanged: (val) {
                  if (onValueChanged != null) {
                    onValueChanged!(val != null && val.isNotEmpty);
                  }
                },
                validator: ValidationUtils.required,
                onSaved: (val) {
                  formData['floor_$index'] = val;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
