class ApiConstants {
  static const String baseUrl = 'http://localhost:8080';
  
  static const String authRegister = '/auth/register';
  static const String authLogin = '/auth/login';
  static const String authMe = '/auth/me';
  
  static const String coffeeTypes = '/coffee-types';
  static const String locations = '/locations';
  static const String orders = '/orders';
  static const String reviews = '/reviews';
  static const String favorites = '/favorites';
  static const String locationHours = '/location-hours';
  
  static String coffeeTypeById(String id) => '$coffeeTypes/$id';
  static String locationById(String id) => '$locations/$id';
  static String orderById(String id) => '$orders/$id';
  static String myOrders = '$orders/my-orders';
  static String reviewsByCoffeeType(String id) => '$reviews/coffee-type/$id';
  static String reviewsByLocation(String id) => '$reviews/location/$id';
  static String locationAvailability(String id) => '$locationHours/location/$id/availability';
}

