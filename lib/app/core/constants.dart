const appDateTimePattern = "dd/MM/yyyy hh:mm:ss";
const storageDateTimePattern = "yyyy-MM-dd hh:mm:ss";

const appDatePattern = "dd/MM/yyyy";
const storageDatePattern = "yyyy-MM-dd";

const baseUrl = "https://204.216.172.42:/3599";
const httpTimeout = Duration(seconds: 10);
const maxRetries = 3;
const retryDelay = 1000;

const httpUnauthorizedErrorMessage = "Unauthorized access error";
const httpServerErrorMessage = "Server error";
const httpNoConnectionErrorMessage = "No internet connection";
