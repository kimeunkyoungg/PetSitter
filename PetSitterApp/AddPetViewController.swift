//
//  AddPetViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/14/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

//반려동물 추가 화면
class AddPetViewController: UIViewController {
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petWeightTextField: UITextField!
    @IBOutlet weak var petKindTextField: UITextField!
    @IBOutlet weak var petSexTextField: UITextField!
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var petAgeTextField: UITextField!
    
    var petImageURL: String?
    var selectedImage: UIImage? 
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(capturePicture))
        petImageView.addGestureRecognizer(imageTapGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func petAddButtonPressed(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        let userID = user.uid
        let petName = petNameTextField.text ?? ""
        let petWeight = petWeightTextField.text ?? ""
        let petKind = petKindTextField.text ?? ""
        let petSex = petSexTextField.text ?? ""
        let petAge = petAgeTextField.text ?? ""
        
        // Check if an image is selected
        guard let petImage = petImageView.image else {
            print("Pet image is not selected")
            return
        }
        
        // Upload image to Firebase Storage
        uploadPetImage(petImage) { [weak self] imageUrl in
            guard let self = self else { return }
            self.petImageURL = imageUrl
            self.savePetData(userID: userID, petName: petName, petWeight: petWeight, petKind: petKind, petSex: petSex, petAge: petAge, imageUrl: imageUrl)
            
        }
        
    }
    
    func uploadPetImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        let storageRef = Storage.storage().reference().child("petImages/\(UUID().uuidString).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
            completion(nil)
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                print("Failed to upload image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Failed to get download URL: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                completion(url?.absoluteString)
            }
        }
        
    }
    
    func savePetData(userID: String, petName: String, petWeight: String, petKind: String, petSex: String, petAge: String, imageUrl: String?) {
        let db = Firestore.firestore()
        var petData: [String: Any] = [
            "userID": userID,
            "name": petName,
            "weight": petWeight,
            "kind": petKind,
            "sex": petSex,
            "age": petAge
        ]
        
        if let imageUrl = imageUrl {
            petData["imageUrl"] = imageUrl
        }
        
        db.collection("petInfo").addDocument(data: petData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added successfully")
                self.navigateToPetManagement()
            }
        }
        
    }
    
    func navigateToPetManagement() {
        if let petManageVC = storyboard?.instantiateViewController(withIdentifier: "PetManagementViewController") as? PetManageViewController {
            self.navigationController?.pushViewController(petManageVC, animated: true)
        }
        
    }
    
    @objc func capturePicture(sender: UITapGestureRecognizer){
        // 사진찍는 별도의 UIViewController가 UIImagePickerController이다.
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self // 이를 설정하면 사진을 찍은후 호출된다
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // 카메라가 있다면 카메라로부터
            imagePickerController.sourceType = .camera
        }else{
            // 카메라가 없으면 앨범으로부터
            imagePickerController.sourceType = .savedPhotosAlbum
        }
        // 시뮬레이터는 카메라가 없으므로, 실 아이폰의 경우 이라인 삭제
        imagePickerController.sourceType = .savedPhotosAlbum
        // UIImagePickerController이 전이 된다
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
}

extension AddPetViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // UIImagePickerController.InfoKey.originalImage를 키로 사용하여 UIImage를 가져옵니다.
        guard let image = info[.originalImage] as? UIImage else {
            print("이미지를 가져오는 데 실패했습니다.")
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        // 가져온 이미지를 petImageView에 설정합니다.
        petImageView.image = image
        selectedImage = image // 선택한 이미지를 selectedImage에 저장합니다.
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddPetViewController{
    @objc func dismissKeyboard(sender: UITapGestureRecognizer){
        petWeightTextField.resignFirstResponder()
        petKindTextField.resignFirstResponder()
        petSexTextField.resignFirstResponder()
        petNameTextField.resignFirstResponder()
        petAgeTextField.resignFirstResponder()
        
    }
    
}

