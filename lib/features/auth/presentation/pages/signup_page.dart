import 'package:blogapp/core/common/widgets/loader.dart';
import 'package:blogapp/core/theme/app_pallete.dart';
import 'package:blogapp/core/utils/show_snackbar.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/auth/presentation/pages/login_page.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogapp/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthFailure){
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {

            if(state is AuthLoading){
              return const Loader();
            }
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 140),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text("Sign Up.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    AuthField(
                        hintText: "Name",
                        controller: nameController),
                    const SizedBox(height: 20),
                    AuthField(
                      hintText: "Email",
                      controller: emailController,),
                    const SizedBox(height: 20),
                    AuthField(
                      hintText: "Password",
                      controller: passController,
                      isObscure: true,),
                    const SizedBox(height: 25),
                    authButton(msg: "Sign Up",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignUp(
                              email: emailController.text.trim(),
                              name: nameController.text.trim(),
                              pass: passController.text.trim()));
                        }
                      },),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      },
                      child: RichText(
                          text: TextSpan(text: "Already have an account?",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium,
                              children: [
                                TextSpan(
                                    text: " Sign in",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                        color: AppPallete.gradient2,
                                        fontWeight: FontWeight.w600
                                    )
                                )
                              ])
                      ),
                    ),


                  ],
                ),
              ),
            );
          },
        ),
      ),

    );
  }
}
