//
//  UserInfoCellModel.swift
//  JBankRisk
//
//  Created by caohouhong on 17/1/4.
//  Copyright © 2017年 jingjinsuo. All rights reserved.
//

import UIKit

struct UserInfoCellModel {

    enum CellModelType {
        case product
        case work
        case school
        case income
        case contact
        case dataReupload //重新上传
        case dataWorker30000 //小于30000
        case dataWorker50000
        case dataWorkerAll
        case dataStudentAll
        case dataFreedom10000
        case dataFreedom30000
        case dataFreedom50000
        case dataFreedomAll
    }
    
    var cellData: [CellDataInfo] = [CellDataInfo]()
    
   private var productCellData:[CellDataInfo] = [
        CellDataInfo(leftText: "所属商户", holdText: "商户名称", content: "", cellType: .defaultType),
       CellDataInfo(leftText: "产品名称", holdText: "请输入产品名称", content: "", cellType: .clearType),
       CellDataInfo(leftText: "", holdText: "", content: "", cellType: .defaultType),
       CellDataInfo(leftText: "借款金额", holdText: "请输入借款金额", content: "", cellType: .textType),
       CellDataInfo(leftText: "申请期限", holdText: "", content: "", cellType: .arrowType),
       CellDataInfo(leftText: "月还款额", holdText: "", content: "", cellType: .textType),
       CellDataInfo(leftText: "", holdText: "", content: "", cellType: .defaultType),
       CellDataInfo(leftText: "业务员", holdText: "请输入业务员工号", content: "", cellType: .clearType)
    ]
    
    
   private var workCellData:[CellDataInfo] = [
         CellDataInfo(leftText: "单位名称", holdText: "请输入单位名称", content: "", cellType: .clearType),
         CellDataInfo(leftText: "单位性质", holdText: "请选择单位性质", content: "", cellType: .arrowType),
         CellDataInfo(leftText: "单位电话", holdText: "请填写单位电话", content: "", cellType: .clearType),
         CellDataInfo(leftText: "单位地址", holdText: "请选择所属地区", content: "", cellType: .arrowType),
         CellDataInfo(leftText: "", holdText: "详细街道地址", content: "", cellType: .clearType),
         CellDataInfo(leftText: "职位", holdText: "请填写当前职位", content: "",  cellType: .clearType),
         CellDataInfo(leftText: "工作年限", holdText: "请选择工作年限", content: "", cellType: .arrowType),
         CellDataInfo(leftText: "月收入", holdText: "请填写月收入", content: "", cellType: .textType)]
    
  private  var schoolCellData:[CellDataInfo] = [
         CellDataInfo(leftText: "学校地址", holdText: "请选择所属地区", content: "", cellType: .arrowType),
         CellDataInfo(leftText: "", holdText: "详细街道地址", content: "", cellType: .clearType),
         CellDataInfo(leftText: "学校名称", holdText: "请选择学校名称", content: "", cellType: .arrowType),
         CellDataInfo(leftText: "学历", holdText: "请选择学历", content: "", cellType: .arrowType),
         CellDataInfo(leftText: "年级", holdText: "请选择年级", content: "", cellType: .arrowType),
         CellDataInfo(leftText: "专业", holdText: "请填写专业", content: "", cellType: .clearType),
         CellDataInfo(leftText: "学制", holdText: "请选择学制", content: "", cellType: .arrowType)]
    
  private  var incomeCellData:[CellDataInfo] = [
         CellDataInfo(leftText: "每月收入", holdText: "请填写每月收入", content: "", cellType: .textType),
         CellDataInfo(leftText: "收入来源", holdText: "请填写收入来源", content: "", cellType: .clearType),
         CellDataInfo(leftText: "结算方式", holdText: "请选择结算方式", content: "", cellType: .arrowType)]
   
   private var contactCellData:[CellDataInfo] = [
          CellDataInfo(leftText: "家庭地址", holdText: "请选择所属地区", content: "", cellType: .arrowType),
          CellDataInfo(leftText: "", holdText: "详细街道地址", content: "", cellType: .clearType),
          CellDataInfo(leftText: "常住地址", holdText: "请选择所属地区", content: "", cellType: .arrowType),
          CellDataInfo(leftText: "", holdText: "详细街道地址", content: "", cellType: .clearType),
          CellDataInfo(leftText: "住房情况", holdText: "请选择住房情况", content: "", cellType: .arrowType),
          CellDataInfo(leftText: "居住时间", holdText: "请选择居住时间", content: "", cellType: .arrowType),
          CellDataInfo(leftText: "婚姻状况", holdText: "请选择婚姻状况", content: "", cellType: .arrowType),
          CellDataInfo(leftText: "直系亲属", holdText: "请选择直系亲属关系", content: "", cellType: .arrowType),
          CellDataInfo(leftText: "", holdText: "联系人姓名，可从通讯录中选择", content: "", cellType: .arrowType),
          CellDataInfo(leftText: "", holdText: "请填写手机号", content: "", cellType: .clearType),
          CellDataInfo(leftText: "", holdText: "", content: "", cellType: .defaultType),
          CellDataInfo(leftText: "紧急联系人", holdText: "可从通讯录中选择", content: "", cellType: .arrowType),
          CellDataInfo(leftText: "", holdText: "填写姓名", content: "", cellType: .clearType),
          CellDataInfo(leftText: "", holdText: "填写手机号码", content: "", cellType: .clearType)]
    
    //MARK:Data上传
   private var dataReuploadCellData:[CellDataInfo] = [
         CellDataInfo(leftText: "房产证", holdText: "上传您所拥有的房产证照片", content: "", cellType: .cameraType),
         CellDataInfo(leftText: "行驶证", holdText: "上传您的汽车行驶证照片", content: "", cellType: .cameraType),
         CellDataInfo(leftText: "收入流水", holdText: "上传银行卡6个月收入流水", content: "", cellType: .cameraType),
         CellDataInfo(leftText: "其他材料", holdText: "选填", content: "", cellType: .cameraType)]

 
   private var workerAllCellData:[CellDataInfo] = [
         CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
         CellDataInfo(leftText: "亲签照", holdText: "上传手持身份证照片", content: "", cellType: .cameraType),
         CellDataInfo(leftText: "征信报告", holdText: "上传人民银行征信报告", content:   "", cellType: .cameraType),
         CellDataInfo(leftText: "收入流水", holdText: "上传银行卡6个月收入流水", content: "", cellType: .cameraType),
         CellDataInfo(leftText: "居住证明", holdText: "上传居住证明文件照片", content: "", cellType: .cameraType),
         CellDataInfo(leftText: "社保", holdText: "社保公积金缴纳信息（选填）", content: "", cellType: .cameraType),
         CellDataInfo(leftText: "财力证明", holdText: "上传可证明财力的文件（选填）", content: "", cellType: .cameraType)]
    
   private var worker30000CellData = [
        CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "亲签照", holdText: "上传手持身份证照片", content: "", cellType: .cameraType), CellDataInfo(leftText: "社保", holdText: "社保公积金缴纳信息（选填）", content: "", cellType: .cameraType)]
    
   private var worker50000CellData = [
        CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "亲签照", holdText: "上传手持身份证照片", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "收入流水", holdText: "上传银行卡6个月收入流水", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "居住证明", holdText: "上传居住证明文件照片", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "社保", holdText: "社保公积金缴纳信息（选填）", content: "", cellType: .cameraType)]
    
    
   private var studentAllCellData:[CellDataInfo] = [
        CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "亲签照", holdText: "上传手持身份证照片", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "在读证明", holdText: "上传学信网个人信息或校园卡", content: "", cellType: .cameraType)]
    
    private var freedomAllCellData:[CellDataInfo] = [
        CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "亲签照", holdText: "上传手持身份证照片", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "征信报告", holdText: "上传人民银行征信报告", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "收入流水", holdText: "上传银行卡6个月收入流水", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "居住证明", holdText: "上传居住证明文件照片", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "社保", holdText: "社保公积金缴纳信息（选填）", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "财力证明", holdText: "上传可证明财力的文件（选填）", content: "", cellType: .cameraType)]
    
    private var freedom10000CellData = [
        CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "亲签照", holdText: "上传手持身份证照片", content: "", cellType: .cameraType)]
    
    private var freedom30000CellData = [
        CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "亲签照", holdText: "上传手持身份证照片", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "收入流水", holdText: "上传银行卡6个月收入流水", content: "", cellType: .cameraType)]
    
    private var freedom50000CellData = [
        CellDataInfo(leftText: "身份证", holdText: "上传身份证正反面", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "亲签照", holdText: "上传手持身份证照片", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "收入流水", holdText: "上传银行卡6个月收入流水", content: "", cellType: .cameraType),
        CellDataInfo(leftText: "居住证明", holdText: "上传居住证明文件照片", content: "", cellType: .cameraType)]
    
    
    //MARK: init
    init(dataType: CellModelType) {
        switch dataType {
        case .product:
            cellData = productCellData
        case .work:
            cellData = workCellData
        case .school:
            cellData = schoolCellData
        case .income:
            cellData = incomeCellData
        case .contact:
            cellData = contactCellData
        case .dataReupload:
            cellData = dataReuploadCellData
        case .dataWorker30000:
            cellData = worker30000CellData
        case .dataWorker50000:
            cellData = worker50000CellData
        case .dataWorkerAll:
            cellData = workerAllCellData
        case .dataStudentAll:
            cellData = studentAllCellData
        case .dataFreedom10000:
            cellData = freedom10000CellData
        case .dataFreedom30000:
            cellData = freedom30000CellData
        case .dataFreedom50000:
            cellData = freedom50000CellData
        case .dataFreedomAll:
            cellData = freedomAllCellData
        }
    }
}
