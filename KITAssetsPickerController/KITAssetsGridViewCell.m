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

#import <PureLayout/PureLayout.h>
#import "KITAssetsPickerDefines.h"
#import "KITAssetsGridViewCell.h"
#import "KITAssetsGridSelectedView.h"
#import "NSDateFormatter+KITAssetsPickerController.h"
#import "UIImage+KITAssetsPickerController.h"



@interface KITAssetsGridViewCell ()

@property (nonatomic, strong) id<KITAssetDataSource> asset;

@property (nonatomic, strong) UIImageView *disabledImageView;
@property (nonatomic, strong) UIView *disabledView;
@property (nonatomic, strong) UIView *highlightedView;
@property (nonatomic, strong) KITAssetsGridSelectedView *selectedView;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end





@implementation KITAssetsGridViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.opaque                 = YES;
        self.isAccessibilityElement = YES;
        self.accessibilityTraits    = UIAccessibilityTraitImage;
        self.enabled                = YES;
        self.showsSelectionIndex    = NO;
        
        [self setupViews];
    }
    
    return self;
}


#pragma mark - Setup

- (void)setupViews
{
    KITAssetThumbnailView *thumbnailView = [KITAssetThumbnailView newAutoLayoutView];
    self.backgroundView = thumbnailView;
    
    UIImage *disabledImage = [UIImage KITAssetsPickerImageNamed:@"GridDisabledAsset"];
    disabledImage = [disabledImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *disabledImageView = [[UIImageView alloc] initWithImage:disabledImage];
    disabledImageView.tintColor = KITAssetsPikcerThumbnailTintColor;
    self.disabledImageView = disabledImageView;
    
    UIView *disabledView = [UIView newAutoLayoutView];
    disabledView.backgroundColor = KITAssetsGridViewCellDisabledColor;
    disabledView.hidden = YES;
    [disabledView addSubview:self.disabledImageView];
    self.disabledView = disabledView;
    [self addSubview:self.disabledView];
    
    UIView *highlightedView = [UIView newAutoLayoutView];
    highlightedView.backgroundColor = KITAssetsGridViewCellHighlightedColor;
    highlightedView.hidden = YES;
    self.highlightedView = highlightedView;
    [self addSubview:self.highlightedView];
    
    KITAssetsGridSelectedView *selectedView = [KITAssetsGridSelectedView newAutoLayoutView];
    selectedView.hidden = YES;
    self.selectedView = selectedView;
    [self addSubview:self.selectedView];
}

#pragma mark - Apperance

- (UIColor *)disabledColor
{
    return self.disabledView.backgroundColor;
}

- (void)setDisabledColor:(UIColor *)disabledColor
{
    UIColor *color = (disabledColor) ? disabledColor : KITAssetsGridViewCellDisabledColor;
    self.disabledView.backgroundColor = color;
}

- (UIColor *)highlightedColor
{
    return self.highlightedView.backgroundColor;
}

- (void)setHighlightedColor:(UIColor *)highlightedColor
{
    UIColor *color = (highlightedColor) ? highlightedColor : KITAssetsGridViewCellHighlightedColor;
    self.highlightedView.backgroundColor = color;
}


#pragma mark - Accessors

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    self.disabledView.hidden = enabled;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.highlightedView.hidden = !highlighted;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.selectedView.hidden = !selected;
}

- (void)setShowsSelectionIndex:(BOOL)showsSelectionIndex
{
    _showsSelectionIndex = showsSelectionIndex;
    self.selectedView.showsSelectionIndex = showsSelectionIndex;
}

- (void)setSelectionIndex:(NSUInteger)selectionIndex
{
    _selectionIndex = selectionIndex;
    self.selectedView.selectionIndex = selectionIndex;
}


#pragma mark - Update auto layout constraints

- (void)updateConstraints
{
    if (!self.didSetupConstraints)
    {
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.backgroundView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
            [self.disabledView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
            [self.highlightedView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
            [self.selectedView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        }];
        
        [self.disabledImageView autoCenterInSuperview];

        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}


- (void)bind:(id<KITAssetDataSource> )asset
{
    self.asset = asset;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end