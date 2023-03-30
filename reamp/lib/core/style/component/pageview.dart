import 'package:flutter/material.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/core/style/component/container.dart';

class ContentBoxPageView extends StatefulWidget {
  final List<Widget> pages;
  final double? height;
  final Function(int) onPageChanged;
  final PageController controller;

  ContentBoxPageView({ Key? key, required this.pages, this.height, Function(int)? onPageChanged, PageController? controller })
    : onPageChanged = onPageChanged ?? ((_) {}),
      controller = controller ?? PageController(viewportFraction: 0.8),
      super(key: key);

  @override
  State<ContentBoxPageView> createState() => _ContentBoxPageViewState();
}

class _ContentBoxPageViewState extends State<ContentBoxPageView> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height ?? MediaQuery.of(context).size.height/3,
          child: PageView(
            controller: widget.controller,
            onPageChanged: (page) {
              widget.onPageChanged(page);
              setState(() => selected = page);
            },
            children: widget.pages.map((t) => ContentBox(
              child: t,
              margin: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            )).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PageViewPageDots(
            selected: selected,
            pages: widget.pages.length,
          ),
        ),
      ],
    );
  }
}

class PageViewPageDots extends StatelessWidget {
  final int selected;
  final int pages;

  const PageViewPageDots({ Key? key, required this.selected, required this.pages }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < pages; i++) AnimatedContainer(
          decoration: BoxDecoration(
            color: selected == i ? ReampColors.primary : ReampColors.primaryAccent,
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          duration: const Duration(milliseconds: 250),
          height: 16,
          width: 16,
        ),
      ],
    );
  }
}
