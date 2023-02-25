class AppStrings {
  //Bottom bar
  static const home = "Home";
  static const location = "Our Location";
  static const trackingLocation = "Your Order";
  static const notification = "Notifications";
  static const cart = "Cart";
  static const carts = "Carts";
  static const about = "About";
  static const profile = "Profile";
  static const contact = "Contact";
  static const productName = "Product name:";
  static const productCount = "Product count:";
  static const splash = "Best Furniture For You";

  static const sentVerification = "Send Verification";
  static const confirmVerification = "Confirm Verification";

  static const loading = "Loading";
  static const logout = "LogOut";

  static const trackYourOrder = "Track Your Order";
  static const changeLang = "Change Language";
  static const lightMode = "Light Mode";
  static const darkMode = "Dark Mode";

  static const details = "Details";
  static const description = "Description";
  static const readMore = "Read more";
  static const less = "Less";
  static const addToCart = "Add to cart";
  static const checkOut = "Check out";
  static const inCart = "In cart";
  static const price = "Price:";
  static const settings = "Settings";
  static const reviews = "reviews";

  static const error = "Error";
  static const close = "Close";

  static const searchResults = "Search Results";

  static const viewAll = "View all";

  static const successfullyRegistered = "Successfully Registered";
  static const successfullyLogin = "Successfully Login";

  static const notificationNotSent = "Notification not sent";

  static const successDeleted = "Notification deleted";
  static const deletingError = "Notification not deleted";
  static const showNotificationError = "Show Notification Error";

  static String checkFields(String error) {
    if (error == 'empty') {
      return "Empty Field";
    } else if (error == 'notValidMail') {
      return "Email Not Valid";
    } else if (error == 'checkPassword') {
      return "Check Password";
    } else if (error == 'checkMainPassword') {
      return "Check Main Password";
    } else if (error == 'imageError') {
      return "Image Required";
    } else if (error == 'noInternet') {
      return "Sorry, there is no internet";
    } else if (error == 'userOrPassError') {
      return "User or password error";
    } else if (error == 'somethingError') {
      return "Something error";
    } else if (error == 'foundSameEmail') {
      return "Found Same Email";
    } else {
      return '';
    }
  }

  // static const emailNotValid = "Email Not Valid";
  //
  // static const checkPassword = "Check Password";

  static const noRouteFound = "No Route Found";
  static const homeTitle1 = "Best Furniture";
  static const homeTitle2 = "in your home.";
  static const searchHint = "Search";
  static const pickPhoto = "Pick Photo";
  static const name = "Name";
  static const email = "Email";
  static const password = "Password";
  static const confirmPassword = "Confirm Password";
  static const signIn = "SignIn";
  static const signUp = "SignUp";
  static const orSignInWith = "OrSignInWith";
  static const orSignUpWith = "OrSignUpWith";
  static const dontHaveAnAccount = "DontHaveAnAccount";
  static const loginToAccount = "LoginToAccount";
  static const createYourAccount = "CreateYourAccount";
  static const categories = "Categories";
  static const topChair = "Top Chair";
  static const allChair = "All Chairs";

  static const topCupboard = "Top Cupboard";
  static const allCupboard = "All Cupboards";

  static const topTable = "Top Table";
  static const allTable = "All Tables";

  static const topSofa = "Top Sofa";
  static const allSofa = "All Sofas";

  static const chair = "Chair";
  static const table = "Table";
  static const cupboard = "Cupboard";
  static const sofa = "Sofa";

  static const String success = "success";

  // error handler
  static const String badRequestError = "bad_request_error";
  static const String noContent = "no_content";
  static const String forbiddenError = "forbidden_error";
  static const String unauthorizedError = "unauthorized_error";
  static const String notFoundError = "not_found_error";
  static const String conflictError = "conflict_error";
  static const String internalServerError = "internal_server_error";
  static const String unknownError = "unknown_error";
  static const String timeoutError = "timeout_error";
  static const String defaultError = "default_error";
  static const String cacheError = "cache_error";
  static const String noInternetError = "no_internet_error";
}
