mkdir -p strace
rm -rf strace
mkdir strace

cd strace
wget https://github.com/strace/strace/releases/download/v6.6/strace-6.6.tar.xz
tar xvf strace-6.6.tar.xz
cd strace-6.6/

CC=arm-linux-gcc ./configure --build x86_64-pc-linux-gnu --host arm-unknown-linux-gnu LDFLAGS="-static -pthread" --enable-mpers=check

make

cd ../../
