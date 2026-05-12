Return-Path: <linux-erofs+bounces-3404-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JyAJvzaAmrJyAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3404-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 09:47:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A3651C203
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 09:47:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF7w74j4sz2ygG;
	Tue, 12 May 2026 17:47:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778572023;
	cv=none; b=dUJS/88SHqRACOw31mjd4CBzattiADsSthcPg7pBRgeVtpxf6FdD+kHDkjhdukde3U+OLnXB+it5Ojh59Rpacl8SIhc08/qyjnoCSw6ZUG5JahZpcJvTB0ogbeLZVUZB1LyzTEAp5B5Uo67tJ2pUc8nA/UNOrxFMI6LgIxWyM+UUqhu8EcNyH8JG8DuMRXwHu120layx4h/0lufdGQjqiM6KbutylJODOnhv7BMv3zjYoxH7rxtSn98gooxKbH9G9JC00VbAoQpygPweVbtXJlqDQie4C9QKsJBn9sPvKrageXGgyT/fnju84n6TA9mnbpl79gcr8i3SCs4PNKU41A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778572023; c=relaxed/relaxed;
	bh=HR+O8UpItopWMMAgZ+erF5Z+7cfJkA/lFsQSkiQDQJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RCdb3w2Na7RZSLuUuZEDvM4iTnUev5olKOtudEbDwl6aLRIjs02pFxgnqcQJoatQVPKmR2ArpIJo7fQFCkQTQp1kNRITyNrddhdG8OMlpZQFyZ6xLcxDD6k0+TgDRs+48pxzKkN7L3lin2tt1MuC+PkL6OCYqiNyEOo3zVX1Yek2AVJioSPXhMsd/E0mBqd5WbhJnLip8eBBM1l9KRzvsUM0D4tiT3FCoJr/GIbblrb3mEn8NGrgHMXnR3MeCafwQxsXg2sbtgzZw/2aCdYAna9Lfy7LRHX9YZ3N/YwoOSg+Pv9j2wKTZhXydIERc336CY34zW81syP3Hk/AqjpWIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=X4s52Ho5; dkim-atps=neutral; spf=pass (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=X4s52Ho5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.227; helo=canpmsgout12.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF7w50rqdz2yb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 May 2026 17:46:59 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HR+O8UpItopWMMAgZ+erF5Z+7cfJkA/lFsQSkiQDQJ0=;
	b=X4s52Ho5wX/t7jiYZoOMCJzhSuUwQ+h/nBU83KxZQ96eRWQPImrripPFLm4Lf7AXnt7gZqBby
	dSwaz/+W+ziq3HXyXQFhoy14IYRh3wbUh8cuC/MRMaRMELfhZ9pl9hUYt9U0+nzuUzJD5Gd7zVr
	oVoEcFo4oCc3L67LvRNNz3c=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gF7lq4338znTVK;
	Tue, 12 May 2026 15:39:51 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id E97B940571;
	Tue, 12 May 2026 15:46:54 +0800 (CST)
Received: from [100.102.28.251] (100.102.28.251) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 15:46:54 +0800
Message-ID: <aa902420-a6d8-41c8-b3c4-68d6be1c839b@huawei.com>
Date: Tue, 12 May 2026 15:46:54 +0800
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
Subject: Re: [PATCH 2/3] erofs-utils: lib: reject packed inodes in metabox
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <jingrui@huawei.com>, <zhukeqian1@huawei.com>, linux-erofs mailing list
	<linux-erofs@lists.ozlabs.org>
References: <20260512071631.969752-1-zhaoyifan28@huawei.com>
 <20260512071631.969752-2-zhaoyifan28@huawei.com>
 <d759a7f6-b273-4a3b-b686-3ff48ccd7150@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <d759a7f6-b273-4a3b-b686-3ff48ccd7150@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.102.28.251]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: B6A3651C203
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3404-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,huawei.com:email,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Action: no action


On 2026/5/12 15:33, Gao Xiang wrote:
>
>
> On 2026/5/12 15:16, Yifan Zhao wrote:
>> If packed_nid carries the metabox NID bit, loading the packed
>> inode first redirects its inode metadata lookup through the
>> metabox inode.  Initializing that metabox inode can then read
>> metadata that refers back through the packed inode, forming a
>> recursive packed inode -> metabox inode -> packed inode path.
>>
>> Reject such images while parsing the superblock, matching the
>> format rule that the special packed inode itself is not stored
>> inside the metabox.
>>
>> Reproducible image (base64-encoded gzipped blob):
>> H4sIAAAAAAAAA2NgGAWjYBSMVPDo4dcHrY0KwsxANg8jAwMLFjVMSGzPx/7Lzj3zXb3jSFTh
>> 5iN7v6CrbQSa8f8/gq8GoRpARHErYxYDEh8EVAm4jw2Il4AMFYDoB7IYmDGVNRhAzf8PBMh+
>> yEjNyclXKM8vyklRIILNRcA5o2AUjIJRMApGwSgYBaNgFAxpAGorv3VkYtBgQLSfQW3sF8wv
>> kJvZDSqIXkCDKpANlWxQZ2Bk0NPTS8RlPkgXqP0Oa5/DxNDNB7XvR8EoGAWjYBSMglEwCkbB
>> KBgFo2AUjIJRQBsAAEZO6n4AIAAA
>>
>> Assisted-by: Codex:GPT-5.5
>> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
>
> Can you fix the kernel instead first and backport to
> erofs-utils? like below,
>
OK. Should we do the same for [PATCH 1/3] too?


Thanks,

Yifan Zhao


> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 802add6652fd..d1829262c06e 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -337,11 +337,12 @@ static int erofs_read_superblock(struct 
> super_block *sb)
>                                              metabox_nid))
>                         goto out;
>                 sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
> -               if (sbi->metabox_nid & 
> BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
> -                       goto out;               /* self-loop detection */
>         }
> -       sbi->inos = le64_to_cpu(dsb->inos);
> +       if ((sbi->metabox_nid | sbi->packed_nid) &
> +           BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
> +               goto out;
>
> +       sbi->inos = le64_to_cpu(dsb->inos);
>         sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
>         sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
>         super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));
>
> Thanks,
> Gao Xiang

