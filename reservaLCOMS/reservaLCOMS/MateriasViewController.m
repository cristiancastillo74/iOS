//
//  MateriasViewController.m
//  reservaLCOMS
//
//  Created by cristian castillo on 5/20/18.
//  Copyright © 2018 cristian castillo. All rights reserved.
//

#import "MateriasViewController.h"
#import "controlBD.h"

@interface MateriasViewController ()
{
    NSMutableArray *arrayMaterias;
    sqlite3 *reservaBD;
    NSString *dbPathSting;
}
@end

@implementation MateriasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[controlBD sharedInstance] crearOabrirBD];
    arrayMaterias=[[NSMutableArray alloc]init];
    [[self MateriasTableView]setDelegate:self];
    [[self MateriasTableView]setDataSource:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayMaterias count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Materia *mMateria=[arrayMaterias objectAtIndex:indexPath.row];
    cell.textLabel.text=mMateria.codMateria;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ %@",mMateria.nomMateria ,mMateria.ciclo];
    
    return cell ;
}





- (IBAction)InsertarMateriaBoton:(id)sender {
    char *error;
    if (sqlite3_open([[controlBD sharedInstance].dbPath UTF8String], &reservaBD)==SQLITE_OK){
        NSString *insert_Stmt=[NSString stringWithFormat:@"INSERT INTO materia(codMateria,nomMateria,ciclo) values ('%s','%s','%s')",[self.codMateriaField.text UTF8String],[self.nomMateriaField.text UTF8String],[self.cicloField.text UTF8String]];
        const char *insert_stmt=[insert_Stmt UTF8String];
        if(sqlite3_exec(reservaBD, insert_stmt, NULL, NULL, &error)==SQLITE_OK){
            NSLog (@"Materia Insertada correctamente");
            
            Materia *materias =[[Materia alloc]init];
            [materias setCodMateria:self.codMateriaField.text];
            [materias setNomMateria:self.nomMateriaField.text];
            [materias setCiclo:self.cicloField.text];
            [arrayMaterias addObject:materias];
        }
        else {
            NSLog(@" Registro no insertado");
        }
        sqlite3_close(reservaBD);
        
    }}

- (IBAction)ConsultarMateriaBoton:(id)sender {
    sqlite3_stmt *statement;
    if(sqlite3_open([[controlBD sharedInstance].dbPath UTF8String], &reservaBD)==SQLITE_OK){
        [arrayMaterias removeAllObjects];
        NSString *querySql=[NSString stringWithFormat:@"SELECT * FROM materia"];
        const char *querysql=[querySql UTF8String];
        if(sqlite3_prepare(reservaBD, querysql, -1, &statement, NULL)==SQLITE_OK){
            while (sqlite3_step(statement)==SQLITE_ROW){
                NSString *codMateria1= [[NSString alloc ] initWithUTF8String:(const char *) sqlite3_column_text(statement,0)];
                NSString *nomMateria1= [[NSString alloc ] initWithUTF8String:(const char *) sqlite3_column_text(statement,1)];
                NSString *ciclo1= [[NSString alloc ] initWithUTF8String:(const char *) sqlite3_column_text(statement,2)];
                
                Materia *materias =[[Materia alloc]init];
                [materias setCodMateria:codMateria1];
                [materias setNomMateria:nomMateria1];
                [materias setCiclo:ciclo1];
                [arrayMaterias addObject:materias];
            }
        }
        else{
            NSLog(@"Lista vacia");
        }
        sqlite3_close(reservaBD);
    }
    [[self MateriasTableView]reloadData];
}





- (IBAction)ActualizarMateriaBoton:(id)sender {
    static sqlite3_stmt *statement=nil;
    if(sqlite3_open([[controlBD sharedInstance].dbPath UTF8String], &reservaBD)==SQLITE_OK){
        
        char *update_Stmt="UPDATE materia SET nomMateria=?, ciclo=? WHERE codMateria=?";
        if(sqlite3_prepare_v2(reservaBD, update_Stmt, -1, &statement, NULL)==SQLITE_OK){
            sqlite3_bind_text(statement, 1,[self.codMateriaField.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2,[self.nomMateriaField.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3,[self.cicloField.text UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_step(statement);
            
            Materia *materias =[[Materia alloc]init];
            [materias setNomMateria:self.nomMateriaField.text];
            [materias setCiclo:self.cicloField.text];
            [arrayMaterias addObject: materias];
            NSLog(@"Materia modificada");
        }
        else{
            NSLog(@"Materia no modificada");
        }
        sqlite3_close(reservaBD);
    }
}


- (IBAction)EliminarMateriaBoton:(id)sender {
    [[self MateriasTableView]setEditing:!self.MateriasTableView.editing animated:YES];
}



-(void)deleteData:(NSString *)deleteQuery
{
    char * error;
    if (sqlite3_open([[controlBD sharedInstance].dbPath UTF8String], &reservaBD)==SQLITE_OK) {
        if(sqlite3_exec(reservaBD, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK){
            NSLog(@" Materia Eliminada");
        }
        else{
            NSLog(@"Materia NO Eliminada");
        }
        sqlite3_close(reservaBD);
    }
}


-(void) tableView:(UITableView *) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        Materia *mMateria =[arrayMaterias objectAtIndex:indexPath.row];
        [self deleteData:[NSString stringWithFormat:@"DELETE FROM materia WHERE codMateria IS '%s'",[mMateria.codMateria UTF8String]]];
        [arrayMaterias removeObjectAtIndex: indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
    }
    
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan: touches withEvent:event];
    [[self codMateriaField]resignFirstResponder];
    [[self nomMateriaField] resignFirstResponder];
    [[self cicloField] resignFirstResponder];
}


@end
