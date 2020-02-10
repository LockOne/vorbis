#vorbis : https://github.com/xiph/vorbis/archive/v1.3.6.tar.gz
#libogg : http://downloads.xiph.org/releases/ogg/libogg-1.3.4.tar.xz


ANGORA_LOC=/local_home/cheong/Angora_func
FUZZ_LOC=${ANGORA_LOC}


if [ ! -d "libogg" ]
then
  if ! wget http://downloads.xiph.org/releases/ogg/libogg-1.3.4.tar.xz ;
  then
    exit
  fi
  tar -xf libogg-1.3.4.tar.xz
  mv libogg-1.3.4 libogg
fi

cd libogg
rm -rf install
LIBOGG_PATH=`pwd`
CC=gclang ./configure --prefix=`pwd`/install --disable-shared
make clean
make -j 5
make install

cd ..

rm -rf install
./autogen.sh
CC=gclang ./configure --prefix=`pwd`/install --disable-shared  --with-ogg=${LIBOGG_PATH}/install \
          --with-ogg-libraries=${LIBOGG_PATH}/install/lib --with-ogg-includes=${LIBOGG_PATH}/install/include
make clean
make -j 5
make install

CXXFLAGS="-stdlib=libc++ -L./install/lib -I./install/include -Ilibogg/install/include -Llibogg/install/lib -lvorbisfile -lvorbis -logg"

gclang++ ./contrib/oss-fuzz/decode_fuzzer.cc ${CXXFLAGS} -o decode_fuzzer
get-bc decode_fuzzer

${ANGORA_LOC}/bin/angora-clang++ decode_fuzzer.bc ${CXXFLAGS} -o ${FUZZ_LOC}/subjects/vorbis.fast
mv FuncInfo.txt ${FUZZ_LOC}/FInfos/FuncInfo-vorbis.txt
USE_TRACK=1 ${ANGORA_LOC}/bin/angora-clang++ decode_fuzzer.bc ${CXXFLAGS} -o ${FUZZ_LOC}/subjects/vorbis.tt

exit
/local_home/cheong/Angora_func/tools/gen_library_abilist.sh /local_home/cheong/install/llvm4/lib/libomp.so functional >> libs_abilist.txt
ANGORA_TAINT_RULE_LIST=libs_abilist.txt  USE_TRACK=1 LDFLABS="-lc++" /local_home/cheong/Angora_func/bin/angora-clang++ magick.bc -stdlib=libc++ -fopenmp -fexceptions -pthread -lXt -lSM -lICE -lX11 -lgomp -lm -o ${FUZZ_LOC}/subjects/magick.tt
