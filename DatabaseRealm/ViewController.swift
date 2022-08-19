//
//  ViewController.swift
//  DatabaseRealm
//
//  Created by ryo on 2022/08/19.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        contentTextField.delegate = self
        
        //Realmの情報読み取ってmemoに代入するためのMemo型の変数memo
        let memo: Memo? = read()
        
        titleTextField.text = memo?.title
        contentTextField.text = memo?.content
        
        // Do any additional setup after loading the view.
    }
    
    //読み取りメソッド
    //?はnilを許すため
    func read() -> Memo? {
        return realm.objects(Memo.self).first //Memoオブジェクトから最初のデータ取り出す
    }
    
    @IBAction func save() {
        let title: String = titleTextField.text!
        let content: String = contentTextField.text!
        
        let memo: Memo? = read()
        
        if memo != nil { //メモに既にデータがあれば更新
            try! realm.write {
                memo!.title = title
                memo!.content = content
            }
        } else { //保存されているメモがない場合は新規作成
            let newMemo = Memo()
            newMemo.title = title
            newMemo.content = content
            
            try! realm.write {
                realm.add(newMemo)
            }
        }
        
        //保存完了したらアラートを出す
        let alert: UIAlertController = UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        //アラート内にOKボタンを設定
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //作ったアラートを画面に表示
        present(alert, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}

