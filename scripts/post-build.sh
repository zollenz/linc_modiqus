#/bin/sh

cd ..

ROOT_DIR=$PWD
BUILD_DIR=$ROOT_DIR/test/cpp
LIB_DIR=$BUILD_DIR/lib
RESOURCES_DIR=$BUILD_DIR/Resources

echo Root dir : $ROOT_DIR
echo Build dir : $BUILD_DIR
echo Lib dir : $LIB_DIR

if [ -d $LIB_DIR ]
then
rm -rfv $LIB_DIR
fi

mkdir $LIB_DIR
cp -R lib/csound/lib/ $LIB_DIR/
cp -R lib/libsndfile.1.dylib $LIB_DIR/

if [ -d $RESOURCES_DIR ]
then
rm -rfv $RESOURCES_DIR
fi

mkdir $RESOURCES_DIR
cp -R resources/csound $RESOURCES_DIR