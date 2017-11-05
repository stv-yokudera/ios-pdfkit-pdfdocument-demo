//
//  ViewController.swift
//  ios-pdfkit-pdfdocument-demo
//
//  Created by OkuderaYuki on 2017/10/31.
//  Copyright © 2017年 OkuderaYuki. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    @IBOutlet weak var pdfView: PDFView!
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Macで以下の3つの設定をしたPDFを表示する
        // - 1. 書類を開くときにパスワードを要求
        // - 2. テキストやイメージなどのコンテンツをコピーするときにパスワードを要求
        // - 3. 書類をプリントするときにパスワードを要求
        showPDF(pdfName: "password_pdf")
        
        guard let document = pdfView.document else { return }
        
        // パスワード解除前
        print("【パスワード解除前】")
        checkPDFDocumentProperties(document: document)
        
        // 閲覧パスワード解除
        print("【閲覧パスワード解除】unlock: \(unlock(document: document, password: "read"))")
        checkPDFDocumentProperties(document: document)

        // 印刷パスワード解除
        print("【印刷パスワード解除】unlock: \(unlock(document: document, password: "print"))")
        checkPDFDocumentProperties(document: document)
    }
    
    /// AddPageボタン押下で、末尾に白紙ページを追加する
    ///
    /// - Parameter sender: UIButton
    @IBAction func didTapAddPageButton(_ sender: UIButton) {
        
        guard let document = pdfView.document,
            let newPageImage = UIImage(named: "white"),
            let newPage = PDFPage(image: newPageImage) else { return }
        document.insert(newPage, at: document.pageCount)
    }
    
    /// Saveボタン押下で、DocumentsディレクトリにPDFを保存する
    ///
    /// - Parameter sender: UIButton
    @IBAction func didTapSaveButton(_ sender: UIButton) {
        
        guard let document = pdfView.document else { return }
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        // 保存先のPATH
        let destinationPath = documentPath + "/test.pdf"
        
        // PDFを保存する
        let result = document.write(toFile: destinationPath)
        
        if result {
            print("PDF保存成功\n\(destinationPath)")
        }
    }
    
    // MARK: - PDF表示
    
    /// ローカルのPDFのファイル名を指定して、画面に表示する
    ///
    /// - Parameter pdfName: foo.pdfの場合 -> foo
    func showPDF(pdfName: String, usePageViewController: Bool = false) {
        if let pdfPath = Bundle.main.path(forResource: pdfName, ofType: "pdf"),
            let fileHandle = FileHandle(forReadingAtPath: pdfPath) {
            let pdfData = fileHandle.readDataToEndOfFile()
            pdfView.usePageViewController(usePageViewController)
            
            // PDFDocumentの初期化
            pdfView.document = PDFDocument(data: pdfData)
        }
    }
    
    // MARK: - PDFDocument
    
    /// PDFがロックされているかどうか
    ///
    /// - Parameter document: PDFDocument
    /// - Returns: true: パスワード未解除, false: パスワード解除済み
    func isLocked(document: PDFDocument) -> Bool {
        return document.isLocked
    }
    
    /// PDFのテキストや画像などコンテンツのコピーが可能かどうか
    ///
    /// - Parameter document: PDFDocument
    /// - Returns: true: コピー可, false: コピー不可
    func allowsCopying(document: PDFDocument) -> Bool {
        return document.allowsCopying
    }
    
    /// PDFが印刷可能かどうか
    ///
    /// - Parameter document: PDFDocument
    /// - Returns: true: 印刷可, false: 印刷不可
    func allowsPrinting(document: PDFDocument) -> Bool {
        return document.allowsPrinting
    }
    
    /// PDFのロックを解除する
    ///
    /// - Parameters:
    ///   - document: PDFDocument
    ///   - password: パスワード
    /// - Returns: true: ロック解除成功, false: ロック解除失敗
    func unlock(document: PDFDocument, password: String) -> Bool {
        return document.unlock(withPassword: password)
    }
}

// MARK: - DEBUG用
extension ViewController {
    func checkPDFDocumentProperties(document: PDFDocument) {
        print("isLocked: \(isLocked(document: document))")
        print("allowsCopying: \(allowsCopying(document: document))")
        print("allowsPrinting: \(allowsPrinting(document: document))")
        print("permissionsStatus: \(document.permissionsStatus.rawValue)")
    }
}

