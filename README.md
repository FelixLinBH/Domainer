# Domainer

> Multi-domain mapper.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/Domainer.svg?style=flat)](http://cocoapods.org/pods/Domainer)
[![License](https://img.shields.io/cocoapods/l/Domainer.svg?style=flat)](http://cocoapods.org/pods/Domainer)
[![Platform](https://img.shields.io/cocoapods/p/Domainer.svg?style=flat)](http://cocoapods.org/pods/Domainer)

This library provides manage multi-domain table.

![Editor preferences pane](https://github.com/FelixLinBH/Domainer/blob/master/ScreenShot.png?raw=true)

## Features

- [x] Manage multi-domain mapping main domain.  
- [x] Find best domain which with low latency.
- [x] Bypass dns resolver when IP table exists the domain.
- [x] Swizzle NSURLRequest method in runtime.

## Installation

*Domainer requires iOS 7.0 or later.*

### Using [CocoaPods](http://cocoapods.org)

1.  Add the pod `Domainer` to your [Podfile](http://guides.cocoapods.org/using/the-podfile.html).

        pod 'Domainer'

2.  Run `pod install` from Terminal, then open your app's `.xcworkspace` file to launch Xcode.
3.  Import the `Domainer.h` header. Typically, this should be written as `#import <Domainer.h>`

### Using [Carthage](https://github.com/Carthage/Carthage)

1.  Add the `felixLinBH/Domainer` project to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).

        github "felixLinBH/Domainer"

2.  Run `carthage update`, then follow the [additional steps required](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) to add the iOS and/or Mac frameworks into your project.
3.  Import the Domainer framework/module.
    *  Using Modules: `@import Domainer `
    *  Without Modules: `#import <Domainer.h>`  

## Usage example

###Create domain table with Json format###

```json
[
{"mainDomainName":"www.mainDomain.com","mapping":["www.domain1.com","www.domain2.com","www.domain3.com"]}
,
{"mainDomainName":"www.mainDomain2.com","mapping":["www.domain4.com","www.domain5.com","www.domain6.com"]}
]
```

###Set mapping###
```
[Domainer setMapper:jsonArray];
```

###Run with callback###
```
[Domainer runWithCompleteHandler:^(BOOL sucess, NSArray *noResolvedDomain) {
	if(sucess){
	 //Start query some api...
	};
}];
```
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Contribute

We would love for you to contribute to **Domainer**, check the ``LICENSE`` file for more info.

## Author

[Felix.lin](mailto:fly_81211@hotmail.com)

## License

Domainer is available under the MIT license. See the LICENSE file for more info.