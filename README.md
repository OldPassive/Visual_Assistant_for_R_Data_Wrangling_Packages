# Visual_Assistant_for_R_Data_Wrangling_Packages
A knowledge base of R data wrangling packages based on MySQL and Django.

Instructions:
1. Download all the files in the dictionary.
2. Install the latest version of Python.
3. Install the Django Framework, the guide can be found in: https://docs.djangoproject.com/en/2.1/intro/install/
4. Install MySQL 5.7.23 from https://dev.mysql.com/downloads/installer/
   and establish a database called 'r_data_wrangling_packages_knowledge_base' or any other name.
5. Open the 'settings.py' with the same name as the root dictionary and change the parameters for the database:
   DATABASES = {
     'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'r_data_wrangling_packages_knowledge_base',  ......The name of the database
        'USER': 'root', ......The user of MySQL
        'PASSWORD': '', ......The password of MySQL
        'HOST': 'localhost',
        'PORT': '3306',
      }
    }
6. Open the command line in project dictionary and run the following conmand in order to establish the tables in the database:
   'python manage.py makemigrations Knowledge_Base'
   'python manage.py migrate'
7. Run 'Data_in_Knowledge_Base.sql' in MySQL.
8. Open the command line in the project dictionary and use the command below to run the project:
   'python manage.py runserver'
9. The project can be accessed by '127.0.0.1:8000' in a web browser.
   
   
