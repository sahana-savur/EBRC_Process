def logfile(file_path,timestamp,log_level,log_message):
    f= open(file_path,"a+")
    f.write(timestamp+"   "+log_level+"  "+log_message+"\n")
    f.close()