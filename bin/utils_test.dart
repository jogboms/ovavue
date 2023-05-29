// ignore_for_file: depend_on_referenced_packages

import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group('Utils', () {
    group('calculateNewVersion', () {
      test('works', () {
        expect(calculateNewVersion('0.1.2', VersionBumpType.major), '1.0.0+1');
        expect(calculateNewVersion('0.1.2+1', VersionBumpType.major), '1.0.0+1');
        expect(calculateNewVersion('1.1.2', VersionBumpType.major), '2.0.0+1');
        expect(calculateNewVersion('0.1.2', VersionBumpType.minor), '0.2.0+1');
        expect(calculateNewVersion('0.0.1', VersionBumpType.minor), '0.1.0+1');
        expect(calculateNewVersion('1.0.2', VersionBumpType.minor), '1.1.0+1');
        expect(calculateNewVersion('0.1.2', VersionBumpType.patch), '0.1.3+1');
        expect(calculateNewVersion('1.0.1', VersionBumpType.patch), '1.0.2+1');
        expect(calculateNewVersion('0.1.0', VersionBumpType.patch), '0.1.1+1');
        expect(calculateNewVersion('0.0.0', VersionBumpType.build), '0.0.0+1');
        expect(calculateNewVersion('0.1.0+1', VersionBumpType.build), '0.1.0+2');
      });
    });

    group('VersionBumpType', () {
      test('works', () {
        expect(VersionBumpType.fromName(null), VersionBumpType.patch);
        expect(VersionBumpType.fromName('unknown'), VersionBumpType.patch);
        expect(VersionBumpType.fromName('build'), VersionBumpType.build);
        expect(VersionBumpType.fromName('patch'), VersionBumpType.patch);
        expect(VersionBumpType.fromName('minor'), VersionBumpType.minor);
        expect(VersionBumpType.fromName('major'), VersionBumpType.major);
      });
    });
  });
}
