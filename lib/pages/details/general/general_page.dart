import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key, required this.username});

  final String username;

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageWidget(
      config: PageConfig(
        title: 'PROPERTY DETAILS',
        username: widget.username,
        useGridLayout: false,
        actionButtonText: AppStrings.backButton,
        actionButtonOnPressed: () => Navigator.pop(context),
        contentType: ContentType.modal,
        cards: [],
        modalSections: [
          ModalSection(
            title: 'General',
            subtitle: 'Completed',
            items: [
              SectionItem(text: 'Intent of valuation', isChecked: true),
              SectionItem(text: 'Homeowner', isChecked: false),
              SectionItem(text: 'Form information', isChecked: true),
              SectionItem(text: 'Property address', isChecked: false),
              SectionItem(text: 'Locality', isChecked: false),
              SectionItem(text: 'Tenure', isChecked: true),
              SectionItem(text: 'Property size', isChecked: false),
              SectionItem(text: 'Efficiences', isChecked: false),
              SectionItem(text: 'New properties (optional)', isChecked: false),
            ],
            onActionPressed: () {
              // Handle arrow button tap
            },
          ),
        ],
      ),
    );
  }
}
