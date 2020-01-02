def date_to_epoch(date):
    '''
    Returns a integer of Epoch timestamps to use with the Strava API
    Datetime requires 5 different integers (yyyy,mm/dd/h/m)
    TODO: Does a dictionary fit better here to allow for localised time?
    TODO: Also means we can change it straight to an INT
    '''
 
    # For start_date and end_date, split on / and assign these values to fields (yyyy, mm, dd) 

    # Creates a list object
    date = date.split('/')
    date_dict = {}
    date_dict.update({'Day' : date[0]})
    date_dict.update({'Month' : date[1]})
    date_dict.update({'Year' : date[2]})
    print(date_dict)

    try:
        epoch = datetime.datetime(int(date_dict['Year']), int(date_dict['Month']), int(date_dict['Day']), 0, 0).timestamp()
        print(epoch)
    except ValueError:
        raise ValueError("Error: Unable to convert date to Epoch")
    return int(epoch)
