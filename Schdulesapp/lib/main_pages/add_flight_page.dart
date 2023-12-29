
import 'package:flutter/material.dart';

import '../sub_pages/available_flights_page.dart';
import '../sub_pages/checkout_page.dart';
import '../sub_pages/route_selection_page.dart';
import '../sub_pages/seat_selection_page.dart';
import '../widgets/custom_tab_bar/custom_tab_bar.dart';
import '../widgets/custom_tab_bar/custom_tab_bar_controller.dart';
import '../widgets/fade_in_out_widget/fade_in_out_widget.dart';
import '../widgets/fade_in_out_widget/fade_in_out_widget_controller.dart';
import 'add_flight_page_controller.dart';

class AddFlightPage extends StatefulWidget {
  final AddFlightPageController addFlightPageController;
  final Function(bool)? isSingleTabSelectionCompleted;
  const AddFlightPage({
    super.key,
    required this.isSingleTabSelectionCompleted,
    required this.addFlightPageController,
  });

  @override
  State<AddFlightPage> createState() => _AddFlightPageState();
}

class _AddFlightPageState extends State<AddFlightPage> {
  late final List<Widget> _pages;
  late final ValueNotifier<int> _pageNotifier;
  late final CustomTabBarController _customTabBarController;
  late final FadeInOutWidgetController _fadeInOutWidgetController;

  @override
  void initState() {
    super.initState();
    _fadeInOutWidgetController = FadeInOutWidgetController();

    _pages = [
      AvailableFlightsPage(
        isSelectionCompleted: (isCompleted, flight) {
          widget.isSingleTabSelectionCompleted?.call(isCompleted);
          _pages.add(
            SeatSelectionPage(
              isSelectionCompleted: (isCompleted, flight) {
                widget.isSingleTabSelectionCompleted?.call(isCompleted);
                _pages.add(
                  CheckoutPage(
                    flightData: flight,
                    isSelectionCompleted: (isCompleted) =>
                        widget.isSingleTabSelectionCompleted?.call(isCompleted),
                  ),
                );
              },
            ),
          );
        },
      ),
    ];

    _pageNotifier = ValueNotifier(0);
    _customTabBarController = CustomTabBarController();

    widget.addFlightPageController.customTabBarController =
        _customTabBarController;
    widget.addFlightPageController.pageNotifier = _pageNotifier;
    widget.addFlightPageController.fadeInOutWidgetController =
        _fadeInOutWidgetController;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            CustomTabBar(
              customTabBarController:
                  widget.addFlightPageController.customTabBarController,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: FadeInOutWidget(
                slideDuration: const Duration(milliseconds: 500),
                slideEndingOffset: const Offset(0, 0.04),
                fadeInOutWidgetController: _fadeInOutWidgetController,
                child: ValueListenableBuilder(
                  valueListenable: widget.addFlightPageController.pageNotifier,
                  builder: (_, value, __) => _pages[value],
                ),
              ),
            ),
          ],
        ),
      );
}
