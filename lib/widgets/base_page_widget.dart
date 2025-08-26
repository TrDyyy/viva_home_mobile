import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/splash_page.dart';
import '../utils/constants.dart';
import '../utils/custom_button.dart';

/// Configuration for a card item
class CardItemConfig {
  final IconData icon;
  final String title;
  final bool isEnabled;
  final VoidCallback onTap;
  final List<String>? borders; // For grid layout borders
  
  const CardItemConfig({
    required this.icon,
    required this.title,
    required this.isEnabled,
    required this.onTap,
    this.borders,
  });
}

/// Configuration for the page layout
class PageConfig {
  final String title;
  final String username;
  final List<CardItemConfig> cards;
  final bool useGridLayout; // true = 2-column grid, false = vertical list
  final String? actionButtonText;
  final VoidCallback? actionButtonOnPressed;
  
  const PageConfig({
    required this.title,
    required this.username,
    required this.cards,
    this.useGridLayout = false,
    this.actionButtonText,
    this.actionButtonOnPressed,
  });
}

/// Reusable base page widget for Home and Details pages
class BasePageWidget extends StatelessWidget {
  final PageConfig config;
  
  const BasePageWidget({
    super.key,
    required this.config,
  });

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
              _buildHeader(context),
              
              // Content area
              Expanded(
                child: _buildContentContainer(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.paddingLarge(context)),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.14159),
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
                      fontSize: AppSizes.fontMedium(context),
                    ),
                  ),
                  Text(
                    config.username,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSizes.fontMedium(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSizes.paddingLarge(context)),
          
          // Page title
          Text(
            config.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: AppSizes.font(context,SizeCategory.xxlarge),
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0, // Standard letter spacing
              height: 1.2, // Standard text height multiplier
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: AppSizes.paddingMedium(context)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.radiusXLarge(context)),
          topRight: Radius.circular(AppSizes.radiusXLarge(context)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: AppSizes.padding(context, SizeCategory.medium) * 0.625, // ~10 responsive
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: AppSizes.paddingLarge(context),
          top: AppSizes.paddingLarge(context),
        ),
        child: Column(
          children: [
            // Drag indicator
            Container(
              width: AppSizes.padding(context, SizeCategory.large) * 1.6, // ~38 responsive
              height: AppSizes.padding(context, SizeCategory.small) * 0.5, // ~4 responsive
              margin: EdgeInsets.only(
                bottom: AppSizes.paddingLarge(context),
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(AppSizes.radius(context, SizeCategory.small) * 0.5),
              ),
            ),

            // Cards content
            Expanded(
              child: config.useGridLayout 
                ? _buildGridLayout(context)
                : _buildListLayout(context),
            ),
            
            // Optional action button
            if (config.actionButtonText != null && config.actionButtonOnPressed != null)
              Padding(
                padding: EdgeInsets.all(AppSizes.paddingLarge(context)),
                child: CustomButton(
                  text: config.actionButtonText!,
                  style: CustomButtonStyle.secondary,
                  onPressed: config.actionButtonOnPressed!,
                  width: double.infinity,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.center,
        children: config.cards.map((card) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 2.3,
            child: _buildGridCard(context, card),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListLayout(BuildContext context) {
    return Column(
      children: config.cards.map((card) {
        return Expanded(
          child: _buildListCard(context, card),
        );
      }).toList(),
    );
  }

  Widget _buildGridCard(BuildContext context, CardItemConfig card) {
    const BorderSide side = BorderSide(
      color: AppColors.primaryTeal, 
      width: 1.0,
    );
    final borders = card.borders ?? [];
    
    return Container(
      width: double.infinity,
      height: AppSizes.container(context, SizeCategory.xlarge), // ~168 responsive
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
          onTap: card.isEnabled ? card.onTap : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                card.icon,
                size: AppSizes.iconXLarge(context),
                color: card.isEnabled ? AppColors.primaryTeal : AppColors.darkGray,
              ),
              SizedBox(height: AppSizes.paddingMedium(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      card.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppSizes.fontMedium(context),
                        fontWeight: FontWeight.w600,
                        color: card.isEnabled ? AppColors.textDark : AppColors.darkGray,
                        letterSpacing: 1.2, // Standard letter spacing
                      ),
                    ),
                  ),
                  SizedBox(width: AppSizes.paddingMedium(context)),
                  Icon(
                    Icons.check_box_outline_blank,
                    size: AppSizes.iconSmall(context),
                    color: card.isEnabled ? AppColors.primaryTeal : AppColors.darkGray,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCard(BuildContext context, CardItemConfig card) {
    return Container(
      width: double.infinity,
      height: AppSizes.container(context, SizeCategory.xxxlarge), 
      decoration: BoxDecoration(
        color: card.isEnabled ? AppColors.white : AppColors.lightGray,
        border: card.isEnabled
            ? const Border(
                bottom: BorderSide(
                  color: AppColors.darkGray, 
                  width: 1.0,
                ),
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: card.isEnabled ? card.onTap : null,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                card.icon,
                size: AppSizes.iconXLarge(context),
                color: card.isEnabled ? AppColors.primaryTeal : AppColors.darkGray,
              ),
              SizedBox(height: AppSizes.paddingMedium(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    card.title,
                    style: TextStyle(
                      fontSize: AppSizes.fontMedium(context),
                      fontWeight: FontWeight.w600,
                      color: card.isEnabled ? AppColors.textDark : AppColors.darkGray,
                      letterSpacing: 1.2, // Standard letter spacing
                    ),
                  ),
                  SizedBox(width: AppSizes.paddingSmall(context)),
                  Icon(
                    Icons.square_outlined,
                    size: AppSizes.iconSmall(context),
                    color: card.isEnabled ? AppColors.primaryTeal : AppColors.darkGray,
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
