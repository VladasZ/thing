
echo a.ps
echo Helloy

del alias:gp -Force

New-Alias which get-command
New-Alias l lazygit

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

function order {
  py $HOME/dev/thing/.shell/shorts/order.py
}

function publish {
    param (
        [Parameter(ValueFromRemainingArguments=$true)]
        $args
    )
    
    cargo publish -p $args --allow-dirty
}
