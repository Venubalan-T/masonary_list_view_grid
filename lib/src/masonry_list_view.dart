import 'dart:async';

import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class MasonryGrid extends StatefulWidget {
  const MasonryGrid({
    required this.column,
    required this.children,
    this.mainAxisGap = 8.0,
    this.crossAxisGap = 8.0,
    this.padding = const EdgeInsets.all(0),
    this.scrollToTopIcon = const Icon(Icons.keyboard_arrow_up),
    this.scrollToTopBgColor = const Color(0xff0F4AA3),
    super.key,
  });

  final int column;
  final List<Widget> children;
  final double mainAxisGap;
  final double crossAxisGap;
  final EdgeInsets padding;
  final Icon scrollToTopIcon;
  final Color scrollToTopBgColor;

  @override
  State<MasonryGrid> createState() => _MasonryGridState();
}

class _MasonryGridState extends State<MasonryGrid> {
  late LinkedScrollControllerGroup _controllers;
  late List<ScrollController> _scrollControllers;

  late List<double> sizedBoxHeights;
  late VoidCallback _scrollCallbackFunction;

  bool isShowScrollToTop = false;

  @override
  void initState() {
    super.initState();

    _controllers = LinkedScrollControllerGroup();

    sizedBoxHeights = List.generate(widget.column, (_) => 0);

    _scrollControllers = List.generate(
      widget.column,
      (_) => _controllers.addAndGet(),
    );

    _scrollCallbackFunction = throttle(() {
      checkScrollToTopNeeded();
      setSizedBoxHeights();
    }, 500);

    //Scroll listener
    _controllers.addOffsetChangedListener(_scrollCallbackFunction);
  }

  @override
  void dispose() {
    _controllers.removeOffsetChangedListener(_scrollCallbackFunction);
    for (var scrollController in _scrollControllers) {
      scrollController.dispose();
    }

    super.dispose();
  }

  VoidCallback throttle(Function cb, int milliSeconds) {
    bool shouldWait = false;
    bool isWaiting = false;
    void timerFunction() {
      Timer(
        Duration(milliseconds: milliSeconds),
        () {
          if (isWaiting) {
            cb();
            isWaiting = false;
            timerFunction();
          } else {
            shouldWait = false;
          }
        },
      );
    }

    return () {
      if (shouldWait) {
        isWaiting = true;
        return;
      }

      cb();
      shouldWait = true;

      timerFunction();
    };
  }

  void checkScrollToTopNeeded() {
    setState(() {
      isShowScrollToTop = _scrollControllers[0].offset > 500;
    });
  }

  void setSizedBoxHeights() {
    if (_scrollControllers.every((element) =>
        _scrollControllers[0].position.maxScrollExtent ==
        element.position.maxScrollExtent)) {
      return;
    }

    bool isReachedEnd = false;
    double overallMaxOffset = 0;

    for (int index = 0; index < _scrollControllers.length; index++) {
      double currentMaxExtend =
          _scrollControllers[index].position.maxScrollExtent;

      if (currentMaxExtend - sizedBoxHeights[index] > overallMaxOffset) {
        overallMaxOffset = currentMaxExtend - sizedBoxHeights[index];
      }

      if (_controllers.offset >= currentMaxExtend) isReachedEnd = true;
    }

    if (isReachedEnd) {
      List<double>? newSizedBoxHeights;
      for (int index = 0; index < _scrollControllers.length; index++) {
        double currentMaxExtend =
            _scrollControllers[index].position.maxScrollExtent;

        double neededHeight =
            overallMaxOffset - (currentMaxExtend - sizedBoxHeights[index]);

        if (neededHeight > 0) {
          newSizedBoxHeights ??= List.generate(widget.column, (index) => 0);
          newSizedBoxHeights[index] = neededHeight;
        }
      }

      if (newSizedBoxHeights != null) {
        setState(() {
          sizedBoxHeights = newSizedBoxHeights!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.padding.left,
        right: widget.padding.right,
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.column,
              (rowChildIndex) => Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  cacheExtent: 50,
                  controller: _scrollControllers[rowChildIndex],
                  itemCount: (widget.children.length % widget.column <
                              rowChildIndex
                          ? (widget.children.length / widget.column).ceil()
                          : (widget.children.length / widget.column).floor()) +
                      1,
                  itemBuilder: (BuildContext context, int columnChildIndex) {
                    int maxLength = (widget.children.length % widget.column <
                                rowChildIndex
                            ? (widget.children.length / widget.column).ceil()
                            : (widget.children.length / widget.column)
                                .floor()) +
                        1;

                    //Adds sizedBox to match scroll height of all columns
                    if (columnChildIndex == maxLength - 1) {
                      return SizedBox(
                        height: sizedBoxHeights[rowChildIndex] +
                            widget.padding.bottom,
                      );
                    }

                    return Container(
                      margin: EdgeInsets.only(
                        top: columnChildIndex == 0 ? widget.padding.top : 0,
                        right: rowChildIndex < widget.column - 1
                            ? widget.mainAxisGap / 2
                            : 0,
                        left: rowChildIndex > 0 ? widget.mainAxisGap / 2 : 0,
                      ),
                      child: widget.children[
                          (columnChildIndex * widget.column) + rowChildIndex],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: widget.crossAxisGap,
                  ),
                ),
              ),
            ),
          ),
          if (isShowScrollToTop)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.square(0),
                  padding: const EdgeInsets.all(8),
                  backgroundColor: widget.scrollToTopBgColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  _controllers.animateTo(
                    0,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 1000),
                  );
                },
                child: widget.scrollToTopIcon,
              ),
            ),
        ],
      ),
    );
  }
}
