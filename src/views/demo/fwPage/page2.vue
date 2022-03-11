<template>
  <div class="ledger-content">
    <div class="ledger-header" style="">
      <div class="title">访客管理 - script setup lang="ts"</div>
      <div class="extra"></div>
    </div>

    <div class="filter-area">
      <a-form-model
        ref="lastParams"
        :model="lastParams"
        layout="inline"
        :colon="false"
        style="flex: 1"
      >
        <a-form-model-item label="访客姓名" prop="visitor_name">
          <a-input style="width: 205px" v-model="lastParams.visitor_name" placeholder="请输入" />
        </a-form-model-item>
        <a-form-model-item label="访客电话" prop="visitor_mobile">
          <a-input style="width: 205px" v-model="lastParams.visitor_mobile" placeholder="请输入" />
        </a-form-model-item>
        <a-form-model-item label="邀请人姓名" prop="interviewee_name">
          <a-input
            style="width: 205px"
            v-model="lastParams.interviewee_name"
            placeholder="请输入"
          />
        </a-form-model-item>
        <a-form-model-item label="邀请人电话" prop="interviewee_mobile">
          <a-input
            style="width: 205px"
            v-model="lastParams.interviewee_mobile"
            placeholder="请输入"
          />
        </a-form-model-item>
      </a-form-model>
      <div style="margin-top: 5px; min-width: 140px">
        <a-button type="primary" @click="search">查找</a-button>
        <a-button class="defaultBtn" @click="resetFields" type="primary" ghost>重置</a-button>
      </div>
    </div>

    <BasicTable title="基础表格" :columns="columns" :dataSource="data" />
  </div>
</template>

<script setup lang="ts">
  import { fpmsCommunityVisitorList, ArgType } from './api';
  import { BasicTable } from '/@/components/Table';
  import { onMounted, ref } from 'vue';
  import { fpmsUrmMessageList } from '/@/api/fwdemo/page2';

  // let columns = ref([
  //   {
  //     title: '房屋',
  //     ellipsis: true,
  //     width: 250,
  //     dataIndex: 'room_location_str',
  //   },
  //   {
  //     title: '访客姓名',
  //     ellipsis: true,
  //     dataIndex: 'visitor_name',
  //   },
  //   {
  //     title: '访客电话',
  //     ellipsis: true,
  //     dataIndex: 'visitor_mobile',
  //   },
  //   {
  //     title: '邀请人姓名',
  //     ellipsis: true,
  //     dataIndex: 'interviewee_name',
  //   },
  //   {
  //     title: '邀请人电话',
  //     ellipsis: true,
  //     dataIndex: 'interviewee_mobile',
  //   },
  //   {
  //     title: '预约时间',
  //     ellipsis: true,
  //     dataIndex: 'visit_time',
  //   },
  //   {
  //     title: '状态',
  //     ellipsis: true,
  //     dataIndex: 'status',
  //   },
  //   {
  //     title: '操作',
  //     width: 80,
  //     fixed: 'right',
  //   },
  // ]);

  let columns = [
    {
      title: 'ID',
      ellipsis: true,
      width: 80,
      dataIndex: 'id',
    },
    {
      title: '标题',
      ellipsis: true,
      dataIndex: 'title',
    },
    {
      title: '内容',
      ellipsis: true,
      dataIndex: 'summary',
    },
    {
      title: '操作',
      width: 80,
      fixed: 'right',
    },
  ];

  let data = ref([]);

  let lastParams = ref({
    visitor_name: undefined,
    visitor_mobile: undefined,
    interviewee_name: undefined,
    interviewee_mobile: undefined,
  });

  let loadData = async () => {
    const params: ArgType = {
      type: 0, // 限制受邀访客
      page: 1,
      page_size: 20,
      visitor_name: undefined,
      visitor_mobile: undefined,
      interviewee_name: undefined,
      interviewee_mobile: undefined,
    };
    // this.loading = true;
    let res = await fpmsCommunityVisitorList(params);

    if (res.code === 200) {
      data.value = res.data.list;
      // data = ref(res.data.list);
    } else {
      // this.$message.error(res.msg);
    }
    // this.loading = false;
  };
  loadData();

  // 获取消息列表
  let getMessageList = async () => {
    const res = await fpmsUrmMessageList({
      page: 1,
      page_size: 10,
      only_not_read: 1,
    });
    console.log('getMessageList', res);
    data.value = res.list;
  };

  onMounted(async () => {
    await getMessageList();
  });
</script>

<style type="text/css" lang="less" scoped>
  .ledger-content {
    .ledger-header {
      height: 60px;
      padding: 14px 34px;
      display: flex;
      box-sizing: border-box;
      justify-content: space-between;
      background-color: white;

      .title {
        font-size: 18px;
        font-weight: 500;
        color: #282828;
        line-height: 32px;
      }
    }

    .filter-area {
      display: flex;
      margin-left: 16px;
      margin-bottom: 16px;
    }
  }

  .status-badge {
    font-size: 14px;
    line-height: 16px;
    padding-left: 14px;
    position: relative;

    &::before {
      content: '';
      display: block;
      width: 6px;
      height: 6px;
      vertical-align: middle;
      border-radius: 50%;
      position: absolute;
      left: 0;
      top: 6px;
    }

    &.success {
      color: #357aff;

      &::before {
        background: #357aff;
      }
    }

    &.warning {
      color: #ff4d4f;

      &::before {
        background: #ff4d4f;
      }
    }

    &.default {
      &::before {
        background: #d9d9d9;
      }
    }
  }
</style>
