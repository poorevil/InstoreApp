//
// Copyright 2011 Jeff Verkoeyen
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "NIPagingScrollViewPage.h"
#import "NIPhotoScrollViewPhotoSize.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol NIPhotoScrollViewDelegate;
@class NICenteringScrollView;
@class MBProgressHUD;

@class BaseImageView;

/**
 * A single photo view that supports zooming and rotation.
 *
 *      @ingroup Photos-Views
 */
@interface NIPhotoScrollView : UIView <
  UIScrollViewDelegate,
  NIPagingScrollViewPage> {
@private
  // The photo view to be zoomed.
  BaseImageView* _imageView;
  // The scroll view.
  NICenteringScrollView* _scrollView;

  // Photo Information
  NIPhotoScrollViewPhotoSize _photoSize;
  CGSize _photoDimensions;

  // Configurable State
  BOOL _zoomingIsEnabled;
  BOOL _zoomingAboveOriginalSizeIsEnabled;
  BOOL _doubleTapToZoomIsEnabled;

  UITapGestureRecognizer* _doubleTapGestureRecognizer;

  __unsafe_unretained id<NIPhotoScrollViewDelegate> _photoScrollViewDelegate;

}

#pragma mark Configuring Functionality

@property (nonatomic, readwrite, assign, getter=isZoomingEnabled) BOOL zoomingIsEnabled; // default: yes
@property (nonatomic, readwrite, assign, getter=isZoomingAboveOriginalSizeEnabled) BOOL zoomingAboveOriginalSizeIsEnabled; // default: yes
@property (nonatomic, readwrite, assign, getter=isDoubleTapToZoomEnabled) BOOL doubleTapToZoomIsEnabled; // default: yes
@property (nonatomic, readwrite, assign) id<NIPhotoScrollViewDelegate> photoScrollViewDelegate;

#pragma mark State

- (UIImage *)image;
- (NIPhotoScrollViewPhotoSize)photoSize;
- (void)setImage:(UIImage *)image photoSize:(NIPhotoScrollViewPhotoSize)photoSize;

@property (nonatomic, readwrite, assign) NSInteger pageIndex;
@property (nonatomic, readwrite, assign) CGSize photoDimensions;

#pragma mark added by hanchao

@property (nonatomic,retain) MBProgressHUD *hud;

//设置加载进度
-(void)setLoadProgress:(CGFloat)progress;
//下载失败，关闭progress窗口
-(void)loadProcessFailed;

@end

/** @name Configuring Functionality */

/**
 * Whether the photo is allowed to be zoomed.
 *
 * By default this is YES.
 *
 *      @fn NIPhotoScrollView::zoomingIsEnabled
 */

/**
 * Whether small photos can be zoomed at least until they fit the screen.
 *
 * If this is disabled, images smaller than the view size can not be zoomed in beyond
 * their original dimensions.
 *
 * If this is enabled, images smaller than the view size can be zoomed in only until
 * they fit the view bounds.
 *
 * The default behavior in Photos.app allows small photos to be zoomed in.
 *
 *      @attention This will allow photos to be zoomed in even if they don't have any more
 *                 pixels to show, causing the photo to blur. This can look ok for photographs,
 *                 but might not look ok for software design mockups.
 *
 * By default this is YES.
 *
 *      @fn NIPhotoScrollView::zoomingAboveOriginalSizeIsEnabled
 */

/**
 * Whether double-tapping zooms in and out of the image.
 *
 * Available on iOS 3.2 and later.
 *
 * By default this is YES.
 *
 *      @fn NIPhotoScrollView::doubleTapToZoomIsEnabled
 */

/**
 * The photo scroll view delegate.
 *
 *      @fn NIPhotoScrollView::photoScrollViewDelegate
 */


/** @name State */

/**
 * The currently-displayed photo.
 *
 *      @fn NIPhotoScrollView::image
 */

/**
 * Set a new photo with a specific size.
 *
 * If image is nil then the photoSize will be overridden as NIPhotoScrollViewPhotoSizeUnknown.
 *
 * Resets the current zoom levels and zooms to fit the image.
 *
 *      @fn NIPhotoScrollView::setImage:photoSize:
 */

/**
 * The index of this photo within a photo album.
 *
 *      @fn NIPhotoScrollView::pageIndex
 */

/**
 * The current size of the photo.
 *
 * This is used to replace the photo only with successively higher-quality versions.
 *
 *      @fn NIPhotoScrollView::photoSize
 */

/**
 * The largest dimensions of the photo.
 *
 * This is used to show the thumbnail at the final image size in case the final image size
 * is smaller than the album's frame. Without this value we have to assume that the thumbnail
 * will take up the full screen. If the final image doesn't take up the full screen, then
 * the photo view will appear to "snap" to the smaller full-size image when the final image
 * does load.
 *
 * CGSizeZero is used to signify an unknown final photo dimension.
 *
 *      @fn NIPhotoScrollView::photoDimensions
 */
