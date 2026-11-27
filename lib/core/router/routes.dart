import '../domain/article_language.dart';

/// Route paths in one place so screens never hard-code a string twice.
abstract final class Routes {
  // The four tabs of the bottom navigation bar.
  static const home = '/home';
  static const search = '/search';
  static const favourites = '/favourites';
  static const settings = '/settings';

  // Full-screen routes above the tabs.
  static const article = '/article/:id';
  static const aiTools = '/article/:id/ai';
  static const signIn = '/sign-in';

  /// The article reader. The language is a query parameter, so the URL
  /// alone says which version is open: `/article/lalibela?lang=en`.
  static String articleFor(String id, ArticleLanguage language) {
    return Uri(
      path: '/article/$id',
      queryParameters: {'lang': language.code},
    ).toString();
  }

  static String aiToolsFor(String id, ArticleLanguage language) {
    return Uri(
      path: '/article/$id/ai',
      queryParameters: {'lang': language.code},
    ).toString();
  }
}
