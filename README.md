# X1 compatible ROM ver 0.4.0

2020-09-14 by Meister

## 概要

8bit パソコン シャープ X1シリーズのエミュレータ等で使用可能なフリーの互換IPL ROMイメージです。  
実機のIPLと無関係に，フルスクラッチで実装しています。

## 製作の背景

シャープ X1はROMをほとんど搭載しないクリーン設計であり，IPL ROMさえ互換実装を準備すれば実機を所有しない人でも合法的にエミュレータを使用することができます。  

過去に公開された互換実装として，X1エミュの部屋(http://www.turboz.to/)に掲載されていた，ぷにゅ氏作の IPL ver1.01(x1ipl101.zip,IPLROM.z80)があります。
しかし配布元のページが閉鎖されて久しいこと，今一つライセンスが明確でないことから広くお勧めすることが難しい状況です。また，あくまでイレギュラーな使用をした時の挙動ですが，CRTCの初期化を行わないためX1 turboエミュレータにturbo BIOSの代わりに読み込ませても，正しく起動できません。  

そこで，新たにフルスクラッチでエミュレータ用の互換IPLを作成しました。


## 実装済みの機能

以下のデバイスからの起動が可能です。

* FDD ドライブNo.0～3
* BASIC ROM (CZ-8RB)
* EMM0
* メインRAM 0番地

以下のデバイスからの起動はできません。

* カセットテープ
* HDD

また，以下の機能が未実装です。

* 内蔵タイマーの設定

## 使用方法

### インストール

ファイル X1_compatible_rom.bin をエミュレータ等に読み込ませます。例えばeX1の場合ならIPLROM.X1にリネームしてx1.exeと同じフォルダに置きます。詳細は各エミュレータ等の説明を参照してください。

X1_compatible_rom.bin以外のファイルはソースファイルです。通常の使用では不要です。

### 起動方法

* 起動時にFD0にディスクイメージが挿入されている場合，FD0からブートフラグのあるプログラムを探して起動します。
* ディスクが未挿入の場合，以下のようなメニューが表示されます。

```
Press selected key to start driving:

           0-3:FDD
           R:ROM
           E:EMM
           M:Mon
           #:RAM
```

* メニューの表示中に 0，1，2，3 いずれかのキーを押すと，それぞれ FD0，1，2，3 から起動します。
* 大文字の R，E いずれかのキーを押すと，それぞれ BASIC ROM または EMM0 から起動します。ただし多くのエミュレータでは BASIC ROM が実装されていないと思います。また，EMM0は適切にフォーマットされ，ＯＳ等が転送されている必要があります。
* Mキーでマシン語モニタを起動可能にする計画ですが，現時点で未実装です。
* #キーでメインRAMの0番地から起動します。CP/M使用中に間違えてIPLリセットした場合等に有効ですが，メモリの状況によっては暴走します。


## 互換性について

実機の雰囲気を残しつつ，完全互換を狙わない方針で実装しています。

* カセットテープとタイマが未実装です。
* turboのIPLについての解説を参考に，RAMからの起動機能を追加しました。
* EMMからの起動機能を追加しました。

各種文献を参考に，以下のエントリアドレスに同様のルーチンを実装しています。

| アドレス | ルーチン               |
|:--------:|:-----------------------|
| 0066     | NMIリセット            |
| 021a     | IPL用ディスクREAD      |
| 038a     | IPL用KEY入力           |
| 03cb     | IPL用メッセージ表示    |
| 03d9     | IPL用1文字表示ルーチン |

DRAMを使用しているシステムではメモリのウォーミングアップが必要ですが，行っていません。最近読んだ「ザイログZ80伝説」(鈴木哲哉著，ラトルズ)で必要性をはじめて知りました。不勉強でした。(注・実機ROMのリバースエンジニアリングを行っていないため，実機が本当にやっているかどうか確信なし)  
エミュレータでは全く問題ありませんが，本物のROMに焼いて実機やレプリカ機で使用する場合に問題あるかもしれません。


## 実装について

当初IPL ROMの容量を1KBと勘違いしていたため，かなり無理をしながら詰め込んであります。結果，3KB弱残っていますので，TinyBASICを載せるのも面白いかもしれません。


## 参考文献

1. IPL ver1.01(x1ipl101.zip,IPLROM.z80), ぷにゅ, http://www.turboz.to/ (閉鎖)
2. X1 turbo  BIOSの解析,稲葉 康治,Oh!MZ 1985年1月号,p.97～109
3. IOCS DATA LIST,泉 大介ら,Oh!MZ 1986年11月号,p.76～
4. 試験に出るX1,祝 一平，日本ソフトバンク,1987
5. HuBASIC Format詳細,BouKiCHi,https://boukichi.github.io/HuDisk/HuBASIC_Format.html 2020-07-31 閲覧


## 謝辞

開発にあたり武田氏のX1エミュレータ eX1 (http://takeda-toshiya.my.coocan.jp/)を全面的に使用しました。ICE以上に強力なeX1のデバッグ機能のお陰でこのプラグラムを作りえたと思います。また，ソースが公開されているおかげでCZ-8RBのエミュレーションを組み込んで試すことができました。


## ライセンス

本プログラム(ソース・バイナリ含む)およびドキュメント一式について，CC0ライセンス(http://creativecommons.org/publicdomain/zero/1.0/deed.ja)を宣言します。