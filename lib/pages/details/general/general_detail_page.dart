import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:viva_home_mobile/pages/camera/custom_camera_page.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/utils/custom_button.dart';
import 'package:viva_home_mobile/utils/custom_combobox.dart';
import 'package:viva_home_mobile/utils/custom_text_field.dart';
import 'package:viva_home_mobile/utils/radio_group.dart';
import 'package:viva_home_mobile/utils/validation.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';
import 'package:viva_home_mobile/widgets/form_widget.dart';

class GeneralDetailPage extends StatefulWidget {
  const GeneralDetailPage({super.key});

  @override
  State<GeneralDetailPage> createState() => _GeneralDetailPageState();
}

//Form
final _formKey = GlobalKey<FormState>();
final Map<String, dynamic> formData = {};

class _GeneralDetailPageState extends State<GeneralDetailPage> {
  final List<AddOwnerWidget> ownerFields = [];
  bool showInfoCard = false;

  int index = 1;
  bool? isHomeowner;
  bool? hasGroundRentServiceCharge;
  String? energyEfficienciesOption;
  bool? isNewBuild;
  bool? isHasUKFinanceDisclosure;

  // Image upload states
  File? selectedImage;
  String? selectedFileName;
  bool showUploadSuccess = false;

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

  void addOwnerField() {
    setState(() {
      index++;
      ownerFields.add(AddOwnerWidget(index: index));
    });
  }

  void toggleInfoCard() {
    setState(() {
      showInfoCard = !showInfoCard;
    });
  }

  Future<void> _pickImageFromCamera() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomCameraPage()),
    );
    if (result is File) {
      setState(() {
        selectedImage = result;
        selectedFileName = path.basename(result.path);
        showUploadSuccess = true;
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        selectedFileName = path.basename(image.path);
        showUploadSuccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePageWidget(
      config: PageConfig(
        title: 'General',
        username: '',
        cards: [],
        isAppBarVisible: true,
        customBody: Padding(
          padding: EdgeInsets.only(
            top: AppSizes.padding(context, SizeCategory.xlarge),
          ),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: FormSection(
                    children: [
                      // Intent of valuation section
                      FormFieldWrapper(
                        label: "Intent of valuation",
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
                              onChanged: (val) {},
                              validator: ValidationUtils.required,
                              onSaved: (val) => formData["purpose"] = val,
                            ),
                            SizedBox(
                              height: AppSizes.padding(
                                context,
                                SizeCategory.large,
                              ),
                            ),
                            buildOtherSpecifyField(
                              context: context,
                              highlightText: "Other",
                              description: "please specify:",
                              colorBorder: AppColors.dark,
                              onSaved: (val) => formData["other_purpose"] = val,
                            ),
                          ],
                        ),
                      ),

                      // Homeowner section
                      FormFieldWrapper(
                        label: "Homeowner",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildComboBoxField(
                              label: "Homeowner's Name",
                              items: const [
                                "Mr",
                                "Mrs",
                                "Ms",
                                "Dr",
                                "Prof",
                                "Other",
                              ],
                              onChanged: (val) {},
                              validator: ValidationUtils.required,
                              onSaved: (val) =>
                                  formData["homeowner_name"] = val,
                            ),
                            SizedBox(
                              height: AppSizes.padding(
                                context,
                                SizeCategory.large,
                              ),
                            ),
                            buildOtherSpecifyField(
                              context: context,
                              highlightText: "Other",
                              description: "please detail below:",
                              hintText: "John…",
                              onSaved: (val) =>
                                  formData["other_homeowner_name"] = val,
                            ),
                            buildCustomTextField(
                              label: "First name:",
                              hintText: "John…",
                              onSaved: (val) =>
                                  formData["first_name_$index"] = val,
                              validator: ValidationUtils.required,
                            ),
                            SizedBox(
                              height: AppSizes.padding(
                                context,
                                SizeCategory.medium,
                              ),
                            ),
                            buildCustomTextField(
                              label: "Surname:",
                              hintText: "Doe…",
                              onSaved: (val) =>
                                  formData["surname_$index"] = val,
                              validator: ValidationUtils.required,
                            ),
                            SizedBox(
                              height: AppSizes.padding(
                                context,
                                SizeCategory.small,
                              ),
                            ),

                            //List of owner fields
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: ownerFields.length,
                              separatorBuilder: (_, __) => SizedBox(
                                height: AppSizes.padding(
                                  context,
                                  SizeCategory.medium,
                                ),
                              ),
                              itemBuilder: (context, index) =>
                                  ownerFields[index],
                            ),
                            Center(
                              child: CustomButton(
                                text: "Add Owner",
                                onPressed: () => addOwnerField(),
                                backgroundColor: AppColors.lightGray,
                                foregroundColor: AppColors.dark,
                                icon: DottedBorder(
                                  options: RectDottedBorderOptions(
                                    dashPattern: [6, 3],
                                    strokeWidth: 1,
                                    padding: EdgeInsets.all(
                                      AppSizes.padding(
                                            context,
                                            SizeCategory.small,
                                          ) *
                                          0.2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.primaryTeal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Form information section
                      FormFieldWrapper(
                        label: "Form information",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildRadioField<bool>(
                              context: context,
                              label: "Are you the homeowner?",
                              options: [
                                RadioOption<bool>(value: true, label: "Yes"),
                                RadioOption<bool>(value: false, label: "No"),
                              ],
                              groupValue: isHomeowner,
                              onChanged: (value) {
                                setState(() {
                                  isHomeowner = value;
                                });
                              },
                              onSaved: (val) => formData["is_homeowner"] = val,
                              validator:
                                  ValidationUtils.validateRequiredOption<bool>,
                            ),
                            // Add the info text
                            FormFieldGroup(
                              customLabelText: true,
                              items: [
                                Text(
                                  "If you are not the homeowner please fill out the following questions below:",
                                  style: TextStyle(
                                    fontSize: AppSizes.font(
                                      context,
                                      SizeCategory.medium,
                                    ),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkTeal,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSizes.padding(
                                context,
                                SizeCategory.medium,
                              ),
                            ),
                            buildComboBoxField(
                              label: "Status to house:",
                              items: ["Surveyor", "Agent", "Owner", "Investor"],
                              onChanged: (value) {},
                              onSaved: (val) => formData["status_house"] = val,
                              validator: (val) {
                                if (isHomeowner == false) {
                                  return ValidationUtils.required(val);
                                }
                                return null;
                              },
                            ),
                            buildCustomTextField(
                              label: "Title:",
                              hintText: "Mr / Mrs",
                              onSaved: (val) => formData["title_name"] = val,
                              validator: (val) {
                                if (isHomeowner == false) {
                                  return ValidationUtils.required(val);
                                }
                                return null;
                              },
                            ),
                            buildCustomTextField(
                              label: "First name:",
                              hintText: "John...",
                              onSaved: (val) =>
                                  formData["first_name_nonowner"] = val,
                              validator: (val) {
                                if (isHomeowner == false) {
                                  return ValidationUtils.required(val);
                                }
                                return null;
                              },
                            ),
                            buildCustomTextField(
                              label: "Surname:",
                              hintText: "Doe...",
                              onSaved: (val) =>
                                  formData["surname_nonowner"] = val,
                              validator: (val) {
                                if (isHomeowner == false) {
                                  return ValidationUtils.required(val);
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      // Property Address section
                      FormFieldWrapper(
                        label: "Property Address",
                        child: Column(
                          children: [
                            buildCustomTextField(
                              label: "Address Line 1:",
                              hintText: "...",
                              onSaved: (val) =>
                                  formData["address_line_1"] = val,
                              validator: ValidationUtils.required,
                            ),
                            buildCustomTextField(
                              label: "Address Line 2:",
                              hintText: "...",
                              onSaved: (val) =>
                                  formData["address_line_2"] = val,
                              validator: ValidationUtils.required,
                            ),
                            buildCustomTextField(
                              label: "Town / City:",
                              hintText: "...",
                              onSaved: (val) => formData["town_city"] = val,
                              validator: ValidationUtils.required,
                            ),
                            buildCustomTextField(
                              label: "Post Code:",
                              hintText: "...",
                              onSaved: (val) => formData["post_code"] = val,
                              validator: ValidationUtils.required,
                            ),
                          ],
                        ),
                      ),

                      // Locality section
                      FormFieldWrapper(
                        label: "Locality",
                        child: Column(
                          children: [
                            buildCustomTextField(
                              label: "Location:",
                              hintText: "Urban",
                              enabled: false,
                              onSaved: (val) => formData["location"] = val,
                            ),
                          ],
                        ),
                      ),

                      // Tenure section
                      FormFieldWrapper(
                        label: "Tenure",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildComboBoxField(
                              label: "Ownership type:",
                              items: [
                                "Freehold",
                                "Leasehold",
                                "Share of freehold",
                                "long leasehold",
                                "< 85 years leasehold",
                                "> 85 years leasehold",
                              ],
                              onChanged: (val) {},
                              validator: ValidationUtils.required,
                              onSaved: (val) =>
                                  formData["ownership_type"] = val,
                            ),
                            buildCustomTextField(
                              label: "Term Remaining (Years):",
                              hintText: "...",
                              keyboardType: TextInputType.numberWithOptions(),
                              onSaved: (val) =>
                                  formData["term_remaining_years"] = val,
                              validator: ValidationUtils.number,
                            ),
                            buildRadioField<bool>(
                              context: context,
                              label:
                                  "Do you have ground rent service maintenance charge?: ",
                              options: [
                                RadioOption(value: true, label: "Yes"),
                                RadioOption(value: false, label: "No"),
                              ],
                              groupValue: hasGroundRentServiceCharge,
                              onChanged: (value) {
                                setState(() {
                                  hasGroundRentServiceCharge = value;
                                });
                              },
                              validator:
                                  ValidationUtils.validateRequiredOption<bool>,
                              onSaved: (val) =>
                                  formData["has_ground_rent_service_charge"] =
                                      val,
                            ),
                            buildOtherSpecifyField(
                              context: context,
                              keyboardType: TextInputType.number,
                              highlightText: "Other",
                              description: "please specify amount (£):",
                              onSaved: (val) =>
                                  formData["other_ground_rent_service_charge"] =
                                      val,
                            ),
                          ],
                        ),
                      ),

                      // Efficiencies section
                      FormFieldWrapper(
                        label: "Efficiences",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildRadioField<String>(
                              context: context,
                              label: "Are there any energy effiences?",
                              options: [
                                RadioOption(
                                  value: "Solar Panels",
                                  label: "Solar Panels",
                                ),
                                RadioOption(
                                  value: "Pellet heating",
                                  label: "Pellet heating",
                                ),
                                RadioOption(
                                  value: "Air source Heating",
                                  label: "Air source Heating",
                                ),
                              ],
                              groupValue: energyEfficienciesOption,
                              onChanged: (val) {
                                setState(() => energyEfficienciesOption = val);
                              },
                              onSaved: (val) =>
                                  formData["energyEfficienciesOption"] = val,
                            ),
                            buildOtherSpecifyField(
                              context: context,
                              textFieldEnabled: false,
                              highlightText: "Other",
                              description: "please specify:",
                              onSaved: (val) =>
                                  formData["other_energy_efficiencies"] = val,
                            ),
                            CustomTextField(
                              hintText: "",
                              hintTextEnable: false,
                              maxLines: 5,
                              onSaved: (val) =>
                                  formData["energy_efficiencies_notes"] = val,
                              colorBorder: AppColors.dark,
                            ),
                            SizedBox(
                              height: AppSizes.padding(
                                context,
                                SizeCategory.small,
                              ),
                            ),
                            FormFieldGroup(
                              label: "EPC Rating:",
                              items: [
                                Text(
                                  "If you do not know your EPC rating, please visit:",
                                  style: TextStyle(
                                    fontSize: AppSizes.font(
                                      context,
                                      SizeCategory.medium,
                                    ),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkTeal,
                                  ),
                                ),
                                CustomButton(
                                  text: "Find my EPC No.",
                                  onPressed: () {},
                                  backgroundColor: AppColors.darkTeal,
                                  foregroundColor: AppColors.white,
                                ),

                                SizedBox(
                                  height: AppSizes.padding(
                                    context,
                                    SizeCategory.small,
                                  ),
                                ),
                                Text(
                                  "Example: '2628-8071-6228-8899-5924'",
                                  style: TextStyle(
                                    fontSize: AppSizes.font(
                                      context,
                                      SizeCategory.medium,
                                    ),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkTeal,
                                  ),
                                ),

                                CustomTextField(
                                  hintText: "2628-8071-6228-8899-5924",
                                  hintTextEnable: false,
                                  colorBorder: AppColors.dark,
                                  validator: ValidationUtils.required,
                                  onSaved: (val) =>
                                      formData["epc_rating"] = val,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Property Size section
                      FormFieldWrapper(
                        label: "Property Size",
                        subtitle: "(If applicable)",
                        child: Column(
                          children: [
                            FormFieldGroup(
                              customLabelText: true,
                              items: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.darkTeal,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text:
                                            "If you do not know your EPC rating, please visit: ",
                                      ),
                                      TextSpan(
                                        text:
                                            "https://getting-new-energy-certificate.digital.communities.gov.uk",
                                        style: TextStyle(
                                          color: AppColors.primaryTeal,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: AppSizes.padding(
                                    context,
                                    SizeCategory.small,
                                  ),
                                ),
                                CustomButton(
                                  text: "External Link",
                                  backgroundColor: AppColors.darkTeal,
                                  foregroundColor: AppColors.white,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppSizes.padding(
                                context,
                                SizeCategory.medium,
                              ),
                            ),
                            buildCustomTextField(
                              label: "Property footprint size (Sqm2):",
                              hintText: "000",
                              keyboardType: TextInputType.number,
                              onSaved: (val) =>
                                  formData["property_footprint_size"] = val,
                              validator: ValidationUtils.number,
                              colorBorder: AppColors.darkGray,
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(
                                  AppSizes.padding(
                                    context,
                                    SizeCategory.medium,
                                  ),
                                ),
                                child: const Text(
                                  "Sqm²",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              maxLength: 3,
                            ),
                          ],
                        ),
                      ),

                      // New Build section
                      FormFieldWrapper(
                        label: "New Build:",
                        subtitle: '(If applicable)',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildRadioField<bool>(
                              context: context,
                              label: "Is this a 'New Build' Property?",
                              options: [
                                RadioOption(value: true, label: "Yes"),
                                RadioOption(value: false, label: "No"),
                              ],
                              groupValue: isNewBuild,
                              onChanged: (value) {
                                setState(() {
                                  isNewBuild = value;
                                });
                              },
                              validator:
                                  ValidationUtils.validateRequiredOption<bool>,
                              onSaved: (val) => formData["is_new_build"] = val,
                            ),
                            FormFieldGroup(
                              customLabelText: true,
                              items: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      color: AppColors.darkTeal,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text:
                                            "If 'Yes', have you seen the UK Finance Disclosure of Incentives form? ",
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppSizes.padding(
                                              context,
                                              SizeCategory.small,
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: toggleInfoCard,
                                            child: Icon(
                                              Icons.info_outline,
                                              color: AppColors.primaryTeal,
                                              size: AppSizes.icon(
                                                context,
                                                SizeCategory.medium,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (showInfoCard) ...[
                                  SizedBox(
                                    height: AppSizes.padding(
                                      context,
                                      SizeCategory.medium,
                                    ),
                                  ),
                                  InfoCard(
                                    onClose: () {
                                      setState(() {
                                        showInfoCard = false;
                                      });
                                    },
                                  ),
                                ],
                                buildRadioField<bool>(
                                  context: context,
                                  customLabelText: true,
                                  options: [
                                    RadioOption(value: true, label: "Yes"),
                                    RadioOption(value: false, label: "No"),
                                  ],
                                  groupValue: isHasUKFinanceDisclosure,
                                  onChanged: (value) {
                                    setState(() {
                                      isHasUKFinanceDisclosure = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (isNewBuild == true) {
                                      return ValidationUtils.validateRequiredOption<
                                        bool
                                      >(value);
                                    }
                                    return null;
                                  },
                                  onSaved: (val) =>
                                      formData["has_uk_finance_disclosure"] =
                                          val,
                                ),
                              ],
                            ),
                            buildOtherSpecifyField(
                              context: context,
                              textFieldEnabled: false,
                              highlightText: "Yes",
                              description:
                                  "upload a copy of your document below:",
                            ),
                            // File upload container
                            FormFieldGroup(
                              customLabelText: true,
                              items: [
                                FormField<String>(
                                  validator: (value) {
                                    if (isHasUKFinanceDisclosure == true &&
                                        (selectedFileName == null ||
                                            selectedFileName!.isEmpty)) {
                                      return "Please upload a document";
                                    }
                                    return null;
                                  },
                                  builder: (field) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppSizes.padding(
                                              context,
                                              SizeCategory.medium,
                                            ),
                                            vertical:
                                                AppSizes.padding(
                                                  context,
                                                  SizeCategory.large,
                                                ) *
                                                0.75,
                                          ),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            border: Border.all(
                                              color: AppColors.darkGray,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              AppSizes.radius(
                                                context,
                                                SizeCategory.xxlarge,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  selectedFileName ??
                                                      "upload.jpg",
                                                  style: TextStyle(
                                                    fontSize: AppSizes.font(
                                                      context,
                                                      SizeCategory.large,
                                                    ),
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        selectedFileName != null
                                                        ? AppColors.primaryTeal
                                                        : AppColors.darkGray,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                onTap: _pickImageFromCamera,
                                                child: const Icon(
                                                  Icons.camera_alt_outlined,
                                                ),
                                              ),
                                              SizedBox(
                                                width: AppSizes.padding(
                                                  context,
                                                  SizeCategory.small,
                                                ),
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                onTap: _pickImageFromGallery,
                                                child: const Icon(
                                                  Icons.upload_outlined,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (field.hasError)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top:
                                                  AppSizes.container(
                                                    context,
                                                    SizeCategory.small,
                                                  ) *
                                                  0.25,
                                            ),
                                            child: Text(
                                              field.errorText!,
                                              style: TextStyle(
                                                color: AppColors.error,
                                                fontSize: AppSizes.font(
                                                  context,
                                                  SizeCategory.medium,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                            buildOtherSpecifyField(
                              context: context,
                              textFieldEnabled: false,
                              highlightText: "No",
                              description:
                                  "provide contact details of the development site office or the development company if the development is complete and there is no longer a site office:",
                            ),
                            SizedBox(
                              height: AppSizes.padding(
                                context,
                                SizeCategory.small,
                              ),
                            ),
                            buildComboBoxField(
                              label: "Development Company:",
                              items: [
                                "Bovis Homes",
                                "Persimmon Homes",
                                "Berkeley Group",
                                "Unknown",
                              ],
                              onChanged: (value) {},
                              validator: (value) {
                                if (isHasUKFinanceDisclosure == false) {
                                  return ValidationUtils.required(value);
                                }
                                return null;
                              },
                              onSaved: (val) => formData["title"] = val,
                            ),
                            buildCustomTextField(
                              label: "Name of Development:",
                              hintText: "...",
                              validator: (value) {
                                if (isHasUKFinanceDisclosure == false) {
                                  return ValidationUtils.required(value);
                                }
                                return null;
                              },
                              onSaved: (val) =>
                                  formData["development_name"] = val,
                            ),
                            buildCustomTextField(
                              label: "Phone Number (Site Office):",
                              hintText: "...",
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (isHasUKFinanceDisclosure == false) {
                                  return ValidationUtils.required(value);
                                }
                                return null;
                              },
                              onSaved: (val) =>
                                  formData["phone_site_office"] = val,
                            ),
                            buildCustomTextField(
                              label: "Email Address (Site Office):",
                              hintText: "...",
                              validator: (value) {
                                if (isHasUKFinanceDisclosure == false) {
                                  return ValidationUtils.validateEmail(value);
                                }
                                return null;
                              },
                              onSaved: (val) =>
                                  formData["email_site_office"] = val,
                            ),
                            buildCustomTextField(
                              label: "Phone Number:",
                              hintText: "...",
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (isHasUKFinanceDisclosure == false) {
                                  return ValidationUtils.required(value);
                                }
                                return null;
                              },
                              onSaved: (val) => formData["phone"] = val,
                            ),
                            buildCustomTextField(
                              label: "Email Address:",
                              hintText: "...",
                              validator: (value) {
                                if (isHasUKFinanceDisclosure == false) {
                                  return ValidationUtils.validateEmail(value);
                                }
                                return null;
                              },
                              onSaved: (val) => formData["email"] = val,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.padding(
                            context,
                            SizeCategory.small,
                          ),
                          vertical:
                              AppSizes.padding(context, SizeCategory.xxxlarge) *
                              2,
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
                              height: AppSizes.padding(
                                context,
                                SizeCategory.medium,
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}

// Helper for ComboBox field
FormFieldGroup buildComboBoxField({
  onSaved,
  validator,
  required String label,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return FormFieldGroup(
    label: label,
    items: [
      CustomComboBox<String>(
        items: items,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
      ),
    ],
  );
}

// Helper for TextField field
FormFieldGroup buildCustomTextField({
  required String label,
  required String hintText,
  Color colorBorder = AppColors.darkGray,
  bool enabled = true,
  TextInputType? keyboardType,
  Widget? suffixIcon,
  int? maxLength,
  int? maxLines,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
}) {
  return FormFieldGroup(
    label: label,
    items: [
      CustomTextField(
        hintText: hintText,
        hintTextEnable: false,
        colorBorder: colorBorder,
        enabled: enabled,
        keyboardType: keyboardType ?? TextInputType.text,
        suffixIcon: suffixIcon,
        maxLength: maxLength,
        maxLines: maxLines,
        validator: validator,
        onSaved: onSaved,
      ),
    ],
  );
}

// Helper for Radio Button field
FormFieldGroup buildRadioField<T>({
  required BuildContext context,
  String? label,
  required List<RadioOption<T>> options,
  bool customLabelText = false,
  required T? groupValue,
  required Function(T?) onChanged,
  FormFieldValidator<T>? validator,
  FormFieldSetter<T>? onSaved,
}) {
  return FormFieldGroup(
    customLabelText: customLabelText,
    label: label ?? '',
    items: [
      FormField<T>(
        initialValue: groupValue,
        validator: validator,
        onSaved: onSaved,
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRadioGroup<T>(
                options: options,
                groupValue: field.value,
                onChanged: (val) {
                  onChanged(val);
                  field.didChange(val);
                },
              ),
              if (field.hasError)
                Padding(
                  padding: EdgeInsets.only(
                    top: AppSizes.container(context, SizeCategory.small) * 0.25,
                  ),
                  child: Text(
                    field.errorText!,
                    style: TextStyle(
                      color: AppColors.error,
                      fontSize: AppSizes.font(context, SizeCategory.medium),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    ],
  );
}

// Helper for "If Other, please specify" field
Widget buildOtherSpecifyField({
  required BuildContext context,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
  String highlightText = "Other",
  String description = "please specify:",
  String hintText = "...",
  Color colorBorder = AppColors.dark,
  TextInputType keyboardType = TextInputType.text,
  bool textFieldEnabled = true,
  int? maxLines,
}) {
  return FormFieldGroup(
    customLabelText: true,
    items: [
      RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: AppSizes.font(context, SizeCategory.large),
            fontWeight: FontWeight.w600,
            color: AppColors.darkTeal,
          ),
          children: [
            const TextSpan(text: "If '"),
            TextSpan(
              text: highlightText,
              style: TextStyle(color: AppColors.primaryTeal),
            ),
            TextSpan(text: "', $description"),
          ],
        ),
      ),
      if (textFieldEnabled)
        CustomTextField(
          validator: validator,
          onSaved: onSaved,
          hintText: hintText,
          hintTextEnable: false,
          colorBorder: colorBorder,
          maxLines: maxLines,
          keyboardType: keyboardType,
        ),
    ],
  );
}

class AddOwnerWidget extends StatelessWidget {
  final int index;
  const AddOwnerWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Homeowner $index",
          style: TextStyle(
            fontSize: AppSizes.font(context, SizeCategory.xxlarge),
            fontWeight: FontWeight.w600,
            color: AppColors.darkTeal,
          ),
        ),
        SizedBox(height: AppSizes.padding(context, SizeCategory.xlarge)),
        buildCustomTextField(
          label: "First name:",
          hintText: "John…",
          onSaved: (val) => formData["first_name_$index"] = val,
          validator: ValidationUtils.required,
        ),
        SizedBox(height: AppSizes.padding(context, SizeCategory.medium)),
        buildCustomTextField(
          label: "Surname:",
          hintText: "Doe…",
          onSaved: (val) => formData["surname_$index"] = val,
          validator: ValidationUtils.required,
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  final VoidCallback? onClose;

  const InfoCard({super.key, this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.padding(context, SizeCategory.medium),
        horizontal: AppSizes.padding(context, SizeCategory.small),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryTeal),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: AppColors.primaryTeal),
              SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
              Expanded(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                  "Quisque consectetur ullamcorper, ac feugiat arcu semper.",
                ),
              ),
              InkWell(
                onTap: () => onClose?.call(),
                child: Icon(
                  Icons.close,
                  color: Colors.teal,
                  size: AppSizes.icon(context, SizeCategory.medium),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.padding(context, SizeCategory.small)),
          Center(
            child: Stack(
              children: [
                Hero(
                  tag: "ukFormImage",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/ukForm.png",
                      height: AppSizes.container(context, SizeCategory.large),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Scaffold(
                            backgroundColor: AppColors.dark,
                            body: Stack(
                              children: [
                                Center(
                                  child: Hero(
                                    tag: "ukFormImage",
                                    child: InteractiveViewer(
                                      panEnabled: true,
                                      minScale: 0.8,
                                      maxScale: 4.0,
                                      child: Image.asset(
                                        "assets/images/ukForm.png",
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 40,
                                  right: 20,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: AppColors.white,
                                      size: 32,
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
