//
//  BCBigImageView.h
//  DDBoxCreator
//
//  Created by DahaoJiang on 2020/9/2.
//  Copyright © 2020 DahaoJiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DlBigImageView : UIView


/// 单张图片最大高度, 默认屏高
@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, strong) NSString *imageName;

@end

NS_ASSUME_NONNULL_END
