import datetime
def full_month_name(month_num):
    datetime_object = datetime.datetime.strptime(month_num, "%m")
    full_month_name = datetime_object.strftime("%B")
    print("Full name: ",full_month_name)
    return  full_month_name

def month_name(month_num):
    datetime_object = datetime.datetime.strptime(month_num, "%m")
    full_month_name = datetime_object.strftime("%B")
    print("Full name: ", full_month_name)
    return full_month_name