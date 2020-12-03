import random, re
from datetime import datetime, timedelta

class DataGenerator:

    def __init__(self, fileName):
        self.fileName = fileName

    def generate(self, minutes):

        f = open(self.fileName, "w")
        f.write("-- CREATE ... USE ... CREATE ... DROP")
        f.close()

        f = open(self.fileName, "a")
        for i in range(minutes):
            f.write("""
                INSERT INTO Measure(device, temperature, tim_date) VALUES (%d, %.2f, '%s');
            """ % (int(random.random()*(4-1)+1), (random.random()*(39-36)+36), datetime.now() + timedelta(seconds=60*i)))
        
        f.close()