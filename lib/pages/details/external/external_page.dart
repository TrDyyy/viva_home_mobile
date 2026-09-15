import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/details/external/external_form.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';

class ExternalPage extends StatefulWidget {
  const ExternalPage({super.key, required this.username});

  final String username;

  @override
  State<ExternalPage> createState() => _ExternalPageState();
}

class _ExternalPageState extends State<ExternalPage> {
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
            title: 'External',
            subtitle: 'Completed',
            items: [
              SectionItem(
                text: 'Dwelling type',
                nodeKey: 'det_ext_dwellingType',
              ),
              SectionItem(text: 'Property Age', nodeKey: 'det_ext_propertyAge'),
              SectionItem(text: 'Alterations', nodeKey: 'det_ext_alterations'),
              SectionItem(
                text: 'Construction',
                nodeKey: 'det_ext_construction',
              ),
              SectionItem(
                text: 'Outbuildings',
                nodeKey: 'det_ext_outbuildings',
              ),
            ],
            onActionPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExternalFormPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
