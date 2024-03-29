import 'package:flutter/material.dart';
import 'package:netflix/components/checkbox/app_checkbox.dart';
import 'package:netflix/components/textfields/app_textfield.dart';
import 'package:netflix/components/buttons/direct_login_button/direct_login_button.dart';
import 'package:netflix/components/buttons/primary_buttons/primary_long_button.dart';

import '../../config/app_local_assets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _checkBox = false;
  void _onPressedCheckBox() {
    setState(() {
      _checkBox = !_checkBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mySize = MediaQuery.sizeOf(context);
    TextTheme myTextTheme = Theme.of(context).textTheme;
    ColorScheme myColorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // SizedBox(height: mySize.height / 12),
              Image.asset(
                AppAssets.appLogo,
                height: mySize.height / 6,
              ),
              SizedBox(height: mySize.height / 64),
              Text(
                "Create Your Account",
                style: myTextTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: mySize.height / 64),
              const AppTextField(hintText: "Email"),
              SizedBox(height: mySize.height / 32),
              const AppTextField(hintText: "Password"),
              Row(
                children: [
                  AppCheckBox(
                    checkBox: _checkBox,
                    func: _onPressedCheckBox,
                  ),
                  const Text("Remember me"),
                ],
              ),
              SizedBox(height: mySize.height / 80),
              PrimaryLongButton(text: "Sign up", func: () {}),
              SizedBox(height: mySize.height / 40),
              Row(children: <Widget>[
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    "or continue with",
                    style: myTextTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ]),
              SizedBox(height: mySize.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DirectLoginButton(
                    func: () {},
                    myicon: Icons.facebook,
                    iconColor: Colors.lightBlue,
                  ),
                  SizedBox(width: mySize.width / 12),
                  DirectLoginButton(
                    func: () {},
                    isImage: true,
                    logo: AppAssets.google,
                  ),
                  SizedBox(width: mySize.width / 12),
                  DirectLoginButton(
                    func: () {},
                    myicon: Icons.apple,
                    iconColor: myColorScheme.onSurface,
                  ),
                ],
              ),
              SizedBox(height: mySize.height / 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: myTextTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //TODO Add your button logic here
                    },
                    child: Text(
                      "Sign in",
                      style: myTextTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
