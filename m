Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D9A9C8306
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 07:23:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xpqq60571z2ytN
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2024 17:23:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731565422;
	cv=none; b=JwIFf30kTCv+ixU2sBx6as2iq+4OSXnz1qK64L9aS6RJqh6Ip+abLMREIRv3xpet+WO5lylb+0qnUh5vaxMaTZYrKPUNGWUBsF/xbDWv5CCg7LqLb2epJXEJXh5Ht5apScOxMhijBQYK8TtJHnZFwlgYUbzN3lSxeFRPx98wgDxag3Xg7TOBdTsXag9xPHBuwbiP0ijZ1Q4eSbkmxwgHKPD7qygx2U9k+HF3XYBW4X6fBZvXzryiwqj6p4cHdzUuKaNFx0wEv286PSdZ6gGBDkqZ2XCy2CBX4GM5QVJQxjahc6Tom8nFunSuZ8W8O/YS8TOaEzIAm8Y9VFUX6cvOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731565422; c=relaxed/relaxed;
	bh=G6Rh8YayiJ3l9UGc9UACdDnDVmzCbGcYUPz+C6VwgWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBtUF1XK06Z56tzpWuecNud6Pwah4BUjGD3WpT9wW337fK8Wr06x0adtIsy6djuP5zCuNIUu17NyAuAd2VmqyTk29Mcc8No1YsNmYXRQvE17IR8p2g4SBv7Xct1VTIevV0WezC8hMk7/hUg8bSCNXtQ7fC+8HMYnYEggwvry1owi8jo6TA9tGwOBJSDpmzYJmT2P4D4OK/moWMQmjZ1xrzQLZ9ROU6z+bCwdBi8pPLOBCSnhLm/HWpJZ8FxHMOH/hYqx7HsqDWU9czX2zkBi1RIivhnJ1FJkmfbBXXtD9n4d5Q0h3qFgTsdez+gt7mRf0lw1UTYyTTZEKQ274LJqaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VnF7r4UY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VnF7r4UY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xpqpy2l53z2yR9
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2024 17:23:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731565410; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G6Rh8YayiJ3l9UGc9UACdDnDVmzCbGcYUPz+C6VwgWI=;
	b=VnF7r4UYv9XLOmeVBTNFBYevwhG1DGged23BcqdI2BNgupy2jMRBfr+QIIteOEfETWg/FCbBAFVr5rsu64sTmE3aRd0g87QPwUXtDETbQAxa2hkw3wBPPiRIazxJbissUivVvgYXNkFDlWdeUyxzMSQDjLAGYhwYmcTdZ5LeVLI=
Received: from 30.221.128.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJNRdxs_1731565407 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 14:23:28 +0800
Message-ID: <61c24337-798d-4a2e-82bf-996e86d0c0fb@linux.alibaba.com>
Date: Thu, 14 Nov 2024 14:23:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix file-backed mounts over FUSE
To: Al Viro <viro@zeniv.linux.org.uk>
References: <20241114051957.419551-1-hsiangkao@linux.alibaba.com>
 <20241114060434.GL3387508@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241114060434.GL3387508@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Al,

On 2024/11/14 14:04, Al Viro wrote:
> On Thu, Nov 14, 2024 at 01:19:57PM +0800, Gao Xiang wrote:
> 
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index 6355866220ff..43c89194d348 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -38,7 +38,10 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset,
>>   	}
>>   	if (!folio || !folio_contains(folio, index)) {
>>   		erofs_put_metabuf(buf);
>> -		folio = read_mapping_folio(buf->mapping, index, NULL);
>> +		folio = buf->use_fp ?
>> +			read_mapping_folio(file_inode(buf->filp)->i_mapping,
>> +				index, buf->filp) :
>> +			read_mapping_folio(buf->mapping, index, NULL);
> 
> UGH...
> 
> 1) 'filp' is an atrocious identifier.  Please, don't perpetuate
> the piss-poor taste of AST - if you want to say 'file', say so.

ok.

> 
> 2) there's ->f_mapping; no need to go through the file_inode().

Yeah, thanks for the suggestion.

> 
> 3) AFAICS, (buf->kmap_type == EROFS_KMAP) == (buf->base != NULL).  What's
> the point of having that as a separate field?

Once buf->kmap_type has EROFS_KMAP and EROFS_KMAP_ATOMIC, but it
seems that it can be cleaned up now.

I will clean up later but it's a seperate story.

> 
> 4) Why bother with union?  Just have buf->file serve as your buf->use_fp
> and be done with that...

I'd like to leave `struct erofs_buf` as small as possible since
it's on stack.

Leave two fields for this are also ok for me anyway.

Thanks,
Gao Xiang
