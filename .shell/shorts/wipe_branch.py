#!/usr/bin/env python3

import os
from git import Repo
# pip install gitpython

def delete_local_branches_except_main():
    repo = Repo(os.getcwd())
    branches = repo.branches
    current_branch = repo.active_branch

    # Determine main branch name ("master" or "main")
    main_branch_name = "master" if "master" in branches else "main"

    # Checkout to main branch
    if current_branch.name != main_branch_name:
        repo.heads[main_branch_name].checkout()
        print(f'Checked out to {main_branch_name} branch.')

    # Delete all local branches except main
    for branch in branches:
        if branch.name != main_branch_name:
            # repo.delete_head(branch, force=True)
            repo.delete_head(branch)
            print(f'Deleted local branch: {branch.name}')

    print('Completed.')

delete_local_branches_except_main()
