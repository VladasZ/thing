#!/usr/bin/env python3

import os
import subprocess

# get current working directory
cwd = os.getcwd()

# loop through all directories in the current directory
for folder in os.listdir(cwd):
    # check if the folder name ends with "-service"

    if folder.endswith("-service"):

        # create the path to the migration directory
        migration_path = os.path.join(cwd, folder, "migrations")
        # check if the migration directory exists
        if os.path.exists(migration_path):
            
            print(folder)

            db_name = folder.rstrip("-service")

            with open(folder + "/.env", "w") as f:
                f.write("DATABASE_URL=postgresql://test:tester@localhost/" + db_name)

            # change current working directory to the service folder
            os.chdir(os.path.join(cwd, folder))
            # run the sqlx database drop command
            subprocess.run(["sqlx", "database", "drop", "-y"])
            # run the sqlx database setup command
            subprocess.run(["sqlx", "database", "setup"])
            # change back to the original directory
            os.chdir(cwd)
