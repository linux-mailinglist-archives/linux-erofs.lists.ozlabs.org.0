Return-Path: <linux-erofs+bounces-3403-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFZrGsXXAmpXyAEAu9opvQ
	(envelope-from <linux-erofs+bounces-3403-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 09:33:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3CB51BE9E
	for <lists+linux-erofs@lfdr.de>; Tue, 12 May 2026 09:33:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF7cK5hKQz2ygG;
	Tue, 12 May 2026 17:33:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778571201;
	cv=none; b=egzvvXvAiBCqwcjApmqpHAOFueoCjS5BK5WTduXuYvdoUQARWBuZP6AnItqrcIsxK4D4m1PNGj3SNC/3kNpvKF9hFL91Q0jv5Axs1QNfla5kYCvs0xlECfX5+OvxeXhZh2Rh5f+HJgt5QCspaOAcq1TmDEpJBaqW/1Ql1g+ecbWzTxK42eBSnzefZTt2uOf1u5zvrTybGceRtOnvFD9sgNc4uwoxSldHDTCYH8rkWhuImmruqqGT504Dbfd9z6kNBkDBki8x3vIu5kyc3ZfQQ/19+v7JzgS9JMY9U/IkQ9LbUYa7+/6xD/Zw3sGJ64Bbym9h+m8GrinOP4LppFdy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778571201; c=relaxed/relaxed;
	bh=KilzlgYdXvQP1EF5iW6ehOR1n8vPeCFyMZcdoC2ZPQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbdvHNzrIJnAMlgHcX3tVoYoW7IzA840MgJwYXDqNI2Rtt1T4YHqe0SQM6JuQ16xPVlNIVbexRhrZV3NV6zmZvwRlKnRaSDlunf+b4rQxpHsg7Y6mzJFnVRiU+lZihEXMNsXOaNJZ2itJxmP/godDia8jP2vc4s0cVQ6fJLUgl6UZ1AjC/VGU56l86wOuo0XDnABxDXLu1sNtuwGFrWilDFT3ujqe+pyzMWG7jTpMMor9E1fmrYRRg0zYhPE/FW1C+9Sxdmuw3a4xylJl09JJzUedRVSyfYIDwyn4SUqQgyIApbIUTaRO469DbHLFCJsQzpdXS6h8kq6GWyrG4fGSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kTlZKDMM; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kTlZKDMM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF7cH1t40z2yb9
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 May 2026 17:33:17 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778571193; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KilzlgYdXvQP1EF5iW6ehOR1n8vPeCFyMZcdoC2ZPQ8=;
	b=kTlZKDMMKYSQIkfG8ZvCrdTGiKww4una3Wm9OOeDpJCbyv2yP9OK4/sU65PgkuA59aAZ5fLVMgffqY0iCU5hDvV3Ubbeah0JkPdu359LYzBIAOi8njtXTCwvxCJ5xHKCrBB0OGAomjwBYdRrtcwPJp1gobGHpvibXoH3Ua3gHnc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X2pmzEB_1778571189;
Received: from 30.221.130.241(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2pmzEB_1778571189 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 15:33:11 +0800
Message-ID: <d759a7f6-b273-4a3b-b686-3ff48ccd7150@linux.alibaba.com>
Date: Tue, 12 May 2026 15:33:11 +0800
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
To: Yifan Zhao <zhaoyifan28@huawei.com>
Cc: jingrui@huawei.com, zhukeqian1@huawei.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20260512071631.969752-1-zhaoyifan28@huawei.com>
 <20260512071631.969752-2-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260512071631.969752-2-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 5A3CB51BE9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3403-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action



On 2026/5/12 15:16, Yifan Zhao wrote:
> If packed_nid carries the metabox NID bit, loading the packed
> inode first redirects its inode metadata lookup through the
> metabox inode.  Initializing that metabox inode can then read
> metadata that refers back through the packed inode, forming a
> recursive packed inode -> metabox inode -> packed inode path.
> 
> Reject such images while parsing the superblock, matching the
> format rule that the special packed inode itself is not stored
> inside the metabox.
> 
> Reproducible image (base64-encoded gzipped blob):
> H4sIAAAAAAAAA2NgGAWjYBSMVPDo4dcHrY0KwsxANg8jAwMLFjVMSGzPx/7Lzj3zXb3jSFTh
> 5iN7v6CrbQSa8f8/gq8GoRpARHErYxYDEh8EVAm4jw2Il4AMFYDoB7IYmDGVNRhAzf8PBMh+
> yEjNyclXKM8vyklRIILNRcA5o2AUjIJRMApGwSgYBaNgFAxpAGorv3VkYtBgQLSfQW3sF8wv
> kJvZDSqIXkCDKpANlWxQZ2Bk0NPTS8RlPkgXqP0Oa5/DxNDNB7XvR8EoGAWjYBSMglEwCkbB
> KBgFo2AUjIJRQBsAAEZO6n4AIAAA
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>

Can you fix the kernel instead first and backport to
erofs-utils? like below,

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 802add6652fd..d1829262c06e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -337,11 +337,12 @@ static int erofs_read_superblock(struct super_block *sb)
                                              metabox_nid))
                         goto out;
                 sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
-               if (sbi->metabox_nid & BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
-                       goto out;               /* self-loop detection */
         }
-       sbi->inos = le64_to_cpu(dsb->inos);
+       if ((sbi->metabox_nid | sbi->packed_nid) &
+           BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT))
+               goto out;

+       sbi->inos = le64_to_cpu(dsb->inos);
         sbi->epoch = (s64)le64_to_cpu(dsb->epoch);
         sbi->fixed_nsec = le32_to_cpu(dsb->fixed_nsec);
         super_set_uuid(sb, (void *)dsb->uuid, sizeof(dsb->uuid));

Thanks,
Gao Xiang

