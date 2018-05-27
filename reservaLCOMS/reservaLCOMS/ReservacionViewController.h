//
//  ReservacionViewController.h
//  reservaLCOMS
//
//  Created by cristian castillo on 5/20/18.
//  Copyright © 2018 cristian castillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservacionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *idReservacionField;
@property (strong, nonatomic) IBOutlet UITextField *idProfesorField;
@property (strong, nonatomic) IBOutlet UITextField *codMateriaField;
@property (strong, nonatomic) IBOutlet UITextField *codLabField;
@property (strong, nonatomic) IBOutlet UITextField *idHorarioField;
@property (strong, nonatomic) IBOutlet UITextField *idDiaFIeld;

- (IBAction)InsertarReservacionBoton:(id)sender;
- (IBAction)ConsultarReservacionBoton:(id)sender;
- (IBAction)ActualizarReservacionBoton:(id)sender;
- (IBAction)EliminarReservacionBoton:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *ReservacionTableView;

@end
