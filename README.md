# Bijarim
This project has two topics. 
The first thing is a meta object which can be used as a model object in a common application.
The second subject is a structure-patten which is composed of a data-loader and sections.

## Meta Object
In order to understand this concept property, you have to understand key value coding.
If you were not familiar with this, please understand it with this link first.
[Apple developer](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html)

The key point of meta object is very clear. 

```
public	class	Human	:	Meta	{

	@objc	dynamic	var	name:			String!
	@objc	dynamic	var	from:			String?
	@objc	dynamic	var	age:			NSNumber!
	@objc	dynamic	var	history:		[String]!
	@objc	dynamic	var	certificate:	Certificate!

	public	override	var descriptors:	[Descriptor]	{

		return [
			Descriptor(from: "nm", to: "name")									,
			NumberDescriptor(from: "age", to: "age")							,
			ListDescriptor(from: "history", to: "history")						,
			CertificateDescriptor(from: "certificate", to: "certificate")
		]
	}
}
```
