# PhotoCollectionView

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/48765cde3eb542288c8e90d47f8fa400)](https://www.codacy.com/app/noblakit01/PhotoCollectionView?utm_source=github.com&utm_medium=referral&utm_content=noblakit01/PhotoCollectionView&utm_campaign=badger)

Custom CollectionView like as Facebook Feed for iOS 

## Overview

<table>
  <tr>
    <th>
      <img src="Example/demo.gif" width="280"/>
    </th>
  </tr>
</table>

## Requirements

* iOS 8.0+
* Xcode 8+
* Swift 3

## Installation

### CocoaPods

To integrate PhotoCollectionView into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'PhotoCollectionView', '~> 1.5.2' 
```

Then, run the following command:

```bash
$ pod install
```

### Manually
- Drag and drop `Sources` folder into your project

## Usage

### Create PhotoCollectionView
Use can create instance of `PhotoCollectionView` by code:

```
import PhotoCollectionView
```

```
let photoCollectionView = PhotoCollectionView(frame: CGRect(x: 0, y: 0, width: 320, height: 240))
```

or create an `UIView` in storyboard and Outlet it

<table>
  <tr>
    <th>
      <img src="Example/storyboard.png" width="220"/>
    </th>
  </tr>
</table>

```
import PhotoCollectionView
```
```
@IBOutlet weak var imageCollectionView: PhotoCollectionView!
```

### PhotoCollectionViewDataSource

- Extension `PhotoCollectionViewDataSource` for binding data

```
extension ViewController: PhotoCollectionViewDataSource {
    func numPhotos(in photoCollectionView: PhotoCollectionView) -> Int {
        // Return count photo.
        return 10
    }
    
    func photoCollectionView(_ photoCollectionView: PhotoCollectionView, photoSource index: Int) -> PhotoSource {
        return .url(URL(string: urls[index]))
        // or return .image(*your image*)
    }
}
```

- Set `dataSource` of PhotoCollectionView

```
imageCollectionView.dataSource = self
```

### PhotoCollectionViewDelegate

Handle image selection in PhotoCollectionView
```
imageCollectionView.delegate = self
```

```
extension ViewController: PhotoCollectionViewDelegate {
    func photoCollectionView(_ photoCollectionView: PhotoCollectionView, didSelectImageAt index: Int) {
        print("Press at index \(index)")
    }
}
```

## [TODO](https://github.com/noblakit01/PhotoCollectionView/blob/master/TODO.md)

## Author

Luan Tran - noblakit01@gmail.com

## License
[MIT](http://thi.mit-license.org/)


