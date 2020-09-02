//
//  BCBigImageView.m
//  DDBoxCreator
//
//  Created by DahaoJiang on 2020/9/2.
//  Copyright © 2020 DahaoJiang. All rights reserved.
//

#import "DlBigImageView.h"

@interface DlBigImageView ()

@property (nonatomic, strong) UIScrollView *sc;

@property (nonatomic, strong) NSMutableArray *igvArr;

@property (nonatomic, strong) UIImage *currentImg;

@end

@implementation DlBigImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.contentMode = UIViewContentModeScaleAspectFit;
    _maxHeight = [UIScreen mainScreen].bounds.size.height;
    _igvArr = [NSMutableArray array];
    _sc = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_sc];
    
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    [self createBigImg];
    
}

- (void)setContentMode:(UIViewContentMode)contentMode {
    [super setContentMode:contentMode];
    
    [self.igvArr enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.contentMode = contentMode;
    }];
}

- (void)createBigImg {
    
    [_igvArr removeAllObjects];
    
    _currentImg = [UIImage imageNamed:_imageName];

    if (_currentImg) {
                
        //图片的y值
        CGFloat originY = 0;
        
        /// imageView宽度
        CGFloat contentWidth = self.frame.size.width;
        
        /// 图片宽度
        CGFloat imageWidth = _currentImg.size.width;
        /// 计算出scrollview的contentSize
        CGFloat contentHeight = contentWidth * _currentImg.size.height / _currentImg.size.width;
        _sc.contentSize =  CGSizeMake(0, contentHeight);
        
        NSInteger count = ceil(_currentImg.size.height / _maxHeight);
        
        for (NSInteger index = 0; index < count; ++ index) {
            /// 判断是否最后一张图，如果不是，截取设置的最大高度，如果是，截取剩下的高度
            CGFloat clipHeight = (index == count - 1) ? _currentImg.size.height - _maxHeight * index : _maxHeight;
            CGImageRef imgRef = CGImageCreateWithImageInRect(_currentImg.CGImage, CGRectMake(0, index * _maxHeight, imageWidth, clipHeight));
            
            /// 生成截取后的图片,赋值到igv上
            UIImageView *igv = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:imgRef]];
            igv.contentMode = self.contentMode;
            
            /**
                计算出实际图片的高度
                （当前view宽）     414           750 （这张图片的宽度）
                             -----     =    -----
                需要获取的高度     height      _maxHeight（截取图片最大）
             */
            CGFloat igvHeight = (index == count -1) ?
            ((_currentImg.size.height - _maxHeight * index) * contentWidth /imageWidth) :
            (contentWidth * _maxHeight / imageWidth);
            
            igv.frame = CGRectMake(0, originY, self.frame.size.width, igvHeight);
            originY += igvHeight;
            
            [_sc addSubview:igv];
            [self.igvArr addObject:igv];
            // 记得释放
            CGImageRelease(imgRef);
        }
        
        [self setNeedsLayout];
    }
    

}

- (void)layoutSubviews {
    
    _sc.frame = self.bounds;
    
}


@end
