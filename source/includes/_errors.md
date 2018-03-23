# Errors

<aside class="dangers">
List of http request errors you might get from EXIR.
</aside>

The EXIR API uses the following error codes:


Error Code | Meaning
---------- | -------
400 | Bad Request -- Your request is invalid.
403 | Unauthorized/Forbidden -- Your api token is not valid.
404 | Not Found -- The specified request could not be found.
405 | Method Not Allowed -- You tried to access a request with an invalid method.
410 | Gone -- The request has been removed from our servers.
429 | Too Many Requests -- You're requesting too many requests! Slow down!
500 | Internal Server Error -- We had a problem with our server. Try again later.
503 | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.
