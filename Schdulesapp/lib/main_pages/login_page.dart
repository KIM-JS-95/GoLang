import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ajax/user_repository.dart';
import '../models/User.dart';
import '../models/UserProvider.dart';
import '../utils/hard_coded_data.dart';
import '../utils/r.dart';
import '../utils/custom_flutter_logo.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/fade_in_out_widget/fade_in_out_widget.dart';
import '../widgets/fade_in_out_widget/fade_in_out_widget_controller.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final FadeInOutWidgetController _fadeInOutWidgetController =
      FadeInOutWidgetController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    _fillFields();
    const hSpace = SizedBox(
      height: 24.0,
    );
    return Stack(
      children: [
        const Scaffold(),
        FadeInOutWidget(
          fadeInOutWidgetController: _fadeInOutWidgetController,
          slideEndingOffset: const Offset(0, 0.01),
          child: Scaffold(
            backgroundColor: R.primaryColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomFlutterLogo(
                      size: 100,
                    ),
                    hSpace,
                    hSpace,
                    _buildEmailField(),
                    hSpace,
                    _buildPasswordField(),
                    hSpace,
                    Text(
                      "Forget Password?",
                      style: TextStyle(color: R.tertiaryColor),
                    ),
                    hSpace,
                    _buildLoginButton(context),
                    hSpace,
                    _buildSignUpTextWidget
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    final emailFieldData = HardCodedData.loginPageFieldsData[0];
    return CustomTextField(
      controller: emailFieldData.controller,
      labelText: emailFieldData.label,
      prefixIcon: emailFieldData.icon,
      mainColor: R.secondaryColor,
      secondaryColor: R.tertiaryColor,
    );
  }

  Widget _buildPasswordField() {
    final passwordFieldData = HardCodedData.loginPageFieldsData[0];
    return CustomTextField(
      controller: passwordFieldData.controller,
      labelText: passwordFieldData.label,
      prefixIcon: passwordFieldData.icon,
      mainColor: R.secondaryColor,
      secondaryColor: R.tertiaryColor,
      isTextObscure: true,
    );
  }

  Widget _buildLoginButton(BuildContext context) => FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: R.secondaryColor,
          minimumSize: const Size(
            double.infinity,
            50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () async {
          // 사용자가 입력한 아이디와 패스워드를 가져오기
          String userid = HardCodedData.loginPageFieldsData[0].controller.text;
          String password = HardCodedData.loginPageFieldsData[1].controller.text;

          User user = User(userid: "001200", password: "123"); /// 테스트
          Map<String, dynamic> loginResult = await UserRepository.login(user);

          // 로그인 성공 여부 확인
          if (loginResult['success']) {
            user.auth=loginResult['token'];
            final userProvider = Provider.of<UserProvider>(context, listen: false);
            userProvider.setUser(user);

            // 로그인 성공 시 홈 화면으로 이동
            _fadeInOutWidgetController.hide();
            Future.delayed(
              const Duration(milliseconds: 500),
              () => Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomePage(routeTransitionValue: animation),
                ),
              ),
            );
          } else {
            // 로그인 실패 시 사용자에게 알림
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(loginResult['message']),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Text(
          "Login",
          style: TextStyle(color: R.primaryColor, fontWeight: FontWeight.bold),
        ),
      );

  Widget get _buildSignUpTextWidget => RichText(
        text: TextSpan(
          text: "Not a member? ",
          style: TextStyle(color: R.tertiaryColor),
          children: [
            TextSpan(
              text: "Join now",
              style: TextStyle(
                color: R.secondaryColor,
              ),
            )
          ],
        ),
      );

  void _fillFields() {
    Future.delayed(const Duration(seconds: 1), () {
      /// reset fields
      for (var field in HardCodedData.loginPageFieldsData) {
        field.controller.text = "";
      }

      /// populate fields
      for (var field in HardCodedData.loginPageFieldsData) {
        for (int i = 0; i < field.text.length; i++) {
          Future.delayed(
            Duration(milliseconds: 20 * i),
            () => field.controller.text += field.text[i],
          );
        }
      }
    });
  }
}
