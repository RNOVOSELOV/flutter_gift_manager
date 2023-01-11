import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/presentation/theme/custom_theme.dart';

export 'dark_theme.dart';
export 'light_theme.dart';

CustomTheme currentTheme = sl.get<CustomTheme>();
