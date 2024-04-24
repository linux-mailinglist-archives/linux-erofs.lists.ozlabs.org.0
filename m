Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985068B04A6
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 10:45:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713948310;
	bh=VYO5JujBqFYVef45KN1r1Z6DoRGEiTAQ2ROrnpy89Ns=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RTO9tjnUyxlWEfEQkO0xNpw2r+fpSMgAu/FGvYksNrc6o1okTm84XtsvAsW2MUpSl
	 K8hNRoZcp5KAvsvwKe/CWTV/26TY1zxUwg76qvLJ1O8v0P5gwy6zo4FzYXOzdIcPjh
	 xp3fJjTqcVHwAt/VPMCbLql9yVZbSe8FXJ6Ooe6gFILRZa2RhrpWiHvGldB3utmLNR
	 hIEZ4sL38wVtJX7R+xd6iby9YBv7bAhqiYvAA2FIxm0YJ4eAwfUgyBI+7qH6VFbkPD
	 Jvx9JeIuID+cCrzbRb9b+eUUKmTKh6TdEce76diiwCz3F4QWZ62VG19U7RJMFzSDKW
	 NwSWTuvbsR0Aw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPXcQ1sHBz3cP7
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 18:45:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 139 seconds by postgrey-1.37 at boromir; Wed, 24 Apr 2024 18:45:02 AEST
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPXcG3Dq8z3cDk
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 18:45:02 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VPXWx2KVVzwSZg;
	Wed, 24 Apr 2024 16:41:17 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 041921800C2;
	Wed, 24 Apr 2024 16:44:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 16:44:27 +0800
Message-ID: <7ae4a071-56b3-410b-9c95-d6677dc46f25@huawei.com>
Date: Wed, 24 Apr 2024 16:44:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: modify the error message when
 prepare_ondemand_read failed
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>
References: <20240424023945.420828-1-lihongbo22@huawei.com>
 <871467f7-1218-4c13-ae47-13e89bbbe0cc@linux.alibaba.com>
In-Reply-To: <871467f7-1218-4c13-ae47-13e89bbbe0cc@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: huyue2@coolpad.com, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

ok, thanks!

On 2024/4/24 11:29, Gao Xiang wrote:
> 
> (+cc linux-erofs & LKML)
> 
> On 2024/4/24 10:39, Hongbo Li wrote:
>> When prepare_ondemand_read failed, wrong error message is printed.
>> The prepare_read is also implemented in cachefiles, so we amend it.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Could you resend the patch with proper mailing list cced with my
> "reviewed-by:" tag?  So I could apply with "b4" tool.
> 
> Thanks,
> Gao Xiang
> 
>> ---
>>   fs/erofs/fscache.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
>> index 8aff1a724805..62da538d91cb 100644
>> --- a/fs/erofs/fscache.c
>> +++ b/fs/erofs/fscache.c
>> @@ -151,7 +151,7 @@ static int erofs_fscache_read_io_async(struct 
>> fscache_cookie *cookie,
>>           if (WARN_ON(len == 0))
>>               source = NETFS_INVALID_READ;
>>           if (source != NETFS_READ_FROM_CACHE) {
>> -            erofs_err(NULL, "prepare_read failed (source %d)", source);
>> +            erofs_err(NULL, "prepare_ondemand_read failed (source 
>> %d)", source);
>>               return -EIO;
>>           }
