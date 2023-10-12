
extension S on String{

  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstOfEach => split(" ").map((str) =>str.isNotEmpty?str.inCaps:str).join(" ");

}