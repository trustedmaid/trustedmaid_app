/// Centralized registry for all assets used in the application.
class AppAssets {
  AppAssets._();

  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';

  // Image assets
  static const String appLogo = 'assets/logo/trusted-maid.png';
  static const String placeholderImage = '$_imagesPath/placeholder.png';
  static const String headerBanner = '$_imagesPath/header_banner.png';
  static const String servicesComposite = '$_imagesPath/d.png';
  static const String splashScreenImg = '$_imagesPath/splash_screen.png';

  // Icon assets
  static const String homeIcon = '$_iconsPath/ic_home.png';
}
