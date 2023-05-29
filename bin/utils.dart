import 'dart:io';

Future<String> bumpPackageVersion(VersionBumpType type) async {
  stdout.writeln('Performing a "${type.name}" version bump');

  final RegExp versionRegExp = RegExp(r'(version:\s)(.*)');
  final File pubspecFile = File('${Directory.current.path}/pubspec.yaml');
  final String pubspec = await pubspecFile.readAsString();
  final String currentVersion = versionRegExp.firstMatch(pubspec)!.group(2)!;
  final String newVersion = calculateNewVersion(currentVersion, type);

  final String updatedPubspec = pubspec.replaceFirstMapped(versionRegExp, (Match match) => '${match[1]}$newVersion');
  await pubspecFile.writeAsString(updatedPubspec);

  return newVersion;
}

String calculateNewVersion(String current, VersionBumpType type) {
  final List<int> split = RegExp(r'(\d+).(\d+).(\d+)\+?(\d)?')
          .firstMatch(current)
          ?.groups(<int>[1, 2, 3, 4])
          .map((String? it) => it != null ? int.tryParse(it) ?? 0 : 0)
          .toList() ??
      List<int>.filled(4, 0);

  switch (type) {
    case VersionBumpType.major:
      return '${split[0] + 1}.0.0+1';
    case VersionBumpType.minor:
      return '${split[0]}.${split[1] + 1}.0+1';
    case VersionBumpType.patch:
      return '${split[0]}.${split[1]}.${split[2] + 1}+1';
    case VersionBumpType.build:
      return '${split[0]}.${split[1]}.${split[2]}+${split[3] + 1}';
  }
}

enum VersionBumpType {
  major,
  minor,
  patch,
  build;

  static VersionBumpType fromName(String? name) => values.asNameMap()[name] ?? VersionBumpType.patch;

  static Iterable<String> names = values.map((VersionBumpType it) => it.name);
}

enum BuildPlatform {
  android,
  ios;

  static BuildPlatform fromName(String? name) => values.asNameMap()[name] ?? BuildPlatform.android;

  static Iterable<String> names = values.map((BuildPlatform it) => it.name);
}

class CmdAction {
  const CmdAction(this.cmd, [this.cwd]);

  final String cmd;
  final String? cwd;
}

Future<void> runCmdAction(CmdAction action, {required Map<String, String> environment}) async {
  stdout.writeln('Running ${action.cmd}');
  final List<String> args = action.cmd.split(' ');
  final Process process = await Process.start(
    args[0],
    args.sublist(1),
    workingDirectory: action.cwd,
    environment: environment,
  );
  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);
}

Future<dynamic> execCmdAction(CmdAction action, {required Map<String, String> environment}) async {
  stdout.writeln('Running ${action.cmd}');
  final List<String> args = action.cmd.split(' ');
  final ProcessResult process = await Process.run(
    args[0],
    args.sublist(1),
    workingDirectory: action.cwd,
    environment: environment,
  );
  if (process.exitCode != 0) {
    throw Exception('${process.exitCode}: ${process.stderr}');
  }
  stdout.write(process.stdout);
  stderr.write(process.stderr);

  return process.stdout;
}
