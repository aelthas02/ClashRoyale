def get_exception(response):
    if (response.status_code == 400):
        return '400: Client provided incorrect parameters for the request'
    elif (response.status_code == 403):
        return '403: Access denied'
    elif (response.status_code == 404):
        return '404: Not found'
    elif (response.status_code == 429):
        return '429: Request was throttled'
    elif (response.status_code == 500):
        return '500: Internal server error'
    elif (response.status_code == 503):
        return '503: Service is temprorarily unavailable because of maintenance.'
