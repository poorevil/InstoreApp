
enum DATA_TYPE {
    DATA_TYPE_NULL = 0,
    DATA_TYPE_BRANDLIST = 2,
    DATA_TYPE_CATEGRAYLIST = 3,
    DATA_TYPE_CATEGORYSTORE = 4,
    DATA_TYPE_STORELIST = 5,
    DATA_TYPE_ADS = 6,
    DATA_TYPE_ACTIVITY = 7,
    DATA_TYPE_THUMBNAIL = 8,
    DATA_TYPE_CITY = 9,
    DATA_TYPE_DEFAULT_CITY = 10,
    DATA_TYPE_MALL = 11,
    DATA_TYPE_BRANDDETAIL = 12,
    DATA_TYPE_STORE_OVERVIEW = 13,
    DATA_TYPE_FOCUS = 14,
    DATA_TYPE_MALLINFO = 15,
    DATA_TYPE_DISCOUNT = 16,
    DATA_TYPE_USERPROFILE = 17,
    DATA_TYPE_ITEM_FOCUS_DISCOUNT = 18,
    DATA_TYPE_SERVER_STATE = 19,
    DATA_TYPE_APP_PARAMS = 20,
    DATA_TYPE_SVG_SPACE = 21,
    DATA_TYPE_SVG_FLOOR = 22,
    DATA_TYPE_SVG_FLOOR2 = 23,
    DATA_TYPE_STORELIST2 = 24,
    DATA_TYPE_VENUE_GROUPEDPOIS = 25,
};

@protocol ParseOperationDelegate;

@interface ParseOperation : NSOperation <NSXMLParserDelegate>
{
@private
    id <ParseOperationDelegate> delegate;
    NSData          *dataToParse;
@protected
    NSMutableArray  *workingArray; 
}

- (id)initWithData:(NSData *)data delegate:(id <ParseOperationDelegate>)theDelegate;

@end

@protocol ParseOperationDelegate
- (void)didFinishParsing:(NSArray *)parsedData;
- (void)parseErrorOccurred:(NSError *)error;
@end
