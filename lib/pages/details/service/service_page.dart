import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/details/service/service_form.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key, required this.username});

  final String username;

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
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
            title: 'Service',
            subtitle: 'Completed',
            items: [
              SectionItem(text: 'Services', nodeKey: 'det_serv_propServ'),
              SectionItem(text: 'Guarantees', nodeKey: 'det_serv_guarantees'),
              SectionItem(text: 'Warranties', nodeKey: 'det_serv_warranties'),
            ],
            onActionPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ServiceFormPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
