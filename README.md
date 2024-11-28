# z80oolong/vte -- libvte 対応端末エミュレータ及びアプリケーションにおいて各種問題を修正するための Formula 群

## 概要

[Homebrew for Linux][BREW] とは、Linux の各ディストリビューションにおけるソースコードの取得及びビルドに基づいたパッケージ管理システムです。 [Homebrew for Linux][BREW] の使用により、ソースコードからのビルドに基づいたソフトウェアの導入を単純かつ容易に行うことが出来ます。

また、 [libvte][LVTE] は、 [GNOME][GNME] において、端末エミュレータを実装するためのコアとしての機能を [Gtk ウィジェット][DGTK]のライブラリとして纏めたものです。

この [Homebrew for Linux][BREW] 向け Tap リポジトリは、 [libvte][LVTE] に対応した各種端末エミュレータにおいて：

- Unicode の規格における東アジア圏の各種文字のうち、いわゆる "◎" や "★" 等の記号文字及び罫線文字等、 [East_Asian_Width 特性の値が A (Ambiguous) となる文字][EAWA] (以下、 [East Asian Ambiguous Character][EAWA]) が、日本語環境で文字幅を適切に扱うことが出来ずに表示が乱れる問題。
    - 一部の端末エミュレータにおいて、環境変数 ```VTE_CJK_WIDTH``` を用いることにより、設定を可能にしました。
- 一部の端末エミュレータにおいて、メニュー表示及び設定画面等について日本語化が行われていない問題。
    - 一部のメニュー及び設定画面の表示を除き、機械翻訳による簡易な日本語翻訳に基づく日本語化を行いました。

以上の問題を修正した [libvte][LVTE] 対応端末エミュレータ及びアプリケーションを導入するための Formula 群を含む Tap リポジトリです。

なお本リポジトリにおいて、現時点で上記の問題の修正に対応している [libvte][LVTE] 対応端末エミュレータ及びアプリケーションに関しては、本リポジトリに同梱する  ```FormulaList.md``` を参照してください。

## 使用法

まず最初に、以下に示す Qiita の投稿及び Web ページの記述に基づいて、手元の端末に [Homebrew for Linux][BREW] を構築します。

- [thermes 氏][THER]による "[Linuxbrew のススメ][THBR]" の投稿
- [Homebrew for Linux の公式ページ][BREW]

そして、本リポジトリに含まれる Formula を以下のようにインストールします。

```
 $ brew tap z80oolong/vte
 $ brew install <formula>
```

なお、一時的な手法ですが、以下のようにして URL を直接指定してインストールすることも出来ます。

```
 $ brew install https://raw.githubusercontent.com/z80oolong/homebrew-vte/master/Formula/<formula>.rb
```

なお、本リポジトリにて修正を行うアプリケーション及び本リポジトリに含まれる Formula の一覧とその詳細については、本リポジトリに同梱する ```FormulaList.md``` を参照して下さい。

## その他詳細について

その他、本リポジトリ及び [Homebrew for Linux][BREW] の使用についての詳細は ```brew help``` コマンド及び  ```man brew``` コマンドの内容、若しくは [Homebrew for Linux の公式ページ][BREW]を御覧下さい。

## 謝辞

本リポジトリの作成にあたっては、[https://developer-old.gnome.org/vte/unstable/VteTerminal.html][DVTE] 等のページを参照しました。 [GNOME プロジェクト][GNME]の開発者コミュニティ各位と各種 [libvte][LVTE] 対応端末エミュレータ及びアプリケーションの開発者及び開発コニュニティの各位に心より感謝致します。

## 使用条件

本リポジトリは、 [Homebrew for Linux][BREW] の Tap リポジトリの一つとして、 [Homebrew for Linux の開発コミュニティ][BREW]及び [Z.OOL. (mailto:zool@zool.jpn.org)][ZOOL] が著作権を有し、[Homebrew for Linux][BREW] のライセンスと同様である [BSD 2-Clause License][BSD2] に基づいて配布されるものとします。詳細については、本リポジトリに同梱する ```LICENSE``` を参照して下さい。

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
