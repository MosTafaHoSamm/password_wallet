abstract class HomeStates{}
class HomeInitialState extends HomeStates{}
class ChangeDarkState extends HomeStates{}
class OnPageChangeState extends HomeStates{}
class AuthSuccessState extends HomeStates{}
class AuthLoadingState extends HomeStates{}
class AuthErrorState extends HomeStates{
  final String error;

  AuthErrorState({required this.error});
}
class PhoneNumberSubmittedState extends HomeStates{}
class SignOutSuccessState extends HomeStates{}
class ChangeIndexState extends HomeStates{}
class ChangeColorLisViewState extends HomeStates{}
class ChangeCategoryScreenState extends HomeStates{}
class ChangeCheckedBoxState extends HomeStates{}
class GeneratePassword extends HomeStates{}
class PassLengthChangeState extends HomeStates{}
