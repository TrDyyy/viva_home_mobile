import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/details/additional/additional_form.dart';

import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';

class AdditionalPage extends StatefulWidget {
  const AdditionalPage({super.key, required this.username});

  final String username;

  @override
  State<AdditionalPage> createState() => _AdditionalPageState();
}

class _AdditionalPageState extends State<AdditionalPage> {
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
            title: 'AdditionalPage',
            subtitle: 'Completed',
            items: [
              SectionItem(text: 'Roads', nodeKey: 'det_add_roads'),
              SectionItem(
                text: 'Special Risks',
                nodeKey: 'det_add_specialrisks',
              ),
            ],
            onActionPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdditionalForm()),
              );
            },
          ),
        ],
      ),
    );
  }
}
