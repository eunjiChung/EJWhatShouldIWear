//
//  EJFiveDaysMain.swift
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/06/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class EJFiveDaysMain: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let grndLevel = "grnd_level"
    static let tempMin = "temp_min"
    static let tempMax = "temp_max"
    static let temp = "temp"
    static let seaLevel = "sea_level"
    static let pressure = "pressure"
    static let humidity = "humidity"
    static let tempKf = "temp_kf"
  }

  // MARK: Properties
  public var grndLevel: Float?
  public var tempMin: Float?
  public var tempMax: Float?
  public var temp: Float?
  public var seaLevel: Float?
  public var pressure: Float?
  public var humidity: Int?
  public var tempKf: Float?

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
    grndLevel = json[SerializationKeys.grndLevel].float
    tempMin = json[SerializationKeys.tempMin].float
    tempMax = json[SerializationKeys.tempMax].float
    temp = json[SerializationKeys.temp].float
    seaLevel = json[SerializationKeys.seaLevel].float
    pressure = json[SerializationKeys.pressure].float
    humidity = json[SerializationKeys.humidity].int
    tempKf = json[SerializationKeys.tempKf].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = grndLevel { dictionary[SerializationKeys.grndLevel] = value }
    if let value = tempMin { dictionary[SerializationKeys.tempMin] = value }
    if let value = tempMax { dictionary[SerializationKeys.tempMax] = value }
    if let value = temp { dictionary[SerializationKeys.temp] = value }
    if let value = seaLevel { dictionary[SerializationKeys.seaLevel] = value }
    if let value = pressure { dictionary[SerializationKeys.pressure] = value }
    if let value = humidity { dictionary[SerializationKeys.humidity] = value }
    if let value = tempKf { dictionary[SerializationKeys.tempKf] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.grndLevel = aDecoder.decodeObject(forKey: SerializationKeys.grndLevel) as? Float
    self.tempMin = aDecoder.decodeObject(forKey: SerializationKeys.tempMin) as? Float
    self.tempMax = aDecoder.decodeObject(forKey: SerializationKeys.tempMax) as? Float
    self.temp = aDecoder.decodeObject(forKey: SerializationKeys.temp) as? Float
    self.seaLevel = aDecoder.decodeObject(forKey: SerializationKeys.seaLevel) as? Float
    self.pressure = aDecoder.decodeObject(forKey: SerializationKeys.pressure) as? Float
    self.humidity = aDecoder.decodeObject(forKey: SerializationKeys.humidity) as? Int
    self.tempKf = aDecoder.decodeObject(forKey: SerializationKeys.tempKf) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(grndLevel, forKey: SerializationKeys.grndLevel)
    aCoder.encode(tempMin, forKey: SerializationKeys.tempMin)
    aCoder.encode(tempMax, forKey: SerializationKeys.tempMax)
    aCoder.encode(temp, forKey: SerializationKeys.temp)
    aCoder.encode(seaLevel, forKey: SerializationKeys.seaLevel)
    aCoder.encode(pressure, forKey: SerializationKeys.pressure)
    aCoder.encode(humidity, forKey: SerializationKeys.humidity)
    aCoder.encode(tempKf, forKey: SerializationKeys.tempKf)
  }

}
