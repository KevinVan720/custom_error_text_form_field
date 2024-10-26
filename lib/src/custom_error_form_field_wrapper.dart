import 'package:custom_error_text_form_field/src/custom_error_text_form_field.dart';
import 'package:flutter/material.dart';

/// A wrapper widget for form fields that provides custom error handling.
class CustomErrorFormFieldWrapper<T> extends StatefulWidget {
  const CustomErrorFormFieldWrapper({
    super.key,
    required this.builder,
    required this.field,
    required this.errorTextBuilder,
    required this.errorTextAnchor,
    required this.textFieldAnchor,
    required this.errorTextOffset,
  });

  final FormFieldState<T> field;
  final FormFieldBuilder<T> builder;
  final FormFieldErrorTextBuilder<T> errorTextBuilder;
  final Alignment errorTextAnchor;
  final Alignment textFieldAnchor;
  final Offset errorTextOffset;

  @override
  State<CustomErrorFormFieldWrapper> createState() =>
      _CustomErrorFormFieldWrapperState();
}

class _CustomErrorFormFieldWrapperState<T>
    extends State<CustomErrorFormFieldWrapper<T>> {
  bool isOverlayShown = false;
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.field.isValid && isOverlayShown) {
        hideErrorText();
      } else if (widget.field.errorText != null && !isOverlayShown) {
        showErrorText();
      }
    });

    return CompositedTransformTarget(
        link: layerLink, child: widget.builder(widget.field));
  }

  void showErrorText() {
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
            left: 0,
            top: 0,
            child: CompositedTransformFollower(
              followerAnchor: widget.errorTextAnchor,
              targetAnchor: widget.textFieldAnchor,
              offset: widget.errorTextOffset,
              link: layerLink,
              child: widget.errorTextBuilder(widget.field.errorText!),
            ));
      },
    );
    Overlay.of(context).insert(overlayEntry!);
    setState(() {
      isOverlayShown = true;
    });
  }

  void hideErrorText() {
    overlayEntry?.remove();
    overlayEntry = null;
    setState(() {
      isOverlayShown = false;
    });
  }
}
