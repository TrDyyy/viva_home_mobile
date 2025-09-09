import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  int index = 1;
  bool? isHomeowner;
  bool? hasGroundRentServiceCharge;
  String? energyEfficienciesOption;

  void addOwnerField() {
    setState(() {
      index++;
      ownerFields.add(AddOwnerWidget(index: index));
    });
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
                            customFieldText: true,
                            items: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "If '",
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkTeal,
                                    ),
                                  ),
                                  Text(
                                    "Other",
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryTeal,
                                    ),
                                  ),
                                  Text(
                                    "', please specify:",
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkTeal,
                                    ),
                                  ),
                                ],
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
                            customFieldText: true,
                            items: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "If '",
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkTeal,
                                    ),
                                  ),
                                  Text(
                                    "Other",
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryTeal,
                                    ),
                                  ),
                                  Text(
                                    "', please detail below:",
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkTeal,
                                    ),
                                  ),
                                ],
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
                            customFieldText: true,
                            items: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "If '",
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkTeal,
                                    ),
                                  ),
                                  Text(
                                    "Other",
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryTeal,
                                    ),
                                  ),
                                  Text(
                                    "', please specify amount (£):",
                                    style: TextStyle(
                                      fontSize: AppSizes.font(
                                        context,
                                        SizeCategory.large,
                                      ),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkTeal,
                                    ),
                                  ),
                                ],
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
                          CustomTextField(
                            hintText: "Enter property size",
                            hintTextEnable: false,
                            colorBorder: AppColors.dark,
                          ),
                        ],
                      ),
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
