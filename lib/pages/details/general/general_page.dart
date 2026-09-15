import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/details/general/general_detail_page.dart';
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
              SectionItem(text: 'Intent of valuation', nodeKey: 'det_gen_iov'),
              SectionItem(text: 'Homeowner', nodeKey: 'det_gen_homeowner'),
              SectionItem(
                text: 'Form information',
                nodeKey: 'det_gen_formInfo',
              ),
              SectionItem(
                text: 'Property address',
                nodeKey: 'det_gen_proAddress',
              ),
              SectionItem(text: 'Locality', nodeKey: 'det_gen_locality'),
              SectionItem(text: 'Tenure', nodeKey: 'det_gen_tenure'),
              SectionItem(text: 'Property size', nodeKey: 'det_gen_proSize'),
              SectionItem(text: 'Efficiences', nodeKey: 'det_gen_efficiences'),
              SectionItem(
                text: 'New properties (optional)',
                nodeKey: 'det_gen_newProperty',
              ),
            ],
            onActionPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GeneralDetailPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
