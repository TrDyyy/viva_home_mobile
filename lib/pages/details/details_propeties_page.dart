import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/details/general/general_page.dart';
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
            nodeKey: "det_gen",
            borders: {BorderEdge.bottom},
            onTap: () {
              // Navigate to external details
            },
          ),
          CardItemConfig(
            icon: Icons.meeting_room_outlined,
            title: AppStrings.internalDetails,
            nodeKey: "det_gen",
            isEnabled: true,
            borders: {BorderEdge.right, BorderEdge.bottom},
            onTap: () {
              // Navigate to internal details
            },
          ),
          CardItemConfig(
            icon: Icons.build_outlined,
            title: AppStrings.servicesDetails,
            isEnabled: true,
              nodeKey: "det_gen",
            borders: {BorderEdge.bottom},
            onTap: () {
              // Navigate to services
            },
          ),
          CardItemConfig(
            icon: Icons.add_box_outlined,
            title: AppStrings.additionalDetails,
              nodeKey: "det_gen",
            isEnabled: true,
            borders: {},
            onTap: () {
              // Navigate to additional details
            },
          ),
        ],
      ),
    );
  }
}
