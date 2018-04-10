//
//  DataBuilder.h
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2017/12/19.
//  Copyright © 2017年 zhaoxueliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoyageModel : NSObject
@property (nonatomic, copy) NSString *departAir;
@property (nonatomic, copy) NSString *arriveAir;
@property (nonatomic, copy) NSString *flightTime;
@property (nonatomic, copy) NSString *cabin;
@end


@interface TransferModel : NSObject
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *time;
@end



@interface FlightInfo : NSObject
@property (nonatomic, copy) NSString *departCity;
@property (nonatomic, copy) NSString *arriveCity;
@property (nonatomic, copy) NSString *allTime;
@property (nonatomic, copy) NSString *type;
@property (nonatomic,strong) NSMutableArray<VoyageModel*> *voyageList; // 航班list
@property (nonatomic,strong) NSMutableArray<TransferModel*> *transferList; // 中转list

@end



@interface TripModel : NSObject
@property (nonatomic, copy) NSString *tripDesc;
@property (nonatomic,strong) NSMutableArray<FlightInfo*> *flightList; // 航程list

@end




@interface DataBuilder : NSObject

@property (nonatomic,strong) NSMutableArray<TripModel*> *tripList; // 游玩list

+ (DataBuilder *)builderData;

@end




