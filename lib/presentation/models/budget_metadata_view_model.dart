import 'package:equatable/equatable.dart';
import 'package:ovavue/presentation/models/budget_metadata_key_view_model.dart';
import 'package:ovavue/presentation/models/budget_metadata_value_view_model.dart';

class BudgetMetadataViewModel with EquatableMixin {
  const BudgetMetadataViewModel({
    required this.key,
    required this.values,
  });

  final BudgetMetadataKeyViewModel key;
  final List<BudgetMetadataValueViewModel> values;

  @override
  List<Object> get props => [key, values];
}
