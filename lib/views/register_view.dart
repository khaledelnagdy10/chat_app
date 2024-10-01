import 'dart:developer';

import 'package:chat_app2/cubits/aut_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'login_view.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  String emailAddress = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2D3034),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMess)));
          }
          if (state is AuthSucsses) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('sucsses')));
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginView();
            }));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Image.asset('assets/images/scholar.png'),
              const Text(
                'Scholar Chat',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const Spacer(
                flex: 1,
              ),
              const Row(
                children: [
                  Text(
                    'Rigester Chat',
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                ],
              ),
              CustomTextField(
                hint: 'Email',
                onChanged: (value) {
                  emailAddress = value;
                },
              ),
              CustomTextField(
                hint: 'password',
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                text: 'Register',
                onTap: () {
                  BlocProvider.of<AuthCubit>(context)
                      .register(emailAddress, password);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('already have an account',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()));
                      },
                      child: Text(
                        'login',
                        style: TextStyle(color: Colors.blue[200]),
                      )),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}
