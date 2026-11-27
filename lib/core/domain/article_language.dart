/// The two languages the app can show an article in.
///
/// Lives in `core` because articles, settings and the AI tools all use it.
enum ArticleLanguage {
  am(code: 'am', nativeName: 'አማርኛ', englishName: 'Amharic'),
  en(code: 'en', nativeName: 'English', englishName: 'English');

  const ArticleLanguage({
    required this.code,
    required this.nativeName,
    required this.englishName,
  });

  /// The Wikipedia sub-domain and the value used in URLs (`?lang=am`).
  final String code;
  final String nativeName;
  final String englishName;

  /// The other language, used by the language toggle.
  ArticleLanguage get other => this == am ? en : am;

  /// Parses a URL value; anything unknown means Amharic, the app default.
  static ArticleLanguage fromCode(String? code) {
    return values.firstWhere((l) => l.code == code, orElse: () => am);
  }
}
