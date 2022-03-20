class MeditationSvgAssets {
  static final MeditationSvgAssets _instance = MeditationSvgAssets._internal();

  factory MeditationSvgAssets() {
    return _instance;
  }

  MeditationSvgAssets._internal();

  Map<AssetName, String> assets = {
    AssetName.following: "assests/images/following.svg",
    AssetName.home: "assests/images/home.svg",
    AssetName.stethoscope: "assests/images/stethoscope.svg",

  };
}

enum AssetName {
  following,
  home,
  stethoscope,
}
