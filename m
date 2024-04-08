Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4850A89BE17
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Apr 2024 13:24:49 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=guPYQQty;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VCmvz0c9Vz3dTp
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Apr 2024 21:24:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=guPYQQty;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VCmvt63Tqz3cNt
	for <linux-erofs@lists.ozlabs.org>; Mon,  8 Apr 2024 21:24:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712575478; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v3ww6e+Gu+K8KI5rgL5jchFh2dlP3V1LeKZY1mhuX1k=;
	b=guPYQQty6EAk2F5q87bJ1KQhtCaLXFQQt35dBMAnS6vsxV46wn51vCgRieateEFJZLri19T6sfs/b6JoUZoAhVjkVP5Jgy5p/5Pl58b3kuWDciaLMzwXXzAqTQqIwhOc5a9csWqATnyigzhzte3e/4JmxXTrSM8Dv07rEpm8hhQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W488pZW_1712575476;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W488pZW_1712575476)
          by smtp.aliyun-inc.com;
          Mon, 08 Apr 2024 19:24:37 +0800
Message-ID: <8343c31b-d096-4b6b-808e-7e5c5548c411@linux.alibaba.com>
Date: Mon, 8 Apr 2024 19:24:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: change temporal buffer to non static
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>, Noboru Asai <asai@sijam.com>
References: <20240408091627.336554-1-asai@sijam.com>
 <c12daa04-c41d-4b6b-acce-26bd885f142c@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c12daa04-c41d-4b6b-acce-26bd885f142c@sjtu.edu.cn>
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

Hi Yifan,

On 2024/4/8 18:34, Yifan Zhao wrote:
> Hi Noboru,
> 
> 
> AFAIK, this `tryrecompress_trailing` is only used when `may_inline` is true, indicating that
> 
> this segment is the last one in the file. In the current inner-file implementation, it means
> 
> that only one worker will use the `tmp` buffer at a given time.
> 
> 
> In fact, the `static` modifier is removed in the first version of the patchset, but the change
> 
> is reversed during the review. I think Xiang may share his opinion about this.


Yes, I think it will impact inter-file implementation, but that doesn't matter since we'll
finally enable this.  So I will apply this first :)

Thanks,
Gao Xiang

> 
> 
> Thanks,
> 
> Yifan Zhao
> 
> On 4/8/24 5:16 PM, Noboru Asai wrote:
>> In multi-threaded mode, each thread must use a different buffer in tryrecompress_trailing
>> function, so change this buffer to non static.
>>
>> Signed-off-by: Noboru Asai <asai@sijam.com>
>> ---
>>   lib/compress.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/compress.c b/lib/compress.c
>> index 641fde6..7415fda 100644
>> --- a/lib/compress.c
>> +++ b/lib/compress.c
>> @@ -447,7 +447,7 @@ static void tryrecompress_trailing(struct z_erofs_compress_sctx *ctx,
>>                      void *out, unsigned int *compressedsize)
>>   {
>>       struct erofs_sb_info *sbi = ctx->ictx->inode->sbi;
>> -    static char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
>> +    char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
>>       unsigned int count;
>>       int ret = *compressedsize;
