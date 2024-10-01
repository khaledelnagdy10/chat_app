import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future register(String email, String password) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSucsses());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailure(errMess: 'Firebase failure: weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailure(errMess: 'Firebase failure: email-already-in-use'));
      }
    } catch (e) {
      emit(AuthFailure(errMess: 'uknown failure: $e'));
    }
  }

  Future login(String email, String password) async {
    emit(AuthLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSucsses());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailure(errMess: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailure(errMess: 'Wrong password provided for that user.'));
      }
    }
  }
}
