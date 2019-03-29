//
//  LGPhotoManager.m
//  LGBuDeJie
//
//  Created by 甘延娇 on 2019/3/22.
//  Copyright © 2019 itheima. All rights reserved.
//

#import "LGPhotoManager.h"
#import <Photos/Photos.h>

@implementation LGPhotoManager

#pragma mark --- 获取之前相册
+ (PHAssetCollection *)fetchAssetCollection:(NSString *)albumTitle
{
    //获取之前相册
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle isEqualToString:albumTitle]) {
            return assetCollection;
        }
    }
    return nil;
}

+ (void)savePhoto:(UIImage *)image albumTitle:(NSString *)albumTitle
completionHandler:(void(^)(BOOL success, NSError * error))completionHandler
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //判断之前有没有相册，获取之前相册
        PHAssetCollection *assetCollection = [self fetchAssetCollection:albumTitle];
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest;
        if (assetCollection) {
            //已有相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        }else{
            //1创建自定义相册
            assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumTitle];
        }
        //2添加图片到系统相册
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        //3拷贝系统相册图片到自定义相册
        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
        [assetCollectionChangeRequest addAssets:@[placeholder]];
    } completionHandler:^(BOOL success, NSError * error) {
        
        if (completionHandler) {
            completionHandler(success,error);
        }
    }];
}


@end
