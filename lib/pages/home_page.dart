import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/details/details_propeties_page.dart';
import '../utils/constants.dart';
import '../widgets/base_page_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.username});

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BasePageWidget(
      config: PageConfig(
        title: AppStrings.dashboard,
        username: widget.username,
        useGridLayout: false, // Use vertical list layout
        cards: [
          CardItemConfig(
            icon: Icons.key,
            title: AppStrings.details,
            isEnabled: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(username: widget.username),
                ),
              );
            },
          ),
          CardItemConfig(
            icon: Icons.home,
            title: AppStrings.survey,
            isEnabled: true,
            onTap: () {
              // Navigate to survey
            },
          ),
          CardItemConfig(
            icon: Icons.description,
            title: AppStrings.surveyorsRequests,
            isEnabled: false,
            onTap: () {
              // Disabled
            },
          ),
        ],
      ),
    );
  }
}
