# z80oolong/vte -- libvte 対応端末エミュレータおよびアプリケーションの改良 Formula 群

## 概要

[Homebrew for Linux][BREW] は、Linux ディストリビューション向けのソースコードベースのパッケージ管理システムで、ソフトウェアのビルドと導入を簡素化します。

[libvte][LVTE] は、[GNOME][GNME] で端末エミュレータを実装するための [GTK ウィジェット][DGTK] ライブラリです。

本 Tap リポジトリ ```z80oolong/vte``` は、[libvte][LVTE] ベースの端末エミュレータおよびアプリケーションにおける以下の問題を修正した Formula 群を提供します：

- Unicode の [East_Asian_Width 特性が A (Ambiguous)][EAWA] である文字（以下、EAA 文字、例: "◎"、"★"、罫線文字など）が、日本語環境で文字幅を適切に扱えず表示が乱れる問題（以下、EAA 問題）。
    - 一部の端末エミュレータで、環境変数 ```VTE_CJK_WIDTH``` を使用して設定可能にしました。
- 一部の端末エミュレータで、メニューや設定画面が日本語化されていない問題。
    - 一部のメニューおよび設定画面を除き、機械翻訳による簡易な日本語化を実施しました。

本 Tap リポジトリ ```z80oolong/vte``` で対応する [libvte][LVTE] ベースの端末エミュレータおよびアプリケーションの詳細は、本リポジトリに同梱の ```FormulaList.md``` を参照してください。

## 使用方法

1. [Homebrew for Linux][BREW] を以下の参考資料に基づいてインストールします：
    - [thermes 氏][THER] の Qiita 投稿「[Linuxbrew のススメ][THBR]」
    - [Homebrew for Linux 公式ページ][BREW]
2. 本リポジトリの Formula を以下のようにインストールします：

```
  brew tap z80oolong/vte
  brew install <formula>
```

または、一時的に以下の方法で直接インストールも可能です：

```
  brew install https://raw.githubusercontent.com/z80oolong/homebrew-vte/master/Formula/<formula>.rb
```

Formula の一覧と詳細は、本リポジトリに同梱の ```FormulaList.md``` を参照してください。

## 詳細情報

本リポジトリおよび [Homebrew for Linux][BREW] の詳細は、```brew help``` または ```man brew``` コマンド、または [Homebrew for Linux 公式ページ][BREW] を参照してください。

## 謝辞

本リポジトリの作成にあたり、[GNOME 公式ドキュメント][DVTE] を参照しました。[GNOME プロジェクト][GNME] および [libvte][LVTE] 対応端末エミュレータ・アプリケーションの開発者コミュニティに深く感謝します。

## 使用条件

本リポジトリは、[Homebrew for Linux][BREW] の Tap リポジトリとして、[Homebrew for Linux 開発コミュニティ][BREW] および [Z.OOL.][ZOOL] が著作権を有し、[BSD 2-Clause License][BSD2] に基づいて配布されます。詳細は本リポジトリの ```LICENSE``` を参照してください。

<!-- 外部リンク一覧 -->

[BREW]:https://linuxbrew.sh/
[GNME]:https://www.gnome.org/
[DGTK]:https://gtk.org/
[LVTE]:https://github.com/GNOME/vte
[EAWA]:http://www.unicode.org/reports/tr11/#Ambiguous
[THER]:https://qiita.com/thermes
[THBR]:https://qiita.com/thermes/items/926b478ff6e3758ecfea
[DVTE]:https://developer-old.gnome.org/vte/unstable/VteTerminal.html
[BSD2]:https://opensource.org/licenses/BSD-2-Clause
[ZOOL]:http://zool.jpn.org/
