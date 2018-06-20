from cassandra.cluster import Cluster
cluster = Cluster(["node-0-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-1-server.cassandra.autoip.dcos.thisdcos.directory",
                   "node-2-server.cassandra.autoip.dcos.thisdcos.directory"])
session = cluster.connect("mykeyspace")

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
rows = session.execute('SELECT name, age, email FROM users')
for (name, age, email) in rows:
    print name, age, email