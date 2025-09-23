import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/utils/custom_text_field.dart';
import 'package:viva_home_mobile/utils/radio_group.dart';
import 'package:viva_home_mobile/widgets/checkbox_individual_widget.dart';
import 'package:viva_home_mobile/widgets/custom_combobox.dart';

class FormSection extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  const FormSection({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      margin: EdgeInsets.only(
        top: AppSizes.padding(context, SizeCategory.xlarge),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            AppSizes.radius(context, SizeCategory.xlarge),
          ),
          topRight: Radius.circular(
            AppSizes.radius(context, SizeCategory.xlarge),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius:
                AppSizes.padding(context, SizeCategory.medium) *
                0.625, // ~10 responsive
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
        
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: children),
        ),
      ),
    );
  }
}

class FormFieldWrapper extends StatelessWidget {
  final bool? cus;
  final String? label;
  final String? subtitle;
  final String? nodeKey;
  final Widget child;

  const FormFieldWrapper({
    super.key,
    this.label,
    this.cus = false,
    this.nodeKey,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.padding(context, SizeCategory.small)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (nodeKey != null)
                IndividualCheckboxWidget.standalone(
                  nodeKey: nodeKey!,
                  showtitle: false,
                ),
              SizedBox(width: AppSizes.padding(context, SizeCategory.small)),
              Expanded(
                child: Text(
                  label!.toUpperCase(),
                  style: TextStyle(
                    fontSize: AppSizes.font(context, SizeCategory.xxlarge),
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTeal,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),

          SizedBox(height: AppSizes.padding(context, SizeCategory.small)),
          if (subtitle != null) ...[
            Padding(
              padding: EdgeInsets.only(
                left: AppSizes.padding(context, SizeCategory.medium),
              ),
              child: Text(
                subtitle!.toUpperCase(),
                style: TextStyle(
                  fontSize: AppSizes.font(context, SizeCategory.xlarge),
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryTeal,
                ),
              ),
            ),
            SizedBox(height: AppSizes.padding(context, SizeCategory.medium)),
          ],
          Container(
            height: AppSizes.padding(context, SizeCategory.small) * 0.2,
            color: AppColors.primaryTeal,
          ),
          SizedBox(height: AppSizes.padding(context, SizeCategory.medium)),
          child,
        ],
      ),
    );
  }
}

class FormFieldGroup extends StatelessWidget {
  final String? label;
  final bool customLabelText; //render label + spacing
  final List<Widget> items;

  const FormFieldGroup({
    super.key,
    this.label,
    this.customLabelText = false,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!customLabelText) ...[
          Text(
            label ?? '',
            style: TextStyle(
              fontSize: AppSizes.font(context, SizeCategory.large),
              fontWeight: FontWeight.w600,
              color: AppColors.darkTeal,
            ),
          ),
          SizedBox(height: AppSizes.padding(context, SizeCategory.medium)),
        ],
        ...items.expand(
          (item) => [
            item,
            SizedBox(
              height: AppSizes.padding(context, SizeCategory.medium) * 0.5,
            ),
          ],
        ),
      ],
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
  void Function(String?)? onChanged,
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
        onChanged: onChanged,
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
