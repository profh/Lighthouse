//
//  Images.swift
//  Lighthouse
//
//  Created by Shirley Zhou on 11/26/18.
//  Copyright © 2018 Alina Yu. All rights reserved.
//

import Foundation

#if os(OSX)
import AppKit.NSImage
typealias AssetColorTypeAlias = NSColor
typealias Image = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
import UIKit.UIImage
typealias AssetColorTypeAlias = UIColor
typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

@available(*, deprecated, renamed: "ImageAsset")
typealias AssetType = ImageAsset

struct ImageAsset {
  fileprivate var name: String
  
  var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

struct ColorAsset {
  fileprivate var name: String
  
  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
  #endif
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
enum Asset {
  static let logicon = ImageAsset(name: "log_demo")
  static let welcome = ImageAsset(name: "welcome")
  static let key = ImageAsset(name: "Key")
  static let demo1 = ImageAsset(name: "demo1")
  static let demo2 = ImageAsset(name: "demo2")
  static let demo3 = ImageAsset(name: "demo3")
  static let demo4 = ImageAsset(name: "demo4")
  static let demo5 = ImageAsset(name: "demo5")
  static let demo6 = ImageAsset(name: "demo6")
  static let demo7 = ImageAsset(name: "demo7")
  static let demo8 = ImageAsset(name: "demo8")
  static let demo9 = ImageAsset(name: "demo9")
  
  // swiftlint:disable trailing_comma
  static let allColors: [ColorAsset] = [
  ]
  static let allImages: [ImageAsset] = [
    logicon,
    key,
    welcome,
    demo1,
    demo2,
    demo3,
    demo5,
    demo6,
    demo7,
    demo8,
    demo9
    ]
  // swiftlint:enable trailing_comma
  @available(*, deprecated, renamed: "allImages")
  static let allValues: [AssetType] = allImages
}

// swiftlint:enable identifier_name line_length nesting type_body_length type_name

extension Image {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
  message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX) || os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

extension AssetColorTypeAlias {
  #if swift(>=3.2)
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: asset.name, bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
  #endif
}

private final class BundleToken {}
