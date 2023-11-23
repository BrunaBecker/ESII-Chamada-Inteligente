const appDateTimePattern = "dd/MM/yyyy HH:mm:ss";
const storageDateTimePattern = "yyyy-MM-dd HH:mm:ss";

const appDatePattern = "dd/MM/yyyy";
const storageDatePattern = "yyyy-MM-dd";

const baseUrl = "http://10.0.2.2:8080";
const httpTimeout = Duration(seconds: 10);
const maxRetries = 3;
const retryDelay = 1000;

const httpUnauthorizedErrorMessage = "Unauthorized access error";
const httpServerErrorMessage = "Server error";
const httpNoConnectionErrorMessage = "No internet connection";
