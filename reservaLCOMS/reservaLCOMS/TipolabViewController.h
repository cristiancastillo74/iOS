//
//  TipolabViewController.h
//  reservaLCOMS
//
//  Created by cristian castillo on 5/20/18.
//  Copyright © 2018 cristian castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TipoLab.h"

@interface TipolabViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *idTipoLabField;
@property (strong, nonatomic) IBOutlet UITextField *nomTipoLabField;
@property (strong, nonatomic) IBOutlet UITextField *ramField;
@property (strong, nonatomic) IBOutlet UITextField *sistemasOpeField;
@property (strong, nonatomic) IBOutlet UITextField *capacidadDiscoField;
@property (strong, nonatomic) IBOutlet UITextField *procesadorField;

@property (strong, nonatomic) IBOutlet UITableView *TipoLabTableView;

- (IBAction)InsertarTipoLabBoton:(id)sender;
- (IBAction)ConsultarTipoLabBoton:(id)sender;
- (IBAction)ActualizarTipoLabBoton:(id)sender;
- (IBAction)EliminarTipoLabBoton:(id)sender;



/*
@property (strong, nonatomic) IBOutlet UIButton *InsertarTipoLabBoton;
@property (strong, nonatomic) IBOutlet UIButton *ConsultarTipoLabBoton;
@property (strong, nonatomic) IBOutlet UIButton *ActualizarTipoLabBoton;
@property (strong, nonatomic) IBOutlet UIButton *EliminarTipoLabBoton;


*/
@end
