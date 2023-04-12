#!/usr/bin/env python3
import os
import sys
import platform


def get_profile_path():
    # Determine the profile file based on the user's platform and shell
    system = platform.system()
    shell = os.environ.get('SHELL', '').split('/')[-1]
    if system == 'Linux':
        if shell == 'bash':
            return os.path.expanduser('~/.bashrc')
        elif shell == 'zsh':
            return os.path.expanduser('~/.zshrc')
        elif shell == 'fish':
            return os.path.expanduser('~/.config/fish/config.fish')
    elif system == 'Darwin':
        if shell == 'bash':
            return os.path.expanduser('~/.bash_profile')
        elif shell == 'zsh':
            return os.path.expanduser('~/.zshrc')
        elif shell == 'fish':
            return os.path.expanduser('~/.config/fish/config.fish')
    elif system == 'Windows':
        return os.path.expanduser('~\\Documents\\WindowsPowerShell\\Microsoft.PowerShell_profile.ps1')
    return None


def add_to_path(directory):
    if platform.system() == 'Windows':
        # Use the Windows syntax for adding a directory to the PATH
        os.environ['PATH'] += os.pathsep + directory
        print(f"Directory added to PATH: {directory}")

        # Modify the PATH environment variable in the registry
        # to make the change permanent
        command = f'setx /M PATH "%PATH%;{directory}"'
        os.system(command)
    else:
        # Use the Unix/Mac syntax for adding a directory to the PATH
        os.environ['PATH'] += ':' + directory
        print(f"Directory added to PATH: {directory}")

        # Modify the PATH environment variable in the shell
        # configuration file to make the change permanent
        shell_config = os.path.expanduser(get_profile_path())
        with open(shell_config, 'a') as f:
            f.write(f'\nexport PATH=$PATH:{directory}\n')
        print(f"Updated shell configuration file: {shell_config}")

if __name__ == '__main__':
    directory = sys.argv[1]

    directory = os.path.expanduser(directory)

    print(f"Adding to path: {directory}");

    add_to_path(directory)
