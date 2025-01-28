# flutter_clean_architecture_sample


## serverpod notes

serverpod create mypod

----------------------------

cd mypod_server
docker compose up --build --detach
dart bin/main.dart --apply-migrations

----------------------------

cd mypod/mypod_flutter
flutter run -d chrome

----------------------------

iOS
var client = Client('http://192.168.1.117:8080/')
..connectivityMonitor = FlutterConnectivityMonitor();
  
----------------------------

Whenever you change your code in either the endpoints or models directory, you will need to regenerate the classes managed by Serverpod.
Do this by running serverpod generate.

cd mypod/mypod_server
serverpod generate

----------------------------

Working with endpoints

import 'package:serverpod/serverpod.dart';
class ExampleEndpoint extends Endpoint {
Future<String> hello(Session session, String name) async {
return 'Hello $name';
}
}

----------------------------

On the client side, you can now invoke the method by calling:

var result = await client.example.hello('World');

----------------------------

- serializing data

class: Company
fields:
name: String
foundedDate: DateTime?
  
----------------------------

Connecting to the database

database:
host: localhost
port: 8090
name: projectname
user: postgres

...



The password can be found in the file config/passwords.yaml.

development:
database: '<MY DATABASE PASSWORD>'

...


----------------------------

Migrations

cd mypod/mypod_server
serverpod create-migration


Migrations are then applied to the database as part of the server startup by adding the --apply-migrations flag.

$ cd mypod/mypod_server
$ dart bin/main.dart --apply-migrations
  
----------------------------

Object database mapping

class: Company
table: company
fields:
name: String
foundedDate: DateTime?
  
-----------------------------

Writing to database
Inserting a new row into the database is as simple as calling the static db.insertRow method.

var myCompany = Company(name: 'Serverpod corp.', foundedDate: DateTime.now());
myCompany = await Company.db.insertRow(session, myCompany);


-----------------------------

Reading from database
Retrieving a single row from the database can done by calling the static db.findById method and providing the id of the row.

var myCompany = await Company.db.findById(session, companyId);

You can also use an expression to do a more refined search through the db.findFirstRow(...). method. The where parameter is a typed expression builder. The builder's parameter, t, contains a description of the table and gives access to the table's columns.

var myCompany = await Company.db.findFirstRow(
session,
where: (t) => t.name.equals('My Company'),
);


-----------------------------



