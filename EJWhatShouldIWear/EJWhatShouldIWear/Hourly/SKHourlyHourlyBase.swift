//
//  SKHourlyHourlyBase.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKHourlyHourlyBase: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let weather = "weather"
    static let common = "common"
    static let result = "result"
  }

  // MARK: Properties
  public var weather: SKHourlyWeather?
  public var common: SKHourlyCommon?
  public var result: SKHourlyResult?

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
    weather = SKHourlyWeather(json: json[SerializationKeys.weather])
    common = SKHourlyCommon(json: json[SerializationKeys.common])
    result = SKHourlyResult(json: json[SerializationKeys.result])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = weather { dictionary[SerializationKeys.weather] = value.dictionaryRepresentation() }
    if let value = common { dictionary[SerializationKeys.common] = value.dictionaryRepresentation() }
    if let value = result { dictionary[SerializationKeys.result] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.weather = aDecoder.decodeObject(forKey: SerializationKeys.weather) as? SKHourlyWeather
    self.common = aDecoder.decodeObject(forKey: SerializationKeys.common) as? SKHourlyCommon
    self.result = aDecoder.decodeObject(forKey: SerializationKeys.result) as? SKHourlyResult
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(weather, forKey: SerializationKeys.weather)
    aCoder.encode(common, forKey: SerializationKeys.common)
    aCoder.encode(result, forKey: SerializationKeys.result)
  }

}
