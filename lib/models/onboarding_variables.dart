class OnBoardingVariables {
  late final String image;
  late final String title;
  late final String description;

  OnBoardingVariables(
      {required this.image, required this.title, required this.description});

   static List<OnBoardingVariables> onBoarding = [
    OnBoardingVariables(
        image: 'assets/images/password.png',
        title: 'Welcome to Password Wallet',
        description:
            'Password Wallet Save your passwords in one place,they will be available for all your devices.'),
    OnBoardingVariables(
        image: 'assets/images/security.png',
        title: 'Strong Passwords',
        description:
            'Password Wallet will generate a strong and safe password for all your websites.'),
    OnBoardingVariables(
        image: 'assets/images/shield.png',
        title: 'Let\'s get started',
        description:
            'Login or Create an account to start saving your passwords in a secured place on your cloud.'),
  ];
}
