//
//  ViewController.m
//  MoviesInfo
//
//  Created by Cesar Roberto on 19/03/20.
//  Copyright © 2020 Cesar Roberto. All rights reserved.
//

#import "ViewController.h"
//Para usar nuestra custom cell se necesita importar a clase
#import "CollectionViewCell.h"

@interface ViewController () {
    float varToReturn;
    NSString *cal;
    

}

//Variables para poder imprimir la imagen
@property (strong,nonatomic) NSMutableArray *imagenesUrl;
@property (strong,nonatomic) NSMutableArray *imagenRealPelicula;
@property (strong, nonatomic) NSMutableArray *peliculaNombre;
@property (strong,nonatomic) NSMutableArray *movieId;
@property (strong,nonatomic) NSMutableArray *calificationMovie;
@property (strong,nonatomic) NSString *calif;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    [self getData];
}



//MARK: Funciones Para obtener datos de OMDB

- (void) getData{
    dispatch_group_t group = dispatch_group_create();
    //self.url = @"http://www.omdbapi.com/?apikey=c37f63f&s=batman";
    self.url = @"http://www.omdbapi.com/?apikey=c37f63f&s=pokemon";
    
    NSURL *urlComplete = [NSURL URLWithString:self.url];
    
    //Iniciamos el URLSession
    [[NSURLSession.sharedSession dataTaskWithURL:urlComplete completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Terminamos de conseguir los datos");
        //Guardamos la data en un objeto NSString
        NSString *dummyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@" Contenido de dummy:  %@", dummyString);
        
        NSError *err;
        //Serializamos el JSON y guardamos la data con formato Json.
        NSDictionary *dataObtenida = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        //Si hay un error lo imprimimos
        if (err) {
            NSLog(@"Fallamos al obtener la data: %@" , err);
            return;
        }
        //Ahora creamos variables para guardar los datos que nos regresa una determinada key
        NSMutableArray *tituloPelicula = [[dataObtenida objectForKey:@"Search"] valueForKey:@"Title"];
        NSMutableArray *posterPelicula = [[dataObtenida objectForKey:@"Search"] valueForKey:@"Poster"];
        NSMutableArray *idPelicula = [[dataObtenida objectForKey:@"Search"] valueForKey:@"imdbID"];
        
        //iniciamos las clases de neustros objetos
        self.imagenesUrl = [NSMutableArray new];
        self.imagenRealPelicula = [NSMutableArray new];
        self.peliculaNombre = [NSMutableArray new];
        self.movieId = [NSMutableArray new];

        //Se igualan las variables obtenidas a nuestras variables globales
        self.peliculaNombre = tituloPelicula;
        self.movieId = idPelicula;
        
        //Con esto pasamos los datos obtenidos a el objecto que los pasara a las celdas del collection
        for (int i = 0; i < posterPelicula.count; i++){
            
            NSLog(@"Id  imdb en el main thread: %@" , idPelicula[i]);
           

          //  self->cal =  [self getCalificationMovie:idPelicula[i]];

            
            //Vamos a convertir los strings obtenidos en urls
            NSURL *urlFromString = [[NSURL alloc] initWithString: posterPelicula[i]];
            NSData *dataFromUrl = [[NSData alloc] initWithContentsOfURL:urlFromString];
            UIImage *imageFromData = [UIImage imageWithData:dataFromUrl];
            [self.imagenRealPelicula addObject:imageFromData];
            
            //Hacemos la declaracion de la url y le interpolamos el id de la película
               NSString *urlWithIdString = [NSString stringWithFormat:@"http://www.omdbapi.com/?apikey=c37f63f&i=%@",idPelicula[i]];
               NSURL *urlWithId = [NSURL URLWithString:urlWithIdString];
               
            
         
                dispatch_async(dispatch_get_main_queue(), ^{
                  //Hacemos la peticion para sacar de ahi la calificacion
                      self.calificationMovie = [NSMutableArray new];
                         [[NSURLSession.sharedSession dataTaskWithURL:urlWithId completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                             
                             NSError *err;
                             NSDictionary *obtainedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
                             
                             if (err) {
                                 NSLog(@"Fallamos al obtener la data: %@" , err);
                                 return;
                             }
                             
                             NSString *califications = [obtainedData valueForKey:@"imdbRating"];
                            [self.calificationMovie addObject: califications];
                           
                             NSLog(@"ID de la Pelicula: %@" , idPelicula[i]);
                             NSLog(@"Calificacion imdb: %@" , califications);
                             
                             
                             
                         }]resume];
                    });
       

            

        }
        

        

      
        
        //Hacemos reload al collection
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collection reloadData];
        });
        
        
    }]resume];
    
}

//MARK: Funcion para obtener la calificacion de las peliculas

-(NSString *)getCalificationMovie:(NSString *)movieID{
    

    
//    //Hacemos la declaracion de la url y le interpolamos el id de la película
//    NSString *urlWithIdString = [NSString stringWithFormat:@"http://www.omdbapi.com/?apikey=c37f63f&i=%@",movieID];
//    NSURL *urlWithId = [NSURL URLWithString:urlWithIdString];
//
//
//        dispatch_group_t group = dispatch_group_create();
//
//    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
//       //Hacemos la peticion para sacar de ahi la calificacion
//           self.calificationMovie = [NSMutableArray new];
//              [[NSURLSession.sharedSession dataTaskWithURL:urlWithId completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//                  NSError *err;
//                  NSDictionary *obtainedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
//
//                  if (err) {
//                      NSLog(@"Fallamos al obtener la data: %@" , err);
//                      return;
//                  }
//
//                  NSString *califications = [obtainedData valueForKey:@"imdbRating"];
//                  //Variable a retornar
//                  self->_calif = califications;
//
//                  NSLog(@"ID de la Pelicula: %@" , movieID);
//                  NSLog(@"Calificacion imdb: %@" , self->_calif);
//
//                   [self.calificationMovie addObject: self->cal];
//
//
//
//              }]resume];
//    });

       

    
    
    return _calif;
    
}



//MARK: Funciones propias del collection view

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.movieCalifLbl.text = @"";
    //Aplicamos sobra a las celdas de collection
    cell.clipsToBounds = false;
    cell.layer.masksToBounds = false;
    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.layer.shadowOffset = CGSizeMake(0 , 10);
    cell.layer.shadowRadius = 10;
    cell.layer.shadowOpacity = .3;
    
    //Redondeamos las esquinas
    cell.layer.cornerRadius = 10;
    cell.subView.layer.cornerRadius = 10;
    
    //Aplicamos los datos obtenidos
    cell.movieNameLbl.text = self.peliculaNombre[indexPath.row];
    cell.movieImageView.image = self.imagenRealPelicula[indexPath.row];
    cell.idLabel.text = self.movieId[indexPath.row];
    //En el lbl calificacion se pondra lo que obtengamos de la funcion que hace la peticion al servidor por medio del id.
    //cell.movieCalifLbl.text = [self getCalificationMovie:self.movieId[indexPath.row]];
    cell.movieCalifLbl.text = self.calificationMovie[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.peliculaNombre.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectillonViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        return CGSizeMake(390.f,400.f);
}

//funciones para añadir espacio

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 50.0;
}





    



@end
