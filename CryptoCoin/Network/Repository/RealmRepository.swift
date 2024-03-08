//
//  RealmRepository.swift
//  CryptoCoin
//
//  Created by SUCHAN CHANG on 3/3/24.
//

import Foundation
import RealmSwift

final class RealmRepository {
    static let shared = RealmRepository()
    
    private let realm = try! Realm()
    
    private init() {}
        
    func addNewFavorite(id: String, name: String, symbol: String, imageURLString: String) {
        let favorite = Favorite(id: id, name: name, symbol: symbol, imageURLString: imageURLString)
        try! realm.write {
            realm.add(favorite)
            print(realm.configuration.fileURL)
        }
    }
    
    func fetchFavoriteList() -> Results<Favorite> {
        return realm.objects(Favorite.self)
    }
    
    func checkFavorite(id: String) -> Favorite? {
        return realm.object(ofType: Favorite.self, forPrimaryKey: id)
    }
    
    func deleteFavorite(favorite: Favorite) {
        try! realm.write {
            realm.delete(favorite)
        }
    }
}
