import 'package:flutter/material.dart';
import 'package:greenway/others/constants.dart';
import 'package:greenway/theme/app_theme.dart';
import 'package:greenway/widgets/app_widgets.dart';

class coursedetailpage extends StatefulWidget {
  const coursedetailpage({super.key});

  @override
  State<coursedetailpage> createState() => _coursedetailpageState();
}

class _coursedetailpageState extends State<coursedetailpage> {
  @override
  Widget build(BuildContext context) {
    final title = clean(coursename, 'Course details');
    final sub = clean(subcoursename);
    final offer = clean(offeramount);
    final org = clean(orgamount);
    final price = offer.isNotEmpty ? offer : org;

    return Scaffold(
      appBar: gradientAppBar('Course Details'),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: SafeNetworkImage(
              url: profile,
              fallbackAsset: 'assets/default image.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Brand.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800, height: 1.25),
                ),
                if (sub.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(sub,
                      style: const TextStyle(
                          fontSize: 15, color: Brand.textMuted, height: 1.35)),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.group_outlined,
                        size: 18, color: Brand.textMuted),
                    const SizedBox(width: 6),
                    Text('${clean(student, '0')} students',
                        style: const TextStyle(color: Brand.textMuted)),
                  ],
                ),
                const SizedBox(height: 20),
                AppCard(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      _includeRow(Icons.signal_cellular_alt_rounded, 'Level',
                          'Beginner'),
                      const Divider(height: 1, indent: 56),
                      _includeRow(Icons.schedule_rounded, 'Duration',
                          clean(duration, '—')),
                      const Divider(height: 1, indent: 56),
                      _includeRow(Icons.menu_book_rounded, 'Lessons',
                          clean(lectures, '—')),
                      const Divider(height: 1, indent: 56),
                      _includeRow(Icons.language_rounded, 'Language',
                          clean(language, '—')),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CustomTabBarsPage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Brand.border)),
          ),
          padding: const EdgeInsets.fromLTRB(Brand.gutter, 12, Brand.gutter, 12),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Price',
                      style: TextStyle(fontSize: 12, color: Brand.textMuted)),
                  Text(
                    price.isEmpty ? '—' : '₹$price',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Brand.accent),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Buy Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _includeRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Brand.primary, size: 22),
          const SizedBox(width: 18),
          Text(label,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Brand.text),
            ),
          ),
        ],
      ),
    );
  }
}

/// Overview / Curriculum / Requirements tabs. Content sizes to fit, so long
/// text never overflows.
class CustomTabBarsPage extends StatefulWidget {
  const CustomTabBarsPage({super.key});

  @override
  State<CustomTabBarsPage> createState() => _CustomTabBarsPageState();
}

class _CustomTabBarsPageState extends State<CustomTabBarsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = const [
    Tab(text: 'Overview'),
    Tab(text: 'Curriculum'),
    Tab(text: 'Requirements'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging) setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _paragraph(String text, String emptyText) {
    final t = clean(text);
    return Text(
      t.isEmpty ? emptyText : t,
      style: TextStyle(
        fontSize: 15,
        height: 1.55,
        color: t.isEmpty ? Brand.textMuted : Brand.text,
      ),
    );
  }

  Widget _requirements() {
    final items = clean(requirements)
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    if (items.isEmpty) {
      return _paragraph('', 'No specific requirements.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(Icons.check_circle_rounded,
                      size: 18, color: Brand.accent),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(item,
                      style: const TextStyle(fontSize: 15, height: 1.45)),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget content;
    switch (_tabController.index) {
      case 0:
        content = _paragraph(overview ?? '', 'No overview available.');
        break;
      case 1:
        content =
            _paragraph(specification ?? '', 'Curriculum will be added soon.');
        break;
      default:
        content = _requirements();
    }

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Brand.primary,
            unselectedLabelColor: Brand.textMuted,
            indicatorColor: Brand.primary,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(fontWeight: FontWeight.w700),
            dividerColor: Brand.border,
            tabs: _tabs,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: Padding(
              key: ValueKey(_tabController.index),
              padding: const EdgeInsets.all(16),
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialDesignIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  const MaterialDesignIndicator({
    required this.indicatorHeight,
    required this.indicatorColor,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _MaterialDesignPainter(this, onChanged);
  }
}

class _MaterialDesignPainter extends BoxPainter {
  final MaterialDesignIndicator decoration;

  _MaterialDesignPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = Offset(
          offset.dx,
          configuration.size!.height - decoration.indicatorHeight,
        ) &
        Size(configuration.size!.width, decoration.indicatorHeight);

    final Paint paint = Paint()
      ..color = decoration.indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topRight: const Radius.circular(8),
        topLeft: const Radius.circular(8),
      ),
      paint,
    );
  }
}
