<template>
  <div class="ledger-content">
    <div class="ledger-header" style="">
      <div class="title">访客管理 - optional 的写法 和vue2一致</div>
      <div class="extra"></div>
    </div>

    <div class="filter-area">
      <!-- <a-form-model
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
      </a-form-model> -->
      <div style="margin-top: 5px; min-width: 140px">
        <a-button type="primary" @click="search">查找</a-button>
        <a-button class="defaultBtn" @click="resetFields" type="primary" ghost>重置</a-button>
      </div>
    </div>

    <BasicTable title="基础表格" :columns="columns" :dataSource="data" />
  </div>
</template>

<script>
  // import * as _ from './api.js';
  // console.log('----------', _);
  import { fpmsCommunityVisitorList } from './api';
  // console.log('----------', _);
  import { BasicTable } from '/@/components/Table';

  import moment from 'moment';
  // const statusMap = {
  //   0: 'warning',
  //   1: 'success',
  // };
  export default {
    name: 'Page',
    components: { BasicTable },
    data() {
      return {
        moment,
        loading: false,
        // 表头
        columns: [
          {
            title: '房屋',
            ellipsis: true,
            width: 250,
            dataIndex: 'room_location_str',
          },
          {
            title: '访客姓名',
            ellipsis: true,
            dataIndex: 'visitor_name',
          },
          {
            title: '访客电话',
            ellipsis: true,
            dataIndex: 'visitor_mobile',
          },
          {
            title: '邀请人姓名',
            ellipsis: true,
            dataIndex: 'interviewee_name',
          },
          {
            title: '邀请人电话',
            ellipsis: true,
            dataIndex: 'interviewee_mobile',
          },
          {
            title: '预约时间',
            ellipsis: true,
            dataIndex: 'visit_time',
          },
          {
            title: '状态',
            ellipsis: true,
            dataIndex: 'status',
          },
          {
            title: '操作',
            width: 80,
            fixed: 'right',
          },
        ],
        data: [],
        options: [],
        labelCol: {
          xs: { span: 24 },
          sm: { span: 6 },
        },
        wrapperCol: {
          xs: { span: 24 },
          sm: { span: 16 },
        },
        visible: false,
        lastParams: {
          visitor_name: undefined,
          visitor_mobile: undefined,
          interviewee_name: undefined,
          interviewee_mobile: undefined,
        },
        detail: {},
        dataSource: [],
      };
    },
    async created() {
      this.loadDatas();
    },
    methods: {
      resetFields() {
        this.lastParams = {
          visitor_name: undefined,
          visitor_mobile: undefined,
          interviewee_name: undefined,
          interviewee_mobile: undefined,
        };

        this.search();
      },
      loadDatas() {
        const params = {
          type: 0, // 限制受邀访客
          page: 1,
          page_size: 20,
          ...this.lastParams,
        };
        this.loading = true;
        fpmsCommunityVisitorList(params)
          .then((res) => {
            this.loading = false;
            if (res.code === 200) {
              this.data = res.data.list;
            } else {
              this.$message.error(res.msg);
            }
          })
          .catch((_) => {
            this.loading = false;
          });
      },
      /**
       * 跳转到添加页面，不同页面有不同的title，所以添加和编辑使用了两个路由
       */
      addItem() {
        this.$router.push('/base/visitors/create');
      },

      /**
       * 当分页发生变化的时候，我们需要对pagination重新赋值并重新获取列表
       */
      onPageChanged(pagination) {
        this.pagination = pagination;
        this.$scrollTo(0, 800);
        this.loadDatas();
      },

      /**
       * 搜索按钮点击事件
       * @param name
       */
      search() {
        this.pagination.current = 1;
        this.loadDatas();
      },

      showModal(record = {}) {
        this.detail = record;
        console.log(record);
        this.visible = true;
      },
    },
  };
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
