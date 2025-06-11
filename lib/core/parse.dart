import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:job_pool/data/storage/schemas/dictionaries.dart';

abstract interface class HtmlDocumentLoader {
  Future<Document> loadHtmlDocument(Uri uri);
}

class DefaultHtmlDocumentLoader implements HtmlDocumentLoader {
  static const instance = DefaultHtmlDocumentLoader();

  const DefaultHtmlDocumentLoader();

  @override
  Future<Document> loadHtmlDocument(Uri uri) async {
    final client = HttpClient();

    try {
      final request = await client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode != HttpStatus.ok) {
        throw Exception('Failed to load document: ${response.statusCode}');
      }

      final body = await response.transform(utf8.decoder).join();
      return html_parser.parse(body);
    } finally {
      client.close();
    }
  }
}

Future<HeadHunterParsedVacancy> parseHeadHunterVacancy(
  String url, {
  HtmlDocumentLoader loader = DefaultHtmlDocumentLoader.instance,
}) async {
  final parsedUri = Uri.parse(url);

  final uri = Uri(
    scheme: parsedUri.scheme,
    host: parsedUri.host,
    path: parsedUri.path,
  );

  final doc = await loader.loadHtmlDocument(uri);

  final companyNameTag = doc.querySelector('[data-qa="vacancy-company-name"]');

  final companyLink =
      companyNameTag?.attributes['href']?.split('?').firstOrNull ?? '';

  final companyName = companyNameTag?.querySelector('span')?.text.trim() ?? '';

  final isItTag = doc.querySelector(
    '[data-qa="employer-card-employer-it-accreditation"]',
  );

  final directions = doc
      .querySelectorAll('ul[class^="vacancy-skill-list"] li div div')
      .map((d) => d.text.trim())
      .where((d) => d.isNotEmpty)
      .toSet() // remove duplicates
      .toIList();

  final vacancyTitle = doc.querySelector('[data-qa="vacancy-title"]')?.text;

  final vacancyTitleTokens = (vacancyTitle?.split(RegExp(r'[\s\\/,]')) ?? [])
      .map((t) => t.trim())
      .toSet();

  final lowerDirections = directions.map((d) => d.toLowerCase()).toList();

  final mainDirectionIndexes = vacancyTitleTokens
      .map((t) => lowerDirections.indexOf(t.toLowerCase()))
      .where((i) => i >= 0)
      .toISet();

  final sortedDirections = [
    for (final i in mainDirectionIndexes) directions[i],
    ...directions.whereIndexed((i, d) => !mainDirectionIndexes.contains(i)),
  ];

  final gradeNames = JobGrade.values.map((g) => g.name.toLowerCase()).toList();

  final grades = vacancyTitleTokens
      .map((t) => gradeNames.indexOf(t.toLowerCase()))
      .where((i) => i >= 0)
      .map((i) => JobGrade.values[i])
      .toISet();

  return HeadHunterParsedVacancy(
    companyName: companyName.replaceAll(RegExp(r'\s'), ' '),
    companyLink: companyLink.startsWith('http')
        ? companyLink
        : Uri(scheme: uri.scheme, host: uri.host, path: companyLink).toString(),
    vacancyLink: uri.toString(),
    directions: sortedDirections.toIList(),
    grades: grades,
    isIt: isItTag != null,
  );
}

class HeadHunterParsedVacancy extends Equatable {
  final String companyName, companyLink, vacancyLink;
  final IList<String> directions;
  final ISet<JobGrade> grades;
  final bool isIt;

  const HeadHunterParsedVacancy({
    required this.companyName,
    required this.companyLink,
    required this.vacancyLink,
    this.directions = const IList.empty(),
    this.grades = const ISet.empty(),
    this.isIt = false,
  });

  @override
  List<Object?> get props => [
    companyName,
    companyLink,
    vacancyLink,
    directions,
    grades,
    isIt,
  ];
}
