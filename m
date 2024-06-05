Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5348FC274
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 05:52:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hqKBHwPG;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvD7B3q6cz30WX
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jun 2024 13:52:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hqKBHwPG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvD6z5qdlz3bNs
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jun 2024 13:52:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717559528; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=aKh6tcs1VR+5wsa2AsuwIEaTmxuzZ4Zy7RwNJRVDVmI=;
	b=hqKBHwPGa9RsXFTI2hzcWIWvrNw03+UmGixt9cxN0UnAReQw/MQ747PGk45lqVbpkiBnA4iXZmXgVFrL7U3XdAK2V1a8E2nVW1n53mqIlEmEYuei6rOT/187bZk16iOd5gVjJwWTumCcjPvCVMLx5WvWo75CEIln5uxDks3CozA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W7shQXM_1717559525;
Received: from 30.97.48.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7shQXM_1717559525)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 11:52:06 +0800
Message-ID: <c8131de3-cb45-4f56-bede-6a93d1a2c9da@linux.alibaba.com>
Date: Wed, 5 Jun 2024 11:52:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs-utils: introduce the I/O manager
To: Hongzhen Luo <hongzhen@linux.alibaba.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20240604121029.4030290-1-hongzhen@linux.alibaba.com>
 <66602c0c-975b-4dd2-8244-576cada26102@linux.alibaba.com>
 <d262ede7-b046-40ba-aeae-cb3f83486504@linux.alibaba.com>
In-Reply-To: <d262ede7-b046-40ba-aeae-cb3f83486504@linux.alibaba.com>
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

(+ Cc linux-erofs)

On 2024/6/5 11:32, Hongzhen Luo wrote:
> 
> 在 2024/6/5 10:55, Gao Xiang 写道:
>>
>>
>> On 2024/6/4 20:10, Hongzhen Luo wrote:
>>> Introduce the I/O manager to provide a more flexible way to specify
>>> the virtual storage.
>>>
>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>> ---
>>> v2: Updated the handling of `.dev_close` being unimplemented in `erofs_dev_close` and so on.
>>> v1: https://lore.kernel.org/all/20240604093556.3883585-1-hongzhen@linux.alibaba.com/
>>
>> I'm unable to apply this patch.
>>
> Sorry about that, I overlooked developing based on the latest branch. I will send a v3 soon.
>>> ---
>>
>> ...
>>
>>>   +struct erofs_io_manager {
>>> +    int (*dev_open)(struct erofs_sb_info *sbi, const char *devname);
>>
>>     int (*open)(...);
>>
>>> +    int (*dev_open_ro)(struct erofs_sb_info *sbi, const char *dev);
>>
>>     int (*open_ro)(...);
>>
>>> +    int (*blob_open_ro)(struct erofs_sb_info *sbi, const char *dev);
>>
>>
>>     int (*blob_open_ro)(...);
>>
>>> +    int (*dev_read)(struct erofs_sb_info *sbi, int device_id,
>>> +        void *buf, u64 offset, size_t len);
>>
>>     int (*read)(...);
>>
>>> +    int (*dev_write)(struct erofs_sb_info *sbi, const void *buf,
>>> +        u64 offset, size_t len);
>>
>>     int (*write)(...);
>>
>>> +    int (*dev_fillzero)(struct erofs_sb_info *sbi, u64 offset,
>>> +        size_t len, bool padding);
>>     int (*fillzero)(...);
>>
>>> +    int (*dev_fsync)(struct erofs_sb_info *sbi);
>>
>>     int (*fsync)(...);
>>
>>> +    int (*dev_resize)(struct erofs_sb_info *sbi, erofs_blk_t nblocks);
>>
>>     int (*resize)(...);
>>
>>> +    void (*dev_close)(struct erofs_sb_info *sbi);
>>
>>     int (*close)(...);
>>
>>> +    void (*blob_closeall)(struct erofs_sb_info *sbi);
>>
>>     int (*blob_closeall)(...);
>>
>>> +    void *private_data;
>>
>> What does this mean?
>>
> Interface implementers can use it to store the data they wish to save. For example, in C++, this pointer can be used to store an object pointer, thereby accessing the data associated with the object.
> 
> Another option is to remove this pointer and let the implementer wrap the I/O manager into another object. Which strategy to adopt needs to be discussed.

I don't see how private_data is used in this patch and it's
unrelated to C++.  If it's unused, please remove it entirely.

Thanks,
Gao Xiang
