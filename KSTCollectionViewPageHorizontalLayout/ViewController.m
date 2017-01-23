//
//  ViewController.m
//  KSTCollectionViewPageHorizontalLayout
//
//  Created by Zeng on 22/12/2016.
//  Copyright © 2016 Zeng. All rights reserved.
//

#import "ViewController.h"
#import "KSTCollectionViewPageHorizontalLayout.h"
#import "BasicTextCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UICollectionView *originalCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	UILabel *originalLabel = [[UILabel alloc] init];
	originalLabel.text = @"original flow layout";
	[originalLabel sizeToFit];
	
	CGRect originalLabelFrame = CGRectMake(10, 32, self.view.bounds.size.width, originalLabel.bounds.size.height);
	originalLabel.frame = originalLabelFrame;
	[self.view addSubview:originalLabel];
	
	CGRect originalCollectionViewFrame = CGRectMake(0, CGRectGetMaxY(originalLabelFrame) + 10, self.view.bounds.size.width, 100);
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.itemSize = CGSizeMake(originalCollectionViewFrame.size.width / 5 - 1, 44);
	flowLayout.minimumLineSpacing = 1;
	flowLayout.minimumInteritemSpacing = 1;
	flowLayout.sectionInset = UIEdgeInsetsMake(8, 0, 0, 0);
	flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	
	UICollectionView *originalCollectionView = [[UICollectionView alloc] initWithFrame:originalCollectionViewFrame collectionViewLayout:flowLayout];
	originalCollectionView.delegate = self;
	originalCollectionView.dataSource = self;
	originalCollectionView.pagingEnabled = YES;
	originalCollectionView.backgroundColor = [UIColor redColor];
	[originalCollectionView registerClass:[BasicTextCollectionViewCell class] forCellWithReuseIdentifier:@"BasicTextCellIdentifier"];
	[self.view addSubview:originalCollectionView];
	self.originalCollectionView = originalCollectionView;
	
	
	UILabel *customLayoutLabel = [[UILabel alloc] init];
	customLayoutLabel.text = @"custom layout";
	[customLayoutLabel sizeToFit];
	CGRect customLayoutLabelFrame = CGRectMake(10, CGRectGetMaxY(self.originalCollectionView.frame) + 10, self.view.bounds.size.width, originalLabel.bounds.size.height);
	customLayoutLabel.frame = customLayoutLabelFrame;
	[self.view addSubview:customLayoutLabel];
	
	CGRect collectionViewFrame = CGRectMake(0, CGRectGetMaxY(customLayoutLabel.frame) + 10, self.view.bounds.size.width, 100);
	KSTCollectionViewPageHorizontalLayout *pageHorizontalLayout = [[KSTCollectionViewPageHorizontalLayout alloc] init];
	pageHorizontalLayout.itemSize = CGSizeMake(collectionViewFrame.size.width / 5 - 1, 44);
	pageHorizontalLayout.lineSpacing = 1;
	pageHorizontalLayout.interitemSpacing = 1;
	pageHorizontalLayout.sectionInsetTop = 8;
	
	UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:pageHorizontalLayout];
	collectionView.delegate = self;
	collectionView.dataSource = self;
	collectionView.pagingEnabled = YES;
	collectionView.backgroundColor = [UIColor redColor];
	[collectionView registerClass:[BasicTextCollectionViewCell class] forCellWithReuseIdentifier:@"BasicTextCellIdentifier"];
	[self.view addSubview:collectionView];
	self.collectionView = collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 22;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	BasicTextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BasicTextCellIdentifier" forIndexPath:indexPath];
	cell.textLabel.text = [NSString stringWithFormat:@"功能%@", [@(indexPath.item + 1) stringValue]];
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.textLabel.textAlignment = NSTextAlignmentCenter;
	cell.textLabel.frame = cell.bounds;
	cell.backgroundColor = [UIColor blueColor];
	return cell;
}


@end
