360-iOS
=======

360 Feedback for iOS
[![Build Status](https://magnum.travis-ci.com/DefactoSoftware/360-iOS.png?token=A49pyqNGPBpMX52bcsLm)](https://magnum.travis-ci.com/DefactoSoftware/360-iOS)

##Dependencies
1. XCode 5 & iOS 7 SDK
2. Ruby
3. Rubygems
3. CocoaPods

###Installing CocoaPods
(This requires ruby and rubygems which should be installed on OSX by default).
Via command-line:
```
$ [sudo] gem install cocoapods 
$ pod setup
```

Navigate to the projects folder and:
```$ pod install```

This generates a `.xcworkspace` file with our project and a separate project for the pods. It can be opened from the command line by doing:
```open Three\ Sixty\ Feedback.xcworkspace/```
or just double click the file in Finder.
