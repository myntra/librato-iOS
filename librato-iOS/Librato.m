//
//  Librato.m
//  Librato-iOS
//
//  Created by Adam Yanalunas on 9/30/13.
//  Copyright (c) 2013 Amco International Education Services, LLC. All rights reserved.
//

#import "Librato.h"
#import "LibratoClient.h"
#import "LibratoConnection.h"
#import "LibratoPersister.h"
#import "LibratoQueue.h"
#import "LibratoDirectPersister.h"

@implementation Librato

#pragma mark - Class methods
+ (NSDate *)minimumMeasureTime
{
    return [NSDate.date dateByAddingTimeInterval:-(3600*24*365)];
}


- (instancetype)initWithEmail:(NSString *)email token:(NSString *)apiKey prefix:(NSString *)prefix
{
    if((self = [super init]))
    {
        self.prefix = prefix;
        [self authenticateEmail:email APIKey:apiKey];
    }

    return self;
}


- (NSString *)APIEndpoint
{
    return self.client.APIEndpoint;
}


- (void)setAPIEndpoint:(NSString *)APIEndpoint
{
    self.client.APIEndpoint = APIEndpoint;
}


- (void)authenticateEmail:(NSString *)emailAddress APIKey:(NSString *)apiKey
{
    [self.client authenticateEmail:emailAddress APIKey:apiKey];
}


- (LibratoClient *)client
{
    if (!_client)
    {
        _client = LibratoClient.new;
        _client.queue = [LibratoQueue.alloc initWithOptions:@{@"client": _client, @"prefix": self.prefix}];
    }

    return _client;
}


- (LibratoConnection *)connection
{
    return self.client.connection;
}


- (NSString *)persistence
{
    return self.client.persistence;
}


- (void)setPersistence:(NSString *)persistence
{
    self.client.persistence = persistence;
}


- (id<LibratoPersister>)persister
{
    return self.client.persister;
}


- (void)getMetric:(NSString *)name options:(NSDictionary *)options
{
    [self.client getMetric:name options:options];
}


- (void)getMeasurements:(NSString *)named options:(NSDictionary *)options
{
    [self.client getMeasurements:named options:options];
}


- (void)updateMetricsNamed:(NSString *)name options:(NSDictionary *)options
{
    [self.client updateMetricsNamed:name options:options];
}


- (void)updateMetrics:(NSDictionary *)metrics
{
    [self.client updateMetrics:metrics];
}


- (void)submit:(id)metrics
{
    [self.client submit:metrics];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, persister: %@, prefix: %@>", NSStringFromClass([self class]), self, self.client.persister, self.prefix];
}


@end