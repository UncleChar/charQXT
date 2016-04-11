//
//  RequestBlockManager.h
//  QXT
//
//  Created by LingLi on 16/3/23.
//  Copyright © 2016年 LINGLI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    //Acount
    RequestType_Regist = 1,
    RequestType_Login,
    RequestType_SpaceInfo,
    RequestType_AvatarInfo,
    RequestType_CheckToken,
    RequestType_ChangeToken,
    RequestType_ChangeAvatar,
    RequestType_MyTeam,
    RequestType_MyTeamUpdateDefault,
    
    //Files
    RequestType_ObjList,
    RequestType_MoveObjList,
    RequestType_FolderCreate,
    RequestType_NotesCreate,
    RequestType_NotesSave,
    RequestType_NoteRead,
    
    MsgType_Noti,//xhl
    
    
    RequestType_FolderUpdate,
    RequestType_FileUpdate,
    RequestType_FolderMove,
    RequestType_FileMove,
    RequestType_FileCopy,
    RequestType_BatchFileMove,
    
    RequestType_FolderDelete,
    RequestType_FileDelete,
    RequestType_BatchFileDelete,
    RequestType_Search,
    
    //Folder
    RequestType_FolderCooperation,
    RequestType_FolderSchieldCooperation,
    RequestType_FolderLastDiscuss,
    RequestType_FolderLastSendMessage,
    RequestType_FolderLastSchield,
    RequestType_FolderLastDelete,
    
    //Favorite
    RequestType_FavoriteList,
    RequestType_FavoriteCreate,
    RequestType_FavoriteDelete,
    
    //Contact
    RequestType_ContactList,
    RequestType_ContactAdd,
    RequestType_GroupList,
    RequestType_ContactUpdate,
    RequestType_ContactDelete,
    RequestType_ContactUpdatePower,
    
    
    RequestType_ContactPersonalInfo,
    RequestType_ContactPersonPW,
    
    //Recycle
    RequestType_RecycleList,
    RequestType_RecycleEmpty,
    RequestType_RecycleCancel,
    RequestType_RecycleDelete,
    
    //Message
    RequestType_DiscussMessage,
    RequestType_DiscussNotice,
    RequestType_NoticeNum,
    RequestType_DiscussDetailMessage,
    RequestType_DiscussPostMessage,
    RequestType_DiscussLJ,
    
    //Share
    RequestType_ShareCreate,
    RequestType_ShareList,
    RequestType_ShareDelete,
    RequestType_ShareConnect,
    RequestType_shareInvite,
    RequestType_linkShare,
    RequestType_shareSeeStorage,
    RequestType_updateSeeStoragePower,
    RequestType_deleteStorage,
    RequestType_Count,
    RequestType_linkFromBrowser,
    RequestType_saveLinkFromBrowser,
    RequestType_getPermission,
    RequestType_checkLinkPS
    
} RequestType;

typedef enum
{
    REQUEST_METHOD_GET = 0,
    REQUEST_METHOD_POST,

} REQUEST_METHOD;


typedef void(^SuccesBlock)(id responseData);
typedef void(^FailureBlock)(NSString *errorDesc);

@protocol QXTRequestDelegate <NSObject>

- (void)requsetFinshedByResponseData:(NSData *)responseData requestType:(RequestType)requestType;

- (void)requestFailedByError:(NSError *)responseError errorCode:(NSInteger)code forRequest:(ASIHTTPRequest *)errorRequest withRequestType:(RequestType)requestType;

@end



@interface QXTRequest : NSObject
@property (nonatomic, strong) NSDictionary         *parmRequestDict;
@property (nonatomic, strong) NSString             *requestUrl;
@property (nonatomic, assign) RequestType          requestType;
@property (nonatomic, assign) REQUEST_METHOD       requestMothd;
@property (nonatomic, strong) NSString             *requestTag;
@property (nonatomic, weak) id<QXTRequestDelegate> delegate;

+ (void)requestDataForListWithDictionary:(NSDictionary *)parmDict withSuccessBlock:(SuccesBlock)success failure:(FailureBlock)failure;



- (void)requestDataByDictionary:(NSDictionary *)parmDict
                    requestType:(RequestType )requestType
                  requsetMethod:(REQUEST_METHOD)requestMothd
                       delegate:(id<QXTRequestDelegate> )delegate;



+ (void)changeAvatarWithImage:(UIImage *)image;



- (void)clearDelegatesAndCancel;




- (void)changeTokenWithDelegate:(id<QXTRequestDelegate>)delegate
                    requestType:(RequestType )requestType;



@end
