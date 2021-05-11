//
//  ImageNetwork.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import UIKit


class OmnerImagesCache {
    // MARK: - Singleton
    private init(){}
    
    /// Access the singleton instance
    static var shared = OmnerImagesCache()
    
    /// Each owner's image cached (as value) at dictionary with owner's id (as key)
    var images = [Int:UIImage]()
    
}



extension UIImageView {
    
    /// Get Image from HTTP request
    ///
    /// - Parameters:
    ///   - url: URL of image
    ///   - mode: ContentMode of image (by default = .scaleAspectFit)
    ///   - id: Owner's id
    private func getImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, id:Int) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                OmnerImagesCache.shared.images[id] = image
            }
        }.resume()
    }
    
    
    
    /// Returns a cachedImage if `OmnerImagesCache.images` has the image with given owner's id,
    /// ELSE it downloads owner's image from an `owner.avatarUrl`.
    ///
    /// - Parameters:
    ///   - link: URL of image
    ///   - mode: ContentMode of image (by default = .scaleAspectFit)
    ///   - id: Owner's id
    func getImage(from link: String, contentMode mode: ContentMode = .scaleAspectFit, id:Int) {
        if let img = (OmnerImagesCache.shared.images[id]) {
            self.image = img
        }else {
            self.image = UIImage() // To avoid UI arbitrary image changes while scrolling
            guard let url = URL(string: link) else { return }
            self.getImage(from: url, contentMode: mode, id: id)
        }
    }
    
}
