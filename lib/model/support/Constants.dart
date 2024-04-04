class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "TheaterEvents";

  // addresses
  static final String ADDRESS_STORE_SERVER = "http://localhost:8081";
  static final String ADDRESS_AUTHENTICATION_SERVER = "http://localhost:8080/realms/SpringBootKeycloak";

// authentication
  static final String REALM = "SpringBootKeycloak";
  static final String CLIENT_ID = "login-app";
  static final String CLIENT_SECRET = "NWmFPUVLk9KVTMYhDEoTIba6oOVlUwlw";
  static final String REQUEST_LOGIN = "http://localhost:8080/realms/" + REALM +"/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "http://localhost:8080/realms/" + REALM +"/protocol/openid-connect/logout";



  // addresses
  /*static final String ADDRESS_STORE_SERVER = "localhost:8081";
  static final String ADDRESS_AUTHENTICATION_SERVER = "http://localhost:8080/realms/SpringBootKeycloak/protocol/openid-connect/token";


  // authentication
  static final String REALM = "SpringBootKeycloak";
  static final String CLIENT_ID = "login-app";
  static final String CLIENT_SECRET = "nkXRFIQhmshGH5qZKsveJ2oRURDQNaAm";
  static final String REQUEST_LOGIN = "http://localhost:8080/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "http://localhost:8080/realms/" + REALM + "/protocol/openid-connect/logout";*/

  // requests
  static final String REQUEST_ADD_USER = "/cliente/register";
  static final String REQUEST_SEARCH_THEATER = "/teatro/search/by_city";
  static final String REQUEST_SEARCH_SHOW = "/spettacolo/search/byTitle";
  static final String REQUEST_BUY_TICKET = "/biglietto/create";


  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";


}