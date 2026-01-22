Return-Path: <linux-erofs+bounces-2158-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOXkKss9cmnpfAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2158-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 16:10:03 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A134686BE
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 16:10:02 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxkxz5btxz2yFm;
	Fri, 23 Jan 2026 02:09:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769094599;
	cv=none; b=Bt0dMY2jPakH3Qq2STHyK0nC8yOhXkitZRML65eMXZdOCVglnc4i1E+5bZpwXxZoImdycU7zuvt6NH5gOS2CM+h9UqCsp+lKPMQrLLgA8ED/WQ9Rh7Thb7CqmKucwgh3tdewIVXaDxIXFExlkwmJPuEz+c9ZEJysjzczly7h9I01buTA5w37kArqgvtkAYXeS4fqySKPHvJgnoP3xewZmZf+g8ZfBKfFJ5kuPxVuW4E3lxlo3xqcmzbPHLYGDA2dy9p6UEO2lMn9F9O+yFZN8+OuzQvSt6VO4mjLq6i+upyKDPzFPoG3MsK4a7G8eGopxCi6bVBsIh6mYjqL8m1T6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769094599; c=relaxed/relaxed;
	bh=6YeK8+XEQ06p0sml2YP2VgVDLD9DnuRaQ8bZqQQ3Apw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DlkSQS1TvtLB7GgIBRD8KXUq2GCBYzzL58KdS6B4+PAn5DTq2Nf8ge0Hwonn7ajRgbz9Rh+vtgEvei60cUbZsqnuuE5teKZoT8Lp7OkDxFYgKgFD43UOhNb/JbYOx1k0N1t5Kzoa4ckSgrk3E9BEAJuoy2JY0Pg18P//yqkn5KuU52ZFHurmoymFH0nBFft3hFXbY+SEyqpfXrxpti9d0mQtTGZUd0gLlsrkbvREDXj4fW0MslQ7ZEcqzVj+qo8nHJbuPUO8/ks/owbscgnT1mULgm7+EhP7f0wDkmhgfWfEOyGXyYJx3mxSGZMlLo9yb7zRe/To+QyqhAqjPUihRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HllnF4h7; dkim-atps=neutral; spf=pass (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HllnF4h7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.222; helo=canpmsgout07.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxkxv0y1Yz2xl0
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 02:09:52 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6YeK8+XEQ06p0sml2YP2VgVDLD9DnuRaQ8bZqQQ3Apw=;
	b=HllnF4h7vOqZ07JwjUfmVyRa6FO+FLtenoVNbW9wZ5Emt+xwzycb2QbYJT0P2NX9npL2kwnyf
	dkubgZdIwuGWlZN7i8fo2w0TSpSQMtW5XNhErVFXuzPFfJ0GK8nD8tEyGQaAQm6Om+KhobX4vqH
	YrUpWoj9YMKnvSviXtN7leM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dxksm6v28zLlSx;
	Thu, 22 Jan 2026 23:06:20 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id CED1440562;
	Thu, 22 Jan 2026 23:09:44 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Jan 2026 23:09:44 +0800
Message-ID: <46110ee5-ee70-47ec-bd4d-c0c76bdfda13@huawei.com>
Date: Thu, 22 Jan 2026 23:09:43 +0800
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
Subject: Re: [PATCH v16 06/10] erofs: introduce the page cache share feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <chao@kernel.org>,
	<brauner@kernel.org>
CC: <hch@lst.de>, <djwong@kernel.org>, <amir73il@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
References: <20260122133718.658056-1-lihongbo22@huawei.com>
 <20260122133718.658056-7-lihongbo22@huawei.com>
 <a59ef332-fc67-4890-94b1-9c3f2b37a9fa@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <a59ef332-fc67-4890-94b1-9c3f2b37a9fa@linux.alibaba.com>
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
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2158-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,huawei.com:email,huawei.com:dkim,huawei.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 6A134686BE
X-Rspamd-Action: no action



On 2026/1/22 22:01, Gao Xiang wrote:
> 
> 
> On 2026/1/22 21:37, Hongbo Li wrote:
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
>> shared inode and use its page cache as shared. Reads for files
>> with identical content will ultimately be routed to the page cache of
>> the shared inode. In this way, a single page cache satisfies
>> multiple read requests for different files with the same contents.
>>
>> We introduce new mount option `inode_share` to enable the page
>> sharing mode during mounting. This option is used in conjunction
>> with `domain_id` to share the page cache within the same trusted
>> domain.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   Documentation/filesystems/erofs.rst |   5 +
>>   fs/erofs/Makefile                   |   1 +
>>   fs/erofs/inode.c                    |   1 -
>>   fs/erofs/internal.h                 |  31 ++++++
>>   fs/erofs/ishare.c                   | 167 ++++++++++++++++++++++++++++
>>   fs/erofs/super.c                    |  62 ++++++++++-
>>   fs/erofs/xattr.c                    |  34 ++++++
>>   fs/erofs/xattr.h                    |   3 +
>>   8 files changed, 301 insertions(+), 3 deletions(-)
>>   create mode 100644 fs/erofs/ishare.c
>>
>> diff --git a/Documentation/filesystems/erofs.rst 
>> b/Documentation/filesystems/erofs.rst
>> index 40dbf3b6a35f..bfef8e87f299 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -129,7 +129,12 @@ fsid=%s                Specify a filesystem image 
>> ID for Fscache back-end.
>>   domain_id=%s           Specify a trusted domain ID for fscache mode 
>> so that
>>                          different images with the same blobs, 
>> identified by blob IDs,
>>                          can share storage within the same trusted 
>> domain.
>> +                       Also used for different filesystems with inode 
>> page sharing
>> +                       enabled to share page cache within the trusted 
>> domain.
>>   fsoffset=%llu          Specify block-aligned filesystem offset for 
>> the primary device.
>> +inode_share            Enable inode page sharing for this 
>> filesystem.  Inodes with
>> +                       identical content within the same domain ID 
>> can share the
>> +                       page cache.
>>   ===================    
>> =========================================================
>>   Sysfs Entries
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 549abc424763..a80e1762b607 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += 
>> decompressor_zstd.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 389632bb46c4..202cbbb4eada 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -203,7 +203,6 @@ static int erofs_read_inode(struct inode *inode)
>>   static int erofs_fill_inode(struct inode *inode)
>>   {
>> -    struct erofs_inode *vi = EROFS_I(inode);
> 
> Why this line is in this patch other than
> "erofs: add erofs_inode_set_aops helper to set the aops[.]"
> 
> And there is an unneeded dot at the end of the subject.
> 
> Could you check the patches carefully before sending
> out the next version?

I am very sorry for making such stupid mistake. :(

Thanks,
Hongbo

> 
> Thanks,
> Gao Xiang

