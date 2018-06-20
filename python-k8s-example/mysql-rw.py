import mysql.connector
from mysql.connector import errorcode
import datetime


try:
    cnx = mysql.connector.connect(user='admin', password='password',
                              host='mysql.marathon.l4lb.thisdcos.directory',
                              database="defaultdb")


    TABLES = {}
    TABLES['employees'] = (
    "CREATE TABLE `employees` ("
    "  `emp_no` int(11) NOT NULL AUTO_INCREMENT,"
    "  `birth_date` date NOT NULL,"
    "  `first_name` varchar(14) NOT NULL,"
    "  `last_name` varchar(16) NOT NULL,"
    "  `gender` enum('M','F') NOT NULL,"
    "  `hire_date` date NOT NULL,"
    "  PRIMARY KEY (`emp_no`)"
    ") ENGINE=InnoDB")

    cursor = cnx.cursor()

    print("Creating table Employees: ")
    cursor.execute("DROP TABLE IF EXISTS employees")
    cursor.execute(TABLES['employees'])

    print("Inserting employee rows")
    add_employee = ("INSERT INTO employees "
                "(first_name, last_name, hire_date, gender, birth_date) "
                "VALUES (%s, %s, %s, %s, %s)")
    data_employee = ('Geert', 'Vanderkelen', datetime.datetime.now(), 'M', datetime.date(1970, 1, 1))

    # Insert new employee
    cursor.execute(add_employee, data_employee)
    emp_no = cursor.lastrowid

    query = ("SELECT first_name, last_name, hire_date FROM employees ")

    cursor.execute(query)

    for (first_name, last_name, hire_date) in cursor:
        print("{}, {} was hired on {:%d %b %Y}".format(
            last_name, first_name, hire_date))

    cursor.close()
    cnx.close()

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("Something is wrong with your user name or password")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)
