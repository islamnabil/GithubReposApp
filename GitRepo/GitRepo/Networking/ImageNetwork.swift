//
//  ImageNetwork.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 09/05/2021.
//

import UIKit

extension UIImageView {
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
    
    
    /// Returns a cachedImage if `OmnerImagesCache` has the image with given owner's id  or it download owner's image from an `owner?.avatarUrl`.
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
