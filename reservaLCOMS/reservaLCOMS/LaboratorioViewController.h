//
//  LaboratorioViewController.h
//  reservaLCOMS
//
//  Created by cristian castillo on 5/20/18.
//  Copyright © 2018 cristian castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Laboratorio.h"

@interface LaboratorioViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *CodLabField;
@property (strong, nonatomic) IBOutlet UITextField *IdTipoLabField;
@property (strong, nonatomic) IBOutlet UITextField *cupoField;
@property (strong, nonatomic) IBOutlet UITextField *plantaField;



/*
 @property (strong, nonatomic) IBOutlet UITextField *CodLab;
@property (strong, nonatomic) IBOutlet UITextField *idTipoLab;
@property (strong, nonatomic) IBOutlet UITextField *cupo;
@property (strong, nonatomic) IBOutlet UITextField *planta;
 */

- (IBAction)InsertarLaboratorioBoton:(id)sender;
- (IBAction)ActualizarLaboratorioBoton:(id)sender;
- (IBAction)ConsultarLaboratorioBoton:(id)sender;
- (IBAction)EliminarLaboratorioBoton:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *LaboratorioTableView;
@end
