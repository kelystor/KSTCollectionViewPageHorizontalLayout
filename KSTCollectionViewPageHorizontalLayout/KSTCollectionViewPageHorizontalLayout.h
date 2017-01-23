//
//  KSTCollectionViewPageHorizontalLayout.h
//  KSTCollectionViewPageHorizontalLayout
//
//  Created by Zeng on 22/12/2016.
//  Copyright © 2016 Zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSTCollectionViewPageHorizontalLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat sectionInsetTop;
@property (nonatomic, assign) NSInteger columnCount; // 分成多少列，默认为0。如不设置，则会通过itemSize去计算

@end
