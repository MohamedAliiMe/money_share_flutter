import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
    printEmojis: true,
    printTime: false,
  ),
);

/// Stub for ASCII art logging, since enough_ascii_art is missing.
/// This just logs the text in a decorated box.
Future<void> logBigText(String text, {String fontName = "Broadway"}) async {
  final String border = '👻' * 20;
  final String header = '💻 ASCII ART LOG 💻';

  final formattedMessage = '''
🥷💻🎶😜😎🥳🤯🤬😴😈👻☠️🙄🤫🤑🫣🧐😡😤🥺🥺😵😉🤨😏🥷🫵
🥷 🤯 $border
🥷 🤯 $header
🥷 🤯 $border
🥷 🤯 $text
🥷 🤯 $border
''';

  logger.i(formattedMessage);
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    logger.d('onCreate -- ${bloc.runtimeType}');
    super.onCreate(bloc);
    //  logBigText('Block', fontName: "Broadway");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    logger.d('onChange -- ${bloc.state}, $change');
    super.onChange(bloc, change);
    //  logBigText('On', fontName: "Broadway");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logBigText('Error in Bloc: ${bloc.runtimeType}');
    //  logger.e('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    // logBigText('Bloc Closed: ${bloc.runtimeType}');
    logger.w('onClose -- ${bloc.runtimeType}');
  }
}
