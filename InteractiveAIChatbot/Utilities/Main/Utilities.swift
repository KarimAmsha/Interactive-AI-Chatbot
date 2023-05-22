//
//  Utilities.swift
//  M4B
//
//  Created by Karim Amsha on 7/20/22.
//

import Foundation
import UIKit
import AVKit
import MobileCoreServices
import SDWebImageSwiftUI
import CoreLocation
import Vision
import NaturalLanguage
import SwiftUI

class Utilities: NSObject {
    static func detectedLanguage(for string: String) -> Languages? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(string)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode) ?? ""

        if let languageCode = NSLinguisticTagger.dominantLanguage(for: string) {
            print(languageCode)
        } else {
            print("Unknown language")
        }

        return Languages(id: "", name: detectedLanguage, code: languageCode)
    }

    static func highlightedText(str: String, searched: [String]) -> Text {
        
        guard !str.isEmpty && !searched.isEmpty else { return Text(str).foregroundColor(.black).fontWeight(.medium) }
        var result: Text!
        let parts = str.components(separatedBy: " ")
        
        for part_index in parts.indices {
            result = (result == nil ? Text("") : result + Text(" ")).foregroundColor(.red).fontWeight(.bold)
            if searched.contains(where: {$0.lowercased() == parts[part_index].lowercased().trimmingCharacters(in: .punctuationCharacters)}) {
                result = result + Text(parts[part_index])
                    .foregroundColor(.black).fontWeight(.medium)
            }
            else {
                result = result + Text(parts[part_index]).foregroundColor(.red).fontWeight(.bold)
            }
        }
        
        return result ?? Text(str).foregroundColor(.black).fontWeight(.medium)
    }
    
    static func highlight(searchText: String, targetText: String, color: UIColor = .yellow) -> NSAttributedString? {
        do {
            let mutableString = NSMutableAttributedString(string: targetText)
            let regex = try NSRegularExpression(pattern: searchText, options: .caseInsensitive)
            
            for match in regex.matches(in: targetText, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: targetText.utf16.count)) as [NSTextCheckingResult] {
                mutableString.addAttribute(NSAttributedString.Key.backgroundColor, value: color, range: match.range)
            }
            return mutableString
        } catch {
            print(error)
            return nil
        }
    }

    static func generateAttributedString(with searchTerm: String, targetString: String) -> NSAttributedString? {

        let attributedString = NSMutableAttributedString(string: targetString)
        do {
            let regex = try NSRegularExpression(pattern: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current), options: .caseInsensitive)
            let range = NSRange(location: 0, length: targetString.utf16.count)
            for match in regex.matches(in: targetString.folding(options: .diacriticInsensitive, locale: .current), options: .withTransparentBounds, range: range) {
                attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold), range: match.range)
            }
            return attributedString
        } catch {
            NSLog("Error creating regular expresion: \(error)")
            return nil
        }
    }

    static func returnAttributeString(_ str1: String, _ str2: String) -> NSMutableAttributedString {
        //            let difference = zip("Add Instance For Factory", "Add Instance For Factor").filter{ $0 != $1 }
        //            print("dddd \(difference)")
//                            let str1 = "Add Instance For Factory karim tes"
//                            let str2 = "Add Instance For Factor karim test"
//                            let arr1 = str1.components(separatedBy: " ")
//                            let arr2 = str2.components(separatedBy: " ")
//
//                            let difference = arr1.difference(from: arr2)
//                            print("dddd \(difference)")
//                let str1 = "this is the first day in my work"
//                let str2 = "this is a great day"
//
//                let words1 = Set(str1.split(separator: " "))
//                let words2 = Set(str2.split(separator: " "))

//                let str3 = words1.intersection(words2).reduce("") { $0 + $1 + " "}
//                let str3 = words1.intersection(words2).sorted {
//                    words1.index(of: $0)! < words1.index(of: $1)!
//                }.reduce("") { $0 + $1 + " "}
//                let str3 = Array(words1.intersection(words2)).joined(separator: " ")
//                let str1 = "this is the first day in my work"
//                let str2 = "this is a great day"
//
//                let matchingWords = str1.matchingWords(in: str2)  // ["this", "is", "day"]
//
//                let str3 = matchingWords.joined(separator: " ")   // "this is day"


        let correctString = str1//"The soldiers stormed into the village just after sunrise"
        let incorrectString = str2//"solder stormed village just after sunrise"
        let correctArray = Array(correctString)
        let incorrectArray = Array(incorrectString)
        var correctMutableString = NSMutableAttributedString(string: correctString)

        print("str1 \(correctArray.count)")
        print("str2 \(incorrectArray.count)")

        var currentPosition = 0
        for char in incorrectArray {
          guard let position = correctArray.index(of: char, greaterThan: currentPosition) else {
            continue
          }
          while currentPosition < position {
            correctMutableString.setCharacterColor(at: currentPosition)
            currentPosition = currentPosition + 1
          }
          currentPosition = position + 1
        }

//                labelCorrect.attributedText = correctMutableString
//                labelIncorrect.attributedText = NSMutableAttributedString(string: incorrectString)
        return correctMutableString
//        return NSMutableAttributedString(string: incorrectString)
//        print("labelCorrect \(correctMutableString)")
//        print("labelIncorrect \(NSMutableAttributedString(string: incorrectString))")

    }

    static func formatSecondsToHMS(_ seconds: TimeInterval) -> String {
      let secondsInt:Int = Int(seconds.rounded(.towardZero))
      
      let dh: Int = (secondsInt/3600)
      let dm: Int = (secondsInt - (dh*3600))/60
      let ds: Int = secondsInt - (dh*3600) - (dm*60)
      
      let hs = "\(dh > 0 ? "\(dh):" : "")"
      let ms = "\(dm<10 ? "0" : "")\(dm):"
      let s = "\(ds<10 ? "0" : "")\(ds)"
      
      return hs + ms + s
    }

    static func getFileDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }

    static func recognizeText(from images: [CGImage]) -> String {
        var entireRecognizedText = ""
        let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
            guard error == nil else { return }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            let maximumRecognitionCandidates = 1
            for observation in observations {
                guard let candidate = observation.topCandidates(maximumRecognitionCandidates).first else { continue }
                
                entireRecognizedText += "\(candidate.string)\n"
            }
        }
        recognizeTextRequest.recognitionLevel = .accurate
        
        for image in images {
            let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
            
            try? requestHandler.perform([recognizeTextRequest])
        }
        
        return entireRecognizedText
    }
    static func thumbnailFromPdf(withUrl url: URL, pageNumber: Int = 1, width: CGFloat = 240) -> UIImage? {
        guard
            let pdf = CGPDFDocument(url as CFURL),
            let page = pdf.page(at: pageNumber)
        else { return nil }

        var pageRect = page.getBoxRect(.mediaBox)
        let pdfScale = width / pageRect.size.width
        pageRect.size = CGSize(width: pageRect.size.width * pdfScale, height: pageRect.size.height * pdfScale)
        pageRect.origin = .zero

        UIGraphicsBeginImageContext(pageRect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.white.cgColor)
            context.fill(pageRect)
            context.saveGState()

            context.translateBy(x: 0.0, y: pageRect.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.concatenate(page.getDrawingTransform(.mediaBox, rect: pageRect, rotate: 0, preserveAspectRatio: true))

            context.drawPDFPage(page)
            context.restoreGState()
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()
        defer { UIGraphicsEndImageContext() }
        return image
    }

    static func randomString(length: Int) -> String {
         
         let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-"
         let len = UInt32(letters.length)
         
         var randomString = ""
         
         for _ in 0 ..< length {
             let rand = arc4random_uniform(len)
             var nextChar = letters.character(at: Int(rand))
             randomString += NSString(characters: &nextChar, length: 1) as String
         }
         
         return randomString
     }
    
    static func randomNumber(length: Int) -> String {
         
         let letters : NSString = "0123456789"
         let len = UInt32(letters.length)
         
         var randomString = ""
         
         for _ in 0 ..< length {
             let rand = arc4random_uniform(len)
             var nextChar = letters.character(at: Int(rand))
             randomString += NSString(characters: &nextChar, length: 1) as String
         }
         
         return randomString
     }
    
    static func compressVideo( outputFileURL: URL ,completion:@escaping (_ data: Data?,_ error:String?)-> Void) {
        
        guard let data = NSData(contentsOf: outputFileURL as URL) else {
            return
        }
        
        print("File size before compression: \(Double(data.length / 1048576)) mb")
        let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".mp4")
        let urlAsset = AVURLAsset(url: outputFileURL, options: nil)
        
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPreset960x540) else {
            completion(nil,"Faild to upload video , please try again")
            return
        }
        
        exportSession.outputURL = compressedURL
        exportSession.outputFileType = .mp4
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously { () -> Void in
            
            switch exportSession.status {
            case .unknown:
                completion(nil,"Faild to upload video , please try again")
                break
            case .waiting:
                break
            case .exporting:
                break
            case .completed:
                guard let compressedData = NSData(contentsOf: compressedURL) else {
                    completion(nil,"Faild to upload video , please try again")
                    return
                }
                print("File size after compression: \(Double(compressedData.length / 1048576)) mb")
                DispatchQueue.main.async {
                    completion(compressedData as Data,nil)
                }
            case .failed:
                completion(nil,"Faild to upload video , please try again")
                break
            case .cancelled:
                completion(nil,"Faild to upload video , please try again")
                break
            }
        }
    }
            
    static func cropVideo(sourceURL1: URL, statTime:Float, endTime:Float,completion:@escaping (_ url: URL?,_ error:String?)-> Void) {
        let manager = FileManager.default

        guard let documentDirectory = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {return}
        let mediaType = "mp4"
        if mediaType == kUTTypeMovie as String || mediaType == "mp4" as String {
            let asset = AVAsset(url: sourceURL1 as URL)
            let length = Float(asset.duration.value) / Float(asset.duration.timescale)
            print("video length: \(length) seconds")

            let start = statTime
            let end = endTime

            var outputURL = documentDirectory.appendingPathComponent("output")
            do {
                try manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
                outputURL = outputURL.appendingPathComponent("\(UUID().uuidString).\(mediaType)")
            }catch let error {
                print(error)
            }

            //Remove existing file
            _ = try? manager.removeItem(at: outputURL)


            guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {return}
            exportSession.outputURL = outputURL
            exportSession.outputFileType = .mp4

            let startTime = CMTime(seconds: Double(start ), preferredTimescale: 1000)
            let endTime = CMTime(seconds: Double(end ), preferredTimescale: 1000)
            let timeRange = CMTimeRange(start: startTime, end: endTime)

            exportSession.timeRange = timeRange
            exportSession.exportAsynchronously{
                switch exportSession.status {
                case .completed:
                    print("exported at \(outputURL)")
                    completion(outputURL,"")
                case .failed:
                    print("failed \(exportSession.error)")
                    completion(nil,exportSession.error?.localizedDescription)
                case .cancelled:
                    print("cancelled \(exportSession.error)")
                    completion(nil,exportSession.error?.localizedDescription)

                default: break
                }
            }
        }
    }
    
    func reloadCache() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk(onCompletion: nil)
    }
    
    func switchView() {
        SDImageCache.shared.clearMemory()
//        animated.toggle()
    }
    
    static func getAddressFromLatLon(lat: Double, withLongitude lon: Double, handler: @escaping (String) -> Void) {
             var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
 //            let lat: Double = Double("\(pdblLatitude)")!
 //            //21.228124
 //            let lon: Double = Double("\(pdblLongitude)")!
 //            //72.833770
             let ceo: CLGeocoder = CLGeocoder()
             center.latitude = lat
             center.longitude = lon

             let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


             ceo.reverseGeocodeLocation(loc, completionHandler:
                 {(placemarks, error) in
                     if (error != nil)
                     {
                         print("reverse geodcode fail: \(error!.localizedDescription)")
                     }
                 let pm = (placemarks ?? []) as [CLPlacemark]

                     if pm.count > 0 {
                         let pm = placemarks![0]
 //                        print(pm.country)
 //                        print(pm.locality)
 //                        print(pm.subLocality)
 //                        print(pm.thoroughfare)
 //                        print(pm.postalCode)
 //                        print(pm.subThoroughfare)
                         var addressString : String = ""
                         if pm.subLocality != nil {
                             addressString = addressString + pm.subLocality! + ", "
                         }
                         if pm.thoroughfare != nil {
                             addressString = addressString + pm.thoroughfare! + ", "
                         }
                         if pm.locality != nil {
                             addressString = addressString + pm.locality! + ", "
                         }
                         if pm.country != nil {
                             addressString = addressString + pm.country! + ", "
                         }
                         if pm.postalCode != nil {
                             addressString = addressString + pm.postalCode! + " "
                         }


                         print(addressString)
                         handler(addressString)
                   }
             })

         }
}

