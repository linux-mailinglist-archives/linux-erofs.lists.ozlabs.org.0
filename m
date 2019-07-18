Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EEC6C701
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 05:22:11 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pzvg1QzGzDqGX
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 13:22:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pzrz1bJLzDqJ8
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 13:19:46 +1000 (AEST)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A88C5C767F34CFCE5A69;
 Thu, 18 Jul 2019 11:19:42 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 11:19:35 +0800
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mmVyb3PmgKfog73pl67popg=?=
To: ZHOU <353779207@qq.com>
References: <tencent_43D5609D92443B9ED755C87B7843FA71D705@qq.com>
 <d3efd7a5-c781-6163-d04a-c2e6382ea760@huawei.com>
 <c85d590a-2eed-2501-b144-33a95fc0bec2@huawei.com>
 <tencent_4AE55DADBCB537681FA35D97D66948F2E209@qq.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <5050b57d-bf2d-9615-fb2c-9f3edfbd84d5@huawei.com>
Date: Thu, 18 Jul 2019 11:19:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <tencent_4AE55DADBCB537681FA35D97D66948F2E209@qq.com>
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
Cc: linux-erofs <linux-erofs@lists.ozlabs.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/18 11:15, ZHOU wrote:
> Dear xiang,
> 没有启用directIO,
> 好的,我尝试一下您提供的测试方法。

至少对于不压缩的情况，难以理解随机读有差异。

谢谢。

> 
> 非常感谢
> 
> 
> ------------------ 原始邮件 ------------------
> *发件人:* Gao Xiang <gaoxiang25@huawei.com>
> *发送时间:* 2019年7月18日 11:10
> *收件人:* ZHOU <353779207@qq.com>
> *抄送:* Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
> *主题:* 回复：eros性能问题
> 
> 
> 
> On 2019/7/18 10:54, Gao Xiang wrote:
>>> 放入erofs中，测试命令为：./iozone -i 2 -s 300m -r 4k -+E -w -f ./vendor/tmp_file
>> 我不清楚这个代表什么意思，是否有对应的fio的命令。
>>
> 
> 另外，我们建议的随机读pattern（也是我们测试关注的）是
> echo 3 > /proc/sys/vm/drop_caches
> ./fio --readonly -rw=randread -size=100% -bs=4k -name=job1
> 
> 因为绝大多数应用没有direct I/O请求，没有direct I/O读路径，短期没有direct I/O支持计划，
> 也不建议使用direct I/O测试性能。
