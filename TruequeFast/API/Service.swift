//
//  Service.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 14/01/21.
//

import UIKit
import Firebase

// MARK: - Service
struct Service{
    // MARK: - Obtener Articulos
    static func fetchArticles(forCurrentUser user: User, completion: @escaping([Article]) -> Void) {
        var articles = [Article]()
        let query = COLLECTION_ARTICLES
            .whereField("art_country", isEqualTo: user.user_country)
            .whereField("art_city", isEqualTo: user.user_city)
            .whereField("art_district", isEqualTo: user.user_district)
        fetchFromQuery(query: query) { snapshot in
            snapshot.documents.forEach({ (document) in
                let dict = document.data()
                let art = Article(dict: dict)
                guard art.art_owner_id != Auth.auth().currentUser?.uid else { return }
                articles.append(art)
            })
            completion(articles)
        }
    }
    // MARK: - Obtener de Query
    static func fetchFromQuery(query: Query, maxItems:Int = 30, startAt:Int = 0, completion: @escaping(QuerySnapshot) -> Void) {
        query
            .start(at: [startAt])
            .limit(to: maxItems)
            .getDocuments { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                completion(snapshot)
            }
    }
    // MARK: - Subir fotos al storage
    static func uploadImage(image: UIImage, dir: String = "images", completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/\(dir)/\(filename)")
        ref.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("DEBUG: Error subiendo la foto: \(error.localizedDescription)")
                return
            }
            ref.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
    // MARK: - Subir usuarios
    static func saveUserData(user: User, completion: @escaping(Error?) -> Void){
        print("User es \(user.data())")
        COLLECTION_USERS.document(user.user_uid).setData(user.data(), completion: completion)
    }
    // MARK: - Obtener usuario
    static func fetchUser(withUid uid: String, completion: @escaping(User?) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dict = snapshot?.data() else {
                completion(nil)
                return
            }
            let user = User(dict: dict)
            completion(user)
        }
    }
}


