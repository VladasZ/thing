Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation
choco install git
choco install make
choco install python3
choco install firefox
choco install visualstudio2019community

$vc_components = @(
    "Microsoft.VisualStudio.Component.VC.ATL",
    "Microsoft.VisualStudio.Component.VC.ATLMFC",
    # "Microsoft.VisualStudio.Component.VC.Tools.ARM",
    # "Microsoft.VisualStudio.Component.VC.Tools.ARM64",
    "Microsoft.VisualStudio.Component.Windows81SDK"
)

$params = "--add " + [system.String]::Join(" --add ", $vc_components)
choco install visualstudio2017-workload-vctools `--params "$params" 

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
refreshenv

pip3 install cmake

Invoke-WebRequest https://win.rustup.rs/x86_64 -OutFile rustup-init.exe
.\rustup-init.exe

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
refreshenv
