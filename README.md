# ios-pdfkit-pdfdocument-demo
iOS PDFDocumentのデモ(Swift)

# PDFDocument

## 概要

PDFDocumentは、PDFデータまたはPDFファイルを表し、<br>
PDFデータの書き込みやパスワードの解除、検索などの操作をできるクラスです。

## 関連クラス
NSObject
　
## 実装手順
1. StoryboardにUIViewを配置します。
2. UIViewのCustom ClassにPDFViewを設定します。
3. UIViewControllerとStoryboardのPDFViewを関連付けます。
4. PDFViewにPDFDocumentオブジェクトをセットして画面に表示させます。

## 主要プロパティ

|プロパティ名|説明|サンプル|
|---|---|---|
|isLocked | PDFがロックされているかどうか | document.isLocked |
|allowsCopying | PDFのテキストや画像などコンテンツのコピーが可能かどうか | document.allowsCopying |
|allowsPrinting | PDFが印刷可能かどうか | document.allowsPrinting |

## 主要メソッド

|メソッド名|説明|サンプル|
|---|---|---|
|init?(data: Data) | イニシャライザ | pdfView.document = PDFDocument(data: pdfData) |
|insert(_:at:) | 指定位置にページを追加する | document.insert(newPage, at: document.pageCount) |
|write(toFile:) | 指定パスのファイルに書き込む | document.write(toFile: destinationPath) |
|unlock(withPassword:) | パスワードを渡して<br>PDFのロックを解除する | document.unlock(withPassword: password) |

## フレームワーク
PDFKit.framework

## サポートOSバージョン
iOS11.0以上

## 開発環境
|category | Version|
|---|---|
| Swift | 4.0 |
| XCode | 9.0 |
| iOS | 11.0〜 |

## 参考
https://developer.apple.com/documentation/pdfkit/pdfdocument
