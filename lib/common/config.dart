class Config {
  const Config._();

  static const String baseUrl = "https://api.currencyapi.com/";

  static const String apiKey = String.fromEnvironment("CURRENCY_API_KEY");

  static const int amountDecimal = 9;
}
