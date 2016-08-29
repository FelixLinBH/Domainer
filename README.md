# Domainer

[![Version](https://img.shields.io/cocoapods/v/Domainer.svg?style=flat)](http://cocoapods.org/pods/Domainer)
[![License](https://img.shields.io/cocoapods/l/Domainer.svg?style=flat)](http://cocoapods.org/pods/Domainer)
[![Platform](https://img.shields.io/cocoapods/p/Domainer.svg?style=flat)](http://cocoapods.org/pods/Domainer)

This library provides manage multi-domain table.

It provides:

* Manage multi-domain mapping main domain.  
* Find best domain which with low latency.
* Bypass dns resolver when IP table exists the domain.
* Swizzle NSURLRequest method in runtime.

## How To Use
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
## Screen shot

![Editor preferences pane](https://github.com/FelixLinBH/Domainer/blob/master/ScreenShot.png?raw=true)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Domainer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Domainer"
```

## Author

[Felix.lin](mailto:fly_81211@hotmail.com)

## License

Domainer is available under the MIT license. See the LICENSE file for more info.
