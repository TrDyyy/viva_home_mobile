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
import 'package:viva_home_mobile/widgets/base_page_widget.dart';
import 'package:viva_home_mobile/widgets/form_widget.dart';

class GeneralDetailPage extends StatefulWidget {
  const GeneralDetailPage({super.key});

  @override
  State<GeneralDetailPage> createState() => _GeneralDetailPageState();
}

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

  // Image picker functions
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
                child: FormSection(
                  children: [
                    FormFieldWrapper(
                      label: "Intent of valuation",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldGroup(
                            label: "What is the purpose of this valuation?",
                            items: [
                              CustomComboBox<String>(
                                items: const [
                                  "Shared Ownership",
                                  "Help to Buy",
                                  "Probate",
                                  "General Sale",
                                  "Other",
                                ],
                                onChanged: (val) {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSizes.padding(
                              context,
                              SizeCategory.large,
                            ),
                          ),
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
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkTeal,
                                  ),
                                  children: [
                                    const TextSpan(text: "If '"),
                                    TextSpan(
                                      text: "Other",
                                      style: TextStyle(
                                        color: AppColors.primaryTeal,
                                      ),
                                    ),
                                    const TextSpan(text: "', please specify:"),
                                  ],
                                ),
                              ),
                              CustomTextField(
                                hintText: "...",
                                hintTextEnable: false,
                                colorBorder: AppColors.dark,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FormFieldWrapper(
                      label: "Homeowner",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldGroup(
                            label: "Homeowner's Name",
                            items: [
                              CustomComboBox<String>(
                                items: const [
                                  "Mr",
                                  "Mrs",
                                  "Ms",
                                  "Dr",
                                  "Prof",
                                  "Other",
                                ],
                                onChanged: (val) {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSizes.padding(
                              context,
                              SizeCategory.large,
                            ),
                          ),
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
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkTeal,
                                  ),
                                  children: [
                                    const TextSpan(text: "If '"),
                                    TextSpan(
                                      text: "Other",
                                      style: TextStyle(
                                        color: AppColors.primaryTeal,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: "', please detail below:",
                                    ),
                                  ],
                                ),
                              ),
                              CustomTextField(
                                hintText: "John…",
                                hintTextEnable: false,
                                colorBorder: AppColors.darkGray,
                              ),
                            ],
                          ),
                          FormFieldGroup(
                            label: "First name:",
                            items: [
                              CustomTextField(
                                hintText: "John…",
                                hintTextEnable: false,
                                colorBorder: AppColors.dark,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppSizes.padding(
                              context,
                              SizeCategory.medium,
                            ),
                          ),
                          FormFieldGroup(
                            label: "Surname:",
                            items: [
                              CustomTextField(
                                hintText: "Doe…",
                                hintTextEnable: false,
                                colorBorder: AppColors.dark,
                              ),
                            ],
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
                            itemBuilder: (context, index) => ownerFields[index],
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
                    FormFieldWrapper(
                      label: "Form information",
                      child: Column(
                        children: [
                          FormFieldGroup(
                            label: "Are you the homeowner?",
                            items: [
                              Row(
                                children: [
                                  CustomRadioGroup<bool>(
                                    options: [
                                      RadioOption<bool>(
                                        value: true,
                                        label: "Yes",
                                      ),
                                      RadioOption<bool>(
                                        value: false,
                                        label: "No",
                                      ),
                                    ],
                                    groupValue: isHomeowner,
                                    onChanged: (value) {
                                      setState(() {
                                        isHomeowner = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
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
                          FormFieldGroup(
                            label: "Status to house:",
                            items: [
                              CustomComboBox<String>(
                                items: [
                                  "Surveyor",
                                  "Agent",
                                  "Owner",
                                  "Investor",
                                ],
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                          FormFieldGroup(
                            label: "Title:",
                            items: [
                              CustomTextField(
                                hintText: "Mr / Mrs",
                                hintTextEnable: false,
                                colorBorder: AppColors.dark,
                              ),
                            ],
                          ),
                          FormFieldGroup(
                            label: "First name:",
                            items: [
                              CustomTextField(
                                hintText: "John...",
                                hintTextEnable: false,
                                colorBorder: AppColors.dark,
                              ),
                            ],
                          ),
                          FormFieldGroup(
                            label: "Surname:",
                            items: [
                              CustomTextField(
                                hintText: "Doe...",
                                hintTextEnable: false,
                                colorBorder: AppColors.dark,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.xlarge),
                    ),
                    FormFieldWrapper(
                      label: "Property Address",
                      child: Column(
                        children: [
                          FormFieldGroup(
                            label: "Address Line 1:",
                            items: [
                              CustomTextField(
                                hintText: "...",
                                hintTextEnable: false,
                                colorBorder: AppColors.darkGray,
                              ),
                            ],
                          ),
                          FormFieldGroup(
                            label: "Address Line 2:",
                            items: [
                              CustomTextField(
                                hintText: "...",
                                hintTextEnable: false,
                                colorBorder: AppColors.darkGray,
                              ),
                            ],
                          ),
                          FormFieldGroup(
                            label: "Town / City:",
                            items: [
                              CustomTextField(
                                hintText: "...",
                                hintTextEnable: false,
                                colorBorder: AppColors.darkGray,
                              ),
                            ],
                          ),
                          FormFieldGroup(
                            label: "Post Code:",
                            items: [
                              CustomTextField(
                                hintText: "...",
                                hintTextEnable: false,
                                colorBorder: AppColors.darkGray,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.padding(context, SizeCategory.xlarge),
                    ),
                    FormFieldWrapper(
                      label: "Locality",
                      child: Column(
                        children: [
                          FormFieldGroup(
                            label: "Location:",
                            items: [
                              CustomTextField(
                                hintText: "Urban",
                                hintTextEnable: false,
                                colorBorder: AppColors.darkGray,
                                enabled: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FormFieldWrapper(
                      label: "Tenure",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldGroup(
                            label: "Ownership type:",
                            items: [
                              CustomComboBox(
                                items: [
                                  "Freehold",
                                  "Leasehold",
                                  "Share of freehold",
                                  "long leasehold",
                                  "< 85 years leasehold",
                                  "> 85 years leasehold",
                                ],
                                onChanged: (val) {},
                              ),
                            ],
                          ),
                          FormFieldGroup(
                            label: "Term Remaining (Years):",
                            items: [
                              CustomTextField(
                                hintText: "...",
                                hintTextEnable: false,
                                colorBorder: AppColors.darkGray,
                              ),
                            ],
                          ),
                          FormFieldGroup(
                            label:
                                "Do you have ground rent service maintenance charge?: ",
                            items: [
                              CustomRadioGroup(
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
                              ),
                            ],
                          ),
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
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkTeal,
                                  ),
                                  children: [
                                    const TextSpan(text: "If '"),
                                    TextSpan(
                                      text: "Other",
                                      style: TextStyle(
                                        color: AppColors.primaryTeal,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: "', please specify amount (£):",
                                    ),
                                  ],
                                ),
                              ),
                              CustomTextField(
                                hintText: "...",
                                hintTextEnable: false,
                                colorBorder: AppColors.dark,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FormFieldWrapper(
                      label: "Efficiences",
                      child: Column(
                        children: [
                          FormFieldGroup(
                            label: "Are there any energy effiences?",
                            items: [
                              CustomRadioGroup(
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
                                onChanged: (value) {
                                  setState(() {
                                    energyEfficienciesOption = value;
                                  });
                                },
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: AppSizes.font(
                                      context,
                                      SizeCategory.large,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.darkTeal,
                                  ),
                                  children: [
                                    const TextSpan(text: "If '"),
                                    TextSpan(
                                      text: "Other",
                                      style: TextStyle(
                                        color: AppColors.primaryTeal,
                                      ),
                                    ),
                                    const TextSpan(text: "', please specify:"),
                                  ],
                                ),
                              ),
                              CustomTextField(
                                hintText: "",
                                hintTextEnable: false,
                                colorBorder: AppColors.dark,
                                maxLines: 5,
                              ),
                            ],
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
                                "Example: ‘2628-8071-6228-8899-5924’",
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
                                colorBorder: AppColors.darkGray,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                          FormFieldGroup(
                            label: "Property footprint size (Sqm2):",
                            items: [
                              CustomTextField(
                                hintText: "000",
                                keyboardType: TextInputType.number,
                                hintTextEnable: false,
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                maxLength: 3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    FormFieldWrapper(
                      label: "New Build:",
                      subtitle: '(If applicable)',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormFieldGroup(
                            label: "Is this a 'New Build' Property?",
                            items: [
                              CustomRadioGroup(
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
                              ),
                            ],
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
                            ],
                          ),
                          SizedBox(
                            height: AppSizes.padding(
                              context,
                              SizeCategory.medium,
                            ),
                          ),
                          CustomRadioGroup(
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
                          ),
                        ],
                      ),
                    ),
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
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkTeal,
                            ),
                            children: [
                              const TextSpan(text: "If '"),
                              TextSpan(
                                text: "Yes",
                                style: TextStyle(color: AppColors.primaryTeal),
                              ),
                              const TextSpan(
                                text: "' upload a copy of your document below:",
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.padding(
                              context,
                              SizeCategory.medium,
                            ),
                            vertical:
                                AppSizes.padding(context, SizeCategory.large) *
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
                              AppSizes.radius(context, SizeCategory.xxlarge),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  selectedFileName ?? "upload.jpg",
                                  style: TextStyle(
                                    fontSize: AppSizes.font(
                                      context,
                                      SizeCategory.large,
                                    ),
                                    fontWeight: FontWeight.w400,
                                    color: selectedFileName != null
                                        ? AppColors.primaryTeal
                                        : AppColors.darkGray,
                                  ),
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: _pickImageFromCamera,
                                child: const Icon(Icons.camera_alt_outlined),
                              ),
                              SizedBox(
                                width: AppSizes.padding(
                                  context,
                                  SizeCategory.small,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: _pickImageFromGallery,
                                child: const Icon(Icons.upload_outlined),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkTeal,
                            ),
                            children: [
                              const TextSpan(text: "If '"),
                              TextSpan(
                                text: "No",
                                style: TextStyle(color: AppColors.primaryTeal),
                              ),
                              const TextSpan(
                                text:
                                    "' provide contact details of the development site office or the development company if the development is complete and there is no longer a site office:",
                              ),
                            ],
                          ),
                        ),
                      ],
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
        FormFieldGroup(
          label: "First name:",
          items: [
            CustomTextField(
              hintText: "John…",
              hintTextEnable: false,
              colorBorder: AppColors.dark,
            ),
          ],
        ),
        SizedBox(height: AppSizes.padding(context, SizeCategory.medium)),
        FormFieldGroup(
          label: "Surname:",
          items: [
            CustomTextField(
              hintText: "Doe…",
              hintTextEnable: false,
              colorBorder: AppColors.dark,
            ),
          ],
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
