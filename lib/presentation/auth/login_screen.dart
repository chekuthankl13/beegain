import 'package:beegain/config/config.dart';
import 'package:beegain/logic/bloc_export.dart';
import 'package:beegain/presentation/auth/widgets/field.dart';
import 'package:beegain/presentation/home/home_screen.dart';
import 'package:beegain/utils/utills.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ValueNotifier<bool> isSHow = ValueNotifier(false);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController usrCntr = TextEditingController();
TextEditingController pswCntr = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Config().baseclr,
      body: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              height: sH(context) / 2,
              width: sW(context),
              color: Config().baseclr,
              child: Image.asset(
                "assets/login.png",
                height: 100,
                width: sW(context),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: sH(context) / 2,
              width: sW(context),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  spaceHeight(10),
                  fields(
                      hint: "username",
                      isPsw: false,
                      ic: Icons.emoji_people_rounded,
                      cntr: usrCntr),
                  spaceHeight(15),
                  ValueListenableBuilder(
                    valueListenable: isSHow,
                    builder: (context, value, child) => fields(
                        hint: "password",
                        ic: Icons.security,
                        cntr: pswCntr,
                        isPsw: true,
                        onPressed: () {
                          if (value) {
                            isSHow.value = false;
                          } else {
                            isSHow.value = true;
                          }
                        }),
                  ),
                  spaceHeight(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthLoadError) {
                            errorToast(context, error: state.error);
                          }
                          if (state is AuthLoadSuccess) {
                            errorToast(context,
                                error:
                                    "welcome back ${state.data.user.userName} !!");
                            navigatorKey.currentState!.pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                (route) => false);
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(sW(context) / 2, 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Config().baseclr,
                                  foregroundColor: Colors.white,
                                ),
                                child: const CupertinoActivityIndicator(
                                  color: Colors.white,
                                ));
                          }
                          return ElevatedButton(
                            onPressed: () {
                              context.read<AuthCubit>().onLogin(
                                  name: usrCntr.text.trim(),
                                  psw: pswCntr.text.trim());
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(sW(context) / 2, 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Config().baseclr,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Login"),
                          );
                        },
                      )
                    ],
                  ),
                  spaceHeight(10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
