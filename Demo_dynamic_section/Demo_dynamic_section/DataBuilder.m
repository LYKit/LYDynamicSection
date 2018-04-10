//
//  DataBuilder.m
//  Demo_dynamic_section
//
//  Created by 赵学良 on 2017/12/19.
//  Copyright © 2017年 zhaoxueliang. All rights reserved.
//

#import "DataBuilder.h"

@implementation VoyageModel

@end


@implementation TransferModel

@end




@implementation FlightInfo

@end




@implementation TripModel

@end



@implementation DataBuilder


// 游玩层 -- 航程层 -- 航班层|中转层
+ (DataBuilder *)builderData
{
    DataBuilder *data = [DataBuilder new];
    NSMutableArray *mainArray = [NSMutableArray array];
    data.tripList = mainArray;
    { // 游玩 1
        TripModel *trip = [TripModel new];
        trip.tripDesc = @"游玩";
        NSMutableArray *flightArray = [NSMutableArray array];
        trip.flightList = flightArray;
        { // 航程 1
            FlightInfo *flight = [FlightInfo new];
            flight.departCity = @"上海";
            flight.arriveCity = @"新加坡";
            flight.allTime = @"总耗时：10小时";
            flight.type = @"去";
            NSMutableArray *voyageArray = [NSMutableArray array];
            flight.voyageList = voyageArray;
            { // 航班 1
                VoyageModel *voyage = [VoyageModel new];
                voyage.departAir = @"浦东机场T2";
                voyage.arriveAir = @"香港机场T1";
                voyage.flightTime = @"飞行时长2小时30分";
                voyage.cabin = @"上海航空";
                [voyageArray addObject:voyage];
            }
            { // 航班 2
                VoyageModel *voyage = [VoyageModel new];
                voyage.departAir = @"香港机场T1";
                voyage.arriveAir = @"仁川机场";
                voyage.flightTime = @"飞行时长3小时20分";
                voyage.cabin = @"香港航空";
                [voyageArray addObject:voyage];
            }
            { // 航班 3
                VoyageModel *voyage = [VoyageModel new];
                voyage.departAir = @"仁川机场";
                voyage.arriveAir = @"樟宜机场";
                voyage.flightTime = @"飞行时长1小时30分";
                voyage.cabin = @"新加坡航空";
                [voyageArray addObject:voyage];
            }
            NSMutableArray *transferArray = [NSMutableArray array];
            flight.transferList = transferArray;
            { // 中转 1
                TransferModel *model = [TransferModel new];
                model.city = @"香港";
                model.time = @"停留2小时10分";
                [transferArray addObject:model];
            }
            { // 中转 2
                TransferModel *model = [TransferModel new];
                model.city = @"新加坡";
                model.time = @"停留50分";
                [transferArray addObject:model];
            }
            [flightArray addObject:flight];
        }
        { // 航程 2
            FlightInfo *flight = [FlightInfo new];
            flight.departCity = @"新加坡";
            flight.arriveCity = @"上海";
            flight.allTime = @"总耗时：10小时";
            flight.type = @"返";
            NSMutableArray *voyageArray = [NSMutableArray array];
            flight.voyageList = voyageArray;
            { // 航班 1
                VoyageModel *voyage = [VoyageModel new];
                voyage.departAir = @"浦东机场T2";
                voyage.arriveAir = @"香港机场T1";
                voyage.flightTime = @"飞行时长2小时30分";
                voyage.cabin = @"上海航空";
                [voyageArray addObject:voyage];
            }
            { // 航班 2
                VoyageModel *voyage = [VoyageModel new];
                voyage.departAir = @"香港机场T1";
                voyage.arriveAir = @"仁川机场";
                voyage.flightTime = @"飞行时长3小时20分";
                voyage.cabin = @"香港航空";
                [voyageArray addObject:voyage];
            }
            NSMutableArray *transferArray = [NSMutableArray array];
            flight.transferList = transferArray;
            { // 中转 1
                TransferModel *model = [TransferModel new];
                model.city = @"香港";
                model.time = @"停留2小时10分";
                [transferArray addObject:model];
            }
            [flightArray addObject:flight];
        }
        [mainArray addObject:trip];
    }
    
    
    { // 游玩 2
        TripModel *trip = [TripModel new];
        trip.tripDesc = @"出差";
        NSMutableArray *flightArray = [NSMutableArray array];
        trip.flightList = flightArray;
        { // 航程 1
            FlightInfo *flight = [FlightInfo new];
            flight.departCity = @"北京";
            flight.arriveCity = @"纽约";
            flight.allTime = @"总耗时：7小时";
            flight.type = @"去";
            NSMutableArray *voyageArray = [NSMutableArray array];
            flight.voyageList = voyageArray;
            { // 航班 1
                VoyageModel *voyage = [VoyageModel new];
                voyage.departAir = @"首都国际机场T3";
                voyage.arriveAir = @"纽约机场";
                voyage.flightTime = @"飞行时长7小时";
                voyage.cabin = @"东方航空";
                [voyageArray addObject:voyage];
            }
            [flightArray addObject:flight];
        }
        [mainArray addObject:trip];
    }
    
    return data;
}


@end
