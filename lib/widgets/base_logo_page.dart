import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// Base widget for pages with logo and background
class BaseLogoPage extends StatelessWidget {
  final Widget child;
  final bool isScrollable;
  final EdgeInsets? padding;
  final double? logoWidth;
  final double? logoHeight;
  final String heroTag;
  
  const BaseLogoPage({
    super.key,
    required this.child,
    required this.heroTag,
    this.isScrollable = true,
    this.padding,
    this.logoWidth,
    this.logoHeight,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: AppSizes.paddingLarge(context),
    );
    
    final logoContainer = Hero(
      tag: heroTag,
      child: Container(
        width: logoWidth ?? AppSizes.padding(context, SizeCategory.xxxlarge) * 4,
        height: logoHeight ?? AppSizes.padding(context, SizeCategory.xxxlarge) * 2.5,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage("assets/images/image.png"),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSizes.paddingXLarge(context)),
        Center(child: logoContainer),
        child,
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent background from moving
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: padding ?? defaultPadding,
          child: isScrollable 
            ? SingleChildScrollView(child: Center(child: content))
            : Center(child: content),
        ),
      ),
    );
  }
}
