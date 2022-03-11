import type { AppRouteModule } from '/@/router/types';

import { getParentLayout, LAYOUT } from '/@/router/constant';
// import { RoleEnum } from '/@/enums/roleEnum';
// import { t } from '/@/hooks/web/useI18n';

const permission: AppRouteModule = {
  path: '/fwdemo',
  name: 'FWdemo',
  component: LAYOUT,
  redirect: '/fwdemo/test/page1',
  meta: {
    orderNo: 15,
    icon: 'ion:key-outline',
    title: 'FW demo',
  },

  children: [
    {
      path: 'test',
      name: 'PermissionFrontDemo',
      component: getParentLayout('PermissionFrontDemo'),
      meta: {
        title: '组件测试',
      },
      children: [
        {
          path: 'page1',
          name: 'option',
          component: () => import('/@/views/demo/fwPage/page.vue'),
          meta: {
            title: 'option api的写法',
          },
        },
        {
          path: 'page2',
          name: 'sfc',
          component: () => import('/@/views/demo/fwPage/page2.vue'),
          meta: {
            title: 'sfc单文件组件',
          },
        },
        {
          path: 'page3',
          name: 'tsx',
          component: () => import('/@/views/demo/fwPage/page.vue'),
          meta: {
            title: 'TSX (JSX)',
          },
        },
      ],
    },
  ],
};

export default permission;
