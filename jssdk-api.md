# 蓝牙API

## LL.ble.isEnable

> 蓝牙是否可用

``` javascript
LL.ble.isEnable(cb);
```

``` javascript
// cb
function(result){
    if (result.isEnabled == true) {
        // 蓝牙可用
    }else{
		// 蓝牙不可用
    }
}
```
蓝牙打开关闭等事件会通过bleStateDidChangedNotify消息下发

---

## LL.ble.isConnect

> 是否已连接

``` javascript
LL.ble.isConnect(params, cb);
```

``` javascript
// params
{
 	deviceId: ""
}

// cb
function(result){
  	if (result.isconnect == true) {
  		// 设备已连接
  	}else{
  		// 设备未连接
	}
}
```

---
## LL.ble.deviceId

> 获取当前连接设备的deviceId

``` javascript
LL.ble.getDeviceId(cb);
```

``` javascript
// cb
function(result){
 	// result.deviceId
}
```
---
## LL.ble.connect

> 连接设备

``` javascript
LL.ble.connect(params,cb);
```

``` javascript
// params
{
 	deviceId: ""
}

// cb
function(result){
   	if (result.status == "success") {
   		// 连接成功
   	}else{
   		// 连接失败
  	}
}
```
---
## LL.ble.disconnect

> 断开连接

``` javascript
LL.ble.disconnect(params,cb);
```

``` javascript
// params
{
 	deviceId: ""
}

// cb
function(result){
   	if (result.status == "success") {
   		// 断开连接成功
   	}else{
   		// 断开连接失败
  	}
}
```

---

## LL.ble.subscribe

> 订阅设备的信息

``` javascript
LL.ble.subscribe(params, cb);
```

``` javascript
// params
{
    deviceId: ""
}

// cb
function(result){
   	if (result.status == "success") {
   		// 订阅成功
   	}else{
   		// 订阅失败
  	}
}
```

订阅成功后通过bleSubscribeNotify事件下发消息

---

## LL.ble.unsubscribe

> 取消订阅

``` javascript
LL.ble.unsubscribe(params, cb);
```

``` javascript
// params
{
 	deviceId: ""
}

// cb
function(result){
   	if (result.status == "success") {
   		// 取消订阅成功
   	}else{
   		// 取消订阅失败
  	}
}
```

---

## LL.ble.write

> 写入设备数据

``` javascript
LL.ble.write(params, cb);
```

``` javascript
// params
{
 	deviceId:"",
 	data:{字节数组}
}

// cb
function(result){
   	if (result.status == "success") {
   		// 写数据成功
   	}else{
   		// 写数据失败
  	}
}
```

---

# 蓝牙消息推送

> 在开发蓝牙设备面板时， 除了会使用到设备api以外还需要根据需要监听蓝牙消息事件

## bleStateDidChangedNotify

> 蓝牙状态改变事件

``` javascript
document.addEventListener('bleStateDidChangedNotify',function(e){
    alert(e.params);
},false);
```
- 蓝牙状态发生改变的时候会发送一次该事件
_e.params
- Unknown: 未知
- Unsupported: 设备不支持
- PoweredOff: 关闭状态
- PoweredOn: 开启状态

``` javascript
{
    "state": "PoweredOn"
}
```

---
## bleSubscribeNotify

> 蓝牙订阅通知事件

``` javascript
document.addEventListener('bleSubscribeNotify',function(e){
    alert(e.params);
},false);
```

- LL.ble.subscribe 订阅方法在调用之后会在回调函数中获知订阅成功与否，之后需要监听bleSubscribeNotify事件获得订阅的数据

``` javascript
// e.params
{
   value: "BkY=",
   deviceId: ""
}
```
---

## deviceStateDidChangedNotify

> 设备连接状态发生改变事件

``` javascript
document.addEventListener('deviceStateDidChangedNotify',function(e){
   alert(e.params.state);
},false);
```

- 设备连接状态发生改变的时候调用

``` javascript
// e.params
{
   state: "connect"
}
```

---

# 设备对象(Peripheral)API

## LL.peripheral.getDeviceInfo

> 获取设备信息

``` javascript
LL.peripheral.getDeviceInfo(cb);
```

``` javascript
// cb
function(result){
    if (result.status == "success") {
        // 获取设备信息成功
        var deviceId = result.deviceId;
    }else{
		// 获取设备信息失败
    }
}
```

---

## LL.peripheral.getFirmwareInfo

> 获取固件信息

``` javascript
LL.peripheral.getFirmwareInfo(cb);
```

``` javascript
// cb
function(result){
    if (result.status == "success") {
        // 获取固件信息成功
    }else{
		// 获取固件信息失败
    }
}
```

---

## LL.peripheral.startUpgradeFirmware

> 升级固件

``` javascript
LL.peripheral.startUpgradeFirmware(cb);
```

``` javascript
// cb
function(result){
    if (result.status == "success") {
        // 升级固件成功
    }else{
		// 升级固件失败
    }
}
```
注：调用startUpgradeFirmware接口后，app会自动下载服务器上最新的固件并升级固件。所以在调用startUpgradeFirmware接口前，第三方开发者需要自行获取当前硬件版本号和服务器固件版本号进行对比。
调用startUpgradeFirmware接口和升级成功后设备都要转换模式，会先断开设备再自动连接，所以收到断开和连接的消息是正常的。

---

# 消息(IM)API

## LL.im.sendMessage

> 发送消息

``` javascript
LL.im.sendMessage(params,cb);
```

``` javascript
// params
{
    "deviceId": "", // 目标设备的deviceId
    "content":""    // 自定义消息内容，必须是Key-Value格式
}
// cb
function(result){
    if (result.status == "success") {
        // 发送成功
    }else{
		// 发送失败
    }
}
```

---

## receiveMessageNotify

> 收到消息

``` javascript
document.addEventListener('receiveMessageNotify',function(e){
   alert(e.params);
},false);
```

``` javascript
// e.params
{
    "deviceId": "", // 目标设备的deviceId
    "content":""    // 消息内容，Key-Value格式
}
```

---

## deviceOnlineNotify

> 收到设备上线通知

``` javascript
document.addEventListener('deviceOnlineNotify',function(e){
   alert(e.params);
},false);
```

``` javascript
// e.params
{
    "deviceId": "", // 上线设备的deviceId
}
```

---

## deviceOfflineNotify

> 收到设备下线通知

``` javascript
document.addEventListener('deviceOfflineNotify',function(e){
   alert(e.params);
},false);
```

``` javascript
// e.params
{
    "deviceId": "", // 下线设备的deviceId
}
```

---



# 数据处理

## LL.tool.stringToBytes

> 字符串转bytes

``` javascript
// params - string 字符串
var bytes = LL.tool.stringToBytes(string);
```

---
## LL.tool.bytesToString

> bytes转换成字符串

``` javascript
// params - bytes 字节数组
var string = LL.tool.bytesToString(bytes)
```

---

# 数据存储

## LL.nativeStorage.setStorage

> 将信息存储到本地

``` javascript
LL.tool.setStorage(params, cb);
```

``` javascript
// params - itemKey:支持多级存储和查找，每层key以:分隔
{
 	deviceId:"",
 	itemKey:"a:b:c",
 	itemValue:"json对象或者字符串"
}

// cb
function(result){
   	if (result.status == "success") {
   		// 成功
   	}else{
   		// 失败
  	}
}
```

---
## LL.nativeStorage.getStorage

> 从本地获取信息

``` javascript
LL.nativeStorage.getStorage(params, cb);
```

``` javascript
// params
{
 	deviceId:"",
 	itemKey:"a:b:c"
}

// cb - 在result里面，用传进去的itemKey取出value值
function(result){
   	if (result.status == "success") {
   		// 成功
 		var value = result[itemKey];
   	}else{
   		// 失败
  	}
}
```

---

## LL.nativeStorage.removeStorage

> 删除本地的信息

``` javascript
LL.nativeStorage.removeStorage(params, cb);
```

``` javascript
// params
{
 	deviceId:"",
 	itemKey:"a:b:c"
}

// cb
function(result){
   	if (result.status == "success") {
   		// 删除成功
   	}else{
   		// 删除失败
  	}
}
```

---

## LL.backupAppData

> 存储数据到服务器

``` javascript
LL.backupAppData(params, cb);
```

``` javascript
// params
{
 	deviceId:"",
 	dataKey:"",
 	dataValue:""
}

// cb
function(result){
   	if (result.status == "success") {
   		// 存储数据到服务器成功
   	}else{
   		// 存储数据到服务器失败
  	}
}
```

---

## LL.retrieveAppData

> 从服务器获取数据

``` javascript
LL.retrieveAppData(params, cb);
```

``` javascript
// params
{
 	deviceId:"",
 	dataKey:""
}

// cb
function(result){
   	if (result.status == "success") {
   		// 从服务器获取数据成功
   	}else{
   		// 从服务器获取数据失败
  	}
}
```

---

# GPS定位

## LL.getLocation

> 获取经纬度

``` javascript
LL.getLocation(params, cb);
```

``` javascript
// params - enableHighAcuracy：是否获取高精度位置
{
 	enableHighAcuracy:true
}

// cb
function(result){
   	if (result.status == "success") {
   		// 经纬度获取成功
   	}else{
   		// 经纬度获取失败
  	}
}
```
---

## LL.searchLocation

> 根据街道信息查询经纬度

``` javascript
LL.searchLocation(params, cb);
```

``` javascript
// params
{
 	"addrs" : "杭州市滨江区芯图大厦"
}

// cb
function(result){
   	if (result.status == "success") {
   		// 经纬度获取成功
   	}else{
   		// 经纬度获取失败
  	}
}
```

---

# 网络

## LL.hasNetWork

> 查询手机是否已联网

``` javascript
LL.hasNetWork(cb);
```

``` javascript
// cb
function(result){
   	if (result) {
   		// 有网络
   	}else{
   		// 无网络
  	}
}
```

---

# 页面跳转

## LL.popWebView

> 退出当前Webview

``` javascript
LL.popWebView();
```
