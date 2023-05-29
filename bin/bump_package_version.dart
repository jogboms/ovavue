// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:args/args.dart';

import 'utils.dart';

final ArgParser parser = ArgParser()
  ..addOption(
    'versionBumpType',
    allowed: VersionBumpType.names,
    defaultsTo: VersionBumpType.patch.name,
    valueHelp: VersionBumpType.patch.name,
  );

void main(List<String> arguments) async {
  final ArgResults args = parser.parse(arguments);
  final String versionBumpType = args['versionBumpType'] as String;

  stdout.writeln(
    await bumpPackageVersion(VersionBumpType.fromName(versionBumpType)),
  );
}
