import 'package:tuple/tuple.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vmath;
/**
 *   Hyperbolic functions to calculate sinh, cosh, tanh, coth, sech and csch.
 */

/// Returns the hyperbolic sine of x.
num sinh(num x) => (math.exp(2 * x) - 1) / (2 * math.exp(x));

/// Returns hyperbolic cosine of x.
num cosh(num x) => (math.exp(2 * x) + 1) / (2 * math.exp(x));

/// Returns hyperbolic tangent of x.
num tanh(num x) => sinh(x) / cosh(x);

/// Returns hyperbolic cotangent of x.
num coth(num x) => cosh(x) / sinh(x);

/// Returns hyperbolic secant (1 / cosh(x)) of x.
num sech(num x) => ((2 * math.exp(x) / math.exp(2 * x) + 1));

/// Returns hyperbolic cosecant (1 / sinh(x)) of x
num csch(num x) => ((2 * math.exp(x) / math.exp(2 * x) - 1));

var _templateRe = RegExp(r'\{ *([\w_-]+) *\}');

String template(String str, Map<String, String> data) {
  return str.replaceAllMapped(_templateRe, (Match match) {
    var value = data[match.group(1)];
    if (value == null) {
      throw Exception('No value provided for variable ${match.group(1)}');
    } else {
      return value;
    }
  });
}

List<double> xyzToWms(int x, int y, int z) {
  double n = math.pow(2.0, z.toDouble().round());
  double lonDeg = x / n * 360.0 - 180.0;
  double latRad = math.atan(sinh(math.pi * (1.0 - 2.0 * y / n)));
  double latDeg = vmath.degrees(latRad);
  return [latDeg, lonDeg];
}

double wrapNum(double x, Tuple2<double, double> range, [bool includeMax]) {
  var max = range.item2;
  var min = range.item1;
  var d = max - min;
  return x == max && includeMax != null ? x : ((x - min) % d + d) % d + min;
}
