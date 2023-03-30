import 'package:flutter/material.dart';
import 'package:reamp/core/config/extensions.dart';
import 'package:reamp/core/config/theme.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final EdgeInsets? margin;

  const PrimaryButton({
    required this.child,
    this.onPressed,
    this.margin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _NeumorphismButtonBase(
      idleColor: ReampColors.primary,
      idleColorBright: ReampColors.primary.withOpacity(0.5),
      activeColor: ReampColors.secondary.lighten(0.3),
      disabledColor: ReampColors.secondaryAccent,
      onPressed: onPressed,
      margin: margin,
      child: child,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final EdgeInsets? margin;

  const SecondaryButton({
    required this.child,
    this.onPressed,
    this.margin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _NeumorphismButtonBase(
      idleColor: ReampColors.background,
      idleColorBright: ReampColors.backgroundBright,
      activeColor: ReampColors.secondaryAccent,
      disabledColor: ReampColors.secondaryAccent,
      onPressed: onPressed,
      margin: margin,
      child: child,
    );
  }
}

class _NeumorphismButtonBase extends StatefulWidget {
  final Color idleColor;
  final Color idleColorBright;
  final Color activeColor;
  final Color disabledColor;
  final Widget child;
  final EdgeInsets? margin;
  final Function()? onPressed;

  const _NeumorphismButtonBase({
    required this.idleColor,
    required this.idleColorBright,
    required this.activeColor,
    required this.disabledColor,
    required this.child,
    this.onPressed,
    this.margin,
    Key? key,
  }) : super(key: key);

  @override
  __NeumorphismButtonBaseState createState() => __NeumorphismButtonBaseState();
}

class __NeumorphismButtonBaseState extends State<_NeumorphismButtonBase> {
  bool active = false;

  bool get isDisabled => widget.onPressed == null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() {
        if (isDisabled == false) {
          active = true;
        }
      }),
      onTap: () => setState(() {
        active = false;
        final callback = widget.onPressed;
        if (callback != null) {
          callback();
        }
      }),
      onTapCancel: () => setState(() => active = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isDisabled
            ? widget.disabledColor
            : active ? widget.activeColor : widget.idleColor,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: ReampColors.backgroundBright,
              blurRadius: 12.0,
              offset: const Offset(-15.0, -15.0),
            ),
            BoxShadow(
              color: ReampColors.secondaryAccent,
              blurRadius: 12.0,
              offset: const Offset(15.0, 15.0),
            ),
          ],
        ),
        width: 300,
        height: 60,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.button!,
          child: widget.child,
        ),
        alignment: Alignment.center,
        margin: widget.margin ?? const EdgeInsets.all(24.0),
      ),
    );
  }
}
