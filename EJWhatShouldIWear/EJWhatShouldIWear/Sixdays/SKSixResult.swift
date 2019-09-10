//
//  SKSixResult.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKSixResult: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let code = "code"
    static let requestUrl = "requestUrl"
    static let message = "message"
  }

  // MARK: Properties
  public var code: Int?
  public var requestUrl: String?
  public var message: String?

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
    code = json[SerializationKeys.code].int
    requestUrl = json[SerializationKeys.requestUrl].string
    message = json[SerializationKeys.message].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = code { dictionary[SerializationKeys.code] = value }
    if let value = requestUrl { dictionary[SerializationKeys.requestUrl] = value }
    if let value = message { dictionary[SerializationKeys.message] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? Int
    self.requestUrl = aDecoder.decodeObject(forKey: SerializationKeys.requestUrl) as? String
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(code, forKey: SerializationKeys.code)
    aCoder.encode(requestUrl, forKey: SerializationKeys.requestUrl)
    aCoder.encode(message, forKey: SerializationKeys.message)
  }

}
