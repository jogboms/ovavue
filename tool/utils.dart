import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('Utils', () {
    group('VersionBumpType', () {
      group('bump', () {
        test('should work as expected', () {
          expect(VersionBumpType.major.bump('0.1.2'), '1.0.0+1');
          expect(VersionBumpType.major.bump('0.1.2+1'), '1.0.0+1');
          expect(VersionBumpType.major.bump('1.1.2'), '2.0.0+1');
          expect(VersionBumpType.minor.bump('0.1.2'), '0.2.0+1');
          expect(VersionBumpType.minor.bump('0.0.1'), '0.1.0+1');
          expect(VersionBumpType.minor.bump('1.0.2'), '1.1.0+1');
          expect(VersionBumpType.patch.bump('0.1.2'), '0.1.3+1');
          expect(VersionBumpType.patch.bump('1.0.1'), '1.0.2+1');
          expect(VersionBumpType.patch.bump('0.1.0'), '0.1.1+1');
          expect(VersionBumpType.build.bump('0.0.0'), '0.0.0+1');
          expect(VersionBumpType.build.bump('0.1.0+1'), '0.1.0+2');
        });

        test('should override value with override', () {
          expect(VersionBumpType.major.bump('0.1.2', override: '2'), '2.0.0+1');
          expect(VersionBumpType.major.bump('1.1.2', override: '1'), '1.0.0+1');
          expect(VersionBumpType.minor.bump('0.1.2', override: '1'), '0.1.0+1');
          expect(VersionBumpType.minor.bump('0.0.1', override: '2'), '0.2.0+1');
          expect(VersionBumpType.patch.bump('0.1.2', override: '1'), '0.1.1+1');
          expect(VersionBumpType.patch.bump('1.0.1', override: '0'), '1.0.0+1');
          expect(VersionBumpType.build.bump('0.0.0', override: '2'), '0.0.0+2');
          expect(VersionBumpType.build.bump('0.1.0+1', override: '0'), '0.1.0+0');
        });
      });

      group('fromName', () {
        test('should work as expected', () {
          expect(VersionBumpType.fromName(null), VersionBumpType.patch);
          expect(VersionBumpType.fromName('unknown'), VersionBumpType.patch);
          expect(VersionBumpType.fromName('build'), VersionBumpType.build);
          expect(VersionBumpType.fromName('patch'), VersionBumpType.patch);
          expect(VersionBumpType.fromName('minor'), VersionBumpType.minor);
          expect(VersionBumpType.fromName('major'), VersionBumpType.major);
        });
      });
    });
  });
}

final String workingDirectory = Directory.current.path;

Future<String> bumpPackageVersion(
  VersionBumpType type, {
  required String workingDirectory,
  String? valueOverride,
}) async {
  stdout.writeln('Performing a "${type.name}" version bump');

  final versionRegExp = RegExp(r'(version:\s)(.*)');
  final pubspecFile = File('$workingDirectory/pubspec.yaml');
  final pubspec = await pubspecFile.readAsString();
  final currentVersion = versionRegExp.firstMatch(pubspec)!.group(2)!;
  final newVersion = type.bump(currentVersion, override: valueOverride);

  final updatedPubspec = pubspec.replaceFirstMapped(versionRegExp, (Match match) => '${match[1]}$newVersion');
  await pubspecFile.writeAsString(updatedPubspec);

  return newVersion;
}

enum VersionBumpType {
  major,
  minor,
  patch,
  build
  ;

  static VersionBumpType fromName(String? name) => values.asNameMap()[name] ?? VersionBumpType.patch;

  String bump(String current, {String? override}) {
    final split =
        RegExp(r'(\d+).(\d+).(\d+)\+?(\d)?')
            .firstMatch(current)
            ?.groups([1, 2, 3, 4])
            .map((String? it) => it != null ? int.tryParse(it) ?? 0 : 0)
            .toList() ??
        List<int>.filled(4, 0);

    return switch (this) {
      major => '${override ?? split[0] + 1}.0.0+1',
      minor => '${split[0]}.${override ?? split[1] + 1}.0+1',
      patch => '${split[0]}.${split[1]}.${override ?? split[2] + 1}+1',
      build => '${split[0]}.${split[1]}.${split[2]}+${override ?? split[3] + 1}',
    };
  }
}

enum BuildPlatform { android, ios }

enum FlavorPlatform { dev, prod }

extension EnumNames on Iterable<Enum> {
  Iterable<String> get names => map((Enum it) => it.name);
}

final class CmdAction {
  const CmdAction(this.cmd, [this.workingDirectory]);

  final String cmd;
  final String? workingDirectory;
}

Future<void> runCmdAction(CmdAction action, {required Map<String, String> environment}) async {
  stdout.writeln('Running ${action.cmd}');
  final args = action.cmd.split(' ');
  final process = await Process.start(
    args[0],
    args.sublist(1),
    workingDirectory: action.workingDirectory,
    environment: environment,
  );
  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);
}
