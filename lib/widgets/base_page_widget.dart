import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/splash_page.dart';
import '../utils/constants.dart';
import '../utils/custom_button.dart';

enum BorderEdge { top, right, bottom, left }

enum CardLayoutType { grid, list }

class CardItemConfig {
  final IconData icon;
  final String title;
  final bool isEnabled;
  final VoidCallback onTap;
  final Set<BorderEdge>? borders; // For grid layout borders

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

class BasePageWidget extends StatelessWidget {
  final PageConfig config;

  const BasePageWidget({super.key, required this.config});

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
              Expanded(child: _buildContentContainer(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.padding(context, SizeCategory.large)),
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
                    MaterialPageRoute(builder: (context) => const SplashPage()),
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
                      fontSize: AppSizes.font(context, SizeCategory.medium),
                    ),
                  ),
                  Text(
                    config.username,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppSizes.font(context, SizeCategory.medium),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSizes.padding(context, SizeCategory.large)),

          // Page title
          Text(
            config.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontSize: AppSizes.font(context, SizeCategory.xxlarge),
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: AppSizes.padding(context, SizeCategory.xlarge),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            AppSizes.radius(context, SizeCategory.xlarge),
          ),
          topRight: Radius.circular(
            AppSizes.radius(context, SizeCategory.xlarge),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius:
                AppSizes.padding(context, SizeCategory.medium) *
                0.625, // ~10 responsive
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: AppSizes.padding(context, SizeCategory.large),
          top: AppSizes.padding(context, SizeCategory.xxlarge),
        ),
        child: Column(
          children: [
            // Drag indicator
            Container(
              width:
                  AppSizes.padding(context, SizeCategory.large) *
                  1.6, // ~38 responsive
              height:
                  AppSizes.padding(context, SizeCategory.small) *
                  0.5, // ~4 responsive
              margin: EdgeInsets.only(
                bottom: AppSizes.padding(context, SizeCategory.large),
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(
                  AppSizes.radius(context, SizeCategory.small) * 0.5,
                ),
              ),
            ),

            // Cards content with action button
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding(context, SizeCategory.medium),
                ),
                child: Column(
                  children: [
                    config.useGridLayout
                        ? _buildGridLayout(context)
                        : _buildListLayout(context),

                    _buildActionButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridLayout(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: config.cards.map((card) {
        return SizedBox(
          width: AppSizes.screenWidth(context) / 2.3,
          child: _buildCard(context, card, CardLayoutType.grid),
        );
      }).toList(),
    );
  }

  Widget _buildListLayout(BuildContext context) {
    return Column(
      children: config.cards
          .map((card) => _buildCard(context, card, CardLayoutType.list))
          .toList(),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (config.actionButtonText == null ||
        config.actionButtonOnPressed == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.padding(context, SizeCategory.large)),
      child: CustomButton(
        text: config.actionButtonText!,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkTeal,
          foregroundColor: AppColors.white,
        ),
        onPressed: config.actionButtonOnPressed!,
        width: double.infinity,
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    CardItemConfig card,
    CardLayoutType layoutType,
  ) {
    final isGrid = layoutType == CardLayoutType.grid;

    return Container(
      width: double.infinity,
      height: isGrid ? AppSizes.container(context, SizeCategory.large) : null,
      constraints: !isGrid
          ? BoxConstraints(
              minHeight:
                  AppSizes.container(context, SizeCategory.xxxlarge) * 1.1,
            )
          : null,
      decoration: BoxDecoration(
        color: isGrid
            ? AppColors.white
            : (card.isEnabled ? AppColors.white : AppColors.lightGray),
        border: isGrid
            ? _buildGridBorder(card)
            : (card.isEnabled
                  ? const Border(
                      bottom: BorderSide(color: AppColors.darkGray, width: 1.0),
                    )
                  : null),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: card.isEnabled ? card.onTap : null,
          borderRadius: !isGrid
              ? BorderRadius.circular(
                  AppSizes.radius(context, SizeCategory.medium),
                )
              : null,
          child: Padding(
            padding: isGrid
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(
                    vertical: AppSizes.padding(context, SizeCategory.medium),
                    horizontal: AppSizes.padding(context, SizeCategory.small),
                  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: !isGrid ? MainAxisSize.min : MainAxisSize.max,
              children: [
                Icon(
                  card.icon,
                  size: AppSizes.icon(context, SizeCategory.xlarge),
                  color: card.isEnabled
                      ? AppColors.primaryTeal
                      : AppColors.darkGray,
                ),
                SizedBox(
                  height: AppSizes.padding(context, SizeCategory.medium),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        card.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppSizes.font(context, SizeCategory.medium),
                          fontWeight: FontWeight.w600,
                          color: card.isEnabled
                              ? AppColors.textDark
                              : AppColors.darkGray,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: isGrid
                          ? AppSizes.padding(context, SizeCategory.medium)
                          : AppSizes.padding(context, SizeCategory.small),
                    ),
                    Icon(
                      isGrid
                          ? Icons.check_box_outline_blank
                          : Icons.square_outlined,
                      size: AppSizes.icon(context, SizeCategory.small),
                      color: card.isEnabled
                          ? AppColors.primaryTeal
                          : AppColors.darkGray,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Border? _buildGridBorder(CardItemConfig card) {
    if (card.borders == null) return null;

    const side = BorderSide(color: AppColors.primaryTeal, width: 1.0);
    return Border(
      top: card.borders!.contains(BorderEdge.top) ? side : BorderSide.none,
      right: card.borders!.contains(BorderEdge.right) ? side : BorderSide.none,
      bottom: card.borders!.contains(BorderEdge.bottom)
          ? side
          : BorderSide.none,
      left: card.borders!.contains(BorderEdge.left) ? side : BorderSide.none,
    );
  }
}
