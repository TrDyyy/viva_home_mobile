import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/splash_page.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/widgets/custom_button.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.username});

  final String username;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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

                    // Property Details title
                    const Text(
                      AppStrings.propertiesDetail,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppSizes.fontXXLarge,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        height: 1.2,
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

                        // Cards wrap
                        Expanded(
                          child: SingleChildScrollView(
                            child: Wrap(
                              alignment:
                                  WrapAlignment.center, 
                              children: _getPropertyCards()
                                  .map(
                                    (card) => SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width /
                                          2.3,
                                      child: _buildPropertyCard(card),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        // Back button
                        Padding(
                          padding: const EdgeInsets.all(AppSizes.paddingLarge),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: CustomButton(text: AppStrings.backButton, buttonKey: "loginpage", onPressed: (){
                             Navigator.pop(context);
                            },),
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

  List<Map<String, dynamic>> _getPropertyCards() {
    return [
      {
        "icon": Icons.key_outlined,
        "title": AppStrings.generalDetails,
        "isEnabled": true,
        "borders": ["right", "bottom"],
        "onTap": () {
          // Navigate to general details
        },
      },
      {
        "icon": Icons.home_outlined,
        "title": AppStrings.externalDetails,
        "isEnabled": true,
        "borders": ["bottom"],
        "onTap": () {
          // Navigate to external details
        },
      },
      {
        "icon": Icons.meeting_room_outlined,
        "title": AppStrings.internalDetails,
        "isEnabled": true,
        "borders": ["right", "bottom"],
        "onTap": () {
          // Navigate to internal details
        },
      },
      {
        "icon": Icons.build_outlined,
        "title": AppStrings.servicesDetails,
        "isEnabled": true,
        "borders": ["bottom"],
        "onTap": () {
          // Navigate to services
        },
      },
      {
        "icon": Icons.add_box_outlined,
        "title": AppStrings.additionalDetails,
        "isEnabled": true,
        "borders": [],
        "onTap": () {
          // Navigate to additional details
        },
      },
    ];
  }

  Widget _buildPropertyCard(Map<String, dynamic> cardData) {
    final IconData icon = cardData["icon"];
    final String title = cardData["title"];
    final bool isEnabled = cardData["isEnabled"];
    final VoidCallback onTap = cardData["onTap"];
    final List<String> borders = (cardData["borders"] ?? []).cast<String>();
    BorderSide side = const BorderSide(color: AppColors.primaryTeal, width: 1);
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: borders.contains("top") ? side : BorderSide.none,
          right: borders.contains("right") ? side : BorderSide.none,
          bottom: borders.contains("bottom") ? side : BorderSide.none,
          left: borders.contains("left") ? side : BorderSide.none,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onTap : null,
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.fontMedium,
                      fontWeight: FontWeight.w600,
                      color: isEnabled
                          ? AppColors.textDark
                          : AppColors.darkGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(width: AppSizes.paddingMedium),
                  Icon(
                    Icons.check_box_outline_blank,
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
