A `TextFormField` widget that lets you show the error message as an overlay.

## Features

This package provides a `CustomErrorTextFormField` widget, which will show the error message
(when the form field is invalid) as an overlay placed relative to the form field, instead of
the default behavior of the `TextFormField` which is to show the error message below the form
field and modifies the layout.

## Usage

The `CustomErrorTextFormField` has all the same parameters as `TextFormField` except for the four
extra parameters:

```dart
  final Widget Function(String) errorTextBuilder;
  final Alignment errorTextAnchor;
  final Alignment textFieldAnchor;
  final Offset errorTextOffset;
```

`errorTextBuilder` specifies how the error text widget is defined. The `errorTextAnchor` and `textFieldAnchor`, plus `errorTextOffset` will determine how the error text widget is placed relative to the form field.

![Example](https://imgur.com/a/IOeOCCx)
