import 'package:flutter/foundation.dart';
import 'package:web/web.dart';

import 'app_font.dart' as fallback;

//https://github.com/flutter/flutter/issues/93140
final String kAppFontFamily =
    kIsWeb && window.navigator.userAgent.contains('OS 15_') ? '-apple-system' : fallback.kAppFontFamily;
