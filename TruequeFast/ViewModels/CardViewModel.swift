//
//  CardViewModel.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 13/01/21.
//

import UIKit

class CardViewModel {
    let article: Article
    let imageURLS: [String]
    let articleInfoText: NSAttributedString
    private var imageIndex = 0
    var index: Int {
        return imageIndex
    }
    var imageUrl: URL?
    
    init(article: Article) {
        self.article = article
        let attributedText = NSMutableAttributedString(string: article.art_title, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy), .foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "\t\(article.art_owner_name)", attributes: [.font: UIFont.systemFont(ofSize: 24), .foregroundColor: UIColor.white]))
        self.articleInfoText = attributedText
        self.imageURLS = article.art_urls
        self.imageUrl = URL(string: self.imageURLS.first!)
    }
    
    func showNextPhoto(){
        guard imageIndex < imageURLS.count - 1 else { return }
        self.imageIndex += 1
        imageUrl = URL(string: imageURLS[imageIndex])
    }
    
    func showPreviousPhoto(){
        guard imageIndex > 0 else { return }
        self.imageIndex -= 1
        imageUrl = URL(string: imageURLS[imageIndex])
    }
}
