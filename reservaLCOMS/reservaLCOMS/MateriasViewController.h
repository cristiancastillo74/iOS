//
//  MateriasViewController.h
//  reservaLCOMS
//
//  Created by cristian castillo on 5/20/18.
//  Copyright © 2018 cristian castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Materia.h"

@interface MateriasViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *codMateriaField;
@property (strong, nonatomic) IBOutlet UITextField *nomMateriaField;
@property (strong, nonatomic) IBOutlet UITextField *cicloField;

@property (strong, nonatomic) IBOutlet UITableView *MateriasTableView;

- (IBAction)InsertarMateriaBoton:(id)sender;
- (IBAction)ConsultarMateriaBoton:(id)sender;
- (IBAction)ActualizarMateriaBoton:(id)sender;
- (IBAction)EliminarMateriaBoton:(id)sender;

@end
