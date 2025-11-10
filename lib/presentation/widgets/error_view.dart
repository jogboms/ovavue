import 'package:flutter/widgets.dart';
import 'package:ovavue/core.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(this.error, this.stackTrace, {super.key});

  static const errorViewKey = Key('errorViewKey');

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    AppLog.e(error, stackTrace ?? StackTrace.current);
    return Center(
      key: errorViewKey,
      child: Text(error.toString()),
    );
  }
}
