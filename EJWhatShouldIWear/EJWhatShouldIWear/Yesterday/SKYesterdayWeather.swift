//
//  SKYesterdayWeather.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKYesterdayWeather: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let yesterday = "yesterday"
  }

  // MARK: Properties
  public var yesterday: [SKYesterdayYesterday]?

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
    if let items = json[SerializationKeys.yesterday].array { yesterday = items.map { SKYesterdayYesterday(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = yesterday { dictionary[SerializationKeys.yesterday] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.yesterday = aDecoder.decodeObject(forKey: SerializationKeys.yesterday) as? [SKYesterdayYesterday]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(yesterday, forKey: SerializationKeys.yesterday)
  }

}
