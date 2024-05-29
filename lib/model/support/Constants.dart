class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "TheaterEvents";

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:8081";
  static final String ADDRESS_AUTHENTICATION_SERVER = "http://localhost:8080/realms/SpringBootKeycloak";

// authentication
  static final String REALM = "SpringBootKeycloak";
  static final String CLIENT_ID = "login-app";
  static final String CLIENT_SECRET = "NWmFPUVLk9KVTMYhDEoTIba6oOVlUwlw";
  static final String REQUEST_LOGIN = "http://localhost:8080/realms/" + REALM +"/protocol/openid-connect/token";
  static final String REQUEST_USER = "http://localhost:8080/admin/realms/" + REALM +"/users";



  // requests
  static final String REQUEST_ADD_USER = "/cliente/register";
  static final String REQUEST_USER_BY_EMAIL = "/cliente/by_email";
  static final String REQUEST_FREE_SEATS= "posto/get_free_seats";
  static final String REQUEST_SEATS_BY_ID= "posto/seats_by_id";
  static final String REQUEST_SEATS_NUMBER = "/sala/seats";
  static final String REQUEST_SEARCH_THEATER = "/teatro/search/by_city";
  static final String REQUEST_SEARCH_SHOW = "/spettacolo/search/byTitle";
  static final String REQUEST_LIST_EVENTS = "/evento/search/by_show";
  static final String REQUEST_LIST_SHOWS = "/spettacolo/search/by_theater";
  static final String REQUEST_BUY_TICKET = "/biglietto/create";
  static final String REQUEST_PRICE_TICKETS = "/spettacolo/price_by_numberTickets";


  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";


}