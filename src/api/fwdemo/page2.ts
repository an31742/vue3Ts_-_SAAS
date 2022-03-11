import { defHttp } from '/@/utils/http/axios';
import { MessageRequestParamsModel } from './model/page2Model';

enum Api {
  FPMS_URM_MESSAGE_LIST = 'http://pms-api-dev.gmtech.top/fpms/urm/message/list',
}

// 未读消息列表
export const fpmsUrmMessageList = (data: MessageRequestParamsModel) =>
  defHttp.post({ url: Api.FPMS_URM_MESSAGE_LIST, data });
