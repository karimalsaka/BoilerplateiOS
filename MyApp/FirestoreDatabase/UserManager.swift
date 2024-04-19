import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser {
    var userId: String
    var email: String?
    var date_created: Date?
}

final class UserManager {
    let database = Firestore.firestore()
    
    func createNewUser(auth: AuthUserModel) async throws {
        var userData: [String : Any] = [
            "user_id" : auth.id,
            "date_created": Timestamp()
        ]

        if let email = auth.email {
            userData["email"] = email
        }
        
        try await database.collection("users").document(auth.id).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser  {
        let snapshot = try await database.collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.unknown)
        }
        

        let email = data["email"] as? String
        let dateCreated = data["date_created"] as? Date
        
        return DBUser(userId: userId, email: email, date_created: dateCreated)
    }
}

extension UserManager: Equatable {
    static func == (lhs: UserManager, rhs: UserManager) -> Bool {
        
        // UserManager doesn't have any meaningful properties
        // to compare, you we can just return true
        return true
    }
}
