//
//  SKThreeFcst3hour.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreeFcst3hour: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let humidity = "humidity"
    static let sky = "sky"
    static let temperature = "temperature"
    static let wind = "wind"
    static let precipitation = "precipitation"
  }

  // MARK: Properties
  public var humidity: SKThreeHumidity?
  public var sky: SKThreeSky?
  public var temperature: SKThreeTemperature?
  public var wind: SKThreeWind?
  public var precipitation: SKThreePrecipitation?

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
    humidity = SKThreeHumidity(json: json[SerializationKeys.humidity])
    sky = SKThreeSky(json: json[SerializationKeys.sky])
    temperature = SKThreeTemperature(json: json[SerializationKeys.temperature])
    wind = SKThreeWind(json: json[SerializationKeys.wind])
    precipitation = SKThreePrecipitation(json: json[SerializationKeys.precipitation])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = humidity { dictionary[SerializationKeys.humidity] = value.dictionaryRepresentation() }
    if let value = sky { dictionary[SerializationKeys.sky] = value.dictionaryRepresentation() }
    if let value = temperature { dictionary[SerializationKeys.temperature] = value.dictionaryRepresentation() }
    if let value = wind { dictionary[SerializationKeys.wind] = value.dictionaryRepresentation() }
    if let value = precipitation { dictionary[SerializationKeys.precipitation] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.humidity = aDecoder.decodeObject(forKey: SerializationKeys.humidity) as? SKThreeHumidity
    self.sky = aDecoder.decodeObject(forKey: SerializationKeys.sky) as? SKThreeSky
    self.temperature = aDecoder.decodeObject(forKey: SerializationKeys.temperature) as? SKThreeTemperature
    self.wind = aDecoder.decodeObject(forKey: SerializationKeys.wind) as? SKThreeWind
    self.precipitation = aDecoder.decodeObject(forKey: SerializationKeys.precipitation) as? SKThreePrecipitation
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(humidity, forKey: SerializationKeys.humidity)
    aCoder.encode(sky, forKey: SerializationKeys.sky)
    aCoder.encode(temperature, forKey: SerializationKeys.temperature)
    aCoder.encode(wind, forKey: SerializationKeys.wind)
    aCoder.encode(precipitation, forKey: SerializationKeys.precipitation)
  }

}
