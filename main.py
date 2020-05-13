import os

SOME_DB = os.environ['SOME_DB']
SOME_USER = os.environ['SOME_USER']

def echo(request):
    request_args = request.args.to_dict()
    return('Hello GCF: {} {} {}'.format(SOME_DB, request_args, request.path))

def yell(request):
    request_args = request.args.to_dict()
    return('Hello GCF: {} {} {}'.format(SOME_DB, request_args, request.path).upper())

GCF_FUNCTIONS = {
    'echo': echo,
    'yell': yell
}

def api(request):
    path_function = request.path.split('/')[1]
    gcf_function = GCF_FUNCTIONS.get(path_function)

    if gcf_function:
        return(gcf_function(request))
    else:
        return('Invalid function: {}'.format(path_function), 400)
