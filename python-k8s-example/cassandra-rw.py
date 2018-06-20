from cassandra.cluster import Cluster
cluster = Cluster(["node-0-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-1-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-2-server.cassandra.autoip.dcos.thisdcos.directory"])
session = cluster.connect()
KEYSPACE = "dcos"
rows = session.execute("SELECT keyspace_name FROM system_schema.keyspaces")
if KEYSPACE in [row[0] for row in rows]:
    print("dropping existing keyspace...")
    session.execute("DROP KEYSPACE " + KEYSPACE)

print("creating keyspace...")
session.execute("""
        CREATE KEYSPACE %s
        WITH replication = { 'class': 'SimpleStrategy', 'replication_factor': '2' }
        """ % KEYSPACE)

print("setting keyspace...")
session.set_keyspace(KEYSPACE)
print("creating table...")
session.execute("""
        CREATE TABLE users (
            name text,
            credits int,
            user_id text,
            PRIMARY KEY (name)
        )
        """)
print("Getting ready to insert rows into the Cassandra table:")
session.execute(
    """
    INSERT INTO users (name, credits, user_id)
    VALUES (%s, %s, %s)
    """,
    ("John O'Reilly", 42, "1")
)

print("Cassandra row inserts into USERS table is now complete.")

print(" ")
print("Users Table Contents")
print("Name, Age, ID")
rows = session.execute('SELECT name, credits, user_id FROM users')
for (name, credits, user_id) in rows:
    print(name, credits, user_id)