class StatusCodes {
  // Informational responses
  static const informational = [100, 101, 102];

  // Successful responses
  static const success = [200, 201, 202, 205];

  // Redirection messages
  static const redirection = [300, 301, 302, 303, 304, 305, 306, 307, 308];

  // Client errors
  static const badRequest = [400];
  static const unauthorized = [401];
  static const notFound = [404];
  static const requestTimeout = [408];
  static const clientError = [
    402,
    403,
    405,
    406,
    407,
    409,
    410,
    411,
    412,
    413,
    414,
    415,
    416,
    417,
    422,
    423,
    424,
    426,
    429,
    431,
  ];

  // Server errors
  static const serverError = [500, 501, 502, 503, 504, 505, 506, 507];

  // Consolidated error codes
  static const List<int> errorCodes = [
    ...informational,
    203,
    204,
    205,
    206,
    207,
    ...redirection,
    ...unauthorized,
    ...clientError,
    ...serverError,
  ];

  // Convenience constants
  static const int statusOkCode = 0;
  static const int unAuthorizedCode = 401;
}
