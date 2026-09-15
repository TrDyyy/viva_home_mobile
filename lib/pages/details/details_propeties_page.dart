import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/details/additional/additional_page.dart';
import 'package:viva_home_mobile/pages/details/external/external_page.dart';
import 'package:viva_home_mobile/pages/details/general/general_page.dart';
import 'package:viva_home_mobile/pages/details/internal/internal_form.dart';
import 'package:viva_home_mobile/pages/details/service/service_page.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/widgets/base_page_widget.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.username});

  final String username;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageWidget(
      config: PageConfig(
        title: AppStrings.propertiesDetail,
        username: widget.username,
        useGridLayout: true, // Use 2-column grid layout
        actionButtonText: AppStrings.backButton,
        actionButtonOnPressed: () => Navigator.pop(context),
        cards: [
          CardItemConfig(
            icon: Icons.key_outlined,
            title: AppStrings.generalDetails,
            isEnabled: true,
            nodeKey: "det_gen",
            borders: {BorderEdge.right, BorderEdge.bottom},
            onTap: () {
              // Navigate to general details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeneralPage(username: widget.username),
                ),
              );
            },
          ),
          CardItemConfig(
            icon: Icons.home_outlined,
            title: AppStrings.externalDetails,
            isEnabled: true,
            nodeKey: "det_ext",
            borders: {BorderEdge.bottom},
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExternalPage(username: widget.username),
                ),
              );
            },
          ),
          CardItemConfig(
            icon: Icons.meeting_room_outlined,
            title: AppStrings.internalDetails,
            nodeKey: "det_int",
            isEnabled: true,
            borders: {BorderEdge.right, BorderEdge.bottom},
            onTap: () {
              // Navigate to internal details
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InternalFormPage()),
              );
            },
          ),
          CardItemConfig(
            icon: Icons.build_outlined,
            title: AppStrings.servicesDetails,
            isEnabled: true,
            nodeKey: "det_serv",
            borders: {BorderEdge.bottom},
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ServicePage(username: widget.username)),
              );
            },
          ),
          CardItemConfig(
            icon: Icons.add_box_outlined,
            title: AppStrings.additionalDetails,
            nodeKey: "det_add",
            isEnabled: true,
            borders: {},
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdditionalPage(username: widget.username)),
              );
            },
          ),
        ],
      ),
    );
  }
}
