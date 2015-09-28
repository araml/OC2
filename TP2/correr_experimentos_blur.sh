#!/bin/bash

# echo "corriendo los experimentos de blur"


# make clean

# make -f MakefileO2


# echo " "
# echo "**Corriendo mediciones blur ASM vs C"

# for j in {1..10}
# do
#   ./build/tp2 -i asm blur img/lena24.bmp 5 15 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_blur_ASM_C
#   echo -n " " >> ./python/test_blur_ASM_C
# done

# echo "" >> ./python/test_blur_ASM_C

# echo ""
# echo "med asm terminadas"

# for r in {1..10}
# do
#   ./build/tp2 -i c blur img/lena24.bmp 5 15 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_blur_ASM_C
#   echo -n " " >> ./python/test_blur_ASM_C
#   echo ""
#   echo $r
# done

# echo " "
# echo "**graficando"

# python ./python/graficar.py 2 ./python/test_blur_ASM_C "blur (ASM vs C)" "CPU Ticks"  Assembly "gcc (-02)"

# echo "" 
# echo "dame las imagenes"






# #SE ROMPE VER PORQUE
# echo " "
# echo "**Corriendo mediciones blur ASM vs C"

# for j in {1..10}
# do
#   ./build/tp2 -i asm blur img/lena24.bmp 5 15 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_blur_ASM_C_vsClang
#   echo -n " " >> ./python/test_blur_ASM_C_vsClang
# done

# echo "" >> ./python/test_blur_ASM_C_vsClang

# echo ""
# echo "med asm terminadas"

# for r in {1..10}
# do
#   ./build/tp2 -i c blur img/lena24.bmp 5 15 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_blur_ASM_C_vsClang
#   echo -n " " >> ./python/test_blur_ASM_C_vsClang
#   echo ""
#   echo $r
# done

# echo " "
# echo "**graficando"

# python ./python/graficar.py 2 ./python/test_blur_ASM_C_vsClang "blur (ASM vs C)" "CPU Ticks"  Assembly "clang (-O2)"

# echo "" 
# echo "dame las imagenes"




echo ""
make clean

make 

echo ""
echo "test radios blur contra tamaño"

for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 5 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM

for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 10 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM


for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 25 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM


for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 50 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM


for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 75 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM


for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 100 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM

for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 150 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM

for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 200 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM

for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 300 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM

for i in {1..10} 
do 
  ./build/tp2 -i asm blur ./experimentos/tests_size/game-824x824.bmp 5 400 | cut -d':' -f2 | sed '9,9!d' | xargs echo -n | tee -a ./python/test_radio_size_ASM
  echo -n " " >> ./python/test_radio_size_ASM
done

echo "" >> ./python/test_radio_size_ASM



python ./python/graficar.py 10 ./python/test_radio_size_ASM "blur ASM (radios)" "CPU Ticks"  5 10 25 50 75 100 150 200 300 400

