//
//  Reservacion.h
//  reservaLCOMS
//
//  Created by Veronica C on 27/5/18.
//  Copyright © 2018 cristian castillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reservacion : NSObject

@property(nonatomic, strong)NSString *idReservacion;
@property(nonatomic, strong)NSString *idProfesor;
@property(nonatomic, strong)NSString *codMateria;
@property(nonatomic, strong)NSString *codLab;
@property(nonatomic, strong)NSString *idHorario;
@property(nonatomic, strong)NSString *idDia;

//reservacion(idReservacion varchar(10) not null primary key, idProfesor varchar(10) not null, codMateria varchar(10) not null, codLab varchar(10) not null, idHorario varchar(10) not null, idDia varchar(10)
@end
