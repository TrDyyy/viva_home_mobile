import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';

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
      child: SingleChildScrollView(child: Column(children: children)),
    );
  }
}

class FormFieldWrapper extends StatelessWidget {
  final String label;
  final String? subtitle;
  final Widget child;

  const FormFieldWrapper({
    super.key,
    required this.label,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                activeColor: AppColors.primaryTeal,
                value: true,
                onChanged: (val) {},
              ),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: AppSizes.font(context, SizeCategory.xxlarge),
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTeal,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.padding(context, SizeCategory.small)),
          if (subtitle != null) ...[
            Padding(
              padding:  EdgeInsets.only(left: AppSizes.padding(context, SizeCategory.medium)),
              child: Text(subtitle!.toUpperCase(), style: TextStyle(
                fontSize: AppSizes.font(context, SizeCategory.xlarge),
                fontWeight: FontWeight.w600,
                color: AppColors.primaryTeal,
              )),
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
            SizedBox(height: AppSizes.padding(context, SizeCategory.medium) *0.5),
          ],
        ),
      ],
    );
  }
}
