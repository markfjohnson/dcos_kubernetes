import os
hostname = "google.com" #example
response = os.system("ping -c 1 " + hostname)
print("Google response: {}".format(response))
response = os.system("ping -c 1 master.mesos")
print ("Master mesos: {}".format(response))