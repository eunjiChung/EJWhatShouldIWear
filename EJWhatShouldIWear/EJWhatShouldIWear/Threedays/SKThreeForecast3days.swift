//
//  SKThreeForecast3days.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreeForecast3days: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let fcst6hour = "fcst6hour"
    static let timeRelease = "timeRelease"
    static let fcst3hour = "fcst3hour"
    static let grid = "grid"
    static let fcstdaily = "fcstdaily"
  }

  // MARK: Properties
  public var fcst6hour: SKThreeFcst6hour?
  public var timeRelease: String?
  public var fcst3hour: SKThreeFcst3hour?
  public var grid: SKThreeGrid?
  public var fcstdaily: SKThreeFcstdaily?

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
    fcst6hour = SKThreeFcst6hour(json: json[SerializationKeys.fcst6hour])
    timeRelease = json[SerializationKeys.timeRelease].string
    fcst3hour = SKThreeFcst3hour(json: json[SerializationKeys.fcst3hour])
    grid = SKThreeGrid(json: json[SerializationKeys.grid])
    fcstdaily = SKThreeFcstdaily(json: json[SerializationKeys.fcstdaily])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = fcst6hour { dictionary[SerializationKeys.fcst6hour] = value.dictionaryRepresentation() }
    if let value = timeRelease { dictionary[SerializationKeys.timeRelease] = value }
    if let value = fcst3hour { dictionary[SerializationKeys.fcst3hour] = value.dictionaryRepresentation() }
    if let value = grid { dictionary[SerializationKeys.grid] = value.dictionaryRepresentation() }
    if let value = fcstdaily { dictionary[SerializationKeys.fcstdaily] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.fcst6hour = aDecoder.decodeObject(forKey: SerializationKeys.fcst6hour) as? SKThreeFcst6hour
    self.timeRelease = aDecoder.decodeObject(forKey: SerializationKeys.timeRelease) as? String
    self.fcst3hour = aDecoder.decodeObject(forKey: SerializationKeys.fcst3hour) as? SKThreeFcst3hour
    self.grid = aDecoder.decodeObject(forKey: SerializationKeys.grid) as? SKThreeGrid
    self.fcstdaily = aDecoder.decodeObject(forKey: SerializationKeys.fcstdaily) as? SKThreeFcstdaily
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(fcst6hour, forKey: SerializationKeys.fcst6hour)
    aCoder.encode(timeRelease, forKey: SerializationKeys.timeRelease)
    aCoder.encode(fcst3hour, forKey: SerializationKeys.fcst3hour)
    aCoder.encode(grid, forKey: SerializationKeys.grid)
    aCoder.encode(fcstdaily, forKey: SerializationKeys.fcstdaily)
  }

}
