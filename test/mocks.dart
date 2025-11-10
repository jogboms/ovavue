import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ovavue/domain.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUsersRepository extends Mock implements UsersRepository {}

class MockBudgetsRepository extends Mock implements BudgetsRepository {}

class MockBudgetPlansRepository extends Mock implements BudgetPlansRepository {}

class MockBudgetCategoriesRepository extends Mock implements BudgetCategoriesRepository {}

class MockBudgetAllocationsRepository extends Mock implements BudgetAllocationsRepository {}

class MockBudgetMetadataRepository extends Mock implements BudgetMetadataRepository {}

class MockPreferencesRepository extends Mock implements PreferencesRepository {}

class MockCreateBudgetAllocationUseCase extends Mock implements CreateBudgetAllocationUseCase {}

class MockUpdateBudgetAllocationUseCase extends Mock implements UpdateBudgetAllocationUseCase {}

class MockCreateBudgetCategoryUseCase extends Mock implements CreateBudgetCategoryUseCase {}

class MockUpdateBudgetCategoryUseCase extends Mock implements UpdateBudgetCategoryUseCase {}

class MockCreateBudgetPlanUseCase extends Mock implements CreateBudgetPlanUseCase {}

class MockCreateBudgetMetadataUseCase extends Mock implements CreateBudgetMetadataUseCase {}

class MockCreateBudgetUseCase extends Mock implements CreateBudgetUseCase {}

class MockUpdateBudgetUseCase extends Mock implements UpdateBudgetUseCase {}

class MockCreateUserUseCase extends Mock implements CreateUserUseCase {}

class MockActivateBudgetUseCase extends Mock implements ActivateBudgetUseCase {}

class MockUpdateBudgetPlanUseCase extends Mock implements UpdateBudgetPlanUseCase {}

class MockUpdateBudgetMetadataUseCase extends Mock implements UpdateBudgetMetadataUseCase {}

class MockDeleteBudgetAllocationUseCase extends Mock implements DeleteBudgetAllocationUseCase {}

class MockDeleteBudgetCategoryUseCase extends Mock implements DeleteBudgetCategoryUseCase {}

class MockDeleteBudgetPlanUseCase extends Mock implements DeleteBudgetPlanUseCase {}

class MockDeleteBudgetUseCase extends Mock implements DeleteBudgetUseCase {}

class MockAddMetadataToPlanUseCase extends Mock implements AddMetadataToPlanUseCase {}

class MockRemoveMetadataFromPlanUseCase extends Mock implements RemoveMetadataFromPlanUseCase {}

class MockFetchAccountUseCase extends Mock implements FetchAccountUseCase {}

class MockFetchBudgetAllocationsByBudgetUseCase extends Mock implements FetchBudgetAllocationsByBudgetUseCase {}

class MockFetchBudgetAllocationsByPlanUseCase extends Mock implements FetchBudgetAllocationsByPlanUseCase {}

class MockFetchBudgetCategoriesUseCase extends Mock implements FetchBudgetCategoriesUseCase {}

class MockFetchBudgetPlansUseCase extends Mock implements FetchBudgetPlansUseCase {}

class MockFetchBudgetPlansByMetadataUseCase extends Mock implements FetchBudgetPlansByMetadataUseCase {}

class MockFetchBudgetMetadataUseCase extends Mock implements FetchBudgetMetadataUseCase {}

class MockFetchBudgetMetadataByPlanUseCase extends Mock implements FetchBudgetMetadataByPlanUseCase {}

class MockFetchBudgetUseCase extends Mock implements FetchBudgetUseCase {}

class MockFetchBudgetsUseCase extends Mock implements FetchBudgetsUseCase {}

class MockFetchActiveBudgetUseCase extends Mock implements FetchActiveBudgetUseCase {}

class MockFetchUserUseCase extends Mock implements FetchUserUseCase {}

class MockFetchThemeModeUseCase extends Mock implements FetchThemeModeUseCase {}

class MockUpdateThemeModeUseCase extends Mock implements UpdateThemeModeUseCase {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockValueChangedCallback<T> extends Mock {
  void call(T data);
}

class MockAsyncCallback<T> extends Mock {
  Future<T> call();
}

class MockAsyncCallbackValueChanged<T, U> extends Mock {
  Future<T> call(U p0);
}

class FakeCreateBudgetData extends Fake implements CreateBudgetData {}

class FakeUpdateBudgetData extends Fake implements UpdateBudgetData {}

class FakeCreateBudgetCategoryData extends Fake implements CreateBudgetCategoryData {}

class FakeUpdateBudgetCategoryData extends Fake implements UpdateBudgetCategoryData {}

class FakeCreateBudgetPlanData extends Fake implements CreateBudgetPlanData {}

class FakeUpdateBudgetPlanData extends Fake implements UpdateBudgetPlanData {}

class FakeCreateBudgetAllocationData extends Fake implements CreateBudgetAllocationData {}

class FakeUpdateBudgetAllocationData extends Fake implements UpdateBudgetAllocationData {}

class FakeAnalytics extends Fake implements Analytics {
  @override
  Future<void> log(AnalyticsEvent event) async {}

  @override
  Future<void> removeUserId() async {}

  @override
  Future<void> setUserId(String id) async {}

  @override
  Future<void> setCurrentScreen(String name) async {}
}

class FakeRoute extends Fake implements Route<dynamic> {}

class FakeStackTrace extends Fake implements StackTrace {}

class FakeFlutterErrorDetails extends Fake implements FlutterErrorDetails {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      toDiagnosticsNode(style: DiagnosticsTreeStyle.error).toStringDeep(minLevel: minLevel);
}
