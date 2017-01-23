//
//  KSTCollectionViewPageHorizontalLayout.m
//  KSTCollectionViewPageHorizontalLayout
//
//  Created by Zeng on 22/12/2016.
//  Copyright © 2016 Zeng. All rights reserved.
//

#import "KSTCollectionViewPageHorizontalLayout.h"

@interface KSTCollectionViewPageHorizontalLayout()

/** 所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributesArray;
/** 实际的列数 */
@property (nonatomic, assign) NSInteger calculatedColumnCount;
/** 实际的行数 */
@property (nonatomic, assign) NSInteger calculatedLineCount;

@end

@implementation KSTCollectionViewPageHorizontalLayout

- (void)prepareLayout {
	[super prepareLayout];
	
	self.calculatedColumnCount = 0;
	self.calculatedLineCount = 1;
	self.layoutAttributesArray = [NSMutableArray array];
	
	// 如果没有设置列数，则按itemSize来算
	if (self.columnCount > 0) {
		self.calculatedColumnCount = self.columnCount;
	} else if (self.itemSize.width > 0) {
		NSInteger baseColumnCount = self.collectionView.frame.size.width / (self.itemSize.width + self.interitemSpacing);
		// 计算所得的baseColumnCount列数是不准的，因为可能多算一个间隔（比如一排放5个item，实际只有4个间隔）
		if (((baseColumnCount + 1) * self.itemSize.width + baseColumnCount * self.interitemSpacing) <= self.collectionView.frame.size.width) {
			self.calculatedColumnCount = baseColumnCount + 1;
		} else {
			self.calculatedColumnCount = baseColumnCount;
		}
	}
	
	// 计算可以放多少行
	CGFloat contentHeight = self.collectionView.frame.size.height - self.sectionInsetTop;
	NSInteger baseLineCount = contentHeight / (self.itemSize.height + self.lineSpacing);
	// 计算所得的baseLineCount行数是不准的，因为可能多算一个间隔（比如5行的话实际只有4个间隔）
	if (((baseLineCount + 1) * self.itemSize.height + baseLineCount * self.lineSpacing) <= contentHeight) {
		self.calculatedLineCount = baseLineCount + 1;
	} else {
		self.calculatedLineCount = baseLineCount;
	}
	
	NSAssert(self.calculatedColumnCount > 0, @"you should set either ColumnCount or ItemSize first");
	
	NSInteger sectionItemCount = [self.collectionView numberOfItemsInSection:0];
	for (NSInteger i = 0; i < sectionItemCount; i++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
		UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
		[self.layoutAttributesArray addObject:layoutAttributes];
	}
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
	return self.layoutAttributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
	if (self.calculatedLineCount == 0) {
		layoutAttributes.hidden = YES;
		NSLog(@"warning: collectionView's itemSize is bigger than the content size allowed");
		return layoutAttributes;
	}
	
	NSInteger pageItemCount = (self.calculatedLineCount * self.calculatedColumnCount);
	NSInteger currentPage = indexPath.row / pageItemCount;
	NSInteger currentLine = (indexPath.row - currentPage * pageItemCount) / self.calculatedColumnCount;
	NSInteger currentColumn = indexPath.row % self.calculatedColumnCount;
	layoutAttributes.frame = CGRectMake(currentPage * self.collectionView.frame.size.width + currentColumn * (self.itemSize.width + self.interitemSpacing), self.sectionInsetTop + currentLine * (self.itemSize.height + self.lineSpacing), self.itemSize.width, self.itemSize.height);
	
	return layoutAttributes;
}

- (CGSize)collectionViewContentSize {
	NSInteger sectionItemCount = [self.collectionView numberOfItemsInSection:0];
	NSInteger pageItemCount = (self.calculatedLineCount * self.calculatedColumnCount);
	NSInteger pageCount = (sectionItemCount + pageItemCount - 1) / pageItemCount;
	return CGSizeMake(pageCount * self.collectionView.frame.size.width, 0);
}

@end
