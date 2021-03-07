def python(request):
    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text or any set of values that can be turned into a
        Response object using
        `make_response <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>`.
    """
    request_json = request.get_json()
  
    if request_json and 'code' in request_json:
        
        return eval(request_json['code'].replace("\\n", "\n"))
    else:
        return f'Hello World!'