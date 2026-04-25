# Parametric Box

A simple parametric box with a lid that closes by friction and features a shadow mask to facilitate opening. This OpenSCAD design allows for easy customization of dimensions, wall thickness, corner radius, and other parameters to fit various needs.

## Features

- **Parametric Design**: Easily customize internal dimensions, wall thickness, corner radius, tolerance, and more.
- **Friction-Fit Lid**: The lid closes securely by friction, with adjustable tolerance for a perfect fit.
- **Shadow Mask**: Helps in easily opening the lid by providing a grip area.
- **Lip Mechanism**: Optional lip on the box to hold the lid in place.
- **Rounded Corners**: Optional rounded corners for a smoother appearance and better ergonomics.
- **OpenSCAD Compatible**: Fully scripted in OpenSCAD for 3D printing and customization.

## Customization

The box can be customized by editing the variables at the top of the `parametricBox.scad` file:

- `InternalWidthX`: Internal width of the box (X-axis).
- `InternalWidthY`: Internal width of the box (Y-axis).
- `InternalHeight`: Internal height of the box.
- `LidHeight`: Height of the lid (affects where the box splits).
- `Thickness`: Thickness of the box walls.
- `CornerRadius`: Radius of the box corners (0 for sharp corners).
- `Tolerance`: Space between lid and box for friction fit.
- `ShadowMask`: Additional space for easy lid opening.
- `LipHeight`: Height of the lip to hold the lid.
- `LipThickness`: Thickness of the lip.

You can also choose to generate only the box or only the lid by setting `generate_box` and `generate_lid` to 1 (yes) or 0 (no).

## Usage

1. Download or clone this repository.
2. Open `parametricBox.scad` in OpenSCAD.
3. Customize the parameters as needed.
4. Render the design (F6) and export as STL for 3D printing.

## License

This project is licensed under the Creative Commons CC0 1.0 Universal (CC0 1.0) License. You are free to use, modify, and distribute this design for any purpose, without any restrictions.

For more details about the CC0 license, visit: [https://creativecommons.org/publicdomain/zero/1.0/](https://creativecommons.org/publicdomain/zero/1.0/)

## Author

Carlos Eduardo Foltran

## Links

- [GitHub Repository](https://github.com/Nartlof/parametricBox)
- [Thingiverse](https://www.thingiverse.com/thing:7341933)
