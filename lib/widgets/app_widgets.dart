import 'package:flutter/material.dart';
import 'package:greenway/theme/app_theme.dart';

/// App bar with the brand gradient. Use for every screen so headers match.
PreferredSizeWidget gradientAppBar(
  String title, {
  List<Widget>? actions,
  Widget? leading,
  bool centerTitle = true,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
    centerTitle: centerTitle,
    leading: leading,
    actions: actions,
    bottom: bottom,
    flexibleSpace:
        Container(decoration: const BoxDecoration(gradient: Brand.gradient)),
  );
}

/// Centered loader used while data is being fetched.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          if (message != null) ...[
            const SizedBox(height: 14),
            Text(message!,
                style: const TextStyle(color: Brand.textMuted, fontSize: 14)),
          ],
        ],
      ),
    );
  }
}

/// Friendly placeholder shown when a screen has nothing to display.
///
/// It is scrollable (so pull-to-refresh keeps working and small screens never
/// overflow) unless [compact] is true, in which case it sizes to its content
/// and can live inside another scroll view.
class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.icon = Icons.inbox_outlined,
    this.title = 'Nothing here yet',
    this.message,
    this.actionLabel,
    this.onAction,
    this.color = Brand.primary,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 132,
            height: 132,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.09),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(icon, size: 32, color: color),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Brand.text),
          ),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14, color: Brand.textMuted, height: 1.4),
            ),
          ],
          if (onAction != null) ...[
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: Text(actionLabel ?? 'Try again'),
            ),
          ],
        ],
      ),
    );

    if (compact) return Center(child: content);

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight:
                  constraints.hasBoundedHeight ? constraints.maxHeight : 0),
          child: Center(child: content),
        ),
      ),
    );
  }
}

/// Error placeholder with a retry button.
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.title = 'Something went wrong',
    this.message =
        'We couldn\'t load this right now. Check your connection and try again.',
    this.onRetry,
    this.compact = false,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return EmptyView(
      icon: Icons.cloud_off_rounded,
      color: Brand.danger,
      title: title,
      message: message,
      onAction: onRetry,
      actionLabel: 'Try again',
      compact: compact,
    );
  }
}

/// Loads data once (and again on [reload]) and renders the right state:
/// loading, error, empty, or [builder] with the data.
///
/// Unlike a bare FutureBuilder in `build`, this does not refetch on every
/// rebuild and never shows a blank screen.
class AsyncView<T> extends StatefulWidget {
  const AsyncView({
    super.key,
    required this.load,
    required this.builder,
    this.isEmpty,
    this.emptyIcon = Icons.inbox_outlined,
    this.emptyTitle = 'Nothing here yet',
    this.emptyMessage,
    this.errorAsEmpty = false,
    this.compact = false,
    this.loadingMessage,
  });

  final Future<T> Function() load;
  final Widget Function(BuildContext context, T data, Future<void> Function() reload)
      builder;

  /// Defaults to: null, or an empty Iterable / Map.
  final bool Function(T data)? isEmpty;
  final IconData emptyIcon;
  final String emptyTitle;
  final String? emptyMessage;

  /// Some endpoints throw when there is simply no data; show the empty state
  /// for those instead of an error.
  final bool errorAsEmpty;

  /// Use inside another scroll view.
  final bool compact;
  final String? loadingMessage;

  @override
  State<AsyncView<T>> createState() => _AsyncViewState<T>();
}

class _AsyncViewState<T> extends State<AsyncView<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.load();
  }

  Future<void> _reload() async {
    final next = widget.load();
    setState(() => _future = next);
    try {
      await next;
    } catch (_) {}
  }

  bool _defaultIsEmpty(T? data) {
    if (data == null) return true;
    if (data is Iterable) return data.isEmpty;
    if (data is Map) return data.isEmpty;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return widget.compact
              ? const SkeletonBox(height: 180)
              : const SkeletonList();
        }

        final empty = EmptyView(
          icon: widget.emptyIcon,
          title: widget.emptyTitle,
          message: widget.emptyMessage,
          onAction: _reload,
          actionLabel: 'Refresh',
          compact: widget.compact,
        );

        if (snapshot.hasError) {
          debugPrint('AsyncView error: ${snapshot.error}');
          if (widget.errorAsEmpty) return empty;
          return ErrorView(onRetry: _reload, compact: widget.compact);
        }

        final data = snapshot.data;
        final isEmpty = data == null ||
            (widget.isEmpty?.call(data as T) ?? _defaultIsEmpty(data));
        if (isEmpty) return empty;

        return widget.builder(context, data as T, _reload);
      },
    );
  }
}

/// Rounded white card with optional tap feedback.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.color = Brand.surface,
    this.animate = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color color;

  /// Fade/slide in when first shown.
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final card = _card();
    return animate ? Appear(child: card) : card;
  }

  Widget _card() {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Brand.radius),
        border: Border.all(color: Brand.border),
        boxShadow: Brand.softShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Brand.radius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

/// Small rounded square with a tinted icon.
class IconBadge extends StatelessWidget {
  const IconBadge({
    super.key,
    required this.icon,
    this.color = Brand.primary,
    this.size = 48,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}

/// Pill-shaped status label.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: color, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

/// Section title used above groups of content.
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.trailing});
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700, color: Brand.text),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Network image with a placeholder while loading and a fallback on error.
class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({
    super.key,
    required this.url,
    this.fallbackAsset = 'assets/course.jpg',
    this.fit = BoxFit.cover,
  });

  final String? url;
  final String fallbackAsset;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final fallback = Image.asset(fallbackAsset, fit: fit);
    final u = url?.trim() ?? '';
    if (u.isEmpty || u == 'null') return fallback;
    return Image.network(
      u,
      fit: fit,
      errorBuilder: (_, _, _) => fallback,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: Brand.primaryLight,
          alignment: Alignment.center,
          child: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}

/// Animated shimmer sweep for skeleton placeholders.
class Shimmer extends StatefulWidget {
  const Shimmer({super.key, required this.child});
  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1300),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      child: widget.child,
      builder: (context, child) {
        final t = _c.value * 3 - 1; // -1 .. 2
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment(t - 1, -0.3),
            end: Alignment(t, 0.3),
            colors: const [
              Color(0xFFE9EDF5),
              Color(0xFFF7F9FC),
              Color(0xFFE9EDF5),
            ],
            stops: const [0.1, 0.5, 0.9],
          ).createShader(rect),
          child: child,
        );
      },
    );
  }
}

/// A single grey rounded block that shimmers.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.height = 80, this.width, this.radius});
  final double height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFE9EDF5),
          borderRadius: BorderRadius.circular(radius ?? Brand.radius),
        ),
      ),
    );
  }
}

/// Placeholder list shown while a list screen loads.
class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key, this.count = 6});
  final int count;

  @override
  Widget build(BuildContext context) {
    Widget line(double w, double h) => Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: const Color(0xFFE9EDF5),
            borderRadius: BorderRadius.circular(6),
          ),
        );
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Brand.gutter),
      itemCount: count,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, _) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Brand.radius),
          border: Border.all(color: Brand.border),
        ),
        child: Shimmer(
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9EDF5),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, c) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      line(c.maxWidth * 0.85, 14),
                      const SizedBox(height: 8),
                      line(c.maxWidth * 0.5, 11),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Fades and slides a child in once, staggered by [index].
class Appear extends StatelessWidget {
  const Appear({super.key, required this.child, this.index = 0});
  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    final delay = (index.clamp(0, 6)) * 60;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 380 + delay),
      curve: Interval(delay / (380 + delay), 1, curve: Curves.easeOutCubic),
      child: child,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, (1 - v) * 18),
          child: child,
        ),
      ),
    );
  }
}

/// Initials avatar with the brand gradient.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.name,
    this.size = 48,
    this.ringColor,
  });
  final String name;
  final double size;
  final Color? ringColor;

  String get _initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: Brand.gradient,
      ),
      child: Text(
        _initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: size * 0.36,
        ),
      ),
    );
    if (ringColor == null) return avatar;
    return Container(
      padding: EdgeInsets.all(size * 0.05),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: ringColor!, width: size * 0.04),
      ),
      child: avatar,
    );
  }
}

/// Shows a floating snackbar.
void showAppSnack(BuildContext context, String message, {bool error = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Brand.danger : null,
        duration: const Duration(seconds: 3),
      ),
    );
}

/// Formats an API date that may be a unix timestamp (seconds) or a string.
String formatApiDate(dynamic raw, [String fallback = '']) {
  final v = clean(raw);
  if (v.isEmpty) return fallback;
  final ts = int.tryParse(v);
  if (ts == null) return v;
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  final d = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}

/// Returns a readable string for API values that may be null / "null".
String clean(dynamic value, [String fallback = '']) {
  if (value == null) return fallback;
  final s = value.toString().trim();
  if (s.isEmpty || s == 'null') return fallback;
  return s;
}
