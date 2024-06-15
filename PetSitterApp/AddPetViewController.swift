//
//  AddPetViewController.swift
//  PetSitterApp
//
//  Created by 김은경 on 6/14/24.
//

import UIKit

class AddPetViewController: UIViewController {

    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petWeightTextField: UITextField!
    @IBOutlet weak var petBirthDatePicker: UIDatePicker!
    @IBOutlet weak var petKindTextField: UITextField!
    @IBOutlet weak var petSexTextField: UITextField!
    @IBOutlet weak var petNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(capturePicture))
        petImageView.addGestureRecognizer(imageTapGesture)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func petAddButtonPressed(_ sender: UIButton) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddPetViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    // 반드시 UINavigationControllerDelegate도 상속받아야 한다
    // 사진을 찍은 경우 호출되는 함수
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :Any])
    {
        // UIImage를 가져온다
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        // 여기서 이미지에 대한 추가적인 작업을 한다
        petImageView.image = image // 화면에 보일 것이다.
        // imagePickerController을 죽인다
        picker.dismiss(animated: true, completion: nil)
    }
    // 사진 캡쳐를 취소하는 경우 호출 함수
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // imagePickerController을 죽인다
        picker.dismiss(animated: true, completion: nil)
    }
    
}
