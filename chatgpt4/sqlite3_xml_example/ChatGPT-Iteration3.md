Certainly! Below is an example of how to create two tables in SQLite3: a `person` table and an `address` table, where the `address` table references the `person` table through a foreign key.

### Step 1: Create the SQLite Database

First, let's create a new SQLite3 database and the tables.

```bash
sqlite3 mydatabase.db <<EOF
-- Create the person table
CREATE TABLE person (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER
);

-- Create the address table with a foreign key referencing the person table
CREATE TABLE address (
    id INTEGER PRIMARY KEY,
    person_id INTEGER,
    street TEXT NOT NULL,
    city TEXT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id)
);

-- Insert some data into the person table
INSERT INTO person (name, age) VALUES ('John Doe', 30);
INSERT INTO person (name, age) VALUES ('Jane Smith', 25);

-- Insert some data into the address table
INSERT INTO address (person_id, street, city) VALUES (1, '123 Elm St', 'Springfield');
INSERT INTO address (person_id, street, city) VALUES (2, '456 Oak St', 'Shelbyville');

-- Verify the data
SELECT * FROM person;
SELECT * FROM address;
EOF
```

### Explanation

1. **Creating the `person` table**:
    - `id`: An integer primary key.
    - `name`: A text field that cannot be null.
    - `age`: An integer field.

2. **Creating the `address` table**:
    - `id`: An integer primary key.
    - `person_id`: An integer that references the `id` field of the `person` table.
    - `street`: A text field that cannot be null.
    - `city`: A text field that cannot be null.
    - `FOREIGN KEY (person_id) REFERENCES person(id)`: Establishes the foreign key relationship with the `person` table.

3. **Inserting Data**:
    - Two records are inserted into the `person` table.
    - Two records are inserted into the `address` table, each referencing a person by `person_id`.

### Step 2: Verifying the Data

You can verify the inserted data by querying the tables:

```bash
sqlite3 mydatabase.db <<EOF
SELECT * FROM person;
SELECT * FROM address;
EOF
```

### Step 3: Export Script

If you want to export these tables to XML using the previously created scripts, you can do so by running:

```bash
./export_table_to_xml.sh mydatabase.db person --include-schema
./export_table_to_xml.sh mydatabase.db address --include-schema
```

This will create `person.xml` and `address.xml` files with the table data and schema details.

### Example Output

**person.xml**:
```xml
<?xml version="1.0"?>
<database>
  <schema>
    <column name="id" type="INTEGER" primary_key="true" not_null="true" />
    <column name="name" type="TEXT" not_null="true" />
    <column name="age" type="INTEGER" />
  </schema>
  <table name="person">
    <row>
      <id>1</id>
      <name>John Doe</name>
      <age>30</age>
    </row>
    <row>
      <id>2</id>
      <name>Jane Smith</name>
      <age>25</age>
    </row>
  </table>
</database>
```

**address.xml**:
```xml
<?xml version="1.0"?>
<database>
  <schema>
    <column name="id" type="INTEGER" primary_key="true" not_null="true" />
    <column name="person_id" type="INTEGER" />
    <column name="street" type="TEXT" not_null="true" />
    <column name="city" type="TEXT" not_null="true" />
    <constraint type="foreign_key" columns="person_id" references_table="person" references_column="id" />
  </schema>
  <table name="address">
    <row>
      <id>1</id>
      <person_id>1</person_id>
      <street>123 Elm St</street>
      <city>Springfield</city>
    </row>
    <row>
      <id>2</id>
      <person_id>2</person_id>
      <street>456 Oak St</street>
      <city>Shelbyville</city>
    </row>
  </table>
</database>
```

This setup ensures that the `address` table properly references the `person` table, and the XML export includes detailed schema information, including foreign key constraints.
