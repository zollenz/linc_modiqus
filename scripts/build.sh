#/bin/sh

cd ..

ROOT_DIR=$PWD
BUILD_DIR=$ROOT_DIR/test/cpp
LIB_DIR=$BUILD_DIR/lib
RESOURCES_DIR=$BUILD_DIR/Resources

echo Root dir : $ROOT_DIR
echo Build dir : $BUILD_DIR
echo Lib dir : $LIB_DIR

if [ -d $BUILD_DIR ]
then
rm -rfv $BUILD_DIR
fi

cd $ROOT_DIR/test

haxe build.hxml

if [ -d $LIB_DIR ]
then
rm -rfv $LIB_DIR
fi

mkdir $LIB_DIR
cp -R $ROOT_DIR/lib/csound/lib/ $LIB_DIR/
cp -R $ROOT_DIR/lib/libsndfile.1.dylib $LIB_DIR/

if [ -d $RESOURCES_DIR ]
then
rm -rfv $RESOURCES_DIR
fi

mkdir $RESOURCES_DIR
cp -R $ROOT_DIR/resources/csound $RESOURCES_DIR

$BUILD_DIR/Test