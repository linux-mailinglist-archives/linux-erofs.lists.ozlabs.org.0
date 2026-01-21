Return-Path: <linux-erofs+bounces-2104-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMhjMQYscGniWwAAu9opvQ
	(envelope-from <linux-erofs+bounces-2104-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 02:29:42 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E48E4F18B
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jan 2026 02:29:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwmns2Gklz2xqD;
	Wed, 21 Jan 2026 12:29:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768958977;
	cv=none; b=gK/qElvsDDEmugeeXhCPC7MBMaZ+fD7XfPNOapmEE4lavNRnpX4qv853MmPd3Wyv38bJZyDTunzOf+KQr+cHRZZSIGvSblROZPjmRg7BsGxpjH2Uu313jdglVTrocS+3yWLaCh3CHAm6XwyEb8l3IFVNoRqENFkVKGgMvZcekKE9ZnXLkO4GxSAA8bD/AE/Ww3umS6xqBxqyzIVdMD/Hsr3I6WrAM0NyD4PcI7d+LcPBqvCSS19JP704jW9UhcpWpiGJJYHn+eUp4UyyPgQwQPuz64A9hK6BKwOLcLSiBgA1BOlrEztEWa0GKceOOCXNXkUsqMtzru2CmyKHU2RBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768958977; c=relaxed/relaxed;
	bh=4tq8UHj7aVk7k1iPD/wf4mLlV9TgYl5jy5aGiJC9N7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y4e345G2+AKdYlQDAIbm7qzj6vqI9MsM+9o2+IHGQJILbuwahUtxdImuVhIJNZhSACuj1H81WVWozMDJIeKVvGBYo7q/jjGF75IBLrETq00isK+/Q5SEohbwX30xYWtnXCo6dtiBDGogZC8kI5IenrA1BGs/ejRrMlEkEIwoIeJgz7QXvyvnHSBTDwB5b5mpRJPILtudzRQCfp6gD4ALEhr4VonBUnjYb2e03REYaM7cDbF3N3zTHHB4EEdhAydUScU/QcDop3iSHUW0UQ2RwiS2yuXIMKSgg5a4QlhME1/oMXULIi5mTiWyhJjQysZaxM/g5wv5l9B+wkZzYGrihw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FXRJFSGm; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=FXRJFSGm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwmnn4Qntz2xpk
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jan 2026 12:29:31 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4tq8UHj7aVk7k1iPD/wf4mLlV9TgYl5jy5aGiJC9N7M=;
	b=FXRJFSGmcLcnGjPztrRgauytaQSjWoUYFoweipDZ4ER/5Dl409paUqvCBR2iKRaBGH3As6Ofa
	bo09ujyT/kibiCLP+9l6zLZtd+1aFjXbSHt3jPwHfIiwwnAtttDee1dpVGTS1k/b38WpHmj43EI
	6gZHuNF55UKAt341smYucgg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dwmjK1PB8zpStY;
	Wed, 21 Jan 2026 09:25:41 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A1E740567;
	Wed, 21 Jan 2026 09:29:26 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Jan 2026 09:29:25 +0800
Message-ID: <45c45182-e0f3-4b69-869f-5a0a90d543f5@huawei.com>
Date: Wed, 21 Jan 2026 09:29:25 +0800
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
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <3ae9078a-ba5c-460d-89ea-8fdbdf190a10@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <3ae9078a-ba5c-460d-89ea-8fdbdf190a10@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lst.de,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2104-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:brauner@kernel.org,m:djwong@kernel.org,m:amir73il@gmail.com,m:hch@lst.de,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_XOIP(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,huawei.com:email,huawei.com:dkim,huawei.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 2E48E4F18B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/1/20 22:19, Gao Xiang wrote:
> 
> 
> On 2026/1/16 17:55, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Currently, reading files with different paths (or names) but the same
>> content will consume multiple copies of the page cache, even if the
>> content of these page caches is the same. For example, reading
>> identical files (e.g., *.so files) from two different minor versions of
>> container images will cost multiple copies of the same page cache,
>> since different containers have different mount points. Therefore,
>> sharing the page cache for files with the same content can save memory.
>>
>> This introduces the page cache share feature in erofs. It allocate a
>> deduplicated inode and use its page cache as shared. Reads for files
>> with identical content will ultimately be routed to the page cache of
>> the deduplicated inode. In this way, a single page cache satisfies
>> multiple read requests for different files with the same contents.
>>
>> We introduce inode_share mount option to enable the page sharing mode
>> during mounting.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   Documentation/filesystems/erofs.rst |   5 +
>>   fs/erofs/Makefile                   |   1 +
>>   fs/erofs/inode.c                    |  24 +----
>>   fs/erofs/internal.h                 |  57 ++++++++++
>>   fs/erofs/ishare.c                   | 161 ++++++++++++++++++++++++++++
>>   fs/erofs/super.c                    |  56 +++++++++-
>>   fs/erofs/xattr.c                    |  34 ++++++
>>   fs/erofs/xattr.h                    |   3 +
>>   8 files changed, 316 insertions(+), 25 deletions(-)
>>   create mode 100644 fs/erofs/ishare.c
>>
>> diff --git a/Documentation/filesystems/erofs.rst 
>> b/Documentation/filesystems/erofs.rst
>> index 08194f194b94..27d3caa3c73c 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -128,7 +128,12 @@ device=%s              Specify a path to an extra 
>> device to be used together.
>>   fsid=%s                Specify a filesystem image ID for Fscache 
>> back-end.
>>   domain_id=%s           Specify a domain ID in fscache mode so that 
>> different images
>>                          with the same blobs under a given domain ID 
>> can share storage.
>> +                       Also used for inode page sharing mode which 
>> defines a sharing
>> +                       domain.
> 
> I think either the existing or the page cache sharing
> here, `domain_id` should be protected as sensitive
> information, so it'd be helpful to protect it as a
> separate patch.
> 
> And change the description as below:
>                             Specify a trusted domain ID for fscache mode 
> so that
>                             different images with the same blobs, 
> identified by blob IDs,
>                             can share storage within the same trusted 
> domain.
>                             Also used for different filesystems with 
> inode page sharing
>                             enabled to share page cache within the 
> trusted domain.
> 
> 
>>   fsoffset=%llu          Specify block-aligned filesystem offset for 
>> the primary device.
>> +inode_share            Enable inode page sharing for this 
>> filesystem.  Inodes with
>> +                       identical content within the same domain ID 
>> can share the
>> +                       page cache.
>>   ===================    
>> =========================================================
> 
> ...
> 
> 
>>       erofs_exit_shrinker();
>> @@ -1062,6 +1111,8 @@ static int erofs_show_options(struct seq_file 
>> *seq, struct dentry *root)
>>           seq_printf(seq, ",domain_id=%s", sbi->domain_id);
> 
> I think we shouldn't show `domain_id` to the userspace
> entirely.
> 
> Also, let's use kfree_sentitive() and no_free_ptr() to
> replace the following snippet:
> 
>           case Opt_domain_id:
>                  kfree(sbi->domain_id); -> kfree_sentitive

Ok, kfree_sensitive/no_free_ptr looks good, this way makes domain_id 
more reliable.

Thanks,
Hongbo

>                  sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
>                       -> sbi->domain_id = no_free_ptr(param->string);
>                  if (!sbi->domain_id)
>                          return -ENOMEM;
>                  break;
> 
> And replace with kfree_sentitive() for domain_id everywhere.
> 
> Thanks,
> Gao Xiang

