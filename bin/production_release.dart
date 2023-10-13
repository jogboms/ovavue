// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:args/args.dart';
import 'package:dotenv/dotenv.dart';

import 'utils.dart';

final ArgParser parser = ArgParser()
  ..addMultiOption(
    'platform',
    allowed: BuildPlatform.names,
    defaultsTo: BuildPlatform.names,
    valueHelp: BuildPlatform.names.join(','),
  )
  ..addOption(
    'versionBumpType',
    allowed: VersionBumpType.names,
    defaultsTo: VersionBumpType.patch.name,
    valueHelp: VersionBumpType.patch.name,
  )
  ..addFlag('skipAnalysisChecks')
  ..addFlag('skipCodeGeneration')
  ..addFlag('skipTests')
  ..addFlag('gitPush');

void main(List<String> arguments) async {
  final DotEnv env = DotEnv(includePlatformEnvironment: true)..load(<String>['${Platform.script.path}/../.env']);

  final ArgResults args = parser.parse(arguments);
  final List<String> platform = args['platform'] as List<String>;
  final String versionBumpType = args['versionBumpType'] as String;
  final bool skipAnalysisChecks = args['skipAnalysisChecks'] as bool;
  final bool skipCodeGeneration = args['skipCodeGeneration'] as bool;
  final bool skipTests = args['skipTests'] as bool;
  final bool gitPush = args['gitPush'] as bool;

  final String newVersion = await bumpPackageVersion(VersionBumpType.fromName(versionBumpType));
  const String flutterCmd = 'fvm flutter';

  for (final CmdAction action in <CmdAction>[
    const CmdAction('$flutterCmd pub get'),
    if (!skipCodeGeneration)
      const CmdAction('$flutterCmd packages pub run build_runner build --delete-conflicting-outputs'),
    if (!skipAnalysisChecks) const CmdAction('$flutterCmd analyze lib'),
    if (!skipTests) const CmdAction('$flutterCmd test --no-pub'),
    if (platform.contains(BuildPlatform.android.name)) ...<CmdAction>[
      const CmdAction('$flutterCmd build appbundle --flavor prod --dart-define=env.mode=prod'),
      const CmdAction('fastlane beta', 'android'),
    ],
    if (platform.contains(BuildPlatform.ios.name)) ...<CmdAction>[
      const CmdAction('$flutterCmd build ios --flavor prod --dart-define=env.mode=prod --release --no-codesign'),
      const CmdAction('fastlane beta', 'ios'),
    ],
    if (gitPush) ...<CmdAction>[
      const CmdAction('git add pubspec.yaml'),
      CmdAction('git commit --message v$newVersion'),
      const CmdAction('git push --force-with-lease'),
    ],
  ]) {
    // ignore: invalid_use_of_visible_for_testing_member
    await runCmdAction(action, environment: env.map);
  }
}
