import 'dart:io';

void main(List<String> args) {
  final clientId = args[0];
  final workspace = Platform.environment['GITHUB_WORKSPACE'] ?? '.';
  final indexFile = File('${workspace}/web/index.html');
  final indexFileContents = indexFile.readAsStringSync();

  final result = indexFileContents.replaceFirstMapped(
    RegExp(r'(<meta name="google-signin-client_id" content=")(.*?)(">)'),
    (match) => '${match[1]}$clientId${match[3]}',
  );

  indexFile.writeAsStringSync(result);
}
