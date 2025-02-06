import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cold_drink_animated_ui/models/drinks.dart';
import 'package:cold_drink_animated_ui/screens/can_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0)
      ..addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    if (!_pageController.hasClients || _pageController.page == null) return;
    final int page = _pageController.page!.round();
    if (_currentPage != page) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  List<Color> _getGradientColors() {
    if (!_pageController.hasClients || _pageController.page == null) {
      return drinks.first.colors;
    }

    final double page = _pageController.page!;
    final int currentIndex = page.floor();
    int nextIndex = currentIndex + 1;
    final double fraction = page - currentIndex;

    if (nextIndex >= drinks.length) nextIndex = drinks.length - 1;

    return List.generate(
      drinks[currentIndex].colors.length,
      (i) =>
          Color.lerp(
            drinks[currentIndex].colors[i],
            drinks[nextIndex].colors[i],
            fraction,
          ) ??
          drinks[currentIndex].colors[i],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // **Background Gradient Animation**
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _getGradientColors(),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              );
            },
          ),
          // **Decorator Images**
          ...List.generate(drinks.length, (drinkIndex) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                double progress = 0.0;
                if (_pageController.hasClients &&
                    _pageController.position.haveDimensions) {
                  progress = (_pageController.page ?? 0) - drinkIndex;
                } else {
                  progress = drinkIndex == 0 ? 0.0 : 1.0;
                }
                final double slideOffset = -progress * height * 1.2;
                final double opacity = (1.0 - progress.abs()).clamp(0.0, 1.0);
                return Opacity(
                  opacity: opacity,
                  child: Transform.translate(
                    offset: Offset(0, slideOffset),
                    child: _DecoratorStack(
                      drink: drinks[drinkIndex],
                      progress: progress,
                      height: height,
                      width: width,
                    ),
                  ),
                );
              },
            );
          }),
          // **Bottom Circle with Drink Details**
          Positioned(
            bottom: -(width / 2),
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                return Container(
                  height: width,
                  width: width,
                  padding: const EdgeInsets.all(90),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: _getGradientColors(),
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SlideTransitionText(
                        text: drinks[_currentPage].title,
                        valueKey: '${_currentPage}_title',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26.29,
                          color: Colors.white,
                        ),
                      ),
                      SlideTransitionText(
                        text: drinks[_currentPage].type,
                        valueKey: '${_currentPage}_type',
                        style: const TextStyle(
                          fontFamily: "FugazOne",
                          fontWeight: FontWeight.bold,
                          fontSize: 18.4,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 19),
                      _PageIndicator(
                        pageController: _pageController,
                        itemCount: drinks.length,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // **Rotating Fanta Can Circle**
          Positioned(
            top: height * 0.15,
            left: -466,
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                final double rotationAngle =
                    (_pageController.hasClients && _pageController.page != null)
                        ? (_pageController.page! * (-360 / drinks.length) + 360)
                        : 0;
                return Transform.rotate(
                  angle: rotationAngle * (pi / 180),
                  child: Image.asset(
                    "assets/Fanta_All_Circle.png",
                    height: 1255,
                    width: 1338,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          // **Tagline Animation**
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: drinks[_currentPage]
                    .tagLine
                    .split(" ")
                    .asMap()
                    .entries
                    .map(
                      (entry) => SlideTransitionText(
                        text: entry.value,
                        valueKey: '${_currentPage}_${entry.value}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: entry.key == 2 ? 45.4 : 26.29,
                          fontWeight: entry.key == 2
                              ? FontWeight.w800
                              : FontWeight.bold,
                          height: 0.9,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          // **PageView for Navigation**
          PageView.builder(
            controller: _pageController,
            itemCount: drinks.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CanDetailScreen(drink: drinks[index]),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      transitionDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                child: Hero(
                  tag: 'can_${drinks[index].title}',
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// **Widget to display decorator images for each drink**
class _DecoratorStack extends StatelessWidget {
  final DrinkData drink;
  final double progress;
  final double height;
  final double width;

  const _DecoratorStack({
    required this.drink,
    required this.progress,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    List<Rect> placedRects = [];
    final List<Widget> decorators = [];

    for (int i = 0; i < drink.decoratorImages.length; i++) {
      final seed = i * 37;
      final random = Random(seed);
      for (int attempt = 0; attempt < 30; attempt++) {
        final canArea = Rect.fromLTWH(
          width * 0.35,
          height * 0.35,
          width * 0.3,
          height * 0.3,
        );
        final double yPos =
            height * 0.15 + random.nextDouble() * (height * 0.55);
        final double xPos = random.nextDouble() < 0.6
            ? random.nextDouble() * width * 0.4
            : width * 0.6 + random.nextDouble() * (width * 0.4);

        final double verticalProgress = yPos / (height * 0.7);
        final double baseSize = 120.0 - (verticalProgress * 40);

        final rect = Rect.fromLTWH(
          xPos - baseSize / 2,
          yPos,
          baseSize,
          baseSize,
        );

        final overlaps = placedRects.any(
          (placed) => placed.inflate(20).overlaps(rect),
        );

        if (!overlaps && !canArea.overlaps(rect)) {
          placedRects.add(rect);
          final double baseRotation = random.nextDouble() * 2 * pi;
          final double rotationSpeed = 0.1 + random.nextDouble() * 0.2;
          final int rotationDirection = random.nextBool() ? 1 : -1;

          decorators.add(Positioned(
            left: xPos - baseSize / 2,
            top: yPos,
            child: Transform.rotate(
              angle: baseRotation +
                  (progress * pi) +
                  (rotationDirection * rotationSpeed * progress * 4 * pi),
              child: Transform.scale(
                scale: 1.0 - progress.abs() * 0.2,
                child: Image.asset(
                  drink.decoratorImages[i],
                  height: baseSize,
                  width: baseSize,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ));
          break;
        }
      }
    }
    return Stack(children: decorators);
  }
}

/// **Widget for Slide Transition Text**
class SlideTransitionText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final String valueKey;

  const SlideTransitionText({
    super.key,
    required this.text,
    required this.style,
    required this.valueKey,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ));
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      },
      child: Text(
        text,
        key: ValueKey(valueKey),
        style: style,
      ),
    );
  }
}

/// **Widget for the page indicator dots**
class _PageIndicator extends StatelessWidget {
  final PageController pageController;
  final int itemCount;

  const _PageIndicator({
    required this.pageController,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        final double page = pageController.hasClients
            ? (pageController.page ?? pageController.initialPage.toDouble())
            : 0.0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(itemCount, (index) {
            final double diff = (page - index).abs().clamp(0.0, 1.0);
            final double size = 8 + (1 - diff) * 4;
            final double opacity = 0.3 + (1 - diff) * 0.7;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:opacity),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}
