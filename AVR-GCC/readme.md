# Installatio des neusten AVR-GCC

## Vorbereitung
```bash
sudo apt update
sudo apt install build-essential libgmp-dev libmpfr-dev libmpc-dev texinfo flex bison libisl-dev
```

## GCC runterladen

Abhängikeiten runterladen:
```bash
git clone git://gcc.gnu.org/git/gcc.git
cd gcc
./contrib/download_prerequisites
```

## AVR-GCC bauen
```bash
mkdir ../gcc-build
cd ../gcc-build
../gcc/configure --target=avr --enable-languages=c,c++ --disable-nls --disable-libssp --with-dwarf2 --prefix=/usr/local/avr-gcc
make -j$(nproc)
sudo make install
```

## avr-libc runterladen
```bash
git clone https://github.com/avrdudes/avr-libc.git
```

## avr-libc bauen
```bash
cd avr-libc
./bootstrap
./configure --prefix=/usr/local/avr-gcc --build=$(./config.guess) --host=avr
make -j$(nproc)
sudo make install
```


## Vor dem Ausführen von acr-gcc
Umgebungsvariable setzen:
`export PATH=/usr/local/avr-gcc/bin:$PATH`



