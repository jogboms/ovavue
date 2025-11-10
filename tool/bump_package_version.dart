#!/usr/bin/env dart

import 'dart:io';

import 'package:args/args.dart';

import 'utils.dart';

final parser = ArgParser()
  ..addOption(
    'versionBumpType',
    allowed: VersionBumpType.values.names,
    defaultsTo: VersionBumpType.build.name,
    valueHelp: VersionBumpType.build.name,
  );

void main(List<String> arguments) async {
  final args = parser.parse(arguments);
  final versionBumpType = args['versionBumpType'] as String;

  stdout.writeln(
    await bumpPackageVersion(
      VersionBumpType.fromName(versionBumpType),
      workingDirectory: workingDirectory,
    ),
  );
}
