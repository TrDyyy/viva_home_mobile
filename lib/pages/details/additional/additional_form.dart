import 'package:flutter/material.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';
import 'package:viva_home_mobile/widgets/form_widget.dart';

class AdditionalForm extends StatefulWidget {
  const AdditionalForm({super.key});

  @override
  State<AdditionalForm> createState() => _AdditionalFormState();
}

final _formKey = GlobalKey<FormState>();
final Map<String, dynamic> formData = {};

class _AdditionalFormState extends State<AdditionalForm> {
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
        title: "Additional",
        isAppBarVisible: true,
        customBody: Form(
          key: _formKey,
          child: FormSection(
            onPressed: _handleSubmit,
            children: [
              FormFieldWrapper(
                child: Column(
                  children: [
                    buildOtherSpecifyField(context: context),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(height: 16),
              buildOtherSpecifyField(context: context)
            ],
          ),
        ),
      ),
    );
  }
}
