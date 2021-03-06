
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CYTopicsType) {
    CYTopicsTypeAll = 1, // 全部
    CYTopicsTypePicture = 10, // 图片
    CYTopicsTypeWord = 29, // 段子
    CYTopicsTypeVoice = 31, // 声音
    CYTopicsTypeVideo = 41 // 视频
};

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const CYTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const CYTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const CYTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const CYTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const CYTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const CYTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const CYTopicCellPictureBreakH;

/** CYUser模型-性别属性值 */
UIKIT_EXTERN NSString * const CYUserSexMale;
UIKIT_EXTERN NSString * const CYUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const CYTopicCellTopCmtTitleH;

/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const CYTabBarDidSelectNotification;
/** tabBar被选中的通知 - 被选中的控制器的index key */
UIKIT_EXTERN NSString * const CYSelectedControllerIndexKey;
/** tabBar被选中的通知 - 被选中的控制器 key */
UIKIT_EXTERN NSString * const CYSelectedControllerKey;

/** 标签-间距 */
UIKIT_EXTERN CGFloat const CYTagMargin;
/** 标签-高度 */
UIKIT_EXTERN CGFloat const CYTagH;
