/*
 
 MIT License (MIT)
 
 Copyright (c) 2013 Clement CN Tsang
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import <UIKit/UIKit.h>
#import "KITAssetItemViewController.h"
#import "KITAssetPlayButton.h"
#import "KITAssetSelectionButton.h"




extern NSString * const KITAssetScrollViewDidTapNotification;


@interface KITAssetScrollView : UIScrollView

@property (nonatomic, assign) BOOL allowsSelection;

@property (nonatomic, strong, readonly) UIImage *image;

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) KITAssetSelectionButton *selectionButton;


- (void)startActivityAnimating;
- (void)stopActivityAnimating;

- (void)setProgress:(CGFloat)progress;

- (void)bind:(id<KITAssetDataSource>)asset image:(UIImage *)image requestInfo:(NSDictionary *)info;

- (void)updateZoomScalesAndZoom:(BOOL)zoom;

@end
