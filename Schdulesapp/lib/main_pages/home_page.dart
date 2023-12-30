import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snake_button/snake_button.dart';

import '../utils/r.dart';
import '../widgets/fade_in_out_widget/fade_in_out_widget.dart';
import '../widgets/fade_in_out_widget/fade_in_out_widget_controller.dart';
import '../widgets/fading_item_list/fading_item_list_controller.dart';
import 'add_flight_page_controller.dart';
import 'add_flight_page.dart';
import 'my_flights_list_page.dart';

enum MainPageEnum { myFlights, addFlight }

class HomePage extends StatefulWidget {
  final Animation routeTransitionValue;

  const HomePage({
    super.key,
    required this.routeTransitionValue,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _sheetAnimationController;
  late final SnakeButtonController _snakeButtonController;
  late final FadingItemListController _fadingItemListController;
  late final AddFlightPageController _addFlightPageController;
  late final FadeInOutWidgetController _sheetContentFadeInOutController;
  late final FadeInOutWidgetController _headerFadeInOutController;
  late final ValueNotifier<MainPageEnum> _currentMainPage;
  late final Map<MainPageEnum, Widget> pages;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _snakeButtonController = SnakeButtonController();
    _fadingItemListController = FadingItemListController();
    _sheetContentFadeInOutController = FadeInOutWidgetController();
    _headerFadeInOutController = FadeInOutWidgetController();
    _sheetAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );

    _sheetAnimationController.forward().whenComplete(
      () {
        _headerFadeInOutController.show();
        _fadingItemListController.showItems();
        _snakeButtonController.toggle();
      },
    );

    _currentMainPage = ValueNotifier(MainPageEnum.myFlights);
    _addFlightPageController = AddFlightPageController();

    pages = {
      MainPageEnum.myFlights: MyFlightsListPage(
        /// 메인화면 스케쥴 리스트
        fadingItemListController: _fadingItemListController,
      ),
      MainPageEnum.addFlight: AddFlightPage(
        addFlightPageController: _addFlightPageController,
      ),
    };
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildFloatingButton(), // Your existing FloatingActionButton
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: _buildHeader,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: FadeInOutWidget(
                  initialVisibilityValue: false,
                  slideDuration: const Duration(milliseconds: 500),
                  fadeInOutWidgetController: _headerFadeInOutController,
                  child: ValueListenableBuilder<MainPageEnum>(
                    valueListenable: _currentMainPage,
                    builder: (_, value, __) => _isMyFlightsPage
                        ? _myFlightsTextWidget
                        : _addFlightTextWidget,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              AnimatedBuilder(
                animation: _sheetAnimationController,
                builder: (context, child) => Container(
                  height: (1 - _sheetAnimationController.value) * 600,
                ),
              ),
              Flexible(
                child: _buildBottomSheet,
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      );

  Text get _myFlightsTextWidget => Text(
        "My flights",
        style: TextStyle(
          color: R.primaryColor,
          fontSize: 30.0,
          fontWeight: FontWeight.w600,
        ),
      );

  Text get _addFlightTextWidget => Text(
        "Add flight",
        style: TextStyle(
          color: R.primaryColor,
          fontSize: 30.0,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget get _buildHeader => AnimatedBuilder(
        animation: widget.routeTransitionValue,
        builder: (context, child) => Opacity(
          opacity: 1.0 * widget.routeTransitionValue.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle menu icon tap
                },
                child: Icon(
                  Icons.menu,
                  color: R.primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {homeButton();},
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: R.primaryColor,
                  ),
                  child: Icon(
                    Icons.home,
                    color: R.secondaryColor,
                    size: 40.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get _buildBottomSheet => Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: R.primaryColor,

          /// 배경색
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20), bottom: Radius.circular(20)),
        ),
        child: FadeInOutWidget(
          slideDuration: const Duration(milliseconds: 500),
          slideEndingOffset: const Offset(0, 0.1),
          fadeInOutWidgetController: _sheetContentFadeInOutController,
          child: ValueListenableBuilder<MainPageEnum>(
            valueListenable: _currentMainPage,
            builder: (_, value, __) => pages[value]!,
          ),
        ),
      );

  Widget _buildFloatingButton() {
    final elevatedButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: R.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: () => _onMainButtonClick(),
      child: ValueListenableBuilder<MainPageEnum>(
        valueListenable: _currentMainPage,
        builder: (_, value, __) => Align(
          child: Icon(
            value == MainPageEnum.myFlights
                ? Icons.add
                : Icons.arrow_forward_ios,
            color: R.primaryColor,
          ),
        ),
      ),
    );

    return SnakeButton(
      controller: _snakeButtonController,
      snakeAnimationDuration: const Duration(milliseconds: 500),
      snakeColor: R.secondaryColor,
      snakeWidth: 2.0,
      borderRadius: 20.0,
      child: SizedBox(
        height: 50,
        width: 50,
        child: elevatedButton,
      ),
    );
  }

  void homeButton() {
      _sheetContentFadeInOutController.hide();
      _headerFadeInOutController.hide();
      Future.delayed(const Duration(milliseconds: 500), () {
        _currentMainPage.value = MainPageEnum.myFlights;
      }).whenComplete(() {
        _sheetContentFadeInOutController.show();
        _headerFadeInOutController.show();
      });
      //_addFlightPageController.nextTab();
  }

  void _onMainButtonClick() {
    //_snakeButtonController.hide(from: 0.3);
    if (_isMyFlightsPage) {
      _sheetContentFadeInOutController.hide();
      _headerFadeInOutController.hide();

      Future.delayed(const Duration(milliseconds: 500), () {
        _currentMainPage.value = MainPageEnum.addFlight;
      }).whenComplete(() {
        _sheetContentFadeInOutController.show();
        _headerFadeInOutController.show();
      });
    } else {
      _addFlightPageController.nextTab();
    }
  }

  bool get _isMyFlightsPage => _currentMainPage.value == MainPageEnum.myFlights;
}
