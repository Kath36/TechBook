
import 'dart:async';

mixin Validators {
  final validaEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@')) {
        sink.add(email);
      } else {
       sink.addError('El formato del correo electrónico es incorrecto');
      }
    },
  );

  final validaPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >=1) {
        sink.add(password);
      } else {
       sink.addError('La contraseña es incorrecta');
      }
    },
  );
}
