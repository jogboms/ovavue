#!/usr/bin/env dart

import 'dart:io';

import 'package:args/args.dart';

import 'utils.dart';

final parser = ArgParser()
  ..addMultiOption(
    'platform',
    allowed: BuildPlatform.values.names,
    defaultsTo: BuildPlatform.values.names,
    valueHelp: BuildPlatform.values.names.join(','),
  )
  ..addOption(
    'versionBumpType',
    allowed: VersionBumpType.values.names,
    defaultsTo: VersionBumpType.build.name,
    valueHelp: VersionBumpType.build.name,
  )
  ..addFlag('skipAnalysisChecks')
  ..addFlag('skipTests')
  ..addFlag('gitPush');

void main(List<String> arguments) async {
  final args = parser.parse(arguments);
  final platform = args['platform'] as List<String>;
  final versionBumpType = args['versionBumpType'] as String;
  final skipAnalysisChecks = args['skipAnalysisChecks'] as bool;
  final skipTests = args['skipTests'] as bool;
  final gitPush = args['gitPush'] as bool;

  final newVersion = await bumpPackageVersion(
    VersionBumpType.fromName(versionBumpType),
    workingDirectory: workingDirectory,
  );

  for (final action in [
    const CmdAction('melos bs'),
    if (!skipAnalysisChecks) const CmdAction('melos run analyze'),
    if (!skipTests) const CmdAction('melos run test_with_coverage'),
    if (platform.contains(BuildPlatform.android.name)) ...[
      CmdAction('fvm flutter build appbundle --flavor prod', workingDirectory),
      CmdAction('fastlane beta', '$workingDirectory/android'),
    ],
    if (platform.contains(BuildPlatform.ios.name)) ...[
      CmdAction('fvm flutter build ios --flavor prod --release --no-codesign', workingDirectory),
      CmdAction('fastlane beta', '$workingDirectory/ios'),
    ],
    if (gitPush) ...[
      CmdAction('git add $workingDirectory/pubspec.yaml'),
      CmdAction('git commit --message v$newVersion'),
      const CmdAction('git push --force-with-lease'),
    ],
  ]) {
    await runCmdAction(action, environment: Platform.environment);
  }
}
