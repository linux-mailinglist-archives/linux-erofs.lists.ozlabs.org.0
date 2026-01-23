Return-Path: <linux-erofs+bounces-2213-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEGUAKUvc2mTswAAu9opvQ
	(envelope-from <linux-erofs+bounces-2213-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 09:21:57 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18372625
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 09:21:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy9rc4xZFz30hP;
	Fri, 23 Jan 2026 19:21:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769156512;
	cv=none; b=nGMgAa38fvfruHrJk+TBykgxB9mTEnVQqYjAVCMxT+ZbbhLlIGJMV+1AVc4gIaeoVhYO/IxNirsZeWEEU8yQCUkuYztusNPJK0hzHmnjsPp7RAU1ihMUsPJ+vDJ7YLsn4YagZlleZjyqAcMRLgKSsGRwa7MVjHoKIqg7yNAzwqi5AVIhCnM6b+VsfE0pg7qMvVQn/Ksw7res1nuv7fnJlJhWPmU7TzXoM0j566/90O/6ywl5Xfuke2SkMl8Zlxjfo+Vj4cvuETIij0ZtY2MEVwkmg2AQ6k3Wg19QxaTcU1SdU1wUoT8hW1JYrwfcyXhGcLA3ITJvi0uuIa8KaHGsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769156512; c=relaxed/relaxed;
	bh=XPpBwN+Ym64kt/gOXADmq5l86PyuqqhVUYveTqcrDUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OlCB/b6+iYG2EPQPrdNx7Fi7954Lzo0Chiu5MWxSJ19qZUucUvKOKHQPk4YEIeZ9FjcRczCiy+TiFqqhFWZenbf6UD7WCqko/WyZxE9ePN24wAIauOWpr4QvXoeM0T6N3ShXPw3eD6xEQ/5/e83w7lE6TDDK19icMSC4TqBZzFEEaDG5p9tb2FsU/ULgerPeQGWa3vPdbBOsNRgPqiS2buN/uMn3gYWS+Kgz8l8XCJVbwcgPtAcHFFLRAnRqhtSFW5gYkeACE42RvZWGJ7S5KA+zEtgWTigF+Swp+AELr1BlPjj2tZuFd5W7m78hnWLqRf9KrBRIjdjYsR+KAs6pxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZGW//1RY; dkim-atps=neutral; spf=pass (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZGW//1RY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.219; helo=canpmsgout04.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy9rZ0QjQz30T8
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 19:21:47 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XPpBwN+Ym64kt/gOXADmq5l86PyuqqhVUYveTqcrDUY=;
	b=ZGW//1RYRTolN6mbtqAHV/mZnwIDOA57/XW6eGmsWVCa9shqLkSsNFMTqGQMryfuzuqMAwIh2
	LafjjnwZmwtBhVi6O+pJV8IGfz6D4KIOZOS3oNzf/3DWY3PzdxlQ47ErVvi/dUDp2yxlV/HCca3
	21io3ldhJqtqWJv/W8cgu8M=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dy9mQ56r2z1prKt;
	Fri, 23 Jan 2026 16:18:14 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 942DA40570;
	Fri, 23 Jan 2026 16:21:41 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Jan 2026 16:21:40 +0800
Message-ID: <7b8bd967-bc81-434a-802c-8c2b95259700@huawei.com>
Date: Fri, 23 Jan 2026 16:21:40 +0800
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
Subject: Re: [PATCH v16 04/10] erofs: add erofs_inode_set_aops helper to set
 the aops.
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>
CC: <chao@kernel.org>, <brauner@kernel.org>, <djwong@kernel.org>,
	<amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260122133718.658056-1-lihongbo22@huawei.com>
 <20260122133718.658056-5-lihongbo22@huawei.com>
 <b20b263d-132b-464e-8314-d3f795e5e582@linux.alibaba.com>
 <20260123061825.GA25722@lst.de>
 <e0b170ec-253e-49ed-be62-9a90e9eb9053@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <e0b170ec-253e-49ed-be62-9a90e9eb9053@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2213-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:hch@lst.de,m:chao@kernel.org,m:brauner@kernel.org,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.826];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 6C18372625
X-Rspamd-Action: no action

Hi Xiang and Christoph,

On 2026/1/23 15:42, Gao Xiang wrote:
> 
> 
> On 2026/1/23 14:18, Christoph Hellwig wrote:
>> On Thu, Jan 22, 2026 at 09:54:15PM +0800, Gao Xiang wrote:
>>>> @@ -455,6 +455,29 @@ static inline void *erofs_vm_map_ram(struct 
>>>> page **pages, unsigned int count)
>>>>        return NULL;
>>>>    }
>>>>    +static inline int erofs_inode_set_aops(struct inode *inode,
>>>> +                       struct inode *realinode, bool no_fscache)
>>>> +{
>>>> +    if 
>>>> (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>>>> +        if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
>>>> +            return -EOPNOTSUPP;
>>>> +        DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>>>> +              erofs_info, realinode->i_sb,
>>>> +              "EXPERIMENTAL EROFS subpage compressed block support 
>>>> in use. Use at your own risk!");
>>>> +        inode->i_mapping->a_ops = &z_erofs_aops;
>>>
>>> Is that available if CONFIG_EROFS_FS_ZIP is undefined?
>>
>> z_erofs_aops is declared unconditionally, and the IS_ENABLED above
>> ensures the compiler will never generate a reference to it.
>>
>> So this is fine, and a very usualy trick to make the code more
>> readable.
> 
> Yeah, I get your point, that is really helpful and I haven't
> used that trick.
> 
> The other problem was the else part is incorrect, Hongbo,
> how about applying the following code and resend the next
> version, I will apply all patches later:
> 

Thanks you very much for your careful review and help. It was indeed my 
own mistake (I have been making errors too easily lately which taught me 
a lot...).
I have updated the new version in:

https://lore.kernel.org/all/20260123075239.664330-1-lihongbo22@huawei.com/

Thanks,
Hongbo

> static inline int erofs_inode_set_aops(struct inode *inode,
>                                         struct inode *realinode, bool 
> no_fscache)
> {
>          if 
> (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>                  if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
>                          return -EOPNOTSUPP;
>                  DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>                            erofs_info, realinode->i_sb,
>                            "EXPERIMENTAL EROFS subpage compressed block 
> support in use. Use at your own risk!");
>                  inode->i_mapping->a_ops = &z_erofs_aops;
>                  return 0;
>          }
>          inode->i_mapping->a_ops = &erofs_aops;
>          if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !no_fscache &&
>              erofs_is_fscache_mode(realinode->i_sb))
>                  inode->i_mapping->a_ops = &erofs_fscache_access_aops;
>          if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) &&
>              erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
>                  inode->i_mapping->a_ops = &erofs_fileio_aops;
>          return 0;
> }
> 
> Thanks,
> Gao Xiang

