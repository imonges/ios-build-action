#!/bin/bash -e

script_path=$(cd $(dirname ${0}); pwd)
cp -r ${script_path}/fastlane ./
cp ${script_path}/Gemfile ./

echo "Testflight_upload: ${TESTFLIGHT_UPLOAD}"
echo "Build_pods: ${BUILD_PODS}"
echo "Ios_App_Id: ${IOS_APP_ID}"

bundle add fastlane --version ${FASTLANE_VERSION}

if [[ $BROWSERSTACK_UPLOAD = true || $BUILD_PODS = true ]]; then
  bundle add cocoapods
fi

bundle install

# If the variable FASTLANE_ENV is set then run fastlane with the --env equal to the variable.
if [ -n "${FASTLANE_ENV}" ]; then
    echo "Running fastlane with environment: ${FASTLANE_ENV}"
    fastlane --env ${FASTLANE_ENV} build
else
    echo "Running fastlane"
    fastlane build
fi
