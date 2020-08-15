import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    /*autorun((_) {
      print(email);
      print(password);
      print(isFormValid);
    });*/
  }

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool verSenha = false;
  
  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void botaoVerSenha() => verSenha = !verSenha;
  
  @action
  Future<void> login() async {
    loading = true;
    
    await Future.delayed(Duration(seconds: 2));
    
    loading = false;
    loggedIn = true;

    email = "";
    password = "";
  }

  /*@computed
  bool get isFormValid => email.length > 6 && password.length > 6;*/

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(email);
  @computed
  bool get isPasswordValid => password.length > 6;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

  @computed
  Function get loginPressed => (isEmailValid && isPasswordValid && !loading) ? login : null;

  @action
  void logout(){
    loggedIn = false;
  }

}
