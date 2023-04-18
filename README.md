# EasyARApp
This is a simplified version of the system developed in my graduation research.

本アプリケーションは自身が卒業研究にて作成した簡易ARアプリケーションシステムを簡素化したものです。<br>
・EasyARapp<br>
XcodeとSwift5を利用し設計したARアプリケーションです。登録するURLを変更することで表示させるポスター状のARコンテンツを容易に変更することができます。
なおサンプルとして登録されているWebアプリケーションURLは、本システムのために拡張されたARWorldクラスを用いて設計された特別なものとなっています。<br>
・HPSettings<br>
EasyARAppと連携してJavaScriptを用いてARアプリケーション内の挙動をコントロールできるよう設計された新規クラスARWorldを含むサンプルWebアプリケーションのコードが含まれています。
JavaScriptの仕様に即して設計されたARWorldクラスのメソッドを利用しながら独自のメソッドを併用することでEasyARAppの挙動と共にコンテンツの表示内容を変化させることも可能です。<br>
