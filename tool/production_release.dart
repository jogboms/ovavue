#!/usr/bin/env dart

import 'dart:io';

import 'package:args/args.dart';

import 'utils.dart';

final ArgParser parser = ArgParser()
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
  final ArgResults args = parser.parse(arguments);
  final List<String> platform = args['platform'] as List<String>;
  final String versionBumpType = args['versionBumpType'] as String;
  final bool skipAnalysisChecks = args['skipAnalysisChecks'] as bool;
  final bool skipTests = args['skipTests'] as bool;
  final bool gitPush = args['gitPush'] as bool;

  final String newVersion = await bumpPackageVersion(
    VersionBumpType.fromName(versionBumpType),
    workingDirectory: workingDirectory,
  );

  for (final CmdAction action in <CmdAction>[
    const CmdAction('melos bs'),
    if (!skipAnalysisChecks) const CmdAction('melos run analyze'),
    if (!skipTests) const CmdAction('melos run test_with_coverage'),
    if (platform.contains(BuildPlatform.android.name)) ...<CmdAction>[
      CmdAction('fvm flutter build appbundle --flavor prod', workingDirectory),
      CmdAction('fastlane beta', '$workingDirectory/android'),
    ],
    if (platform.contains(BuildPlatform.ios.name)) ...<CmdAction>[
      CmdAction('fvm flutter build ios --flavor prod --release --no-codesign', workingDirectory),
      CmdAction('fastlane beta', '$workingDirectory/ios'),
    ],
    if (gitPush) ...<CmdAction>[
      CmdAction('git add $workingDirectory/pubspec.yaml'),
      CmdAction('git commit --message v$newVersion'),
      const CmdAction('git push --force-with-lease'),
    ],
  ]) {
    // ignore: invalid_use_of_visible_for_testing_member
    await runCmdAction(action, environment: Platform.environment);
  }
}
