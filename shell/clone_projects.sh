
cd ~/
mkdir dev
cd ~/dev

git clone --recursive git@github.com:VladasZ/local.git
git clone --recursive git@github.com:VladasZ/petuh.git

git clone --recursive git@github.com:vlasdasz/test-engine.git
cd ~/dev/test-engine
git checkout dev

cd ~/dev
mkdir games
cd ~/dev/games

git clone --recursive git@github.com:vlasdasz/labirintas.git
cd ~/dev/games/labirintas
git checkout dev

cd ~/dev
mkdir deps
cd ~/dev/deps

git clone --recursive git@github.com:VladasZ/refs.git
git clone --recursive git@github.com:VladasZ/hreads.git
git clone --recursive git@github.com:VladasZ/netrun.git



