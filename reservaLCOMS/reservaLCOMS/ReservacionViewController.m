//
//  ReservacionViewController.m
//  reservaLCOMS
//
//  Created by cristian castillo on 5/20/18.
//  Copyright © 2018 cristian castillo. All rights reserved.
//

#import "ReservacionViewController.h"
#import "controlBD.h"
@interface ReservacionViewController ()
{
    NSMutableArray *arrayReservacion;
    sqlite3 *reservaBD;
    NSString *dbPathString;
    
}
@end

@implementation ReservacionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)InsertarReservacionBoton:(id)sender {
}

- (IBAction)ConsultarReservacionBoton:(id)sender {
}

- (IBAction)ConsultarReservacionAction:(id)sender {
}

- (IBAction)ActualizarReservacionBoton:(id)sender {
}

- (IBAction)EliminarReservacionBoton:(id)sender {
}
- (IBAction)EliminarReservacionAction:(id)sender {
}
@end
