import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../data/models/progress_models.dart';
import '../cubit/progress_cubit.dart';
import 'measurement_progress_card.dart';

// class MeasurementCardSwitcher extends StatefulWidget {
//   final MeasurementCardsResponse cards;
//   final MeasurementCardType selectedType;
//
//   const MeasurementCardSwitcher({
//     super.key,
//     required this.cards,
//     required this.selectedType,
//   });
//
//   @override
//   State<MeasurementCardSwitcher> createState() =>
//       _MeasurementCardSwitcherState();
// }
//
// class _MeasurementCardSwitcherState extends State<MeasurementCardSwitcher> {
//   late PageController _pageController;
//   late int _currentPage;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentPage = widget.selectedType.index;
//     _pageController = PageController(
//       initialPage: _currentPage,
//       viewportFraction: 0.92, // Shows slight preview of adjacent cards
//     );
//   }
//
//   @override
//   void didUpdateWidget(MeasurementCardSwitcher oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selectedType != widget.selectedType) {
//       _pageController.animateToPage(
//         widget.selectedType.index,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeOutCubic,
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildPageIndicator(),
//         SizedBox(height: 12.h),
//         _buildPageView(),
//       ],
//     );
//   }
//
//   Widget _buildPageIndicator() {
//     return Container(
//       padding: EdgeInsets.all(4.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: )(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: MeasurementCardType.values.map((type) {
//           return _buildIndicatorChip(type);
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildIndicatorChip(MeasurementCardType type) {
//     final isSelected = widget.selectedType == type;
//     final labels = ['Weight', 'Body Fat', 'Muscle'];
//     final icons = [
//       Icons.monitor_weight_outlined,
//       Icons.water_drop_outlined,
//       Icons.fitness_center_outlined,
//     ];
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           context.read<ProgressCubit>().switchCardType(type);
//           _pageController.animateToPage(
//             type.index,
//             duration: const Duration(milliseconds: 400),
//             curve: Curves.easeOutCubic,
//           );
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           curve: Curves.easeInOut,
//           margin: EdgeInsets.symmetric(horizontal: 2.w),
//           padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
//           decoration: BoxDecoration(
//             gradient: isSelected ? ColorsManager.primaryGradient : null,
//             color: isSelected ? null : Colors.transparent,
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 icons[type.index],
//                 size: 16.sp,
//                 color: isSelected
//                     ? ColorsManager.whiteText
//                     : ColorsManager.secondaryText,
//               ),
//               SizedBox(width: 4.w),
//               Flexible(
//                 child: Text(
//                   labels[type.index],
//                   style: TextStyles.caption.copyWith(
//                     fontSize: 11.sp,
//                     color: isSelected
//                         ? ColorsManager.whiteText
//                         : ColorsManager.secondaryText,
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPageView() {
//     return SizedBox(
//       height: 180.h, // Adjust based on your card height
//       child: PageView.builder(
//         controller: _pageController,
//         onPageChanged: (index) {
//           final type = MeasurementCardType.values[index];
//           context.read<ProgressCubit>().switchCardType(type);
//         },
//         itemCount: MeasurementCardType.values.length,
//         itemBuilder: (context, index) {
//           final type = MeasurementCardType.values[index];
//           return AnimatedBuilder(
//             animation: _pageController,
//             builder: (context, child) {
//               double value = 1.0;
//               if (_pageController.position.haveDimensions) {
//                 value = _pageController.page! - index;
//                 value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
//               }
//
//               return Center(
//                 child: Transform.scale(
//                   scale: value,
//                   child: Opacity(opacity: value, child: child),
//                 ),
//               );
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.w),
//               child: MeasurementProgressCard(
//                 cards: widget.cards,
//                 type: type,
//                 key: ValueKey(type),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:async';

// class MeasurementCardSwitcher extends StatefulWidget {
//   final MeasurementCardsResponse cards;
//   final MeasurementCardType selectedType;
//
//   const MeasurementCardSwitcher({
//     super.key,
//     required this.cards,
//     required this.selectedType,
//   });
//
//   @override
//   State<MeasurementCardSwitcher> createState() =>
//       _MeasurementCardSwitcherState();
// }
//
// class _MeasurementCardSwitcherState extends State<MeasurementCardSwitcher> {
//   late PageController _pageController;
//   int _currentPage = 0;
//   Timer? _autoScrollTimer;
//   bool _isAutoScrolling = false; // ✅ Track if auto-scrolling
//
//   static const Duration _autoScrollDuration = Duration(seconds: 1);
//   static const Duration _scrollAnimationDuration = Duration(milliseconds: 600);
//
//   @override
//   void initState() {
//     super.initState();
//     _currentPage = widget.selectedType.index;
//     _pageController = PageController(
//       initialPage: _currentPage,
//       viewportFraction: 0.92,
//     );
//
//     _startAutoScroll();
//   }
//
//   @override
//   void didUpdateWidget(MeasurementCardSwitcher oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selectedType != widget.selectedType) {
//       setState(() {
//         _currentPage = widget.selectedType.index;
//       });
//
//       _pageController.animateToPage(
//         widget.selectedType.index,
//         duration: _scrollAnimationDuration,
//         curve: Curves.easeOutCubic,
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     _stopAutoScroll();
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   void _startAutoScroll() {
//     _autoScrollTimer = Timer.periodic(_autoScrollDuration, (timer) {
//       if (_pageController.hasClients && mounted) {
//         _isAutoScrolling = true; // ✅ Mark as auto-scrolling
//
//         final nextPage = (_currentPage + 1) % 3;
//
//         debugPrint('🎠 Auto-scrolling from page $_currentPage to $nextPage');
//
//         _pageController
//             .animateToPage(
//               nextPage,
//               duration: _scrollAnimationDuration,
//               curve: Curves.easeInOut,
//             )
//             .then((_) {
//               // ✅ Reset flag after animation completes
//               _isAutoScrolling = false;
//             });
//       }
//     });
//   }
//
//   void _stopAutoScroll() {
//     _autoScrollTimer?.cancel();
//     _autoScrollTimer = null;
//   }
//
//   void _resetAutoScroll() {
//     _stopAutoScroll();
//     _startAutoScroll();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildPageIndicator(),
//         SizedBox(height: 12.h),
//         _buildPageView(),
//       ],
//     );
//   }
//
//   Widget _buildPageIndicator() {
//     return Container(
//       padding: EdgeInsets.all(4.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: )(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: MeasurementCardType.values.map((type) {
//           return _buildIndicatorChip(type);
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildIndicatorChip(MeasurementCardType type) {
//     final isSelected = widget.selectedType == type;
//     final labels = ['Weight', 'Body Fat', 'Muscle'];
//     final icons = [
//       Icons.monitor_weight_outlined,
//       Icons.water_drop_outlined,
//       Icons.fitness_center_outlined,
//     ];
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           // ✅ Only reset when user manually taps
//           _resetAutoScroll();
//
//           context.read<ProgressCubit>().switchCardType(type);
//
//           setState(() {
//             _currentPage = type.index;
//           });
//
//           _pageController.animateToPage(
//             type.index,
//             duration: _scrollAnimationDuration,
//             curve: Curves.easeOutCubic,
//           );
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           curve: Curves.easeInOut,
//           margin: EdgeInsets.symmetric(horizontal: 2.w),
//           padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
//           decoration: BoxDecoration(
//             gradient: isSelected ? ColorsManager.primaryGradient : null,
//             color: isSelected ? null : Colors.transparent,
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 icons[type.index],
//                 size: 16.sp,
//                 color: isSelected
//                     ? ColorsManager.whiteText
//                     : ColorsManager.secondaryText,
//               ),
//               SizedBox(width: 4.w),
//               Flexible(
//                 child: Text(
//                   labels[type.index],
//                   style: TextStyles.caption.copyWith(
//                     fontSize: 11.sp,
//                     color: isSelected
//                         ? ColorsManager.whiteText
//                         : ColorsManager.secondaryText,
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPageView() {
//     return SizedBox(
//       height: 180.h,
//       child: PageView.builder(
//         controller: _pageController,
//         onPageChanged: (index) {
//           debugPrint(
//             '📄 Page changed to: $index (isAutoScrolling: $_isAutoScrolling)',
//           );
//
//           setState(() {
//             _currentPage = index;
//           });
//
//           final type = MeasurementCardType.values[index];
//           context.read<ProgressCubit>().switchCardType(type);
//
//           // ✅ Only reset timer if user manually swiped (not auto-scrolling)
//           if (!_isAutoScrolling) {
//             debugPrint('👆 Manual swipe detected - resetting timer');
//             _resetAutoScroll();
//           }
//         },
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           final type = MeasurementCardType.values[index];
//           return AnimatedBuilder(
//             animation: _pageController,
//             builder: (context, child) {
//               double value = 1.0;
//               if (_pageController.position.haveDimensions) {
//                 value = _pageController.page! - index;
//                 value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
//               }
//
//               return Center(
//                 child: Transform.scale(
//                   scale: value,
//                   child: Opacity(opacity: value, child: child),
//                 ),
//               );
//             },
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.w),
//               child: MeasurementProgressCard(
//                 cards: widget.cards,
//                 type: type,
//                 key: ValueKey(type),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';

// class MeasurementCardSwitcher extends StatefulWidget {
//   final MeasurementCardsResponse cards;
//   final MeasurementCardType selectedType;
//
//   const MeasurementCardSwitcher({
//     super.key,
//     required this.cards,
//     required this.selectedType,
//   });
//
//   @override
//   State<MeasurementCardSwitcher> createState() =>
//       _MeasurementCardSwitcherState();
// }
//
// class _MeasurementCardSwitcherState extends State<MeasurementCardSwitcher> {
//   late CarouselSliderController _carouselController; // ✅ Changed type
//   int _currentPage = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _carouselController = CarouselSliderController(); // ✅ Changed type
//     _currentPage = widget.selectedType.index;
//   }
//
//   @override
//   void didUpdateWidget(MeasurementCardSwitcher oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.selectedType != widget.selectedType) {
//       setState(() {
//         _currentPage = widget.selectedType.index;
//       });
//       // ✅ Updated method call with required parameters
//       _carouselController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 400),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildPageIndicator(),
//         SizedBox(height: 12.h),
//         _buildCarousel(),
//       ],
//     );
//   }
//
//   Widget _buildPageIndicator() {
//     return Container(
//       padding: EdgeInsets.all(4.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: )(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: MeasurementCardType.values.map((type) {
//           return _buildIndicatorChip(type);
//         }).toList(),
//       ),
//     );
//   }
//
//   Widget _buildIndicatorChip(MeasurementCardType type) {
//     final isSelected = _currentPage == type.index;
//     final labels = ['Weight', 'Body Fat', 'Muscle'];
//     final icons = [
//       Icons.monitor_weight_outlined,
//       Icons.water_drop_outlined,
//       Icons.fitness_center_outlined,
//     ];
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _currentPage = type.index;
//           });
//           context.read<ProgressCubit>().switchCardType(type);
//
//           // ✅ Updated method call with required parameters
//           _carouselController.animateToPage(
//             type.index,
//             duration: const Duration(milliseconds: 400),
//             curve: Curves.easeInOut,
//           );
//         },
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 250),
//           curve: Curves.easeInOut,
//           margin: EdgeInsets.symmetric(horizontal: 2.w),
//           padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
//           decoration: BoxDecoration(
//             gradient: isSelected ? ColorsManager.primaryGradient : null,
//             color: isSelected ? null : Colors.transparent,
//             borderRadius: BorderRadius.circular(10.r),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 icons[type.index],
//                 size: 16.sp,
//                 color: isSelected
//                     ? ColorsManager.whiteText
//                     : ColorsManager.secondaryText,
//               ),
//               SizedBox(width: 4.w),
//               Flexible(
//                 child: Text(
//                   labels[type.index],
//                   style: TextStyles.caption.copyWith(
//                     fontSize: 11.sp,
//                     color: isSelected
//                         ? ColorsManager.whiteText
//                         : ColorsManager.secondaryText,
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCarousel() {
//     final items = [
//       MeasurementProgressCard(
//         cards: widget.cards,
//         type: MeasurementCardType.weight,
//         key: const ValueKey('weight'),
//       ),
//       MeasurementProgressCard(
//         cards: widget.cards,
//         type: MeasurementCardType.bodyFat,
//         key: const ValueKey('bodyFat'),
//       ),
//       MeasurementProgressCard(
//         cards: widget.cards,
//         type: MeasurementCardType.muscleMass,
//         key: const ValueKey('muscleMass'),
//       ),
//     ];
//
//     return CarouselSlider(
//       carouselController: _carouselController, // ✅ Now correct type
//       items: items,
//       options: CarouselOptions(
//         height: 180.h,
//         viewportFraction: 0.82,
//         enlargeCenterPage: true,
//         enlargeFactor: 0.15,
//         enableInfiniteScroll: true,
//         autoPlay: true,
//         autoPlayInterval: const Duration(seconds: 5),
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         autoPlayCurve: Curves.easeInOut,
//         pauseAutoPlayOnTouch: true,
//         onPageChanged: (index, reason) {
//           debugPrint('🎠 Page: $index, Reason: $reason');
//
//           setState(() {
//             _currentPage = index;
//           });
//
//           final type = MeasurementCardType.values[index];
//           context.read<ProgressCubit>().switchCardType(type);
//         },
//         initialPage: _currentPage,
//       ),
//     );
//   }
// }

class MeasurementCardSwitcher extends StatefulWidget {
  final MeasurementCardsResponse cards;
  final MeasurementCardType selectedType;

  const MeasurementCardSwitcher({
    super.key,
    required this.cards,
    required this.selectedType,
  });

  @override
  State<MeasurementCardSwitcher> createState() =>
      _MeasurementCardSwitcherState();
}

class _MeasurementCardSwitcherState extends State<MeasurementCardSwitcher> {
  late CarouselSliderController _carouselController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselSliderController();
    _currentPage = widget.selectedType.index;
  }

  @override
  void didUpdateWidget(MeasurementCardSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedType != widget.selectedType) {
      setState(() {
        _currentPage = widget.selectedType.index;
      });
      _carouselController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPageIndicator(),
        SizedBox(height: 12.h),
        _buildCarousel(),
      ],
    );
  }

  Widget _buildPageIndicator() {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: MeasurementCardType.values.map((type) {
          return _buildIndicatorChip(type, s);
        }).toList(),
      ),
    );
  }

  Widget _buildIndicatorChip(MeasurementCardType type, S s) {
    final isSelected = _currentPage == type.index;

    // ✅ Use localized labels
    final labels = [s.weight, s.body_fat, s.muscle_mass];
    final icons = [
      Icons.monitor_weight_outlined,
      Icons.water_drop_outlined,
      Icons.fitness_center_outlined,
    ];

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentPage = type.index;
          });
          context.read<ProgressCubit>().switchCardType(type);

          _carouselController.animateToPage(
            type.index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
          decoration: BoxDecoration(
            gradient: isSelected ? ColorsManager.primaryGradient : null,
            color: isSelected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icons[type.index],
                size: 16.sp,
                color: isSelected
                    ? ColorsManager.whiteText
                    : ColorsManager.secondaryText,
              ),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  labels[type.index],
                  style: TextStyles.caption.copyWith(
                    fontSize: 11.sp,
                    color: isSelected
                        ? ColorsManager.whiteText
                        : ColorsManager.secondaryText,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    final items = [
      MeasurementProgressCard(
        cards: widget.cards,
        type: MeasurementCardType.weight,
        key: const ValueKey('weight'),
      ),
      MeasurementProgressCard(
        cards: widget.cards,
        type: MeasurementCardType.bodyFat,
        key: const ValueKey('bodyFat'),
      ),
      MeasurementProgressCard(
        cards: widget.cards,
        type: MeasurementCardType.muscleMass,
        key: const ValueKey('muscleMass'),
      ),
    ];

    return CarouselSlider(
      carouselController: _carouselController,
      items: items,
      options: CarouselOptions(
        height: 180.h,
        viewportFraction: 0.82,
        enlargeCenterPage: true,
        enlargeFactor: 0.15,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOut,
        pauseAutoPlayOnTouch: true,
        onPageChanged: (index, reason) {
          debugPrint('🎠 Page: $index, Reason: $reason');

          setState(() {
            _currentPage = index;
          });

          final type = MeasurementCardType.values[index];
          context.read<ProgressCubit>().switchCardType(type);
        },
        initialPage: _currentPage,
      ),
    );
  }
}
