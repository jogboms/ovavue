import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:ovavue/presentation/constants.dart';
import 'package:ovavue/presentation/utils.dart';

class DatePickerField extends FormField<DateTime> {
  DatePickerField({
    super.key,
    required super.initialValue,
    required this.onChanged,
    String? hintText,
    String? selectButtonText,
  }) : super(
         builder: (FormFieldState<DateTime> fieldState) {
           final date = fieldState.value;
           final context = fieldState.context;
           final theme = Theme.of(context);
           final materialL10n = MaterialLocalizations.of(context);

           hintText ??= materialL10n.dateInputLabel;

           return InputDecorator(
             decoration: InputDecoration(
               hintText: hintText,
               prefixIcon: const Icon(AppIcons.date),
             ),
             child: Row(
               children: [
                 Expanded(
                   child: Text(
                     date != null ? date.format(DateTimeFormat.yearMonthDate) : hintText!,
                     style: theme.textTheme.bodyLarge,
                   ),
                 ),
                 const SizedBox(width: 4),
                 TextButton(
                   style: TextButton.styleFrom(
                     padding: EdgeInsets.zero,
                     visualDensity: VisualDensity.compact,
                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                   ),
                   onPressed: () async {
                     final value = await showDatePicker(
                       context: context,
                       initialDate: date ?? clock.now(),
                       firstDate: DateTime(0),
                       lastDate: DateTime(clock.now().year + 10),
                     );
                     fieldState.didChange(value);
                   },
                   child: Text(selectButtonText ?? materialL10n.datePickerHelpText),
                 ),
               ],
             ),
           );
         },
       );

  final ValueChanged<DateTime> onChanged;

  @override
  FormFieldState<DateTime> createState() => DatePickerState();
}

@visibleForTesting
class DatePickerState extends FormFieldState<DateTime> {
  @override
  void initState() {
    // NOTE: Weird release mode bug on flutter web
    setValue(widget.initialValue);
    super.initState();
  }

  @override
  void didChange(DateTime? value) {
    if (value != null) {
      (widget as DatePickerField).onChanged(value);
    }
    super.didChange(value);
  }
}
