Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610EC6C825
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 05:50:14 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45q0X34jZNzDqCM
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 13:50:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45q0RW6Xt8zDqD9
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 13:46:15 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4C00333852C3A0D98229;
 Thu, 18 Jul 2019 11:46:10 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 11:46:04 +0800
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8muWbnuWkje+8muWbnuWkje+8mmVyb3PmgKfog70=?=
 =?UTF-8?B?6Zeu6aKY?=
To: ZHOU <353779207@qq.com>
References: <tencent_43D5609D92443B9ED755C87B7843FA71D705@qq.com>
 <d3efd7a5-c781-6163-d04a-c2e6382ea760@huawei.com>
 <c85d590a-2eed-2501-b144-33a95fc0bec2@huawei.com>
 <tencent_4AE55DADBCB537681FA35D97D66948F2E209@qq.com>
 <5050b57d-bf2d-9615-fb2c-9f3edfbd84d5@huawei.com>
 <tencent_EE6B36FC1F655D8BD645489CE3A15DB1BC09@qq.com>
 <4c80715b-8f99-86be-a8b3-532b65152e1a@huawei.com>
 <tencent_5C79776DF03DE2BACEAFEB9154C623BBDE0A@qq.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <7c6cad42-fb76-f1c2-aa92-d69804ab043e@huawei.com>
Date: Thu, 18 Jul 2019 11:45:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <tencent_5C79776DF03DE2BACEAFEB9154C623BBDE0A@qq.com>
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



On 2019/7/18 11:39, ZHOU wrote:
> 好的，该config CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR 已经启用了的。
> 测试时选用同一台设备，分区一致，使用loop方式erofs跟ext4差不多，我再仔细检查一下LBA。

loop方式意义不大，不知道iozone你怎么改的，也不知道你们的内核是否对ext4有改动，
我觉得你可以先拿标准的fio测一下，不需要做任何修改，mkfs有必要也建议使用原始代码，通过新增分区做测试。

> 
> 谢谢给出的建议
> 
> B.R
> 
> 
> 
> 
> 
> ------------------ 原始邮件 ------------------
> *发件人:* Gao Xiang <gaoxiang25@huawei.com>
> *发送时间:* 2019年7月18日 11:28
> *收件人:* ZHOU <353779207@qq.com>
> *抄送:* Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
> *主题:* 回复：回复：回复：eros性能问题
> 
> 
> 
> On 2019/7/18 11:24, ZHOU wrote:
>> 是的 看代码流程erofs更简洁 不应该出现性能恶化的问题 另外在做xattr时，我没有启用share的方式，这在android上应该不会影响到性能吧，因为在读security属性后会缓存到kernel中
> 
> 没有，我觉得你们先排查下自己测试的情况（比如是否跟android内核的调度因素有关），你们可以加log排查，
> 另外建议测试使用相同的LBA区域并且避免测试前写入其他热数据（最好是flash到相同的LBA后直接测试），
> 随机读不压缩不应该是你说的情况。压缩的数据config需要开启CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR
> 
>>
>> B.R
>>
>>
>> ------------------ 原始邮件 ------------------
>> *发件人:* Gao Xiang <gaoxiang25@huawei.com>
>> *发送时间:* 2019年7月18日 11:19
>> *收件人:* ZHOU <353779207@qq.com>
>> *抄送:* Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
>> *主题:* 回复：回复：eros性能问题
>>
>>
>>
>> On 2019/7/18 11:15, ZHOU wrote:
>>> Dear xiang,
>>> 没有启用directIO,
>>> 好的,我尝试一下您提供的测试方法。
>>
>> 至少对于不压缩的情况，难以理解随机读有差异。
>>
>> 谢谢。
>>
>>>
>>> 非常感谢
>>>
>>>
>>> ------------------ 原始邮件 ------------------
>>> *发件人:* Gao Xiang <gaoxiang25@huawei.com>
>>> *发送时间:* 2019年7月18日 11:10
>>> *收件人:* ZHOU <353779207@qq.com>
>>> *抄送:* Miao Xie <miaoxie@huawei.com>, linux-erofs <linux-erofs@lists.ozlabs.org>
>>> *主题:* 回复：eros性能问题
>>>
>>>
>>>
>>> On 2019/7/18 10:54, Gao Xiang wrote:
>>>>> 放入erofs中，测试命令为：./iozone -i 2 -s 300m -r 4k -+E -w -f ./vendor/tmp_file
>>>> 我不清楚这个代表什么意思，是否有对应的fio的命令。
>>>>
>>>
>>> 另外，我们建议的随机读pattern（也是我们测试关注的）是
>>> echo 3 > /proc/sys/vm/drop_caches
>>> ./fio --readonly -rw=randread -size=100% -bs=4k -name=job1
>>>
>>> 因为绝大多数应用没有direct I/O请求，没有direct I/O读路径，短期没有direct I/O支持计划，
>>> 也不建议使用direct I/O测试性能。
