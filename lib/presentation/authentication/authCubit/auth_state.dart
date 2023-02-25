abstract class AuthState{}

class AuthInitial extends AuthState{}

class AuthRegisterSucceededState extends AuthState{}

class AuthErrorInRegisterState extends AuthState{}

class AuthRegisterLoadingState extends AuthState{}

class AuthLoginLoadingState extends AuthState{}

class AuthLoginState extends AuthState{}

class AuthLoginErrorState extends AuthState{}

class AuthGetUserDataState extends AuthState{}

class AuthErrorLoadingImageState extends AuthState{}

class AuthGetCurrentUserLoadingState extends AuthState{}

class AuthSignInLoadingState extends AuthState{}

class NoInternetState extends AuthState{}

