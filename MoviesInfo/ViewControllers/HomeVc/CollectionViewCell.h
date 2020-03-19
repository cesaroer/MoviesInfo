//
//  CollectionViewCell.h
//  MoviesInfo
//
//  Created by Cesar Roberto on 19/03/20.
//  Copyright © 2020 Cesar Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *movieCalifLbl;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@end

NS_ASSUME_NONNULL_END
