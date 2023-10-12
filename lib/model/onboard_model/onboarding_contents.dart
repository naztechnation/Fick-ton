class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to Fik-kton ",
    image: "assets/images/image1.png",
    desc: "Dive into the heart-pounding world of action-packed movies. Get the latest updates, trailers, and exclusive insights!. ",
  ),
  OnboardingContents(
    title: "Stay on the Edge ",
    image: "assets/images/image2.png",
    desc:
        " Get notified about the newest animated releases, heartwarming stories, and unforgettable characters.",
  ),
  OnboardingContents(
    title: "Get Started ",
    image: "assets/images/image3.png",
    desc:
        "Embark on a whimsical animated adventure! Discover the latest in cartoons, series, and family-friendly fun. ",
  ),
];
