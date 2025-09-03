import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/splash_page.dart';
import '../utils/constants.dart';
import '../utils/custom_button.dart';

enum BorderEdge { top, right, bottom, left }

enum CardLayoutType { grid, list }

enum ContentType { container, modal }

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
  final ContentType contentType;
  final List<ModalSection>? modalSections; // For modal content

  const PageConfig({
    required this.title,
    required this.username,
    required this.cards,
    this.useGridLayout = false,
    this.actionButtonText,
    this.actionButtonOnPressed,
    this.contentType = ContentType.container,
    this.modalSections,
  });
}

class SectionItem {
  final String text;
  final bool isChecked;

  SectionItem({required this.text, this.isChecked = false});
}

class ModalSection {
  final String title;
  final String subtitle;
  final List<SectionItem> items;
  final VoidCallback? onActionPressed;

  ModalSection({
    required this.title,
    required this.subtitle,
    required this.items,
    this.onActionPressed,
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
              Expanded(
                child: switch (config.contentType) {
                  ContentType.container => _buildContentContainer(context),
                  ContentType.modal => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _buildContentModal(context)),
                      if (config.actionButtonText != null &&
                          config.actionButtonOnPressed != null)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.padding(
                                context,
                                SizeCategory.xxlarge,
                              ),
                            ),
                            child: _buildActionButton(context),
                          ),
                        ),
                    ],
                  ),
                },
              ),
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

  Widget _buildContentModal(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: AppSizes.padding(context, SizeCategory.medium),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            AppSizes.radius(context, SizeCategory.xlarge),
          ),
          bottomLeft: Radius.circular(
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
                    if (config.modalSections != null)
                      ...config.modalSections!.map(
                        (section) => Padding(
                          padding: EdgeInsets.only(
                            bottom: AppSizes.padding(
                              context,
                              SizeCategory.medium,
                            ),
                          ),
                          child: _buildCompletedSection(
                            context: context,
                            title: section.title,
                            subtitle: section.subtitle,
                            items: section.items,
                            onActionPressed: section.onActionPressed,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedSection({
    required BuildContext context,
    required String title,
    required String subtitle,
    required List<SectionItem> items,
    VoidCallback? onActionPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header với title, subtitle và nút action (mũi tên)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTeal,
                    ),
                  ),
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            if (onActionPressed != null)
            InkWell(
              onTap: onActionPressed,
              child: Container(
                padding: EdgeInsets.all(AppSizes.padding(context, SizeCategory.small)),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal, 
                  border: Border(
                    left: BorderSide(color: AppColors.darkGray, width: 2),
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: AppColors.darkTeal,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // List items
        ...items.map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  item.isChecked
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: item.isChecked ? Colors.teal : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
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
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.padding(context, SizeCategory.large),
      ),
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
