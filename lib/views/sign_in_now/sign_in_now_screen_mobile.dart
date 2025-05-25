import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';

class SignInNowScreenMobile extends StatelessWidget {
  const SignInNowScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize),
          child: Column(
            mainAxisAlignment: mainCenter,
            crossAxisAlignment: crossCenter,
            children: [
              PrimaryButton(
                  title: Strings.signInMsg,
                  onPressed: () {
                    Get.offAllNamed(Routes.signInScreen);
                  },
                  borderColor: Theme.of(context).primaryColor,
                  buttonColor: Theme.of(context).primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
