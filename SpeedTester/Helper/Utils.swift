//
//  Utils.swift
//  SpeedTester
//
//  Created by Ranosys on 14/06/17.
//  Copyright © 2017 Jogendar. All rights reserved.
//

import Foundation

class Utils {
    static let fileManager = FileManager.default
    static let DocumentDirURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    static func writeSpeedDataIntoFile(speedData: String) {
        var fileData = speedData
        fileData = "\n" + fileData
        let fileURL = self.DocumentDirURL.appendingPathComponent("SpeedData.txt")
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            //Append to file
            fileHandle.seekToEndOfFile()
            fileHandle.write(fileData.data(using: String.Encoding.utf8)!)
        } else {
            //Create new file
            do {
                try fileData.write(toFile: fileURL.path, atomically: true, encoding: String.Encoding.utf8)
            } catch {
                print("Error creating \(fileURL.path)")
            }
        }
    }
}
