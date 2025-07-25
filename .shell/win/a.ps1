
echo a.ps
echo Helloy

del alias:gp -Force

New-Alias which get-command
New-Alias l lazygit

# scoop bucket add extras
# scoop install protobuf
# scoop install python

function touch {

  $file = $args[0]
  if($file -eq $null) {
    throw "No filename supplied"
  }

  if(Test-Path $file) {
    (Get-ChildItem $file).LastWriteTime = Get-Date
  }
  else {
    echo $null > $file
  }

}

function mn {
  cd ~/dev/work/my/money/Money
}

function te {
  cd ~/dev/test-engine
}

function th {
  cd ~/dev/thing
}

function clone {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        $args
    )

    cargo run --manifest-path $HOME/dev/thing/Cargo.toml -p clone --release --target-dir $HOME/dev/thing/target -- $args
}

function push {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        $args
    )

    cargo run --manifest-path $HOME/dev/thing/Cargo.toml -p push --release --target-dir $HOME/dev/thing/target -- $args
}

function st {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        $args
    )

    cargo run --manifest-path $HOME/dev/thing/Cargo.toml -p st --release --target-dir $HOME/dev/thing/target -- $args
}

function pull {
    $basePath = "$HOME\dev"
    # Recursively find all directories containing a .git folder
    $gitRepos = Get-ChildItem -Path $basePath -Directory -Recurse | Where-Object {
        Test-Path (Join-Path $_.FullName ".git")
    }

    foreach ($repo in $gitRepos) {
        Write-Host "Pulling: $($repo.FullName)"
        Push-Location $repo.FullName
        git pull
        Pop-Location
    }
}

function order {
  py $HOME/dev/thing/.shell/shorts/order.py
}

function unpack {
    py $HOME/dev/thing/.shell/shorts/unpack $args
}

function pack {
    py $HOME/dev/thing/.shell/shorts/pack $args
}

function pack5 {
    py $HOME/dev/thing/.shell/shorts/pack5 $args
}

function unpack_in_folder {
    py $HOME/dev/thing/.shell/shorts/unpack_in_folder
}

function k {
    kubectl $args
}

function publish {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        $args
    )
    
    cargo publish -p $args --allow-dirty
}

function hi {
    scoop update *
    rustup update
    pull
}

function bb {
    st
}
