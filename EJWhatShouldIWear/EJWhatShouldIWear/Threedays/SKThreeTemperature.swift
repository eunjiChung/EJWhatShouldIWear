//
//  SKThreeTemperature.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreeTemperature: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let tmax1day = "tmax1day"
    static let tmax3day = "tmax3day"
    static let tmin3day = "tmin3day"
    static let tmin1day = "tmin1day"
    static let tmax2day = "tmax2day"
    static let tmin2day = "tmin2day"
  }

  // MARK: Properties
  public var tmax1day: String?
  public var tmax3day: String?
  public var tmin3day: String?
  public var tmin1day: String?
  public var tmax2day: String?
  public var tmin2day: String?

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
    tmax1day = json[SerializationKeys.tmax1day].string
    tmax3day = json[SerializationKeys.tmax3day].string
    tmin3day = json[SerializationKeys.tmin3day].string
    tmin1day = json[SerializationKeys.tmin1day].string
    tmax2day = json[SerializationKeys.tmax2day].string
    tmin2day = json[SerializationKeys.tmin2day].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = tmax1day { dictionary[SerializationKeys.tmax1day] = value }
    if let value = tmax3day { dictionary[SerializationKeys.tmax3day] = value }
    if let value = tmin3day { dictionary[SerializationKeys.tmin3day] = value }
    if let value = tmin1day { dictionary[SerializationKeys.tmin1day] = value }
    if let value = tmax2day { dictionary[SerializationKeys.tmax2day] = value }
    if let value = tmin2day { dictionary[SerializationKeys.tmin2day] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.tmax1day = aDecoder.decodeObject(forKey: SerializationKeys.tmax1day) as? String
    self.tmax3day = aDecoder.decodeObject(forKey: SerializationKeys.tmax3day) as? String
    self.tmin3day = aDecoder.decodeObject(forKey: SerializationKeys.tmin3day) as? String
    self.tmin1day = aDecoder.decodeObject(forKey: SerializationKeys.tmin1day) as? String
    self.tmax2day = aDecoder.decodeObject(forKey: SerializationKeys.tmax2day) as? String
    self.tmin2day = aDecoder.decodeObject(forKey: SerializationKeys.tmin2day) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(tmax1day, forKey: SerializationKeys.tmax1day)
    aCoder.encode(tmax3day, forKey: SerializationKeys.tmax3day)
    aCoder.encode(tmin3day, forKey: SerializationKeys.tmin3day)
    aCoder.encode(tmin1day, forKey: SerializationKeys.tmin1day)
    aCoder.encode(tmax2day, forKey: SerializationKeys.tmax2day)
    aCoder.encode(tmin2day, forKey: SerializationKeys.tmin2day)
  }

}
