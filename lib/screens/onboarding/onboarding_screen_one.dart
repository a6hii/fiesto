import 'dart:math';

import 'package:fiesto/constants.dart';
import 'package:fiesto/screens/login_screen.dart';
import 'package:fiesto/screens/onboarding/pages/first/first_page_images.dart';
import 'package:fiesto/screens/onboarding/pages/first/first_page_text.dart';
import 'package:fiesto/screens/onboarding/pages/onboarding_page.dart';
import 'package:fiesto/screens/onboarding/pages/second/second_page_images.dart';
import 'package:fiesto/screens/onboarding/pages/second/second_page_text.dart';
import 'package:fiesto/screens/onboarding/pages/third/third_page_images.dart';
import 'package:fiesto/screens/onboarding/pages/third/third_page_text.dart';
import 'package:fiesto/widgets/onboarding/back_page_button.dart';
import 'package:fiesto/widgets/onboarding/page_indicators.dart';
import 'package:fiesto/widgets/onboarding/ripple.dart';
import 'package:flutter/material.dart';

import '../../widgets/onboarding/next_page_button.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'onboard-screen';
  final double screenHeight;
  const OnBoardingScreen({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _cardsAnimationController;
  late final AnimationController _pageIndicatorAnimationController;
  late final AnimationController _rippleAnimationController;

  //late Animation<Offset> _slideAnimationLightCard;
  late Animation<Offset> _slideAnimationDarkCard;
  late Animation<double> _pageIndicatorAnimation;
  late Animation<double> _rippleAnimation;

  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _cardsAnimationController = AnimationController(
      vsync: this,
      duration: kCardAnimationDuration,
    );
    _pageIndicatorAnimationController = AnimationController(
      vsync: this,
      duration: kButtonAnimationDuration,
    );

    _rippleAnimationController = AnimationController(
      vsync: this,
      duration: kRippleAnimationDuration,
    );

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: widget.screenHeight * 2,
    ).animate(CurvedAnimation(
      parent: _rippleAnimationController,
      curve: Curves.easeIn,
    ));

    _setPageIndicatorAnimation();
    _setCardsSlideOutAnimation();
  }

  @override
  void dispose() {
    _cardsAnimationController.dispose();
    _pageIndicatorAnimationController.dispose();
    _rippleAnimationController.dispose();
    super.dispose();
  }

  bool get isFirstPage => _currentPage == 1;

  Widget _getPage() {
    switch (_currentPage) {
      case 1:
        return OnboardingPage(
          number: 1,
          darkCardChild: const CreateCard(),
          //lightCardOffsetAnimation: _slideAnimationLightCard,
          darkCardOffsetAnimation: _slideAnimationDarkCard,
          textColumn: const CreateCardText(),
        );
      case 2:
        return OnboardingPage(
          number: 2,
          darkCardChild: const OwnCard(),
          //lightCardOffsetAnimation: _slideAnimationLightCard,
          darkCardOffsetAnimation: _slideAnimationDarkCard,
          textColumn: const OwnCardText(),
        );
      case 3:
        return OnboardingPage(
          number: 3,
          darkCardChild: const NotificationCard(),
          //lightCardOffsetAnimation: _slideAnimationLightCard,
          darkCardOffsetAnimation: _slideAnimationDarkCard,
          textColumn: const NotificationText(),
        );
      default:
        throw Exception("Page with number '$_currentPage' does not exist.");
    }
  }

  void _setCardsSlideInAnimation() {
    setState(() {
      // _slideAnimationLightCard = Tween<Offset>(
      //   begin: const Offset(3.0, 0.0),
      //   end: Offset.zero,
      // ).animate(CurvedAnimation(
      //   parent: _cardsAnimationController,
      //   curve: Curves.easeOut,
      // ));
      _slideAnimationDarkCard = Tween<Offset>(
        begin: const Offset(1.5, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeOut,
      ));
      _cardsAnimationController.reset();
    });
  }

  void _setCardsSlideOutAnimation() {
    setState(() {
      // _slideAnimationLightCard = Tween<Offset>(
      //   begin: Offset.zero,
      //   end: const Offset(-3.0, 0.0),
      // ).animate(CurvedAnimation(
      //   parent: _cardsAnimationController,
      //   curve: Curves.easeIn,
      // ));
      _slideAnimationDarkCard = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-3, 0.0),
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Curves.easeIn,
      ));
      _cardsAnimationController.reset();
    });
  }

  void _setPageIndicatorAnimation({bool isClockwiseAnimation = true}) {
    final multiplicator = isClockwiseAnimation ? 2 : -2;

    setState(() {
      _pageIndicatorAnimation = Tween(
        begin: 0.0,
        end: multiplicator * pi,
      ).animate(
        CurvedAnimation(
          parent: _pageIndicatorAnimationController,
          curve: Curves.easeIn,
        ),
      );
      _pageIndicatorAnimationController.reset();
    });
  }

  void _setNextPage(int nextPageNumber) {
    setState(() {
      _currentPage = nextPageNumber;
    });
  }

  void _setBackPage(int backPageNumber) {
    setState(() {
      _currentPage = backPageNumber;
    });
  }

  Future<void> _nextPage() async {
    switch (_currentPage) {
      case 1:
        if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
          _pageIndicatorAnimationController.forward();
          await _cardsAnimationController.forward();
          _setNextPage(2);
          _setCardsSlideInAnimation();
          await _cardsAnimationController.forward();
          _setCardsSlideOutAnimation();
          _setPageIndicatorAnimation(isClockwiseAnimation: false);
        }
        break;
      case 2:
        if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
          _pageIndicatorAnimationController.forward();
          await _cardsAnimationController.forward();
          _setNextPage(3);
          _setCardsSlideInAnimation();
          await _cardsAnimationController.forward();
          _setCardsSlideOutAnimation();
          //_setPageIndicatorAnimation(isClockwiseAnimation: false);
        }
        break;
      case 3:
        if (_pageIndicatorAnimation.status == AnimationStatus.completed) {
          await _rippleAnimationController.forward();
          await _goToLogin();
        }
        break;
    }
  }

  Future<void> _goToLogin() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  Future<void> _backPage() async {
    switch (_currentPage) {
      case 2:
        if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
          _pageIndicatorAnimationController.forward();
          await _cardsAnimationController.animateBack(1.0);
          _setBackPage(1);
          _setCardsSlideInAnimation();

          await _cardsAnimationController.animateBack(1.0);
          _setCardsSlideOutAnimation();
          _setPageIndicatorAnimation(isClockwiseAnimation: true);
        }
        break;
      case 3:
        if (_pageIndicatorAnimation.status != AnimationStatus.dismissed) {
          _pageIndicatorAnimationController.reverse();
          await _cardsAnimationController.forward();
          _setBackPage(2);
          _setCardsSlideInAnimation();
          await _cardsAnimationController.forward();
          _setCardsSlideOutAnimation();
          //_setPageIndicatorAnimation(isClockwiseAnimation: false);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                // Header(onSkip: _goToLogin),
                Expanded(child: _getPage()),
                BackPage(
                  onPressed: _backPage,
                  currentPage: _currentPage,
                ),
                AnimatedBuilder(
                  animation: _pageIndicatorAnimation,
                  builder: (_, Widget? child) {
                    return OnboardingPageIndicator(
                      angle: _pageIndicatorAnimation.value,
                      currentPage: _currentPage,
                      child: child!,
                    );
                  },
                  child: NextPageButton(
                    onPressed: _nextPage,
                    currentPage: _currentPage,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _rippleAnimation,
          builder: (_, Widget? child) {
            return Ripple(radius: _rippleAnimation.value);
          },
        ),
      ]),
    );
  }
}
