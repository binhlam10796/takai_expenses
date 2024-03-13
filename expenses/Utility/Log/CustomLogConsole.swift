//
//  CustomLogConsole.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation

/* To modify these configuration, change for each target, custom falgs under build settings options **/
#if DEBUG
var logLevel: Int = CustomConsoleLogLevel.ll_VERBOSEFUNC.rawValue
#else
var logLevel: Int = CustomConsoleLogLevel.ll_ERROR.rawValue
#endif


enum CustomConsoleLogLevel: Int {
    case ll_ERROR           = 1
    case ll_WARNING         = 2
    case ll_INFO            = 3
    case ll_DEBUG           = 4
    case ll_VERBOSE         = 5
    case ll_PRINT           = 6
    case ll_VERBOSEFUNC     = 7
}


/// ERROR log message
///
/// - Parameters:
///   - message: log message
///   - fileName: file where log was printed
///   - functionName: Function name
///   - line: code line
public func LOGE(_ message: String, fileName: String = #file, functionName: String = #function, line: Int = #line) {
    
    if( logLevel >= CustomConsoleLogLevel.ll_DEBUG.rawValue ) {
        let timestamp = CustomDateUtils.currentStringDate()
        print("[EXPENSE ERROR] - \(timestamp) - \(fileName).\(functionName):\(line) - \(message)")
    }
}


/// WARNING log level
///
/// - Parameters:
///   - message: log message
///   - fileName: file where log was printed
///   - functionName: Function name
///   - line: code line
public func LOGW(_ message: String, fileName: String = #file, functionName: String = #function, line: Int = #line) {
    
    if( logLevel >= CustomConsoleLogLevel.ll_DEBUG.rawValue ) {
        let timestamp = CustomDateUtils.currentStringDate()
        print("EXPENSE WARN] - \(timestamp) - \(fileName).\(functionName):\(line) - \(message)")
    }
}


/// INFO log level
///
/// - Parameters:
///   - message: log message
///   - fileName: file where log was printed
///   - functionName: Function name
///   - line: code line
public func LOGI(_ message: String, fileName: String = #file, functionName: String = #function, line: Int = #line) {
    
    if( logLevel >= CustomConsoleLogLevel.ll_DEBUG.rawValue ) {
        let timestamp = CustomDateUtils.currentStringDate()
        print("[EXPENSE INFO] - \(timestamp) - \(fileName).\(functionName):\(line) - \(message)")
    }
}


/// DEBUG log level
///
/// - Parameters:
///   - message: log message
///   - fileName: file where log was printed
///   - functionName: Function name
///   - line: code line
public func LOGD(_ message: String, fileName: String = #file, functionName: String = #function, line: Int = #line) {
    
    if( logLevel >= CustomConsoleLogLevel.ll_DEBUG.rawValue ) {
        let timestamp = CustomDateUtils.currentStringDate()
        print("[EXPENSE DEBUG] - \(timestamp) - \(fileName).\(functionName):\(line) - \(message)")
    }
}


/// VERBOSE log level
///
/// - Parameters:
///   - message: log message
///   - functionName: Function name
///   - line: code line
public func LOGV(_ message: String, functionName: String = #function, line: Int = #line) {
    
    if( logLevel >= CustomConsoleLogLevel.ll_VERBOSEFUNC.rawValue ) {
        let timestamp = CustomDateUtils.currentStringDate()
        print("[EXPENSE VERBOSE] - \(timestamp) - \(functionName):\(line) - \(message)")
    }
}


/// PRINT log level
///
/// - Parameters:
///   - message: log message
///   - functionName: Function name
///   - line: code line
public func LOGP(_ message: String, functionName: String = #function, line: Int = #line) {

    if( logLevel >= CustomConsoleLogLevel.ll_PRINT.rawValue ) {
        print("[EXPENSE PRINT] - \(functionName):\(line) - \(message)")
    }
}


/// Static log message to print function begin
///
/// - Parameters:
///   - functionName: Function name that print log
public func LOGFSTART(functionName: String = #function) {
    
    if( logLevel >= CustomConsoleLogLevel.ll_VERBOSEFUNC.rawValue ) {
        let timestamp = CustomDateUtils.currentStringDate()
        print("\(timestamp) - \(functionName): START")
    }
}


/// Static log message to print function end
///
/// - Parameters:
///   - functionName: Function name that print log
public func LOGFEND(functionName: String = #function) {
    
    if( logLevel >= CustomConsoleLogLevel.ll_VERBOSEFUNC.rawValue ) {
        let timestamp = CustomDateUtils.currentStringDate()
        print("\(timestamp) - \(functionName): END")
    }
}

