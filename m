Return-Path: <linux-erofs+bounces-895-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F7B32D6D
	for <lists+linux-erofs@lfdr.de>; Sun, 24 Aug 2025 06:03:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c8gJ20xBwz30Vr;
	Sun, 24 Aug 2025 14:02:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756008178;
	cv=none; b=H3BJETTMDVVsEu6sxlpL8PCfqEzOltDthLsbYJKK4ioPE9Tzm4r2ynmINNIdxmUKSPRFXGyT7wnYPERvZYc854JuoQaXBjXhA+njT9kN935XRSVnXr8wvtZd9CDizGo/4YDyNywPgg0HHafOrIGewl6aWCTl5Xj1MIFGEGp2secw2vkUou8RWAbsNbHs1IpbHtILaTjzhIBC00lNnC2J+cKNkGdhFF0l/Y7KVNKOyatoUCr6GJoKEyG8yFoGa4iQUayTMAEQifHwiY+VwUzuw9UAltFBq5dSGhVrMKmhFdLCLhGP+ATXjXbJT4j3at8bGBbpZzQHgo4UE495VfqkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756008178; c=relaxed/relaxed;
	bh=+D/cc1NGlapS8Z7tnT1Auy/6NgrLSBebNAep/aDhZl8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z90SUUYqnyihO4ZbzMg47wx12xYLkZBuvwwpVeXVMUw8BjTN10elBslBctPrO8ZK7LCil1CcQjIDP8rGi+BPmWTOWi2ohkoPGbbu/rQr2j6Azw2kfOqZ0HowtNKu7UKdppY5jgYUMmr7D/5y9cP+1w+WF8SKL5dXeVOWRaiFyhpmQmOam+UNkZ1aQj0IVSN4/nvAk2AaHGTKEALzJH3v5xLYBeGuF7pKv1SP/7UcwUWh/Mu81/wirfPALL0WpMkuJU3J+QiJzrtI8MdAJhwFIwHj8hbyAEczvdk6cNxdgesoSAavP5kIPuPmJqlyXXMQW2313Amv2HHGCfvXkBgvlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lw+LlyiF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lw+LlyiF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c8gHz17Cnz30FR
	for <linux-erofs@lists.ozlabs.org>; Sun, 24 Aug 2025 14:02:53 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756008169; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=+D/cc1NGlapS8Z7tnT1Auy/6NgrLSBebNAep/aDhZl8=;
	b=lw+LlyiFj19KLIbVpTCEBS9zjCWpXllD/9Y1GkMXFXvOBwJ9u5xPY0T88G2oNcp30yGYjyVn7/vT0yMyMmB/y4kI+4AsODWMZ9qOvIZZ32mZMocNYCNfAZId+WZf7oJ4pwSNx6Og2HQwA+yioqGnIPZoisHmBsqeOeMMfmoqAc4=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmNdq31_1756008166 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 24 Aug 2025 12:02:47 +0800
Message-ID: <217a3ea2-3755-49c1-aef4-6b9ca0d5bd54@linux.alibaba.com>
Date: Sun, 24 Aug 2025 12:02:46 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Friendy Su <friendy.su@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20250823083453.249576-1-friendy.su@sony.com>
 <d1426b16-f5df-4587-813b-a244b4debc84@linux.alibaba.com>
In-Reply-To: <d1426b16-f5df-4587-813b-a244b4debc84@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Friendy,

On 2025/8/23 17:14, Gao Xiang wrote:
> 
> 

...

>> ---
>>   lib/blobchunk.c  | 18 ++++++++++++++++++
>>   man/mkfs.erofs.1 | 15 +++++++++++++++
>>   mkfs/main.c      | 12 ++++++++++++
>>   3 files changed, 45 insertions(+)
>>
>> diff --git a/lib/blobchunk.c b/lib/blobchunk.c
>> index bbc69cf..69c70e9 100644
>> --- a/lib/blobchunk.c
>> +++ b/lib/blobchunk.c
>> @@ -309,6 +309,24 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
>>       minextblks = BLK_ROUND_UP(sbi, inode->i_size);
>>       interval_start = 0;
>> +    /*
>> +     * dsunit <= chunksize, deduplication will not cause unalignment,
>> +     * we can do align with confidence
>> +     */
>> +    if (sbi->bmgr->dsunit > 1 &&
>> +        sbi->bmgr->dsunit <= 1u << (chunkbits - sbi->blkszbits)) {
> 
> Sigh, I meant (sbi->bmgr->dsunit >= 1u << (chunkbits - sbi->blkszbits))
> 
> Let's ignore sbi->bmgr->dsunit < 1u << (chunkbits - sbi->blkszbits).

Sorry, your patch is absolutely correct.

I was looking at this in rush, sorry for the noise.

I will submit this later soon. (busy in other personal
stuffs this weekend.)

Thanks,
Gao Xiang


> 
> Thanks,
> Gao Xiang


