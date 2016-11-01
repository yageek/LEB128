LEB128
==========

A library helping to deal with Little Endian Base 128.

master:
[![Build Status](https://travis-ci.org/yageek/LEB128.svg?branch=master)](https://travis-ci.org/yageek/LEB128)
develop:
[![Build Status](https://travis-ci.org/yageek/LEB128.svg?branch=develop)](https://travis-ci.org/yageek/LEB128)

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/LEB128.svg)](https://img.shields.io/cocoapods/v/LEB128.svg)
[![Platform](https://img.shields.io/cocoapods/p/LEB128.svg?style=flat)](http://cocoadocs.org/docsets/LEB128)

# Install

## Carthage

```
github "yageek/LEB128"
```

## Swift Package Manager

```
import PackageDescription

let package = Package(
    name: "myPackage",
    dependencies: [
    .Package(url: "https://github.com/yageek/LEB128.git", majorVersion: 1, minor: 0)
])
```

## Cocoapods

```
pod 'Leb128'
```

# Usage

```swift

    /// Encoding
    let buff = ByteBuffer(size: 5)
    let length = encodeUnsignedLEB(buff, value: value)
    print("Value: \(buff[0..<length])")
    

    let value: Int = 16256
    let buff = ByteBuffer(size: 5)
    let length = encodeSignedLEB(buff, value: value)
    print("Value: \(buff[0..<length])")


    /// Decoding

    let encodedSigned = decodeUnsignedLEB(ByteBuffer(elements:[0x80, 0x7f]))
    print("Value: \(encodedSigned)")

    let encodedUSigned = decodeSignedLEB(ByteBuffer(elements:[0x80, 0x7f]))
    print("Value: \(encodedUSigned)")

```

# License

LEB128 is released under the MIT license. See LICENSE for details.
