import Foundation
import FirebaseFirestore

fileprivate enum FireStoreCollections: String {
    case users
    case savedPantry
}

enum SortingCriteria: String {
    case fromNewestToOldest = "dateCreated"
    var shouldSortDescending: Bool {
        switch self {
        case .fromNewestToOldest:
            return true
        }
    }
}


class FirestoreService {
    static let manager = FirestoreService()
    
    private let db = Firestore.firestore()
    
    //MARK: AppUsers
    func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
  
    
    func updateCurrentUser(userName: String? = nil, photoURL: URL? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let user = userName {
            updateFields["userName"] = user
        }
        
        if let photo = photoURL {
            updateFields["photoURL"] = photo.absoluteString
        }
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    func createPantry(savedItems: FoodPantry, completion: @escaping (Result<(), Error>)-> ()){
        
        let fields = savedItems.fieldsDict
        
       // guard let id = savedItems.savedID else {return}
        
        db.collection(FireStoreCollections.savedPantry.rawValue).document(savedItems.savedID).setData(fields) {(error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }

    func getFoodPantry(forUserID: String, completion: @escaping (Result<[FoodPantry], Error>) -> ()){
        
        db.collection(FireStoreCollections.savedPantry.rawValue).whereField("userID", isEqualTo: forUserID).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let foodSaved = snapshot?.documents.compactMap({ (snapshot) -> FoodPantry? in
                    let savedID = snapshot.documentID
                    let saved = FoodPantry(from: snapshot.data(), id: savedID)
                    return saved
                })
                completion(.success(foodSaved ?? []))
            }
        }
    }
    
    private init () {}
}
