//
//  SKHourlyWind.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKHourlyWind: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let wspd = "wspd"
    static let wdir = "wdir"
  }

  // MARK: Properties
  public var wspd: String?
  public var wdir: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    wspd = json[SerializationKeys.wspd].string
    wdir = json[SerializationKeys.wdir].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = wspd { dictionary[SerializationKeys.wspd] = value }
    if let value = wdir { dictionary[SerializationKeys.wdir] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.wspd = aDecoder.decodeObject(forKey: SerializationKeys.wspd) as? String
    self.wdir = aDecoder.decodeObject(forKey: SerializationKeys.wdir) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(wspd, forKey: SerializationKeys.wspd)
    aCoder.encode(wdir, forKey: SerializationKeys.wdir)
  }

}
