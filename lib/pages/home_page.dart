import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/details/details_propeties_page.dart';
import 'package:viva_home_mobile/pages/splash_page.dart';
import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.username});

  final String username;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Header area
              Padding(
                padding: const EdgeInsets.all(AppSizes.paddingLarge),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(
                              3.14159,
                            ),
                            child: const Icon(Icons.logout, color: AppColors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SplashPage(),
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppStrings.loggedInAs,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: AppSizes.fontMedium,
                              ),
                            ),
                            Text(
                              widget.username,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: AppSizes.fontMedium,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSizes.paddingLarge),

                    // Dashboard title
                    const Text(
                      AppStrings.dashboard,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppSizes.fontXXLarge,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
              // Content area
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: AppSizes.paddingMedium),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.radiusXLarge),
                      topRight: Radius.circular(AppSizes.radiusXLarge),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppSizes.paddingLarge,
                      top: AppSizes.paddingLarge,
                    ),
                    child: Column(
                      children: [
                        // Drag indicator (optional)
                        Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(
                            bottom: AppSizes.paddingLarge,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightGray,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),

                        // Cards list
                        Expanded(
                          child: Column(
                            children: [
                              ..._getDashboardCards().map((item) {
                                return Expanded(
                                  child: _buildDashboardCard(item),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getDashboardCards() {
    return [
      {
        "icon": Icons.key,
        "title": AppStrings.details,
        "isEnabled": true,
        "onTap": () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(username: widget.username),
            ),
          );
        },
      },
      {
        "icon": Icons.home,
        "title": AppStrings.survey,
        "isEnabled": true,
        "onTap": () {
          // Navigate to survey
        },
      },
      {
        "icon": Icons.description,
        "title": AppStrings.surveyorsRequests,
        "isEnabled": false,
        "onTap": () {
          // Disabled
        },
      },
    ];
  }

  Widget _buildDashboardCard(Map<String, dynamic> cardData) {
    final IconData icon = cardData["icon"];
    final String title = cardData["title"];
    final bool isEnabled = cardData["isEnabled"];
    final VoidCallback onTap = cardData["onTap"];
    
    return Container(
      width: double.infinity,
      height: 175,
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.white : AppColors.lightGray,
        border: isEnabled
            ? const Border(
                bottom: BorderSide(color: AppColors.darkGray, width: 1.0),
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onTap : null,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: isEnabled ? AppColors.primaryTeal : AppColors.darkGray,
              ),
              const SizedBox(height: AppSizes.paddingMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppSizes.fontMedium,
                      fontWeight: FontWeight.w600,
                      color: isEnabled
                          ? AppColors.textDark
                          : AppColors.darkGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: AppSizes.paddingSmall),
                  Icon(
                    Icons.square_outlined,
                    size: 16,
                    color: isEnabled
                        ? AppColors.primaryTeal
                        : AppColors.darkGray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
