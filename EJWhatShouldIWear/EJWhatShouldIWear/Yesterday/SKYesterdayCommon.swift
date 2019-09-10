//
//  SKYesterdayCommon.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKYesterdayCommon: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let alertYn = "alertYn"
    static let stormYn = "stormYn"
  }

  // MARK: Properties
  public var alertYn: String?
  public var stormYn: String?

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
    alertYn = json[SerializationKeys.alertYn].string
    stormYn = json[SerializationKeys.stormYn].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = alertYn { dictionary[SerializationKeys.alertYn] = value }
    if let value = stormYn { dictionary[SerializationKeys.stormYn] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.alertYn = aDecoder.decodeObject(forKey: SerializationKeys.alertYn) as? String
    self.stormYn = aDecoder.decodeObject(forKey: SerializationKeys.stormYn) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(alertYn, forKey: SerializationKeys.alertYn)
    aCoder.encode(stormYn, forKey: SerializationKeys.stormYn)
  }

}
