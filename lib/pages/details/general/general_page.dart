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
    return BasePageWidget(config: PageConfig(
      title: 'General Details',
      username: widget.username,
      useGridLayout: false,
      actionButtonText: AppStrings.backButton,
      actionButtonOnPressed: () => Navigator.pop(context), 
      contentType: ContentType.modal,
      cards: [],
      modalSections: [
          ModalSection(
      title: 'General Details',
      subtitle: 'Completed',
      items: [
        SectionItem(text: 'Personal Information', isChecked: true),
        SectionItem(text: 'Contact Details', isChecked: false),
        SectionItem(text: 'Address', isChecked: true),
      ],
      onActionPressed: () {
        // Handle arrow button tap
      },
    ),
    ModalSection(
      title: 'Additional Info',
      subtitle: 'In Progress',
      items: [
        SectionItem(text: 'Documents', isChecked: false),
        SectionItem(text: 'Verification', isChecked: false),
      ],
    ),
      ]
    ));
  }
}