package com.perssoft.framework.config;



import com.alibaba.druid.filter.stat.StatFilter;
import com.alibaba.druid.wall.WallFilter;
import com.perssoft.config.Constants;
import com.perssoft.config.Handlers;
import com.perssoft.config.Interceptors;
import com.perssoft.config.PerssoftConfig;
import com.perssoft.config.Plugins;
import com.perssoft.config.Routes;
import com.perssoft.framework.GlobalInterceptor;
import com.perssoft.framework.URLHandler;
import com.perssoft.manager.controller.BuyContractController;
import com.perssoft.manager.controller.BuyInvoiceController;
import com.perssoft.manager.controller.BuyPayApplyController;
import com.perssoft.manager.controller.ChangePlaceController;
import com.perssoft.manager.controller.CostController;
import com.perssoft.manager.controller.CustomerController;
import com.perssoft.manager.controller.DomPositionController;
import com.perssoft.manager.controller.MaterialController;
import com.perssoft.manager.controller.MoneytypeController;
import com.perssoft.manager.controller.OutController;
import com.perssoft.manager.controller.PaytypeController;
import com.perssoft.manager.controller.ProductController;
import com.perssoft.manager.controller.ProviderController;
import com.perssoft.manager.controller.ReceiptController;
import com.perssoft.manager.controller.SampleController;
import com.perssoft.manager.controller.SellContractController;
import com.perssoft.manager.controller.SellInvoiceController;
import com.perssoft.manager.controller.SellPayController;
import com.perssoft.manager.controller.SendController;
import com.perssoft.manager.controller.StorageController;
import com.perssoft.manager.controller.UploadController;
import com.perssoft.manager.controller.WorkerController;
import com.perssoft.manager.model.BuyContract;
import com.perssoft.manager.model.BuyInvoice;
import com.perssoft.manager.model.BuyPayApply;
import com.perssoft.manager.model.ChangePlace;
import com.perssoft.manager.model.Cost;
import com.perssoft.manager.model.Customer;
import com.perssoft.manager.model.DomPosition;
import com.perssoft.manager.model.Material;
import com.perssoft.manager.model.Moneytype;
import com.perssoft.manager.model.Out;
import com.perssoft.manager.model.Paytype;
import com.perssoft.manager.model.Product;
import com.perssoft.manager.model.Provider;
import com.perssoft.manager.model.Receipt;
import com.perssoft.manager.model.Sample;
import com.perssoft.manager.model.SellContract;
import com.perssoft.manager.model.SellInvoice;
import com.perssoft.manager.model.SellPay;
import com.perssoft.manager.model.Send;
import com.perssoft.manager.model.Storage;
import com.perssoft.manager.model.Worker;
import com.perssoft.plugin.activerecord.ActiveRecordPlugin;
import com.perssoft.plugin.druid.DruidPlugin;
import com.perssoft.plugin.druid.DruidStatViewHandler;
import com.perssoft.render.ViewType;
import com.perssoft.system.controller.AdminController;
import com.perssoft.system.controller.DictionaryController;
import com.perssoft.system.controller.LoginController;
import com.perssoft.system.controller.ResourceController;
import com.perssoft.system.controller.RoleController;
import com.perssoft.system.model.Admin;
import com.perssoft.system.model.Dictionary;
import com.perssoft.system.model.Resource;
import com.perssoft.system.model.Role;

/**
 * API引导式配置
 */
public class WebConfig extends PerssoftConfig {
	
	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {
		loadPropertyFile("config/jdbc.properties");				// 加载少量必要配置，随后可用getProperty(...)获取值
		me.setDevMode(getPropertyToBoolean("devMode", false));
		me.setViewType(ViewType.JSP);	
		me.setMaxPostSize(1000 * 1024 * 1024);
		// 设置视图类型为Jsp，否则默认为FreeMarker
		System.out.println("read 测试 properties ok!");
	}
	
	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		me.add("/", LoginController.class);
		me.add("/system/admin", AdminController.class);
		me.add("/system/role", RoleController.class);
		me.add("/system/dictionary", DictionaryController.class);
		me.add("/system/resource", ResourceController.class);
		me.add("/manager/worker", WorkerController.class);
		me.add("/manager/sellcontract", SellContractController.class);
		me.add("/manager/sellinvoice", SellInvoiceController.class);
		me.add("/manager/sellpay", SellPayController.class);
		me.add("/manager/buycontract", BuyContractController.class);
		me.add("/manager/changeplace", ChangePlaceController.class);
		me.add("/manager/buyinvoice", BuyInvoiceController.class);
		me.add("/manager/buypayapply", BuyPayApplyController.class);
		me.add("/manager/receipt", ReceiptController.class);
		me.add("/manager/send", SendController.class);
		me.add("/manager/storage", StorageController.class);
		me.add("/manager/out", OutController.class);
		me.add("/manager/sample", SampleController.class);
		me.add("/manager/cost", CostController.class);
		me.add("/manager/customer", CustomerController.class);
		me.add("/manager/provider", ProviderController.class);
		me.add("/manager/product", ProductController.class);
		me.add("/manager/material", MaterialController.class);
		me.add("/manager/moneytype",MoneytypeController.class);
		me.add("/manager/paytype",PaytypeController.class);
		me.add("/manager/upload",UploadController.class);//文件上传
		
		me.add("/manager/position",DomPositionController.class);//节点位置
		
		
	}
	
	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// 配置C3p0数据库连接池插件
//		C3p0Plugin c3p0Plugin = new C3p0Plugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password").trim());
//		me.add(c3p0Plugin);
//		
		
		 DruidPlugin dp = new DruidPlugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password").trim());
		  dp.addFilter(new StatFilter());
		  dp.setMaxActive(500);
		  dp.setInitialSize(20);
		  WallFilter wall = new WallFilter();
		  wall.setDbType("mysql");
		  dp.addFilter(wall);
		  me.add(dp);
		
		// 配置ActiveRecord插件
		ActiveRecordPlugin arp = new ActiveRecordPlugin(dp);
		arp.setShowSql(true);
		arp.addMapping("xt_admin", Admin.class);	// 映射blog 表到 Blog模型
		arp.addMapping("xt_role", Role.class);	 
		arp.addMapping("xt_resource", Resource.class);	 
		arp.addMapping("xt_dictionary", Dictionary.class);	
		arp.addMapping("yw_worker", Worker.class);
		arp.addMapping("sellcontract", SellContract.class);//销售合同
		arp.addMapping("sellinvoice", SellInvoice.class);//销售发票
		arp.addMapping("sellpay", SellPay.class);//货款会收
		arp.addMapping("buycontract", BuyContract.class);//采购合同
		arp.addMapping("changeplace", ChangePlace.class);//坯布流转
		arp.addMapping("buyinvoice", BuyInvoice.class);//采购发票
		arp.addMapping("buypayapply", BuyPayApply.class);//付款申请
		arp.addMapping("receipt", Receipt.class);//收料单
		arp.addMapping("send", Send.class);//发料单
		arp.addMapping("storage", Storage.class);//入库单
		arp.addMapping("outroom", Out.class);//出库单
		arp.addMapping("samples", Sample.class);//样品发送
		arp.addMapping("costs", Cost.class);//成本
		arp.addMapping("customer", Customer.class);//客户
		arp.addMapping("provider", Provider.class);//供应商
		arp.addMapping("product", Product.class);//产品
		arp.addMapping("material", Material.class);//物资材料
		arp.addMapping("moneytype", Moneytype.class);//外币种类
		arp.addMapping("paytype", Paytype.class);//付款方式
		
		arp.addMapping("domposition", DomPosition.class);
		
		me.add(arp);
	}
	
	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		me.add(new GlobalInterceptor());
	}
	
	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		 me.add(new URLHandler()); 
		 
	    DruidStatViewHandler dvh =  new DruidStatViewHandler("/druid");
		me.add(dvh);
	}
	

}
