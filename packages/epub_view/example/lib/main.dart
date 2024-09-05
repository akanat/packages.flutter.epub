import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    _setSystemUIOverlayStyle();
  }

  Brightness get platformBrightness => MediaQueryData.fromView(WidgetsBinding.instance.window).platformBrightness;

  void _setSystemUIOverlayStyle() {
    if (platformBrightness == Brightness.light) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.grey[50],
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.grey[850],
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Epub demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late EpubController _epubReaderController;

  @override
  void initState() {
    _epubReaderController = EpubController(
      document:
          // EpubDocument.openAsset('assets/New-Findings-on-Shirdi-Sai-Baba.epub'),
          EpubDocument.openAsset('assets/aqyqat-pen-angyz.epub'),
      // epubCfi:
      //     'epubcfi(/6/26[id4]!/4/2/2[id4]/22)', // book.epub Chapter 3 paragraph 10
      // epubCfi:
      //     'epubcfi(/6/6[chapter-2]!/4/2/1612)', // book_2.epub Chapter 16 paragraph 3
    );
    super.initState();
  }

  @override
  void dispose() {
    _epubReaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: EpubViewActualChapter(
            controller: _epubReaderController,
            builder: (chapterValue) => Text(
              chapterValue?.chapter?.Title?.replaceAll('\n', '').trim() ?? '',
              textAlign: TextAlign.start,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save_alt),
              color: Colors.white,
              onPressed: () => _showCurrentEpubCfi(context),
            ),
          ],
        ),
        drawer: Drawer(
          child: EpubViewTableOfContents(controller: _epubReaderController),
        ),
        body: EpubView(
          builders: EpubViewBuilders<DefaultBuilderOptions>(
            options: const DefaultBuilderOptions(),
            chapterDividerBuilder: (_) => const Divider(),
          ),
          controller: _epubReaderController,
        ),
      );

  void _showCurrentEpubCfi(context) async {
    List<ParagraphViewport>? items = await _epubReaderController.getContentWithViewport();
    for (ParagraphViewport item in items ?? []) {
      debugPrint('item: ${item.itemIndex}, content: ${item.content}, screenCoverage: ${item.screenCoverage}');

      // I/flutter ( 5263): , screenCoverage: 0.12852373887240356
      // I/flutter ( 5263): item: 2, content: АБАЙ ҚҰНАНБАЙҰЛЫ, screenCoverage: 0.0791913946587537
      // I/flutter ( 5263): item: 3, content: (1845–1904), screenCoverage: 0.0791913946587537
      // I/flutter ( 5263): item: 4, content:
      // I/flutter ( 5263): Осы жұрт Ескендірді біле ме екен?Македония шаһары – оған мекен.Филипп патша баласы, ер көңілді,Мақтан сүйгіш, қызғаншақ адам екен.
      // I/flutter ( 5263):
      // I/flutter ( 5263): 		 Филипп өлді, Ескендір патша болды,Жасы əрең жиырма бірге толды.Өз жұрты аз көрініп, көршілергеКөз алартып қарады оңды-солды.
      // I/flutter ( 5263):
      // I/flutter ( 5263): 		 Сұмдықпен ғаскер жиып қаруланды,Жақын жерге жау болды, тұра аттанды.Көп елді күтінбеген қырды, жойды,Ханды өлтіріп, қаласын тартып алды.
      // I/flutter ( 5263):
      // I/flutter ( 5263): 		 Жазасыз жақын жердің бəрін шапты,Дарияның суындай қандар ақты. , screenCoverage: 1.1060830860534123
      // I/flutter ( 5263): item: 5, content: Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін де бодам Шапқан елдің бəрін �
    }
  }
}
