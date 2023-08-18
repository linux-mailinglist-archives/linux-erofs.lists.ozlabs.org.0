Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8327278068A
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 09:48:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RRvBH6dPPz3cFX
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Aug 2023 17:48:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RRvBD3jn4z2ytK
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Aug 2023 17:48:18 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vq1nWfF_1692344889;
Received: from 30.221.131.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vq1nWfF_1692344889)
          by smtp.aliyun-inc.com;
          Fri, 18 Aug 2023 15:48:10 +0800
Message-ID: <671a514f-8597-7693-1323-929e39c56dda@linux.alibaba.com>
Date: Fri, 18 Aug 2023 15:48:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 6/8] erofs: get rid of fe->backmost for cache
 decompression
To: Yue Hu <zbestahu@gmail.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-6-hsiangkao@linux.alibaba.com>
 <20230818135156.00005a05.zbestahu@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230818135156.00005a05.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/8/18 13:51, Yue Hu wrote:
> On Thu, 17 Aug 2023 16:28:11 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> EROFS_MAP_FULL_MAPPED is more accurate to decide if caching the last
>> incomplete pcluster for later read or not.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/zdata.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 4009283944ca..c28945532a02 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -528,8 +528,6 @@ struct z_erofs_decompress_frontend {
>>   	z_erofs_next_pcluster_t owned_head;
>>   	enum z_erofs_pclustermode mode;
>>   
>> -	/* used for applying cache strategy on the fly */
>> -	bool backmost;
>>   	erofs_off_t headoffset;
>>   
>>   	/* a pointer used to pick up inplace I/O pages */
>> @@ -538,7 +536,7 @@ struct z_erofs_decompress_frontend {
>>   
>>   #define DECOMPRESS_FRONTEND_INIT(__i) { \
>>   	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
>> -	.mode = Z_EROFS_PCLUSTER_FOLLOWED, .backmost = true }
>> +	.mode = Z_EROFS_PCLUSTER_FOLLOWED }
>>   
>>   static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
>>   {
>> @@ -547,7 +545,7 @@ static bool z_erofs_should_alloc_cache(struct z_erofs_decompress_frontend *fe)
>>   	if (cachestrategy <= EROFS_ZIP_CACHE_DISABLED)
>>   		return false;
>>   
>> -	if (fe->backmost)
>> +	if (!(fe->map.m_flags & EROFS_MAP_FULL_MAPPED))
> 
> So, i understand (map.m_flags & EROFS_MAP_FULL_MAPPED) should be false if allocate cache is needed
> (fe->backmost is true)?

fe->backmost is inaccurate compared with !EROFS_MAP_FULL_MAPPED,
if !EROFS_MAP_FULL_MAPPED, it should be cached instead.

Thanks,
Gao Xiang
