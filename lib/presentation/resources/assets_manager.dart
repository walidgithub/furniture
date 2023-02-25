const String imagePath = 'assets/images';
const String jsonPath = "assets/json";

class ImageAssets {
  static const String menuImage = '$imagePath/menu.svg';
  static const String profileImage = '$imagePath/profile.jpg';
  static const String settings = '$imagePath/settings.svg';
  static const String chair = '$imagePath/chair.svg';
  static const String table = '$imagePath/table.svg';
  static const String sofa = '$imagePath/sofa.svg';
  static const String cupboard = '$imagePath/cupboard.svg';
  static const String home = '$imagePath/home.svg';
  static const String cart = '$imagePath/cart.svg';
  static const String inCart = '$imagePath/inCart.svg';
  static const String location = '$imagePath/location.svg';
  static const String trackingLocation = '$imagePath/truck.svg';
  static const String notification = '$imagePath/notification.svg';
  static const String track = '$imagePath/track.svg';
  static const String dots = '$imagePath/dots.svg';
  static const String back = '$imagePath/back.svg';
  static const String star = '$imagePath/star.svg';
  static const String checkout = '$imagePath/checkout.svg';
  static const String drawer = '$imagePath/drawer.jpg';
  static const String next = '$imagePath/next.svg';
  static const String profile = '$imagePath/profile.svg';
  static const String about = '$imagePath/about.svg';
  static const String facebook = '$imagePath/facebook.svg';
  static const String google = '$imagePath/google.svg';
  static const String logout = '$imagePath/logout.svg';
  static const String user = '$imagePath/user.svg';
  static const String email = '$imagePath/email.svg';
  static const String work = '$imagePath/work.svg';
  static const String linkedin = '$imagePath/linkedin.svg';
  static const String facebook_ic = '$imagePath/facebook_ic.svg';
  static const String contact = '$imagePath/whatsapp.svg';

  static const String changeLangIc = "$imagePath/language.svg";
  static const String lightThemeMode = "$imagePath/light_mode.svg";
  static const String darkThemeMode = "$imagePath/dark_mode.svg";
  static const String rightArrow =
      "$imagePath/right_arrow.svg";
  static const String leftArrow =
      "$imagePath/left_arrow.svg";
}

class JsonAssets {

  static String checkError(String error) {
    if (error == 'noInternet') {
      return "$jsonPath/error.json";
    }else if (error == 'imageError') {
      return "$jsonPath/image_error.json";
    }else if (error == 'userOrPassError') {
      return "$jsonPath/error.json";
    }else if (error == 'somethingError') {
      return "$jsonPath/error.json";
    }else if (error == 'foundSameEmail') {
      return "$jsonPath/error.json";
    } else {
      return '';
    }
  }
  static const String loading = "$jsonPath/loading.json";
  static const String splash = "$jsonPath/furniture-splash.json";
}
