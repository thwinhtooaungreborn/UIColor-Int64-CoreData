// filename: UIColor+Int64+CoreData.swift

/*
MIT License

Copyright (c) 2017 Thwin Htoo Aung

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

import UIKit

extension UIColor {
	
	/// Initialize color from int64
	convenience init(fromInt64 int64: Int64) {
		
		let i64Red = (int64 & 0xff000000) >> 24;
		let i64Green = (int64 & 0x00ff0000) >> 16;
		let i64Blue = (int64 & 0x0000ff00) >> 8;
		let i64Alpha = (int64 & 0x000000ff);
		
		let fRed = CGFloat(i64Red)
		let fGreen = CGFloat(i64Green)
		let fBlue = CGFloat(i64Blue)
		let fAlpha = CGFloat(i64Alpha)
		
		self.init(red: fRed/0xff, green: fGreen/0xff, blue: fBlue/0xff, alpha: fAlpha/0xff)
	}
	
	/// Convert UIColor into Int64 which is storable in Core Data
	var int64: Int64 {
		
		var value: Int64 = 0;
		
		// CGFloat version
		var fRed: CGFloat = 0;
		var fGreen: CGFloat = 0;
		var fBlue: CGFloat = 0;
		var fAlpha: CGFloat = 0;
		
		// get CGFloat version of rgba each ranging from 0 to 1
		self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha);
		
		// convert into int64 with range of 0x00 to 0xff, instead of 0 to 1
		let i64Red: Int64 = Int64(fRed * 0xff) << 24;
		let i64Green: Int64 = Int64(fGreen * 0xff) << 16;
		let i64Blue: Int64 = Int64(fBlue * 0xff) << 8;
		let i64Alpha: Int64 = Int64(fAlpha * 0xff);
		
		// store into int64
		value = i64Red + i64Green + i64Blue + i64Alpha;
		
		return value;
	}
}
