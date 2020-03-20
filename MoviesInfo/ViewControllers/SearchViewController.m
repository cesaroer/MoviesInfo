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
@property (strong,nonatomic) NSMutableArray *imagenRealPelicula;
@property (strong, nonatomic) NSMutableArray *peliculaNombre;
@property (strong,nonatomic) NSMutableArray *calificationMovie;
@property (weak,nonatomic) NSString *url;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableViewMovies.delegate = self;
    self.tableViewMovies.dataSource = self;
    self.searchMovieBar.delegate = self;
}

//MARK: Funcion para obtener data

- (void)getMovieSearchedData:(NSString *)movieName{
    
    self.url = [NSString stringWithFormat:@"http://www.omdbapi.com/?apikey=c37f63f&s=%@",movieName];
    NSURL *requestURL = [NSURL URLWithString:self.url];
    
    //Iniciamos el URLSession
    [[NSURLSession.sharedSession dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *dummyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@" Contenido de dummy:  %@", dummyString);
        
    }]resume];
    
}

//MARK: Funciones de la tableview

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

//MARK: Funcion de searchbar

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *str = searchBar.text;
    NSLog(@"%@",str);
    [self getMovieSearchedData:str];
    //Hacemos dissmis al keyboard
    [self.view endEditing:YES];
}

//Con esta funcion cada vez que cambie el texto imprime el texto contenido

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    NSString *str = searchBar.text;
//    NSLog(@"%@",str);
//}

@end
