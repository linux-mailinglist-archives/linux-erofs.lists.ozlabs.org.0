Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE97976640
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 12:02:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4CfN5JBCz2yVj
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 20:02:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726135337;
	cv=none; b=KRd3PjHlx0kgtwqTnBuc9Bzb9hwA/7Rask3fot6bYMJFCGqA/MhAsH0p4OsOW6uhaxuKIKzwUK4rKn38GB/KfU++1rB9yfknsyV0cGcpjN1NI+hoOc/PNoW+hzn6BUOadxavnyGmFC7EGnFPivgy1/ELXHHNTOKPJjcN37LsNAP2yBPAeHbfzQrzE+RUWOWjkOMDZFKhQrdmpH+jOi5Q7hO1pvuM2nfZR2gpUMdR7JmNXsp6RROxNGJqvh0SiumQf4SJxRAOqLiqkD4l95hNzUpg3I8QBVvVEPAgLPhfIh1hbBipU3vovMCbwLLfJWmx13jWg5rSnLPF5c/6Dwkh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726135337; c=relaxed/relaxed;
	bh=5AnZoc4UT0BL6+x9G24CAUMGVo4zp8W/uWBsnaEcTG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=In47odfSqRumdA4mjBTRJR2WcJCXNY2xUeDxca49syORaZ3XgZz0u9IKw1mRMzTs/mG85e4Yy9hZjA4FF7CowtAQHkfMqRPzKdfemLSJyYQds2T1keOmGcoLVPRjYQ1kpqmyawv/+SeYh3wfTD66GU0KGe/uGWIVJMYoM57MThRXPzbIja1nSZNeW/P6eCXVLAAjVGs95VAkTrb1+wxbIVJbW/1iLnExVb7EXjXq3R8VOFb+xQSvc/69rzdhYsGSe8O5bGAKPcqOScUULvy9OA4WZj6tZ7di+423gNEuM+DD2X5SXff4atiLUO+Jfuy+XfNIWXJnCo6ZJCBuJH+EdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SU8HeC5j; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SU8HeC5j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4CfH73X8z2yGQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Sep 2024 20:02:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726135330; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5AnZoc4UT0BL6+x9G24CAUMGVo4zp8W/uWBsnaEcTG4=;
	b=SU8HeC5jF6+0LuCq9YDFiQKSGgEB/tGca9zI0J2NkhWgqq799IgES55dMt6GsN04kqWTAwdjCBuL+VD5FhDpKAuAAZJQjQF6BCBIHDu3Kmt++cS5km0hrrNPFJtuuxqaGV2T47kExkdDzzvFZ5Dvor06arOia1ZesVwaObGrdxg=
Received: from 30.221.133.52(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEr2EfA_1726135323)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 18:02:09 +0800
Message-ID: <d3a0ba29-7c88-42fe-a180-018e43e949b2@linux.alibaba.com>
Date: Thu, 12 Sep 2024 18:02:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] erofs-utils: lib: expose erofs_match_prefix()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240906095853.3167228-1-hongzhen@linux.alibaba.com>
 <1a8bf68a-8712-4428-9724-5c4fae46623f@linux.alibaba.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <1a8bf68a-8712-4428-9724-5c4fae46623f@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


On 2024/9/12 17:50, Gao Xiang wrote:
>
>
> On 2024/9/6 17:58, Hongzhen Luo wrote:
>> Prepare for the feature of exporting extended attributes for
>> `fsck.erofs`.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>> v2: Expose erofs_match_prefix() directly instead of introducing 
>> another helper function.
>> v1: 
>> https://lore.kernel.org/all/20240906083849.3090392-1-hongzhen@linux.alibaba.com/
>> ---
>>   include/erofs/xattr.h |  3 +++
>>   lib/xattr.c           | 11 ++++++-----
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
>> index 7643611..e89172e 100644
>> --- a/include/erofs/xattr.h
>> +++ b/include/erofs/xattr.h
>> @@ -61,6 +61,9 @@ void erofs_clear_opaque_xattr(struct erofs_inode 
>> *inode);
>>   int erofs_set_origin_xattr(struct erofs_inode *inode);
>>   int erofs_read_xattrs_from_disk(struct erofs_inode *inode);
>>   +bool erofs_match_prefix(const char *key, unsigned int *index,
>> +            unsigned int *len);
>
> better to add `xattr` in the function name too,
>
> erofs_xattr_prefix_matches?
>
Agree. I will send a new patch soon.

Thanks,

Hongzhen

> Thanks,
> Gao Xiang
