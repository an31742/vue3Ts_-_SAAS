import { CommonListParams } from '/@/api/common/commonModel';

// 消息列表请求Modal
export interface MessageRequestParamsModel extends CommonListParams {
  only_not_read?: number; // 是否只返回未读消息，可选
}
