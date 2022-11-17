enum AssetsEnum {
  logo("logo"),
  background("background");

  String toPng() => 'assets/images/$name.png';
  String toJpg() => 'assets/images/$name.jpg';
  String toLottie() => 'assets/lottie/$name.json';

  final String name;
  const AssetsEnum(this.name);
}
