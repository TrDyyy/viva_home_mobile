import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryTeal = Color(0xFF1FBCC6);
  static const Color darkTeal = Color(0xFF0C4368);
  static const Color lightTeal = Color(0xFF7EE5EB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color darkGray = Color(0xFF757575);
  static const Color textDark = Color(0xFF2C3E50);
  static const Color accent = Color(0xFF34495E);
}

class AppStrings {
  static const String appName = 'Viva Home Valuation';
  static const String loginTitle = 'LOG IN';
  static const String emailHint = 'Email';
  static const String passwordHint = 'Password';
  static const String loginButton = 'Log In';
  static const String joinButton = 'Join';
  static const String forgotPassword = 'Forgot password?';
  static const String connectSurveyor = 'Please connect your surveyor';
  static const String privacyPolicy = 'Privacy Policy';
  static const String termsConditions = 'Terms & Conditions';
  static const String agreeToTerms = 'By signing in, you agree to our Privacy Policy and Terms of Use.';
  static const String loggedInAs =  'Logged In:';
  static const String dashboard = 'DASHBOARD';
  static const String details = 'DETAILS';
  static const String survey = 'SURVEY';
  static const String surveyorsRequests = "SURVEYOR'S REQUESTS";
  static const String propertiesDetail = 'PROPERTY\nDETAILS';
  static const String backButton = 'Back';
  static const generalDetails = 'GENERAL';
  static const externalDetails = 'EXTERNAL';
  static const additionalDetails = 'ADDITIONAL';
  static const servicesDetails = 'SERVICES';
  static const internalDetails = 'INTERNAL';

}

/// Size categories for responsive design system
enum SizeCategory { small, medium, large, xlarge, xxlarge, xxxlarge }

/// Size type for different responsive properties
enum SizeType { padding, radius, font, icon, container }

/// A comprehensive responsive sizing system for Flutter applications.
/// 
/// This class provides responsive sizing for padding, radius, and fonts
/// based on screen dimensions and device characteristics. It supports
/// custom breakpoints and accessibility features.
/// 
/// Example usage:
/// ```dart
/// // Responsive sizing (recommended)
/// Container(
///   padding: EdgeInsets.all(AppSizes.padding(context, SizeCategory.medium)),
///   child: Text(
///     'Hello',
///     style: TextStyle(fontSize: AppSizes.font(context, SizeCategory.large)),
///   ),
/// )
/// 
/// // Static fallback
/// Container(
///   padding: EdgeInsets.all(AppSizes.paddingStatic(SizeCategory.medium)),
/// )
/// 
/// // Device type checking
/// if (AppSizes.isMobile(context)) {
///   // Mobile-specific logic
/// }
/// ```
class AppSizes {
  /// Base sizes configuration for different types
  static const Map<SizeType, double> _baseValues = {
    SizeType.padding: 8.0,
    SizeType.radius: 4.0,
    SizeType.font: 14.0,
    SizeType.icon: 16.0,
    SizeType.container: 48.0, // Base height for containers
  };
  
  /// Size multipliers configuration for each category
  static const Map<SizeCategory, Map<SizeType, double>> _sizeMultipliers = {
    SizeCategory.small: {
      SizeType.padding: 1.0,   // 8.0
      SizeType.radius: 2.0,    // 8.0
      SizeType.font: 0.85,     // ~12.0
      SizeType.icon: 1.0,      // 16.0
      SizeType.container: 1.5, // 72.0
    },
    SizeCategory.medium: {
      SizeType.padding: 2.0,   // 16.0
      SizeType.radius: 3.0,    // 12.0
      SizeType.font: 1.0,      // 14.0
      SizeType.icon: 1.5,      // 24.0
      SizeType.container: 2.5, // 120.0
    },
    SizeCategory.large: {
      SizeType.padding: 3.0,   // 24.0
      SizeType.radius: 4.0,    // 16.0
      SizeType.font: 1.15,     // ~16.0
      SizeType.icon: 2.0,      // 32.0
      SizeType.container: 3.0, // 144.0
    },
    SizeCategory.xlarge: {
      SizeType.padding: 4.0,   // 32.0
      SizeType.radius: 5.0,    // 20.0
      SizeType.font: 1.3,      // ~18.0
      SizeType.icon: 2.5,      // 40.0
      SizeType.container: 3.5, // 168.0
    },
    SizeCategory.xxlarge: {
      SizeType.padding: 5.0,   // 40.0
      SizeType.radius: 6.0,    // 24.0
      SizeType.font: 1.7,      // ~24.0
      SizeType.icon: 3.0,      // 48.0
      SizeType.container: 4.0, // 192.0
    },
    SizeCategory.xxxlarge: {
      SizeType.padding: 6.0,   // 48.0
      SizeType.radius: 7.0,    // 28.0
      SizeType.font: 2.1,      // ~30.0
      SizeType.icon: 4.0,      // 64.0
      SizeType.container: 3.65, // ~175.0
    },
  };
  
  /// Device-specific scaling multipliers
  static const Map<String, Map<SizeType, double>> _deviceMultipliers = {
    'mobile': {
      SizeType.padding: 1.0,
      SizeType.radius: 1.0,
      SizeType.font: 1.0,
      SizeType.icon: 1.0,
      SizeType.container: 1.0,
    },
    'tablet': {
      SizeType.padding: 1.5,
      SizeType.radius: 1.5,
      SizeType.font: 1.15,
      SizeType.icon: 1.2,
      SizeType.container: 1.2,
    },
    'desktop': {
      SizeType.padding: 2.0,
      SizeType.radius: 2.0,
      SizeType.font: 1.25,
      SizeType.icon: 1.3,
      SizeType.container: 1.3,
    },
  };
  
  /// Default screen size breakpoints in logical pixels
  /// 
  /// These can be overridden using custom breakpoint methods.
  /// Based on Material Design guidelines and common device sizes.
  static const double _defaultMobileBreakpoint = 600;
  static const double _defaultTabletBreakpoint = 1024;
  
  // ==================== SCREEN INFO METHODS ====================
  
  /// Returns the full screen size including status bar and navigation
  static Size screenSize(BuildContext context) => MediaQuery.of(context).size;
  
  /// Returns the screen width in logical pixels
  static double screenWidth(BuildContext context) => screenSize(context).width;
  
  /// Returns the screen height in logical pixels  
  static double screenHeight(BuildContext context) => screenSize(context).height;
  
  /// Returns the shortest side (width or height) - useful for responsive design
  /// 
  /// This is more reliable than width alone for determining device categories,
  /// especially for foldable devices or tablets in different orientations.
  static double shortestSide(BuildContext context) => MediaQuery.of(context).size.shortestSide;
  
  /// Returns the current device orientation
  static Orientation orientation(BuildContext context) => MediaQuery.of(context).orientation;
  
  /// Returns the user's accessibility text scaler
  /// 
  /// This automatically adjusts font sizes based on system accessibility settings.
  /// Uses the modern textScaler API instead of deprecated textScaleFactor.
  static TextScaler textScaler(BuildContext context) => MediaQuery.of(context).textScaler;

  // ==================== BREAKPOINT METHODS ====================
  
  /// Determines device category based on shortest side with custom breakpoints
  /// 
  /// [mobileBreakpoint] - Max shortest side for mobile devices (default: 600)
  /// [tabletBreakpoint] - Max shortest side for tablet devices (default: 1024)
  /// 
  /// Returns:
  /// - 'mobile' for devices <= mobileBreakpoint
  /// - 'tablet' for devices > mobileBreakpoint && <= tabletBreakpoint  
  /// - 'desktop' for devices > tabletBreakpoint
  static String getDeviceType(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) {
    final shortest = shortestSide(context);
    if (shortest <= mobileBreakpoint) return 'mobile';
    if (shortest <= tabletBreakpoint) return 'tablet';
    return 'desktop';
  }
  
  /// Checks if device is mobile category
  static bool isMobile(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
  }) => getDeviceType(context, mobileBreakpoint: mobileBreakpoint) == 'mobile';
  
  /// Checks if device is tablet category  
  static bool isTablet(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => getDeviceType(context, 
         mobileBreakpoint: mobileBreakpoint, 
         tabletBreakpoint: tabletBreakpoint) == 'tablet';
  
  /// Checks if device is desktop/large screen category
  static bool isLargeScreen(BuildContext context, {
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => getDeviceType(context, tabletBreakpoint: tabletBreakpoint) == 'desktop';
  
  // ==================== CORE GENERIC FUNCTIONS ====================
  
  /// Generic responsive scaling function for any size type
  /// 
  /// [context] - BuildContext for responsive calculations
  /// [sizeType] - Type of size (padding, radius, font)
  /// [category] - Size category (small, medium, large, etc.)
  /// [mobileBreakpoint] - Custom mobile breakpoint (default: 600)
  /// [tabletBreakpoint] - Custom tablet breakpoint (default: 1024)
  /// [adjustForLandscape] - Apply landscape adjustment (default: true)
  /// [landscapeMultiplier] - Landscape size adjustment (default: 0.9)
  static double _genericScale(
    BuildContext context,
    SizeType sizeType,
    SizeCategory category, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
    bool adjustForLandscape = true,
    double landscapeMultiplier = 0.9,
  }) {
    // Get base value and category multiplier
    final baseValue = _baseValues[sizeType]!;
    final categoryMultiplier = _sizeMultipliers[category]![sizeType]!;
    
    // Get device type and device multiplier
    final deviceType = getDeviceType(context, 
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    );
    final deviceMultiplier = _deviceMultipliers[deviceType]![sizeType]!;
    
    // Calculate final size
    double finalSize = baseValue * categoryMultiplier * deviceMultiplier;
    
    // Apply landscape adjustment if enabled
    if (adjustForLandscape && orientation(context) == Orientation.landscape) {
      finalSize *= landscapeMultiplier;
    }
    
    // Apply accessibility scaling for fonts
    if (sizeType == SizeType.font) {
      finalSize = textScaler(context).scale(finalSize);
    }
    
    return finalSize;
  }
  
  /// Static fallback calculation for when BuildContext is unavailable
  static double _staticScale(SizeType sizeType, SizeCategory category) {
    final baseValue = _baseValues[sizeType]!;
    final categoryMultiplier = _sizeMultipliers[category]![sizeType]!;
    return baseValue * categoryMultiplier;
  }
  
  // ==================== PUBLIC GENERIC METHODS ====================
  
  /// Returns responsive padding based on size category
  static double padding(BuildContext context, SizeCategory category, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => _genericScale(
    context, 
    SizeType.padding, 
    category,
    mobileBreakpoint: mobileBreakpoint,
    tabletBreakpoint: tabletBreakpoint,
  );
  
  /// Returns responsive border radius based on size category
  static double radius(BuildContext context, SizeCategory category, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => _genericScale(
    context, 
    SizeType.radius, 
    category,
    mobileBreakpoint: mobileBreakpoint,
    tabletBreakpoint: tabletBreakpoint,
  );
  
  /// Returns responsive font size based on size category with accessibility support
  static double font(BuildContext context, SizeCategory category, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => _genericScale(
    context, 
    SizeType.font, 
    category,
    mobileBreakpoint: mobileBreakpoint,
    tabletBreakpoint: tabletBreakpoint,
  );
  
  /// Returns static padding value for when BuildContext is unavailable
  static double paddingStatic(SizeCategory category) => 
    _staticScale(SizeType.padding, category);
  
  /// Returns static border radius value for when BuildContext is unavailable
  static double radiusStatic(SizeCategory category) => 
    _staticScale(SizeType.radius, category);
  
  /// Returns static font size value for when BuildContext is unavailable
  static double fontStatic(SizeCategory category) => 
    _staticScale(SizeType.font, category);
  
  /// Returns responsive icon size based on size category
  static double icon(BuildContext context, SizeCategory category, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => _genericScale(
    context, 
    SizeType.icon, 
    category,
    mobileBreakpoint: mobileBreakpoint,
    tabletBreakpoint: tabletBreakpoint,
  );
  
  /// Returns responsive container height based on size category
  static double container(BuildContext context, SizeCategory category, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => _genericScale(
    context, 
    SizeType.container, 
    category,
    mobileBreakpoint: mobileBreakpoint,
    tabletBreakpoint: tabletBreakpoint,
  );
  
  /// Returns static icon size value for when BuildContext is unavailable
  static double iconStatic(SizeCategory category) => 
    _staticScale(SizeType.icon, category);
  
  /// Returns static container height value for when BuildContext is unavailable
  static double containerStatic(SizeCategory category) => 
    _staticScale(SizeType.container, category);
  
  // ==================== LEGACY COMPATIBILITY METHODS ====================
  // These methods maintain backward compatibility with existing code
  
  // Padding methods
  static double paddingSmall(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => padding(context, SizeCategory.small,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double paddingMedium(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => padding(context, SizeCategory.medium,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double paddingLarge(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => padding(context, SizeCategory.large,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double paddingXLarge(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => padding(context, SizeCategory.xlarge,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  // Radius methods
  static double radiusSmall(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => radius(context, SizeCategory.small,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double radiusMedium(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => radius(context, SizeCategory.medium,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double radiusLarge(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => radius(context, SizeCategory.large,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double radiusXLarge(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => radius(context, SizeCategory.xlarge,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  // Font methods
  static double fontSmall(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => font(context, SizeCategory.small,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double fontMedium(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => font(context, SizeCategory.medium,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double fontLarge(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => font(context, SizeCategory.large,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double fontXLarge(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => font(context, SizeCategory.xlarge,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  // Icon methods
  static double iconSmall(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => icon(context, SizeCategory.small,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double iconMedium(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => icon(context, SizeCategory.medium,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double iconLarge(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => icon(context, SizeCategory.large,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  static double iconXLarge(BuildContext context, {
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) => icon(context, SizeCategory.xlarge,
         mobileBreakpoint: mobileBreakpoint, tabletBreakpoint: tabletBreakpoint);
  
  // ==================== LEGACY STATIC GETTERS ====================
  
  // Padding static getters
  static double get paddingSmallStatic => paddingStatic(SizeCategory.small);
  static double get paddingMediumStatic => paddingStatic(SizeCategory.medium);
  static double get paddingLargeStatic => paddingStatic(SizeCategory.large);
  static double get paddingXLargeStatic => paddingStatic(SizeCategory.xlarge);
  
  // Radius static getters
  static double get radiusSmallStatic => radiusStatic(SizeCategory.small);
  static double get radiusMediumStatic => radiusStatic(SizeCategory.medium);
  static double get radiusLargeStatic => radiusStatic(SizeCategory.large);
  static double get radiusXLargeStatic => radiusStatic(SizeCategory.xlarge);
  
  // Font static getters
  static double get fontSmallStatic => fontStatic(SizeCategory.small);
  static double get fontMediumStatic => fontStatic(SizeCategory.medium);
  static double get fontLargeStatic => fontStatic(SizeCategory.large);
  static double get fontXLargeStatic => fontStatic(SizeCategory.xlarge);
  static double get fontXXLargeStatic => fontStatic(SizeCategory.xxlarge);
  static double get fontXXXLargeStatic => fontStatic(SizeCategory.xxxlarge);
  
  // ==================== UTILITY METHODS ====================
  
  /// Returns EdgeInsets with responsive padding on all sides
  /// 
  /// Convenience method for common padding scenarios.
  static EdgeInsets responsivePadding(BuildContext context, {
    SizeCategory category = SizeCategory.medium,
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) {
    return EdgeInsets.all(padding(context, category, 
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    ));
  }
  
  /// Returns EdgeInsets with responsive horizontal padding
  /// 
  /// Useful for content that needs side padding but not top/bottom.
  static EdgeInsets responsiveHorizontalPadding(BuildContext context, {
    SizeCategory category = SizeCategory.medium,
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) {
    return EdgeInsets.symmetric(horizontal: padding(context, category,
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    ));
  }
  
  /// Returns EdgeInsets with responsive vertical padding
  /// 
  /// Useful for content that needs top/bottom padding but not sides.
  static EdgeInsets responsiveVerticalPadding(BuildContext context, {
    SizeCategory category = SizeCategory.medium,
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) {
    return EdgeInsets.symmetric(vertical: padding(context, category,
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    ));
  }
  
  /// Returns BorderRadius with responsive radius
  /// 
  /// Convenience method for creating rounded corners.
  static BorderRadius responsiveBorderRadius(BuildContext context, {
    SizeCategory category = SizeCategory.medium,
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) {
    return BorderRadius.circular(radius(context, category,
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
    ));
  }
  
  /// Returns TextStyle with responsive font size
  /// 
  /// Convenience method for creating text styles.
  static TextStyle responsiveTextStyle(BuildContext context, {
    SizeCategory category = SizeCategory.medium,
    Color? color,
    FontWeight? fontWeight,
    double mobileBreakpoint = _defaultMobileBreakpoint,
    double tabletBreakpoint = _defaultTabletBreakpoint,
  }) {
    return TextStyle(
      fontSize: font(context, category,
        mobileBreakpoint: mobileBreakpoint,
        tabletBreakpoint: tabletBreakpoint,
      ),
      color: color,
      fontWeight: fontWeight,
    );
  }
}
