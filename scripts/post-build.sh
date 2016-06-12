#/bin/sh


cd ..

ROOT_DIR=$PWD
BUILD_DIR=$ROOT_DIR/test/cpp
LIB_DIR=$BUILD_DIR/Frameworks

echo Root dir : $ROOT_DIR
echo Build dir : $BUILD_DIR
echo Lib dir : $LIB_DIR

if [ -d $LIB_DIR ]
then
rm -rfv $LIB_DIR
fi

mkdir $LIB_DIR

cp -R lib/csound/ $LIB_DIR/

cd $BUILD_DIR

install_name_tool -change @executable_path/lib/CsoundLib.framework/Versions/6.0/CsoundLib \
	@executable_path/Frameworks/CsoundLib.framework/Versions/6.0/CsoundLib \
	Test

otool -L Test

cd $LIB_DIR/CsoundLib.framework

install_name_tool -id @executable_path/Frameworks/CsoundLib.framework/CsoundLib CsoundLib
install_name_tool -change \
	@executable_path/lib/CsoundLib.framework/Versions/6.0/Resources/libsndfile.1.dylib \
	@executable_path/Frameworks/CsoundLib.framework/Versions/6.0/Resources/libsndfile.1.dylib \
	CsoundLib

otool -L CsoundLib

# cd Resources
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libsndfile.1.dylib libsndfile.1.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libampmidid.dylib libampmidid.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libcellular.dylib libcellular.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libclop.dylib libclop.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libcmidi.dylib libcmidi.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libcontrol.dylib libcontrol.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libcs_date.dylib libcs_date.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libdoppler.dylib libdoppler.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libfareygen.dylib libfareygen.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libfractalnoise.dylib libfractalnoise.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libplaterev.dylib libplaterev.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/librtauhal.dylib librtauhal.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libscansyn.dylib libscansyn.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libsignalflowgraph.dylib libsignalflowgraph.dylib
# install_name_tool -id @executable_path/../Frameworks/CsoundLib.framework/Versions/6.0/Resources/libsystem_call.dylib libsystem_call.dylib