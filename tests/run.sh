make clean
make Q=31 M=30 N=15
./xl --challenge ./tests/ToyExample-type3-n15-seed0 --all
make clean
make Q=31 M=40 N=20
./xl --challenge ./tests/ToyExample-type3-n20-seed0 --all

make clean
make Q=2 M=30 N=15
./xl --challenge ./tests/ToyExample-type1-n15-seed0 --all
make clean
make Q=2 M=40 N=20
./xl --challenge ./tests/ToyExample-type1-n20-seed0 --all

make clean
make Q=16 M=30 N=15
./xl --challenge ./tests/q16_15_30 --all
make clean
make Q=16 M=40 N=20
./xl --challenge ./tests/q16_20_40 --all
