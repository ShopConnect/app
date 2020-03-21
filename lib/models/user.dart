import 'package:shopconnect/models/order.dart';

class User {
  static int id = 0;
  static String firstName = '';
  static String lastName = '';
  static String birthday = '';
  static String email = '';
  static String country = '';
  static String city = '';
  static String zipCode = '';
  static String street = '';
  static String houseNumber = '';
  static String payPalHandle = '';
  static String iban = '';
  static String telephoneNumber = '';
  static List<Order> ownedOrders = [];
  static List<Order> acceptedOrders = [];
  static bool isVerified = false;
}