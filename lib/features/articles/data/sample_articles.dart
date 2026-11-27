import '../../../core/domain/article_language.dart';

/// The title, summary and paragraphs of one article in one language.
class ArticleText {
  const ArticleText({
    required this.title,
    required this.summary,
    required this.paragraphs,
  });

  final String title;
  final String summary;
  final List<String> paragraphs;
}

/// One article topic with its versions. [am] is null when Amharic
/// Wikipedia has no article, which is what the English fallback is for.
class ArticleSeed {
  const ArticleSeed({required this.id, required this.en, this.am});

  final String id;
  final ArticleText en;
  final ArticleText? am;

  ArticleText? text(ArticleLanguage language) {
    return switch (language) {
      ArticleLanguage.am => am,
      ArticleLanguage.en => en,
    };
  }
}

/// One historical event with its text in each language.
class FactSeed {
  const FactSeed({
    required this.id,
    required this.year,
    required this.month,
    required this.day,
    required this.en,
    required this.am,
    this.relatedArticleId,
  });

  final String id;
  final int year;
  final int month;
  final int day;
  final String en;
  final String am;
  final String? relatedArticleId;
}

/// Sample content for Milestone 1. Milestone 2 replaces it with live data
/// from the Wikipedia REST API; the screens do not change.
const sampleArticles = <ArticleSeed>[
  ArticleSeed(
    id: 'addis-ababa',
    en: ArticleText(
      title: 'Addis Ababa',
      summary: 'Addis Ababa is the capital and largest city of Ethiopia.',
      paragraphs: [
        'Addis Ababa is the capital and largest city of Ethiopia. It was '
            'founded in the late 19th century by Emperor Menelik II and '
            'Empress Taytu Betul.',
        'The city lies at an altitude of about 2,355 metres, which makes it '
            'one of the highest capital cities in the world. It is also the '
            'seat of the African Union.',
      ],
    ),
    am: ArticleText(
      title: 'አዲስ አበባ',
      summary: 'አዲስ አበባ የኢትዮጵያ ዋና ከተማና ትልቋ ከተማ ናት።',
      paragraphs: [
        'አዲስ አበባ የኢትዮጵያ ዋና ከተማና ትልቋ ከተማ ናት። በ19ኛው ክፍለ ዘመን መጨረሻ '
            'ላይ በአፄ ምኒልክና በእቴጌ ጣይቱ ብጡል ተመሠረተች።',
        'ከተማዋ ከባሕር ጠለል በላይ ወደ 2,355 ሜትር ከፍታ ላይ ትገኛለች። '
            'የአፍሪካ ኅብረት መቀመጫም ናት።',
      ],
    ),
  ),
  ArticleSeed(
    id: 'lalibela',
    en: ArticleText(
      title: 'Lalibela',
      summary:
          'Lalibela is a town in northern Ethiopia famous for its '
          'rock-hewn churches.',
      paragraphs: [
        'Lalibela is a town in the Amhara Region of northern Ethiopia. It is '
            'famous for its eleven medieval churches that were carved down '
            'into solid rock.',
        'The churches were built in the 12th and 13th centuries and are '
            'still used for worship today. UNESCO listed Lalibela as a World '
            'Heritage Site in 1978.',
      ],
    ),
    am: ArticleText(
      title: 'ላሊበላ',
      summary:
          'ላሊበላ ከአለት በተፈለፈሉ አብያተ ክርስቲያናቱ የሚታወቅ በሰሜናዊ ኢትዮጵያ '
          'የሚገኝ ከተማ ነው።',
      paragraphs: [
        'ላሊበላ በሰሜናዊ ኢትዮጵያ በአማራ ክልል የሚገኝ ከተማ ነው። አሥራ አንድ '
            'ከአለት የተፈለፈሉ ጥንታዊ አብያተ ክርስቲያናት አሉት።',
        'አብያተ ክርስቲያናቱ በ12ኛውና በ13ኛው ክፍለ ዘመን የተሠሩ ሲሆን እስከ ዛሬም '
            'ለአምልኮ ያገለግላሉ። ዩኔስኮ ላሊበላን በ1978 እ.ኤ.አ. የዓለም ቅርስ '
            'አድርጎ መዝግቦታል።',
      ],
    ),
  ),
  ArticleSeed(
    id: 'battle-of-adwa',
    en: ArticleText(
      title: 'Battle of Adwa',
      summary:
          'The Battle of Adwa was fought on 1 March 1896, when Ethiopia '
          'defeated Italy.',
      paragraphs: [
        'The Battle of Adwa was fought on 1 March 1896 near the town of Adwa '
            'in northern Ethiopia. The Ethiopian army, led by Emperor '
            'Menelik II, defeated an invading Italian force.',
        'The victory secured the independence of Ethiopia and became a '
            'symbol of African resistance to colonial rule.',
      ],
    ),
    am: ArticleText(
      title: 'የዓድዋ ጦርነት',
      summary: 'የዓድዋ ጦርነት ኢትዮጵያ ጣሊያንን ያሸነፈችበት በ1888 ዓ.ም. የተካሄደ ጦርነት ነው።',
      paragraphs: [
        'የዓድዋ ጦርነት የካቲት 23 ቀን 1888 ዓ.ም. በሰሜናዊ ኢትዮጵያ ዓድዋ አቅራቢያ '
            'ተካሄደ። በዳግማዊ ምኒልክ የሚመራው የኢትዮጵያ ጦር ወራሪውን የጣሊያን ጦር '
            'አሸነፈ።',
        'ድሉ የኢትዮጵያን ነፃነት ያስጠበቀ ሲሆን ለአፍሪካውያን የቅኝ ግዛት ተቃውሞ ምልክት '
            'ሆነ።',
      ],
    ),
  ),
  ArticleSeed(
    id: 'ethiopian-coffee',
    en: ArticleText(
      title: 'Coffee in Ethiopia',
      summary: 'Ethiopia is regarded as the birthplace of Arabica coffee.',
      paragraphs: [
        'Ethiopia is widely regarded as the birthplace of Coffea arabica, '
            'the plant that gives most of the coffee drunk in the world. '
            'Wild coffee plants still grow in the forests of the south-west.',
        'Coffee is part of daily life in Ethiopia. In the traditional coffee '
            'ceremony the beans are roasted, ground and brewed in front of '
            'the guests, which is an important way to welcome visitors.',
      ],
    ),
    am: ArticleText(
      title: 'ቡና',
      summary: 'ኢትዮጵያ የአረቢካ ቡና መገኛ እንደሆነች ይታመናል።',
      paragraphs: [
        'ኢትዮጵያ የአረቢካ ቡና መገኛ እንደሆነች በሰፊው ይታመናል። በደቡብ ምዕራብ ኢትዮጵያ '
            'ደኖች ውስጥ የዱር ቡና አሁንም ይበቅላል።',
        'ቡና በኢትዮጵያ የዕለት ተዕለት ሕይወት አካል ነው። ቡና ተጠብሶ፣ ተፈጭቶና ተፈልቶ '
            'እንግዶች ፊት የሚቀርብበት የቡና ሥነ ሥርዓት እንግዳን የመቀበያ አስፈላጊ መንገድ ነው።',
      ],
    ),
  ),
  ArticleSeed(
    id: 'lake-tana',
    en: ArticleText(
      title: 'Lake Tana',
      summary:
          'Lake Tana is the largest lake in Ethiopia and the source of the '
          'Blue Nile.',
      paragraphs: [
        'Lake Tana is the largest lake in Ethiopia, in the north-west '
            'highlands. It is the source of the Blue Nile, which flows to '
            'Sudan and meets the White Nile at Khartoum.',
        'Its islands hold ancient monasteries, and the lake is home to many '
            'species of birds and fish.',
      ],
    ),
    am: ArticleText(
      title: 'ጣና ሐይቅ',
      summary: 'ጣና ሐይቅ የኢትዮጵያ ትልቁ ሐይቅና የዓባይ ወንዝ መነሻ ነው።',
      paragraphs: [
        'ጣና ሐይቅ በሰሜን ምዕራብ የኢትዮጵያ ደጋማ አካባቢ የሚገኝ የሀገሪቱ ትልቁ ሐይቅ ነው። '
            'ከዚህ ሐይቅ የሚነሳው ዓባይ ወንዝ ወደ ሱዳን ይፈስሳል።',
        'በሐይቁ ደሴቶች ላይ ጥንታዊ ገዳማት ይገኛሉ። ሐይቁ የብዙ የወፍና የዓሣ ዝርያዎች '
            'መኖሪያ ነው።',
      ],
    ),
  ),
  // No Amharic article: the reader falls back to English.
  ArticleSeed(
    id: 'ethiopian-wolf',
    en: ArticleText(
      title: 'Ethiopian wolf',
      summary:
          'The Ethiopian wolf is a rare wolf that lives only in the '
          'highlands of Ethiopia.',
      paragraphs: [
        'The Ethiopian wolf is a rare canid found only in the highlands of '
            'Ethiopia. It is the most endangered carnivore in Africa.',
        'It hunts mainly rodents in open grassland above 3,000 metres, and '
            'most of the remaining wolves live in the Bale Mountains.',
      ],
    ),
  ),
];

const sampleFacts = <FactSeed>[
  FactSeed(
    id: 'adwa-1896',
    year: 1896,
    month: 3,
    day: 1,
    en:
        'Ethiopian forces led by Emperor Menelik II defeat Italy at the '
        'Battle of Adwa.',
    am: 'በዳግማዊ ምኒልክ የሚመራው የኢትዮጵያ ጦር በዓድዋ ጦርነት ጣሊያንን አሸነፈ።',
    relatedArticleId: 'battle-of-adwa',
  ),
  FactSeed(
    id: 'return-1941',
    year: 1941,
    month: 5,
    day: 5,
    en:
        'Emperor Haile Selassie returns to Addis Ababa after five years of '
        'Italian occupation.',
    am: 'አፄ ኃይለ ሥላሴ ከአምስት ዓመት የጣሊያን ወረራ በኋላ ወደ አዲስ አበባ ተመለሱ።',
    relatedArticleId: 'addis-ababa',
  ),
  FactSeed(
    id: 'derg-1974',
    year: 1974,
    month: 9,
    day: 12,
    en:
        'Emperor Haile Selassie is removed from power by the military '
        'committee known as the Derg.',
    am: 'አፄ ኃይለ ሥላሴ ደርግ በተባለው የወታደሮች ኮሚቴ ከሥልጣን ተወገዱ።',
  ),
];
