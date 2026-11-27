import 'package:flutter/material.dart';

import '../../../../core/domain/article_language.dart';

/// Two buttons, one per language. Shows the language name in its own
/// script, so a reader who only reads Amharic can still find it.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final ArticleLanguage selected;
  final ValueChanged<ArticleLanguage> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ArticleLanguage>(
      showSelectedIcon: false,
      segments: [
        for (final language in ArticleLanguage.values)
          ButtonSegment(value: language, label: Text(language.nativeName)),
      ],
      selected: {selected},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
