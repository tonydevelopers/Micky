//
//  ApiMacros.h
//  MickyEasyCredit
//
//  Created by  张宁 on 2016/10/5.
//  Copyright © 2016年  张宁. All rights reserved.
//

#ifndef ApiMacros_h
#define ApiMacros_h

#define IMGURLIP          @"http://dev.qianyijinrong.com:8089"
#define BASEURL           @"http://dev.qianyijinrong.com:8089/jeeplus/api/"

//#define IMGURLIP          @"http://dev.i-caiwu.cn:8089"
//#define BASEURL           @"http://dev.i-caiwu.cn:8089/jeeplus/api/"

//#define IMGURLIP          @"http://116.193.51.30:8089"
//#define BASEURL           @"http://116.193.51.30:8089/jeeplus/api/"

//#define IMGURLIP          @"http://192.168.2.115:8083/"
//#define BASEURL           @"http://192.168.2.115:8083/jeeplus/api/"

//#define IMGURLIP          @"http://172.168.0.245:8080"
//#define BASEURL           @"http://172.168.0.245:8080/jeeplus/api/"

//#define IMGURLIP          @"http://192.168.2.110:8080/"
//#define BASEURL           @"http://192.168.2.110:8080/jeeplus/api/"

#define PUBLIC_URL(domain) [NSString stringWithFormat:@"%@%@",BASEURL,domain]

#define LOGIN                         @"login"                 //登录
#define SENDCODE                      @"sendCode"              //发送验证码
#define REGISTER                      @"register"              //注册
#define SENDLOSTCODE                  @"sendLostCode"          //忘记密码发送验证码
#define SENDCODESUBMIT                @"sendCodeSubmit"        //忘记密码提交
#define SENDCODECONFIRM               @"sendCodeConfirm"       //忘记密码确认
#define ADVERT                        @"advert"                //广告轮播图
#define MSG                           @"msg"                   //消息
#define USERMESSAGE                   @"userMessage"           //我的基本信息
#define UPLOADFILE                    @"uploadFile"            //上传照片
#define UPDATEPWD                     @"updatePwd"             //修改密码
#define MEMBERDATA                    @"memberData"            //资料认证
#define LOAN                          @"loan"                  //我要借款
#define CONFIRMLOAN                   @"confirmLoan"           //确认借款
#define PHOTO                         @"photo"                 //身份认证
#define PHOTOSAVE                     @"photoSave"             //保存照片
#define INDEXWEEKLOAN                 @"indexWeekLoan"         //借款轮播
#define UPDATENICKNAME                @"updateNickName"        //修改昵称
#define BANKCARD                      @"bankCard"              //银行卡列表
#define COUPON                        @"coupon"                //我的优惠券
#define WHITECOLLAR                   @"whiteCollar"           //白领
#define LOANPROTOCOL                  @"loanProtocol"          //借款合同
#define WITHHOLDAGREEMENT             @"withholdingAgreement"  //代扣协议
#define LOCKUSER                      @"lockUser"              //资料判断

#define web_url        @"http://dev.qianyijinrong.com:8089/jeeplus/webpage/modules/h5/"
//#define web_url        @"http://dev.i-caiwu.cn:8089/jeeplus/webpage/modules/h5/"
//#define web_url        @"http://116.193.51.30:8089/jeeplus/webpage/modules/h5/"
//#define web_url        @"http://192.168.2.115:8083/jeeplus/webpage/modules/h5/"
//#define web_url        @"http://116.193.51.30:8089/jiedai/webpage/modules/h5/"
//#define web_url        @"http://172.168.0.245:8080/jeeplus/webpage/modules/h5/"
//#define web_url        @"http://192.168.2.110:8080/jeeplus/webpage/modules/h5/"

#define WEBURL(domain) [NSString stringWithFormat:@"%@%@",web_url,domain]

#define WEB_INDEX           @"index.html"                           //首页
#define WEB_HELP            @"help.html"                            //帮助
#define WEB_VALIDATE2       @"validate_2.html"                      //互联网认证
#define WEB_CREDITCARD      @"creditCard.html"                      //银行卡信息
#define WEB_BIND            @"bind.html"                            //银行卡绑定
#define WEB_EXPLAIN         @"explain.html"                         //费用说明
#define WEB_VALIDATE        @"validate_1.html"                      //手机认证
#define WEB_TOBINDCARD      @"toBindCard"                           //银行卡信息
#define WEB_PHONECRET       @"toPhoneCert"                          //手机认证
#define WEB_JDCERT          @"toJdCert"                             //互联网认证
#define WEB_TOSUCCESS       @"toSuccess"                            //成功
#define WEB_TOREPAYMENT     @"toRepayment"                          //还款
#define WEB_TOXUEXINCERT    @"toxueXinCert"                         //学信网认证
#define WEB_SERVICEPROTOCOL @"serviceProtocol.html"                 //服务协议
#define WEB_REGISTER        @"registerProtocol.html"                //注册协议


#define MACRO_WEB_URL         @"http://dev.qianyijinrong.com:8089/jeeplus/a/h5/"
//#define MACRO_WEB_URL         @"http://dev.i-caiwu.cn:8089/jeeplus/a/h5/"
//#define MACRO_WEB_URL         @"http://116.193.51.30:8089/jeeplus/a/h5/"
//#define MACRO_WEB_URL         @"http://192.168.2.115:8083/jeeplus/a/h5/"
//#define MACRO_WEB_URL         @"http://172.168.0.245:8080/jeeplus/a/h5/"
//#define MACRO_WEB_URL         @"http://192.168.2.110:8080/jeeplus/a/h5/"

#define PUBLIC_WEBURL(domain) [NSString stringWithFormat:@"%@%@",MACRO_WEB_URL,domain]

#define WEB_PERSONAL    @"personal"                             //个人信息
#define WEB_EDUCATION   @"education"                            //教育背景
#define WEB_CONTACT     @"contact"                              //联系人信息
#define WEB_LOANQUERY   @"loanQuery"                            //借款查询
#define WEB_TOLOAN      @"toLoan"                               //借款查询
#define WEB_COUPON      @"coupon"                               //优惠券
#define WEB_TOADVERTISE @"toAdvertise"                          //轮播图详情




//--------------------------



#define BASE_URL                    @"http://eyeweb.yanbaosh.com/"
#define INTERFACE_API               @"interface.api?action="
//Api地址
#define API_BASE                    @"interface.api"



#endif /* ApiMacros_h */
















