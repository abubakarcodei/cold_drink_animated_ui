import 'dart:math';
import 'package:cold_drink_animated_ui/models/drinks.dart';
import 'package:flutter/material.dart';

class CanDetailScreen extends StatefulWidget {
  final DrinkData drink;
  const CanDetailScreen({
    super.key,
    required this.drink,
  });

  @override
  State<CanDetailScreen> createState() => _CanDetailScreenState();
}

class _CanDetailScreenState extends State<CanDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _canAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _canAnimation = Tween<double>(begin: -50, end: -30).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _buttonScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _buttonScaleAnimation.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    // Add to cart functionality with animation feedback
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added to cart!'),
                        backgroundColor: widget.drink.colors[0],
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.white,
                    foregroundColor: widget.drink.colors[0],
                    elevation: 8,
                    shadowColor: Colors.black38,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 20.8,
                      fontFamily: "FugazOne",
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.drink.colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Decorative elements
            ..._buildDecorativeElements(),

            // Main content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // Can image with enhanced animation
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Positioned(
                        top: _canAnimation.value,
                        child: Hero(
                          tag: 'can_${widget.drink.title}',
                          flightShuttleBuilder: (_, animation, __, ___, ____) {
                            return AnimatedBuilder(
                              animation: animation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: 1.0 + (0.1 * animation.value),
                                  child: child,
                                );
                              },
                              child: Image.asset(
                                widget.drink.image,
                                height: MediaQuery.of(context).size.height * .6,
                              ),
                            );
                          },
                          child: Image.asset(
                            widget.drink.image,
                            height: MediaQuery.of(context).size.height * .6,
                          ),
                        ),
                      );
                    },
                  ),

                  // Text content with staggered animations
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textOpacityAnimation.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .45,
                            ),
                            _buildAnimatedText(
                              widget.drink.title,
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                              delay: 0.0,
                            ),
                            _buildAnimatedText(
                              widget.drink.type,
                              TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: "FugazOne",
                              ),
                              delay: 0.1,
                            ),
                            const SizedBox(height: 15),
                            _buildPackageOptions(),
                            const SizedBox(height: 15),
                            _buildAnimatedText(
                              widget.drink.description,
                              TextStyle(
                                color: Colors.white,
                                fontFamily: "FugazOne",
                                fontSize: 14,
                                height: 1.4,
                              ),
                              delay: 0.3,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            _buildAnimatedText(
                              'read more...',
                              TextStyle(
                                color: Colors.white.withValues(alpha:0.8),
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                              ),
                              delay: 0.4,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedText(String text, TextStyle style, {double delay = 0.0, TextAlign? textAlign}) {
    final Animation<Offset> slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2 + delay,
          0.6 + delay,
          curve: Curves.easeOutCubic,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _textOpacityAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Text(
              text,
              style: style,
              textAlign: textAlign,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPackageOptions() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _textOpacityAnimation.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: widget.drink.packageOptions
                  .asMap()
                  .entries
                  .map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: _buildAnimatedText(
                        entry.value,
                        TextStyle(
                          color: Colors.white,
                          fontSize: 13.71,
                          fontWeight: FontWeight.w600,
                        ),
                        delay: 0.2 + (entry.key * 0.05),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildDecorativeElements() {
    final List<Widget> decorators = [];
    final random = Random(widget.drink.title.hashCode);

    // Only use decorative images if they exist
    if (widget.drink.decoratorImages.isNotEmpty) {
      for (int i = 0; i < 8; i++) {
        final imageIndex = i % widget.drink.decoratorImages.length;
        final double size = 40 + random.nextDouble() * 60;
        final double xPos = random.nextDouble() * MediaQuery.of(context).size.width;
        final double yPos = random.nextDouble() * MediaQuery.of(context).size.height;

        final Animation<double> rotationAnimation = Tween<double>(
          begin: 0,
          end: random.nextBool() ? 2 * pi : -2 * pi,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.1,
              0.9,
              curve: Curves.easeInOut,
            ),
          ),
        );

        final Animation<double> scaleAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              0.1 + (i * 0.05),
              0.5 + (i * 0.05),
              curve: Curves.elasticOut,
            ),
          ),
        );

        decorators.add(
          Positioned(
            left: xPos,
            top: yPos,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: rotationAnimation.value,
                  child: Transform.scale(
                    scale: scaleAnimation.value,
                    child: Opacity(
                      opacity: 0.7,
                      child: Image.asset(
                        widget.drink.decoratorImages[imageIndex],
                        width: size,
                        height: size,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    }

    return decorators;
  }
}
