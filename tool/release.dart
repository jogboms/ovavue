#!/usr/bin/env dart

import 'dart:io' as io;

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
  ..addFlag('skipPubGet')
  ..addFlag('skipAnalysisChecks')
  ..addFlag('skipTests')
  ..addFlag('gitPush');

void main(List<String> arguments) async {
  final args = parser.parse(arguments);
  final platform = args['platform'] as List<String>;
  final versionBumpType = args['versionBumpType'] as String;
  final skipAnalysisChecks = args['skipAnalysisChecks'] as bool;
  final skipPubGet = args['skipPubGet'] as bool;
  final skipTests = args['skipTests'] as bool;
  final gitPush = args['gitPush'] as bool;

  final newVersion = await bumpPackageVersion(.fromName(versionBumpType), workingDirectory: workingDirectory);

  for (final action in <CmdAction>[
    if (!skipPubGet) const .new('fvm flutter pub get'),
    if (!skipAnalysisChecks) const .new('fvm flutter analyze lib'),
    if (!skipTests) const .new('fvm flutter test --no-pub --coverage --test-randomize-ordering-seed random'),
  ]) {
    await runCmdAction(action, environment: io.Platform.environment);
  }

  await [
    if (platform.contains(BuildPlatform.android.name))
      _runActions([
        const .new('./tool/decrypt_android_secrets.sh'),
        .new('fvm flutter build appbundle --no-pub --flavor prod', workingDirectory),
        .new('fastlane android beta', workingDirectory),
      ]),
    if (platform.contains(BuildPlatform.ios.name))
      _runActions([
        .new('fvm flutter build ipa --no-pub --flavor prod --no-codesign', workingDirectory),
        .new('fastlane ios beta', workingDirectory),
      ]),
  ].wait;

  if (gitPush) {
    for (final action in <CmdAction>[
      .new('git add $workingDirectory/pubspec.yaml'),
      .new('git commit --message v$newVersion'),
      const .new('git push --force-with-lease'),
    ]) {
      await runCmdAction(action, environment: io.Platform.environment);
    }
  }
}

Future<void> _runActions(List<CmdAction> actions) async {
  for (final action in actions) {
    await runCmdAction(action, environment: io.Platform.environment);
  }
}
