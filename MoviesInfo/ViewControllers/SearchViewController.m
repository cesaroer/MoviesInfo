//
//  SearchViewController.m
//  MoviesInfo
//
//  Created by Cesar Roberto on 19/03/20.
//  Copyright © 2020 Cesar Roberto. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableViewMovies.delegate = self;
    self.tableViewMovies.dataSource = self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"tcell";
    SearchTableViewCell *cell = [self.tableViewMovies dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //Configuramos el diseño de la celda
    cell.movieImage.layer.cornerRadius = 45;
    cell.layer.cornerRadius = 60;
    //Aplicamos sobra a las celdas de la tabla
    cell.clipsToBounds = false;
    cell.layer.masksToBounds = false;
    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.layer.shadowOffset = CGSizeMake(0 , 10);
    cell.layer.shadowRadius = 7;
    cell.layer.shadowOpacity = .5;
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}




//Con esta funcion instanciamos el siguiente controllador:

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", indexPath);
    [self performSegueWithIdentifier:@"presenter" sender:self];

}

//con estas funciones damos espacio entre las secciones y le cambiamos el color al header para que sea transparente

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
}


@end
