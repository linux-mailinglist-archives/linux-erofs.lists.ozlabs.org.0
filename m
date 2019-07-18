Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD946C515
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 04:55:44 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pzKB0qjCzDqMp
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 12:55:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pzK64trVzDqLH
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 12:55:38 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7ECA542EA92E0ADA71C6;
 Thu, 18 Jul 2019 10:55:32 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 10:55:25 +0800
Subject: =?UTF-8?B?UmU6IGVyb3PmgKfog73pl67popg=?=
To: ZHOU <353779207@qq.com>
References: <tencent_43D5609D92443B9ED755C87B7843FA71D705@qq.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <d3efd7a5-c781-6163-d04a-c2e6382ea760@huawei.com>
Date: Thu, 18 Jul 2019 10:54:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <tencent_43D5609D92443B9ED755C87B7843FA71D705@qq.com>
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/18 10:47, ZHOU wrote:
> Dear sir or madam,
> 
>  
> 
> 很感谢华为和贵团队将erofs开源出来，非常感谢您们的付出和贡献。
> 
>  
> 
> 今年有幸看到erofs代码，并选择了一个android p平台（qcom sdm429， kernel 4.9,  emmc5.1）作为移植。
> 
> 选择移植的源kernel版本是4.19，目标版本4.9；mkfs选择分支mkfs-dev。
> 
> 移植过程中添加了xattr和capability等属性，现在已经可以在设备上完美运行。
> 
>  
> 
> 性能测试：
> 
> 测试工具选用iozone，修改iozone将其写数据部分屏蔽，读数据不校验，然后创建一个随机数据测试文件，
> 
> 放入erofs中，测试命令为：./iozone -i 2 -s 300m -r 4k -+E -w -f ./vendor/tmp_file

我不清楚这个代表什么意思，是否有对应的fio的命令。

> 
> 最终随机读性能上，不管是压缩还是不压缩都较ext4，存在较大差异：
> 
> vendor分区测试：
> 
> ext4                                      26113
> 
> erofs no compress               20970

无法理解不压缩的差异，你们是否使用了direct I/O，erofs不支持direct I/O。

谢谢。

> 
> erofs cp 4 ratio                    21485
> 
> erofs cp 100 ratio                19949
> 
> f2fs（userdata）                 32766
> 
>  
> 
> loop测试（镜像文件直接放入userdata，mount到tmp目录）：
> 
> ext4                        29561   30318  29531
> 
> erofs cp 20 ratio     30525   30630  30037
> 
>  
> 
> 在顺序读上面，erofs与ext4没有明显差异。
> 
>  
> 
> 目前，遇到的问题是性能上与ext4在随机读上面还存在差距，请问应该从哪方面去优化?
> 
>  
> 
> 非常感谢！
> 
>  
> 
> -- 
> 
> Thanks & Regards,
> 
> hengguo.zhou 周恒国
> 
