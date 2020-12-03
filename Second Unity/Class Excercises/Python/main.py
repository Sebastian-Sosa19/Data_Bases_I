# -*- coding : utf-8 -*-

"""
    Ejemplo mediante POO y BD para el uso de Select en Python.
"""

from ConnectionConfig import ConnectionConfig
from MySQLEngine import MySQLEngine
import dataGenerator

"""
config = ConnectionConfig("localhost","3306","root","lockandgo","Example")
engine = MySQLEngine(config)
first10 = engine.select("SELECT * FROM Measure ORDER BY id ASC LIMIT 10")
last10 = engine.select("SELECT * FROM Measure ORDER BY id DESC LIMIT 10")
"""

# for id,device,temperature,date in first10:
#     print("Registro: %s, %s, %s, %s" % (id,device,temperature,date))

# for id,device,temperature,date in last10:
#     print("Registro: %s, %s, %s, %s" % (id,device,temperature,date))

#¿Cómo cerrar la conexión con la base de datos?

"""
result1 = engine.select("SELECT * FROM CountMonth2020")
for month,count in result1:
    print("Registro: %s, %s" % (month,count))

result2 = engine.select("SELECT * FROM CountByDayOnNovember2020")
for hour,count in result2:
    print("Registro: %s, %s" % (hour, count))


engine.closeDataBase()

if(engine.connectionCheck()):
    print("Still connected")
else:
    print("Disconnected")
"""

date = dataGenerator.DataGenerator(fileName = "data.sql")

date.generate(100)