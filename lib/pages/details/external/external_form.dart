import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viva_home_mobile/cubits/checkbox_tree_cubit.dart';
import 'package:viva_home_mobile/models/tree_config.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/utils/custom_button.dart';
import 'package:viva_home_mobile/utils/validation.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';
import 'package:viva_home_mobile/widgets/form_widget.dart';

class ExternalFormPage extends StatefulWidget {
  const ExternalFormPage({super.key});

  @override
  State<ExternalFormPage> createState() => _ExternalFormPageState();
}

//Form
final _formKey = GlobalKey<FormState>();
final Map<String, dynamic> formData = {};

class _ExternalFormPageState extends State<ExternalFormPage> {
  bool showInfoCard = false;
  int index = 1;
  bool _hasInitialized = false;

  //Boolean update checkboxWidget
  bool hasPurpose = false;
  bool hasTitle = false;
  bool hasFirstName = false;
  bool hasSurname = false;
  bool hasStatusHouse = false;
  bool hasTitleFormInfo = false;
  bool hasFirstNameFormInfo = false;
  bool hasSurnameFormInfo = false;
  bool hasAddressLine1 = false;
  bool hasAddressLine2 = false;
  bool hasTown = false;
  bool hasPostcode = false;
  bool hasLocation = false;
  bool hasOwnershipType = false;
  bool hasTermRemainingYears = false;
  bool hasEpcNo = false;
  bool hasProSize = false;
  bool isHasImageUpload = false;
  bool hasDevCompany = false;
  bool hasNameOfDev = false;
  bool hasPhoneOffice = false;
  bool hasEmailOffice = false;
  bool hasPhone = false;
  bool hasEmail = false;

  bool shouldCheckIntentOfValuation() => hasPurpose;
  bool shouldCheckHomeowner() => hasTitle && hasFirstName && hasSurname;
  bool shouldCheckFormInfo() =>
      (isHomeowner == true) ||
      (hasTitleFormInfo && hasFirstNameFormInfo && hasSurnameFormInfo);
  bool shouldCheckAddressInfo() =>
      hasAddressLine1 && hasAddressLine2 && hasTown && hasPostcode;
  bool shouldCheckTenure() =>
      hasOwnershipType &&
      hasTermRemainingYears &&
      (hasGroundRentServiceCharge != null);
  bool shouldCheckEfficiencies() =>
      hasEpcNo && energyEfficienciesOption != null;
  bool shouldCheckProSize() => hasProSize;
  bool shouldCheckNewProperty() =>
      (isNewBuild == false) ||
      (isHasUKFinanceDisclosure == true && isHasImageUpload == true) ||
      (isHasUKFinanceDisclosure == false &&
          hasDevCompany &&
          hasNameOfDev &&
          hasPhoneOffice &&
          hasEmailOffice &&
          hasPhone &&
          hasEmail);

  void _updateNodeWithConditions(String nodeKey) {
    late bool shouldCheck;

    switch (nodeKey) {
      case "det_gen_iov":
        shouldCheck = shouldCheckIntentOfValuation();
        break;
      case "det_gen_homeowner":
        shouldCheck = shouldCheckHomeowner();
        break;
      case "det_gen_formInfo":
        shouldCheck = shouldCheckFormInfo();
        break;
      case "det_gen_proAddress":
        shouldCheck = shouldCheckAddressInfo();
        break;
      case "det_gen_locality":
        shouldCheck = hasLocation;
        break;
      case "det_gen_tenure":
        shouldCheck = shouldCheckTenure();
        break;
      case "det_gen_efficiences":
        shouldCheck = shouldCheckEfficiencies();
        break;
      case "det_gen_proSize":
        shouldCheck = hasProSize;
        break;
      case "det_gen_newProperty":
        shouldCheck = shouldCheckNewProperty();
        break;
      default:
        shouldCheck = false;
    }
    context.read<GlobalTreeManager>().toggleNode(nodeKey, shouldCheck);
  }

  //Data for formData
  bool? isHomeowner;
  bool? hasGroundRentServiceCharge;
  String? energyEfficienciesOption;
  bool? isNewBuild;
  bool? isHasUKFinanceDisclosure;

  //Call Initialize Tree Data (Remove when save data for real)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInitialized) {
      _initializeTreeData();
      _hasInitialized = true;
    }
  }

  void _initializeTreeData() {
    context.read<GlobalTreeManager>().initializeNodes(
      CheckboxTreesConfig.allTrees,
    );
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
        title: 'General',
        isAppBarVisible: true,
        customBody: Form(
          key: _formKey,
          child: FormSection(
            children: [
              // Intent of valuation section
              FormFieldWrapper(
                label: "Intent of valuation",
                nodeKey: "det_gen_iov",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildComboBoxField(
                      label: "What is the purpose of this valuation?",
                      items: const [
                        "Shared Ownership",
                        "Help to Buy",
                        "Probate",
                        "General Sale",
                        "Other",
                      ],
                      onChanged: (val) {
                        setState(() => hasPurpose = val!.isNotEmpty);
                        _updateNodeWithConditions("det_gen_iov");
                      },
                      validator: ValidationUtils.required,
                      onSaved: (val) => formData["purpose"] = val,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.large),
                    ),
                    buildOtherSpecifyField(
                      context: context,
                      highlightText: "Other",
                      description: "please specify:",
                      colorBorder: AppColors.dark,
                      onSaved: (val) {
                        if (!hasPurpose) {
                          formData["other_purpose"] = val;
                        }
                      },
                    ),
                  ],
                ),
              ),
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
                      onPressed: () => _handleSubmit(),
                      backgroundColor: AppColors.darkTeal,
                      foregroundColor: AppColors.white,
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.medium),
                    ),
                    CustomButton(
                      text: "Back",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
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