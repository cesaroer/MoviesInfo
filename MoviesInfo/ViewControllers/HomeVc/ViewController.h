//
//  ViewController.h
//  MoviesInfo
//
//  Created by Cesar Roberto on 19/03/20.
//  Copyright © 2020 Cesar Roberto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak,nonatomic) NSString *url;
@property (weak,nonatomic) NSString *posterUrl;

@end

