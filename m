Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F6C583E61
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Jul 2022 14:11:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LtqJM2QCqz2xJY
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Jul 2022 22:11:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jnhuang@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LtqJJ41Wcz2xHg
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Jul 2022 22:11:44 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jnhuang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VKfYr3M_1659010296;
Received: from 30.196.16.204(mailfrom:jnhuang@linux.alibaba.com fp:SMTPD_---0VKfYr3M_1659010296)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 20:11:36 +0800
Message-ID: <cde0a4da-4add-27dd-8222-4e288b03cd06@linux.alibaba.com>
Date: Thu, 28 Jul 2022 20:11:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH] erofs-utils: fuse: introduce xattr support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220715095359.37534-1-jnhuang@linux.alibaba.com>
 <YtaFqh7KEe/ku/b/@B-P7TQMD6M-0146.local>
From: Huang Jianan <jnhuang@linux.alibaba.com>
In-Reply-To: <YtaFqh7KEe/ku/b/@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



在 2022/7/19 18:21, Gao Xiang 写道:
> Hi Jianan,
> 
> On Fri, Jul 15, 2022 at 05:53:59PM +0800, Huang Jianan wrote:
>> This implements xattr functionalities for erofsfuse. A large amount
>> of code was adapted from Linux kernel.
>>
>> Signed-off-by: Huang Jianan <jnhuang@linux.alibaba.com>
>> ---
>>   fuse/main.c              |  32 +++
>>   include/erofs/internal.h |   8 +
>>   include/erofs/xattr.h    |  21 ++
>>   lib/xattr.c              | 508 +++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 569 insertions(+)
>>
>> diff --git a/fuse/main.c b/fuse/main.c
>> index f4c2476..30a0bed 100644
>> --- a/fuse/main.c
>> +++ b/fuse/main.c
>> @@ -139,7 +139,39 @@ static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
>>   	return 0;
>>   }
>>   
>> +static int erofsfuse_getxattr(const char *path, const char *name, char *value,
>> +			size_t size)
>> +{
>> +	int ret;
>> +	struct erofs_inode vi;
>> +
>> +	erofs_dbg("getxattr(%s): name=%s size=%llu", path, name, size);
>> +
>> +	ret = erofs_ilookup(path, &vi);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return erofs_getxattr(&vi, name, value, size);
>> +}
>> +
>> +static int erofsfuse_listxattr(const char *path, char *list, size_t size)
>> +{
>> +	int ret;
>> +	struct erofs_inode vi;
>> +	int i;
> 
> As we discussed offline, this line should be unneeded.
A new patch has been sent, in addition a test case has been added.

Thanks,
Jianan
> 
> Thanks,
> Gao Xiang
