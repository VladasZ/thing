echo "Helloy helloy"

export PATH=$PATH:~/dev/tools/gcc-arm-none-eabi/bin

export PYTHONPATH+=:~/.deps/build_tools

export PATH=$PATH:/usr/local/Cellar/python/3.7.2_1/Frameworks/Python.framework/Versions/3.7/include/python3.7m
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

export PATH=$PATH:/Users/vladas/Library/Android/sdk/ndk/20.0.5594570/

export ANDROID_SDK=/Users/vladas/Library/Android/sdk
export ANDROID_NDK=/Users/vladas/Library/Android/sdk/ndk/20.0.5594570

exe() {
	chmod +x $1
}

res() {
	~/.profile
}

source ~/.shell/paths.sh
