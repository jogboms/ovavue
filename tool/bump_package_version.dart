#!/usr/bin/env dart

import 'dart:io';

import 'package:args/args.dart';

import 'utils.dart';

final ArgParser parser = ArgParser()
  ..addOption(
    'versionBumpType',
    allowed: VersionBumpType.values.names,
    defaultsTo: VersionBumpType.build.name,
    valueHelp: VersionBumpType.build.name,
  );

void main(List<String> arguments) async {
  final ArgResults args = parser.parse(arguments);
  final String versionBumpType = args['versionBumpType'] as String;

  stdout.writeln(
    await bumpPackageVersion(
      VersionBumpType.fromName(versionBumpType),
      workingDirectory: workingDirectory,
    ),
  );
}
