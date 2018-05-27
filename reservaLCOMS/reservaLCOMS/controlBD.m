//
//  controlBD.m
//  reservaLCOMS
//
//  Created by cristian castillo on 5/20/18.
//  Copyright © 2018 cristian castillo. All rights reserved.
//

#import "controlBD.h"


@interface controlBD(){
    sqlite3 *reservaBD;
    NSString *dbPathString;
}

@end

@implementation controlBD

+(controlBD *) sharedInstance{
    static controlBD *myInstance=nil;
    // chect to see if an instance already exists
    if (nil == myInstance) {
        myInstance = [[[self class] alloc] init];
    }
    // return the instance of this class
    return myInstance;
}

-(void) crearOabrirBD
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    dbPathString = [docPath stringByAppendingPathComponent:@"carnet1.db"];
    char *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]){
        const char *dbPath = [dbPathString UTF8String];
        // crear la base de datos
        if (sqlite3_open(dbPath, &reservaBD) == SQLITE_OK) {
            NSString *foreign = @"PRAGMA foreign_keys = ON";
            const char *foreign1 = [foreign UTF8String];
            if (sqlite3_exec(reservaBD, foreign1, NULL, NULL, &error) != SQLITE_OK) {
                NSLog(@"failed to set the foreign_key pragma");
                return;
            }//TABLA PROFESOR
            const char *sql_stmt = "create table profesor(idProfesor varchar(10) not null primary key, nombre varchar(10) not null);";
            sqlite3_exec(reservaBD, sql_stmt, NULL, NULL, &error);
            
            //CREACION DE TABLA TIPO LABORATORIO
            sql_stmt="create table tipoLab(idTipoLab varchar(10) not null primary key,nomTipoLab varchar(10) not null,ram varchar(10) not null,sistemasOpe varchar(10) not null,capacidadDisco varchar(10) not null,procesador varchar(10) not null);";
            sqlite3_exec(reservaBD, sql_stmt, NULL, NULL, &error);
            //CREACION DE TABLA LABORATORIO
            sql_stmt = "CREATE TABLE laboratorio(codLab VARCHAR(10) NOT NULL PRIMARY KEY, idTipoLab VARCHAR(10), cupo VARCHAR(4), planta VARCHAR(4), FOREIGN KEY (idTipoLab) references tipoLab(idTipoLab) on delete restrict on update restrict);";
            sqlite3_exec(reservaBD, sql_stmt, NULL, NULL, &error);
            //CREACION DE TABLA Materia
            sql_stmt="create teable materia(codMateria varchar(10) not null primary key, nomMateria varchar(30) not null, ciclo varchar(10) not null);";
            sqlite3_exec(reservaBD, sql_stmt, NULL, NULL, &error);
            //CREACION TABLA DIA
            sql_stmt="create table dia(idDia VARCHAR(10) NOT NULL PRIMARY KEY, nombreDia VARCHAR(10) NOT NULL);";
            sqlite3_exec(reservaBD, sql_stmt, NULL, NULL, &error);
            //CREACION TABLA HORARIO
            sql_stmt="create table horario(idHorario VARCHAR(10) NOT NULL PRIMARY KEY, horaInicio VARCHAR(10) NOT NULL, horaFin VARCHAR(10) NOT NULL);";
            sqlite3_exec(reservaBD, sql_stmt, NULL, NULL, &error);
            //CREACION DE TABLA RESERVACION
            sql_stmt="create table reservacion(idReservacion varchar(10) not null primary key, idProfesor varchar(10) not null, codMateria varchar(10) not null, codLab varchar(10) not null, idHorario varchar(10) not null, idDia varchar(10) not null, foreign key (idProfesor) references profesor(idProfesor) on delete restrict on update restrict, foreign key (codMateria) references materia (codMateria) on delete restrict on update restrict, foreign key (codLab) references laboratorio (codLab) on delete restrict on update restrict, foreign key (idHorario) references horario (idHorario) on delete restrict on update restrict, foreign key (idDia) dia references (idDia) on delete restrict on update restrict);";
            sqlite3_exec(reservaBD, sql_stmt, NULL, NULL, &error);
            sqlite3_close(reservaBD);
            _dbPath = dbPathString;
            return;
        }
    }
    const char *dbPath = [dbPathString UTF8String];
    //crear la base de datos
    if (sqlite3_open(dbPath, &reservaBD) == SQLITE_OK) {
        _dbPath = dbPathString;
    }
}

@end

