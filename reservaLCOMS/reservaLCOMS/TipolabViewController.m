//
//  TipolabViewController.m
//  reservaLCOMS
//
//  Created by cristian castillo on 5/20/18.
//  Copyright © 2018 cristian castillo. All rights reserved.
//

#import "TipolabViewController.h"
#import "controlBD.h"

@interface TipolabViewController ()
{
    NSMutableArray *arrayTipoLab;
    sqlite3 *reservaBD;
    NSString *dbPathString;
}
@end

@implementation TipolabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[controlBD sharedInstance] crearOabrirBD];
    arrayTipoLab=[[NSMutableArray alloc]init];
    [[self TipoLabTableView]setDelegate:self];
    [[self TipoLabTableView]setDataSource:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-----cantidad de secciones en la tabla y cantidad de filas-----

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrayTipoLab count];
}

//-----Presentacion de filas en TableView-----

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    TipoLab *tTipoLab = [arrayTipoLab objectAtIndex:indexPath.row];
    cell.textLabel.text = tTipoLab.idTipoLab;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",tTipoLab.idTipoLab,tTipoLab.nomTipoLab,tTipoLab.ram,tTipoLab.sistemasOpe,tTipoLab.capacidadDisco,tTipoLab.procesador];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)InsertarTipoLabBoton:(id)sender {
    char *error;
    if(sqlite3_open([[controlBD sharedInstance].dbPath UTF8String], &reservaBD)==SQLITE_OK) {
        //ql_stmt="create table tipoLab(idTipoLab varchar(10) not null primary key,nomTipoLab varchar(10) not null,ram varchar(10) not null,sistemasOpe varchar(10) not null,capacidadDisco varchar(10) not null,procesador varchar(10) not null);";
        
        NSString *insert_Stmt=[NSString stringWithFormat:@"INSERT INTO tipoLab(idTipoLab, nomTipoLab, ram, sistemasOpe, capacidadDisco, procesador) values ('%s','%s','%s','%s','%s','%s')",[self.idTipoLabField.text UTF8String],[self.nomTipoLabField.text UTF8String],[self.ramField.text UTF8String],[self.sistemasOpeField.text UTF8String],[self.capacidadDiscoField.text UTF8String],[self.procesadorField.text UTF8String]];
        const  char *insert_stmt=[insert_Stmt UTF8String];
        
        if(sqlite3_exec(reservaBD, insert_stmt, NULL, NULL, &error)==SQLITE_OK){
            NSLog(@"TipoLaboratorio Insertado correctamente");
            
            TipoLab *tipolab =[[TipoLab alloc]init];
            [tipolab setIdTipoLab:self.idTipoLabField.text];
            [tipolab setNomTipoLab:self.nomTipoLabField.text];
            [tipolab setRam:self.ramField.text];
            [tipolab setSistemasOpe:self.sistemasOpeField.text];
            [tipolab setCapacidadDisco:self.capacidadDiscoField.text];
            [tipolab setProcesador:self.procesadorField.text ];
            [arrayTipoLab addObject:tipolab];
        }
        else {
            NSLog(@" Registro no insertado");
        }
        sqlite3_close(reservaBD);
    }
}






- (IBAction)ConsultarTipoLabBoton:(id)sender {
    sqlite3_stmt *statement;
    if(sqlite3_open([[controlBD sharedInstance].dbPath UTF8String], &reservaBD)==SQLITE_OK){
        [arrayTipoLab removeAllObjects];
        NSString *querySql =[NSString stringWithFormat:@"SELECT * FROM tipoLab"];
        const char *querysql=[querySql UTF8String];
        
        if(sqlite3_prepare(reservaBD, querysql, -1, &statement, NULL)==SQLITE_OK){
            while (sqlite3_step(statement)==SQLITE_ROW){
                
                NSString *idTipoLab1= [[NSString alloc ] initWithUTF8String:(const char *) sqlite3_column_text(statement,0)];
                NSString *nomTipoLab1= [[NSString alloc ] initWithUTF8String:(const char *) sqlite3_column_text(statement,1)];
                NSString *ram1= [[NSString alloc ] initWithUTF8String:(const char *) sqlite3_column_text(statement,2)];
                NSString *sistemasOpe1= [[NSString alloc ] initWithUTF8String:(const char *) sqlite3_column_text(statement,3)];
                NSString *capacidadDisco1= [[NSString alloc ] initWithUTF8String:(const char *) sqlite3_column_text(statement,4)];
                NSString *procesador1= [[NSString alloc ] initWithUTF8String:(const char *) sqlite3_column_text(statement,5)];
                
                TipoLab *tipolab =[[TipoLab alloc]init];
                [tipolab setIdTipoLab:idTipoLab1];
                [tipolab setNomTipoLab:nomTipoLab1];
                [tipolab setRam:ram1];
                [tipolab setSistemasOpe:sistemasOpe1];
                [tipolab setCapacidadDisco:capacidadDisco1];
                [tipolab setProcesador:procesador1];
                [arrayTipoLab addObject:tipolab];
            }
        }
        else{
            NSLog(@"Lista vacia");
        }
        sqlite3_close(reservaBD);
        
    }
    [[self TipoLabTableView]reloadData];
}





- (IBAction)ActualizarTipoLabBoton:(id)sender {
    static sqlite3_stmt *statement=nil;
    if(sqlite3_open([[controlBD sharedInstance].dbPath UTF8String], &reservaBD)==SQLITE_OK){
        char *update_Stmt="UPDATE tipoLab SET nomTipoLab=?, ram=?, sistemasOpe=?, capacidadDisco=?, procesador=? WHERE idTipoLab=?";
        if(sqlite3_prepare_v2(reservaBD, update_Stmt, -1, &statement, NULL)==SQLITE_OK){
            sqlite3_bind_text(statement, 1,[self.nomTipoLabField.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2,[self.ramField.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3,[self.sistemasOpeField.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4,[self.capacidadDiscoField.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5,[self.procesadorField.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_step(statement);
            TipoLab *tipolab =[[TipoLab alloc]init];
            [tipolab setIdTipoLab:self.idTipoLabField.text];
            [tipolab setNomTipoLab:self.nomTipoLabField.text];
            [tipolab setRam:self.ramField.text];
            [tipolab setSistemasOpe:self.sistemasOpeField.text];
            [tipolab setCapacidadDisco:self.capacidadDiscoField.text];
            [tipolab setProcesador:self.procesadorField.text ];
            [arrayTipoLab addObject: tipolab];
            NSLog(@" Tipo de laboratorio modificado");
            
        }
        else
        {
            NSLog(@"Tipo de laboratorio NO modificado");
        }
        sqlite3_close(reservaBD);
    }
    
}





- (IBAction)EliminarTipoLabBoton:(id)sender{
    
    [[self TipoLabTableView]setEditing:!self.TipoLabTableView.editing animated:YES];
}

-(void)deleteData:(NSString *)deleteQuery
{
    char * error;
    if (sqlite3_open([[controlBD sharedInstance].dbPath UTF8String], &reservaBD)==SQLITE_OK) {
        if(sqlite3_exec(reservaBD, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK){
            NSLog(@" Tipo de laboratorio Eliminado");
            
        }
        else{
            NSLog(@"Tipo de laboratorio NO Eliminado");
        }
        sqlite3_close(reservaBD);
    }
}



-(void) tableView:(UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        TipoLab *tlab =[arrayTipoLab objectAtIndex:indexPath.row];
        [self deleteData:[NSString stringWithFormat:@"DELETE FROM tipoLab WHERE idTipoLab IS '%s'",[tlab.idTipoLab UTF8String]]];
        [arrayTipoLab removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
    }
    
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan: touches withEvent:event];
    [[self idTipoLabField]resignFirstResponder];
    [[self nomTipoLabField] resignFirstResponder];
    [[self ramField] resignFirstResponder];
    [[self sistemasOpeField] resignFirstResponder];
    [[self capacidadDiscoField] resignFirstResponder];
    [[self procesadorField] resignFirstResponder];
}


@end
