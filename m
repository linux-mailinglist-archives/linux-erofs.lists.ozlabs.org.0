Return-Path: <linux-erofs+bounces-3467-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAoMG507DWrfugUAu9opvQ
	(envelope-from <linux-erofs+bounces-3467-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 06:42:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 090E058796D
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 06:42:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKzQw6fZTz2xy3;
	Wed, 20 May 2026 14:42:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779252120;
	cv=none; b=Rt8l3+4qOo3zd843fjCpvXTXpByzeYKdiB5yFxBrIIwQqqeu/Tkc+IyNIUV4yUH0Mvp2F6KP83S0MGM+KPYGLrSmPMO+1MaLNXCJYFhhrUzYOwVIRMggOd2TcANO5dXo+kCdTb8ZgE0027AywjFEu/B1bxtoQUxkzTSC/qatpu9SG+QPCd7XWow1BYxzDZilzKGRFdsGCN6Io26q7DCIqHWJWcAWmJ6EysEOj6GhasL02kScFRC2Ay/pSkAloYGYBIAH5LhiZogCsKmG0yPGFnNck3Y+MjQ7/nqDobjQKezb5/b7C1goG8nEN3eT+C11fwA+Uztic+tk99QMhA4fxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779252120; c=relaxed/relaxed;
	bh=+OaZwJUGLjgCIBpYsr1gr8lN155FvC1QL1sH+9BnMXE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GCyT4BE2rTA0ZSE++dXfirveELZGL4wkcMWOtX+Rg4S9j2ug8wsB3t+v3GCdrC3B+qeK78qJ+CeZJIQnMAeuv9TF+482QTVJwsIR2WgGUw1VK/l4QIHV/FNX/EMNhEjanNSfB98ygzSPM+25xRVNEz/S0Wzrmqef59/NU5RkXcFGWRATf3AsaNnLlb67zoKgWGHF0h76xfZuZ98GvAPxwh9QUKQP7B6EeY9zK3sfCF/6r9v6xdIOJUWisv2QTj2Mxn1qGHbiknz/WSOYRLH4IWaijiXsCG3sIRIVHpRBayPoYkRRi1kGfV1x5c2JZhqvSAxOdprb+ATVIlv0+RemSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gJ4mYdOT; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gJ4mYdOT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKzQt103Jz2x9N
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 14:41:55 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779252112; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=+OaZwJUGLjgCIBpYsr1gr8lN155FvC1QL1sH+9BnMXE=;
	b=gJ4mYdOTT+fp0hLVmnWlubBx/ieQtB3LorR099p+hiPFvivJHlpQnPxGQZgkuqrcJvEv+PotFFM6mYvp/PagindRSncAZbB8dQp5d27P/Y2rGQfR0zxIGaRpmTtoE638P7czn9GODZ54r4nGyARB0kI3cgxFjzBQJNgP2jhdlR8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X3HJC5n_1779252109;
Received: from 30.221.132.121(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X3HJC5n_1779252109 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 May 2026 12:41:50 +0800
Message-ID: <cc1beea0-6a1d-456c-9dda-8b2ac6e5848c@linux.alibaba.com>
Date: Wed, 20 May 2026 12:41:49 +0800
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
Subject: Re: [PATCH] erofs: fix metabuf leak in shared xattr initialization
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Jia Zhu <zhujia.zj@bytedance.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Amir Goldstein <amir73il@gmail.com>
References: <20260520034252.40163-1-zhujia.zj@bytedance.com>
 <d6707821-fe25-4331-94bf-c0c3936c8d1f@linux.alibaba.com>
In-Reply-To: <d6707821-fe25-4331-94bf-c0c3936c8d1f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3467-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhujia.zj@bytedance.com,m:xiang@kernel.org,m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:amir73il@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,vger.kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 090E058796D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/20 12:25, Gao Xiang wrote:
> Hi Jia,
> 
> On 2026/5/20 11:42, Jia Zhu wrote:
>> erofs_init_inode_xattrs() uses a local metabuf while reading the inline
>> xattr header and the shared xattr id array.
>>
>> It currently drops that metabuf from some error paths and from the success
>> path, but the erofs_bread() failure while reading the shared xattr id array
>> goes straight to out_unlock.
>>
>> This became observable when file-backed metadata reads started calling
>> rw_verify_area() before reusing or dropping the current metabuf.  Before
>> that, the read_mapping_folio() failure path already dropped the old metabuf
>> before returning an error.

even it's exposable directly due to commit 307210c262a2
"erofs: verify metadata accesses for file-backed mounts")

I still hope we could mark it as an xattr implementaion
issue instead of a random consequence, we should
erofs_put_metabuf() as long as `erofs_buf` was
successfully used once.

>>
>> Consolidate the local metabuf cleanup at out_unlock. erofs_put_metabuf()
>> is a no-op if no page has been acquired, and this keeps all paths after
>> taking EROFS_I_BL_XATTR_BIT covered by one cleanup site.
>>
>> Fixes: 307210c262a2 ("erofs: verify metadata accesses for file-backed mounts")
> 
> 
> Hmm, I don't think it's a correct "Fixes:", and
> the commit message should be fixed too.
> 
> I think it's an issue due to missing erofs_put_metabuf()
> in the erofs_init_inode_xattrs() error path instead.
> 
> I think
> Fixes: bb88e8da0025 ("erofs: use meta buffers for xattr operations")
> 
> is a more proper "Fixes:".
> 
> Thanks,
> Gao Xiang
> 
>> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
>> ---
>>   fs/erofs/xattr.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index 41e311019a251..df7ea019526d7 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -89,13 +89,11 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>>           vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) {
>>           erofs_err(sb, "invalid h_shared_count %u @ nid %llu",
>>                 vi->xattr_shared_count, vi->nid);
>> -        erofs_put_metabuf(&buf);
>>           ret = -EFSCORRUPTED;
>>           goto out_unlock;
>>       }
>>       vi->xattr_shared_xattrs = kmalloc_objs(uint, vi->xattr_shared_count);
>>       if (!vi->xattr_shared_xattrs) {
>> -        erofs_put_metabuf(&buf);
>>           ret = -ENOMEM;
>>           goto out_unlock;
>>       }
>> @@ -112,12 +110,12 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>>           }
>>           vi->xattr_shared_xattrs[i] = le32_to_cpu(*xattr_id);
>>       }
>> -    erofs_put_metabuf(&buf);
>>       /* paired with smp_mb() at the beginning of the function. */
>>       smp_mb();
>>       set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
>>   out_unlock:
>> +    erofs_put_metabuf(&buf);
>>       clear_and_wake_up_bit(EROFS_I_BL_XATTR_BIT, &vi->flags);
>>       return ret;
>>   }
> 


