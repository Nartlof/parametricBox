/**
 * Project Name : Parametric Box
 *
 * Author: Carlos Eduardo Foltran
 * GitHub: https://github.com/Nartlof/parametricBox
 * Thingiverse: https://www.thingiverse.com/thing:7341933
 * License: Creative Commons CC0 1.0 Universal (CC0 1.0)
 * Description: This is a simple box, with a lid, that closes by friction and has a shadow mask to the lid to facilitate oppening.
 *
 * Date Created: 20260425
 * Last Updated: 20260425
 *
 * This OpenSCAD file is provided under the Creative Commons CC0 1.0 Universal (CC0 1.0) License.
 * You are free to use, modify, and distribute this design for any purpose, without any restrictions.
 *
 * For more details about the CC0 license, visit: https://creativecommons.org/publicdomain/zero/1.0/
 */

// Customize the dimensions of the box by changing the values of the following variables:

// Internal dimensions of the box (the size of the space inside the box) The external dimensions will be larger due to the thickness of the walls. 
InternalWidthX = 100;
InternalWidthY = 60;
InternalHeight = 40;
// The internal height of the lid do not add internal height, only tells where the space is splited.
LidHeight = 10;
// Thickness of the walls of the box. The external dimensions will be Internal dimensions + 2 * Thickness.
Thickness = 2;
// Radius of the corners of the box. If it is 0, the corners will be sharp.
// If it is greater than 0, the corners will be rounded. 
// If greater than the thickness, the corners will be rounded on the inside as well.
CornerRadius = 5;
// The tolerance is the amount of space between the lid and the box to allow them to fit together by friction.
Tolerance = 0.25;
// ShadowMask is the amount of space between the lid and the box to allow them to be easily opened by hand. It is added to the tolerance, so it also helps with the fit of the lid.
ShadowMask = 1;
// Lip. The heitght of the lip on top of the box to hold the lid in place. If it is 0, there will be no lip and the lid will fall off. 
LipHeight = 8;
// Lip thickness. The thickness of the lip on top of the box to hold the lid in place. It must be less than or equal half the thickness of the walls. If it is 0, there will be no lip and the lid will fall off.
LipThickness = 1;

// Generate the bottom.
generate_box = 1; // [0:no,1:yes]

// Generate a lid.
generate_lid = 1; // [0:no,1:yes]

// Checking if the values are valid. If not, the script will default to the minimum or maximum values.

_LidHeight = (LidHeight < InternalHeight - ShadowMask) ? LidHeight : InternalHeight - ShadowMask;
_Tolerance = (Tolerance < Thickness / 4) ? Tolerance : Thickness / 4;
_LipThickness = (LipThickness < Thickness / 2) ? LipThickness : Thickness / 2;
_LipHeight = (LipHeight < _LidHeight) ? LipHeight : _LidHeight;
_CornerRadius = (CornerRadius < min(InternalWidthX, InternalWidthY) / 4) ? CornerRadius : min(InternalWidthX, InternalWidthY) / 4;
_InternalCornerRadius = (_CornerRadius < Thickness) ? 0 : _CornerRadius - Thickness;
$fa = ($preview) ? $fa : 2;
$fs = ($preview) ? $fs : .2;

// The module that creates a square with rounded corners. 
// It is used to create the base and the lid of the box.
module roundedSquare(sizeX, sizeY, cornerRadius) {
  if (cornerRadius > 0) {
    translate(v=[cornerRadius, cornerRadius])
      hull() {
        for (x = [0, sizeX - cornerRadius * 2]) {
          for (y = [0, sizeY - cornerRadius * 2]) {
            translate([x, y, 0]) {
              circle(cornerRadius);
            }
          }
        }
      }
  } else {
    square([sizeX, sizeY]);
  }
}

// The module that creates the base of the box. 
// It is a square with rounded corners and a hole in the middle to create the internal space of the box.
module boxBase() {
  baseHeight = InternalHeight + Thickness - _LidHeight - ShadowMask;
  lipThickness = _LipThickness - Tolerance / 2;
  difference() {
    union() {
      // This is the outer part of the base of the box. 
      // It is created by extruding a rounded square with the dimensions of the internal space 
      //plus the thickness of the walls. The height of the extrusion is the internal height plus 
      //the thickness of the walls minus the height of the lid and the shadow mask.
      linear_extrude(height=baseHeight, center=false, convexity=10, twist=0, slices=20, scale=1.0)
        roundedSquare(InternalWidthX + Thickness * 2, InternalWidthY + Thickness * 2, _CornerRadius);
      // This is the lip on top of the box to hold the lid in place.
      if (_LipHeight > 0 && _LipThickness > 0) {
        translate([Thickness - lipThickness, Thickness - lipThickness, baseHeight])
          linear_extrude(height=_LipHeight, center=false, convexity=10, twist=0, slices=20, scale=1.0)
            roundedSquare(InternalWidthX + Thickness * 2 - lipThickness * 2, InternalWidthY + Thickness * 2 - lipThickness * 2, _InternalCornerRadius + lipThickness);
      }
    }
    // This is the inner part of the base of the box. It is created by extruding a rounded square with the dimensions of the internal space. The height of the extrusion is the internal height.
    translate([Thickness, Thickness, Thickness]) {
      linear_extrude(height=InternalHeight, center=false, convexity=10, twist=0, slices=20, scale=1.0)
        roundedSquare(InternalWidthX, InternalWidthY, _InternalCornerRadius);
    }
  }
}

// The module that creates the lid of the box. 
// It is a square with rounded corners and a hole in the middle to create the internal space of the lid.
// The dimensions of the lid are the same as the internal dimensions of the box plus the tolerance and the shadow mask to allow them to fit together by friction and to be easily opened by hand.
module boxLid() {
  lipThickness = _LipThickness + Tolerance / 2;

  difference() {
    union() {
      // This is the outer part of the lid of the box. 
      // It is created by extruding a rounded square with the dimensions of the internal space 
      // plus the tolerance and the shadow mask. The height of the extrusion is the height of the lid.
      linear_extrude(height=_LidHeight + Thickness, center=false, convexity=10, twist=0, slices=20, scale=1.0)
        roundedSquare(InternalWidthX + Thickness * 2, InternalWidthY + Thickness * 2, _CornerRadius);
    }
    // This is the inner part of the lid of the box. It is created by extruding a rounded square with the dimensions of the internal space plus the tolerance and the shadow mask minus the thickness of the walls. The height of the extrusion is the height of the lid.
    translate([Thickness, Thickness, Thickness]) {
      linear_extrude(height=InternalHeight - Thickness, center=false, convexity=10, twist=0, slices=20, scale=1.0)
        roundedSquare(InternalWidthX, InternalWidthY, _InternalCornerRadius);
    }
    // This part cuts the space for the lip on top of the box to hold the lid in place.
    if (_LipHeight > 0 && _LipThickness > 0) {
      translate([Thickness - lipThickness, Thickness - lipThickness, LidHeight + Thickness + 1 - LipHeight])
        linear_extrude(height=_LipHeight + 1, center=false, convexity=10, twist=0, slices=20, scale=1.0)
          roundedSquare(InternalWidthX + lipThickness * 2, InternalWidthY + lipThickness * 2, _InternalCornerRadius + lipThickness);
    }
  }
}
/*
difference() {
  union() {
    boxBase();
    translate([InternalWidthX + Thickness * 2, 0, InternalHeight + Thickness * 2])
      rotate([0, 180, 0])
        boxLid();
  }
  translate(v=[-18, -16, -1])
    cube(size=[20, 20, 100], center=false);
}
*/
if (generate_box == 1) {
  boxBase();
}
if (generate_lid == 1) {
  translate([InternalWidthX + Thickness * 2 + 1, 0, 0])
    boxLid();
}
