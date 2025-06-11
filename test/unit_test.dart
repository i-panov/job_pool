import 'dart:io';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:html/dom.dart';
import 'package:job_pool/core/parse.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:test/test.dart';

Future<void> main() async {
  test('parseHeadHunterVacancy', () async {
    final loader = MockHtmlDocumentLoader();

    await loader.setNextLoad('119699691_c#_is_it.html');

    final v1 = await parseHeadHunterVacancy('', loader: loader);

    expect(v1.companyName, '2ГИС');
    expect(v1.companyLink, 'https://spb.hh.ru/employer/64174');
    expect(v1.vacancyLink, '//');

    expect(v1.directions, IList<String>([
      'C#',
      'SQL',
      'React',
      '.NET Core',
      '.NET Framework',
    ]));

    expect(v1.grades, ISet<JobGrade>([JobGrade.middle, JobGrade.senior]));
    expect(v1.isIt, true);

    await loader.setNextLoad('121545555_php_not_it.html');
    final v2 = await parseHeadHunterVacancy('', loader: loader);

    expect(v2.companyName, 'ООО СДЕЛКАРФ');
    expect(v2.companyLink, 'https://spb.hh.ru/employer/4258907');
    expect(v2.vacancyLink, '//');

    expect(v2.directions, IList<String>([
      'PHP',
      'Symfony',
      'PostgreSQL',
      'DDD',
      'Удаленная работа',
      'GraphQL',
      'Java',
      'Spring Framework',
      'С#',
      '.NET Framework',
      'REST API',
      'SQL',
      'doctrine',
    ]));
    
    expect(v2.grades, ISet<JobGrade>());
    expect(v2.isIt, false);
  });
}

class MockHtmlDocumentLoader implements HtmlDocumentLoader {
  final Map<String, String> _cache = {};
  var _nextLoad = '';

  Future<void> setNextLoad(String filename) async {
    if (filename.isEmpty) {
      throw Exception('filename is empty');
    }

    if (!_cache.containsKey(filename)) {
      final file = File('test/resources/$filename');

      if (!await file.exists()) {
        throw Exception('File not found: $filename');
      }

      _cache[filename] = await file.readAsString();
    }

    _nextLoad = filename;
  }

  @override
  Future<Document> loadHtmlDocument(Uri uri) async {
    if (_nextLoad.isEmpty) {
      throw Exception('No next load set');
    }

    if (!_cache.containsKey(_nextLoad)) {
      throw Exception('Content not found for $_nextLoad');
    }

    final content = _cache[_nextLoad]!;
    return Document.html(content);
  }
}
