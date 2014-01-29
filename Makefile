BUILD_TOOL=xcodebuild
DEFAULT_BUILD_ARGS=-workspace Three\ Sixty\ Feedback.xcworkspace -scheme Three\ Sixty\ Feedback -sdk iphonesimulator

default: clean spec

clean:
	$(BUILD_TOOL) $(DEFAULT_BUILD_ARGS) clean

spec:
	$(BUILD_TOOL) $(DEFAULT_BUILD_ARGS) test

install:
	gem install cocoapods --no-ri --no-rdoc
	pod install

ci: clean spec
