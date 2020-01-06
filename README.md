# Bijarim
The topics is a meta object which can be used as a model object in a common application.

## Meta Object
In order to understand this concept property, you have to understand key value coding.
If you were not familiar with this, please understand it with this link first.
[Apple developer-Key value coding](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html)

The key point of a meta object is very clear. Convert the raw data easily to meta object.

```
{
  "history": [
    "2019",
    "2020"
  ],
  "nm": "Clayton",
  "ager": 31,
  "certificate": {
    "level": 3
  }
}
```

There are many raw data whice are presented by JSON type.
The value(destination) type is different which can be Integer, String, List or custom class.

```
public	class	Human	:	Meta	{

	@objc	dynamic	var	name: String!
	@objc	dynamic	var	from: String?
	@objc	dynamic	var	age:  NSNumber!
	@objc	dynamic	var	history: [String]!
	@objc	dynamic	var	certificate: Certificate!

	public	override	var descriptors:	[Descriptor]	{

		return [
			Descriptor(from: "nm", to: "name")		,
			NumberDescriptor(from: "age", to: "age")	,
			ListDescriptor(from: "history", to: "history")	,
			CertificateDescriptor(from: "certificate", to: "certificate")
		]
	}
}
```

### Descritor
Descriptor will be used to parse raw data. The from value will be used to find key in raw data and will map it to to value.
Because raw data-data type can be different from result data`s type, the descriptor describes return type.

### Meta
Data model will be used. It has multiple descriptos to parse each properties.

In application and test codes, There is a list type which can help you list up easlity in UITableView or UICollectionView.

