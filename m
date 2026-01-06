Return-Path: <linux-erofs+bounces-1687-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1008ACF73D3
	for <lists+linux-erofs@lfdr.de>; Tue, 06 Jan 2026 09:12:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dlkRb4SqLz2y7c;
	Tue, 06 Jan 2026 19:12:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767687147;
	cv=none; b=cD3iu6cFQo/m+i44i4fgRHNnVm3kmHw9D/ns53YzLry80dL5ugbjkzUYjGOrTSUw89D9HXuDd8+Y8e6w5t+W57FMbSiCslV7KyPPlGniUec5N9JH40A2o4jvYP5cVpGedZp/uTac7BQVxfD2JT1A3GLxTfZ/6G19cRjzn1DCe1K80xSO8BCEf76h05+Rmfuv79jyTg9pkyk5jli8QiBRSwXKyWNlB0RPrl8uPJuvvpqQFgHjlu76AD2avvvCEKbL7BSnZYau3LNwunUOQcIz9tncAaNA4z48xbzQxb2v9jGTYj1AcmdUafGDIzbMrbsTOgfoF8pIQXTAW5dry1/DhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767687147; c=relaxed/relaxed;
	bh=TSfxlB4XvTuBrg4WL8fT/ZHBwaHKXvehIxTV2YGG3zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjctP6u8FfgZKeiLiRkhmW1z9U0a5Q+iskbqFeqFw31PTTJoD2+HDo64xlHzQSWR6V8CgrRuwEb0D3a/AfcoO8Um+pd+io8A65ck50zLeHdnw1NB0+9l9NHlfWvtuxecj51IaHOCPivsYsHdKF0pEuDu2GHhpZ6ooB31JGh0MJOf8qpRw8Yu5Vo7apNVn6ik4sNOHCoZ5kX4KpYczbGmfbz9YzNpwe9oivhgrr2YQ17N602BLGyFDau6Aa/8Ai9SyYfcMFeODvDoUDC3MepEeOxCb3f7GehDVlKgOEwYD2wNRCxaksiMojwtYiVJJV7RR0cwBuJIcNBRQMPp3mx7iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pktH58f0; dkim-atps=neutral; spf=pass (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=liubaolin12138@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=pktH58f0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.4; helo=m16.mail.163.com; envelope-from=liubaolin12138@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 18994 seconds by postgrey-1.37 at boromir; Tue, 06 Jan 2026 19:12:22 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dlkRV6cMPz2xSX
	for <linux-erofs@lists.ozlabs.org>; Tue, 06 Jan 2026 19:12:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=TSfxlB4XvTuBrg4WL8fT/ZHBwaHKXvehIxTV2YGG3zA=;
	b=pktH58f0BVCm5ZI0ixtBJshFdVgEG8ZpHwkRQUvn3JDh1yhateMNI3pTFSO7Wn
	oSnlDbMWhlUVXN9d58NJzNgow3Et2EvzJ81CIlnabam4+uNw1hdxVkZLOQGBBP6n
	13j8x/0YswEDTG/EzXtp/sK3ED/p92cTrppvYtC8quzCk=
Received: from [192.168.18.185] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCHPr64w1xpD0jbEA--.3055S2;
	Tue, 06 Jan 2026 16:11:43 +0800 (CST)
Message-ID: <28f3272c-90bf-48a5-a272-244a0481f51a@163.com>
Date: Tue, 6 Jan 2026 16:11:36 +0800
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
Subject: Re: [PATCH v1] erofs: Fix state inconsistency when updating
 fsid/domain_id
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org
Cc: zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 guochunhai@vivo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20260106025502.133470-1-liubaolin12138@163.com>
 <d5a5b58d-de3d-452a-86de-7e7fb71fe518@huawei.com>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <d5a5b58d-de3d-452a-86de-7e7fb71fe518@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHPr64w1xpD0jbEA--.3055S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWUGF1fCF1fJryktF47urg_yoW8Kr4UpF
	Z3K3WFyrZrAr1jgasagr48XF9Y9340y34kK34FqF1kXw15tFn2q3yaqr1jkryfZrZayw40
	qFnruwsrWFyYyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-Originating-IP: [183.242.174.20]
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwh+RXGlcw7+z5wAA3N
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

> Dear Hongbo Li,
> 
> I have reviewed this carefully, and I agree with your point. The old value will eventually be freed in erofs_sb_free(), and keeping it here does not appear to be necessary. Therefore, this patch does not need to be considered further.
> 
> Thank you for your review.
> 
> Dear Gao Xiang,
> 
> Thank you for your review as well.
> 
> Best regards,
> Baolin Liu
>
> 

在 2026/1/6 11:30, Hongbo Li 写道:
> Hi,
> 
> On 2026/1/6 10:55, Baolin Liu wrote:
>> From: Baolin Liu <liubaolin@kylinos.cn>
>>
>> When updating fsid or domain_id, the code frees the old pointer before
>> allocating a new one. If allocation fails, the pointer becomes NULL
>> while the old value is already freed, causing state inconsistency.
>>
>> Fix by allocating the new value first, and only freeing the old value
>> on success.
>>
>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>> ---
>>   fs/erofs/super.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 937a215f626c..6e083d7e634c 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -509,16 +509,22 @@ static int erofs_fc_parse_param(struct 
>> fs_context *fc,
>>           break;
>>   #ifdef CONFIG_EROFS_FS_ONDEMAND
>>       case Opt_fsid:
>> -        kfree(sbi->fsid);
>> -        sbi->fsid = kstrdup(param->string, GFP_KERNEL);
>> -        if (!sbi->fsid)
>> +        char *new_fsid;
>> +
>> +        new_fsid = kstrdup(param->string, GFP_KERNEL);
> 
> May be there is no need to keep the old pointer. Because
> 1) The fsid/domain_id is ignored in reconfiguration.
> 2) Even if memory allocation fails when the user first mounts with multi 
> fsid/domain_id options (like -o fsid=xxx1,fsid=xxx2), the old fsid 
> pointer would also need to be released in cleanup procedure.
> 
> so am I right?
> 
> Thanks,
> Hongbo
> 
>> +        if (!new_fsid)
>>               return -ENOMEM;
>> +        kfree(sbi->fsid);
>> +        sbi->fsid = new_fsid;
>>           break;
>>       case Opt_domain_id:
>> -        kfree(sbi->domain_id);
>> -        sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
>> -        if (!sbi->domain_id)
>> +        char *new_domain_id;
>> +
>> +        new_domain_id = kstrdup(param->string, GFP_KERNEL);
>> +        if (!new_domain_id)
>>               return -ENOMEM;
>> +        kfree(sbi->domain_id);
>> +        sbi->domain_id = new_domain_id;
>>           break;
>>   #else
>>       case Opt_fsid:


