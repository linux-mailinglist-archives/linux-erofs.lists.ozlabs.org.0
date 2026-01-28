Return-Path: <linux-erofs+bounces-2229-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGpkE/W7eWnoygEAu9opvQ
	(envelope-from <linux-erofs+bounces-2229-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 08:34:13 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19B9DC83
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 08:34:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1DYF3l9cz2xT6;
	Wed, 28 Jan 2026 18:34:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769585649;
	cv=none; b=apMa5H9ec9aq6Ij9xYnKR3Vd9xPHtEsM6rIVta22M/9UxmUtQKwQFbNzYZnX7Q1RZs3LzgYgrYXY/fM4BWRGkPypGOJl6y/m1VdoUEz3sbcvcZqiVyZsTlH0up2EjCjRoJO8NsVbQdAboqAR7ArtEQPCswL9vVICT6Hl/tqqaTNxs9fTtRmm2bu+mm8Mh+WXvYRy6aZKL/PgXuJfLtHpwzpzStN7YKMJCo3E2rZr4FdW5cNN56J+kHijBl/hpnqIIKJ6KVbSkIoN5IWMSTKgJc28mDf8wg8lUAo71duIWQtC2Y/sn41oOFa+UY11OicouiymBCbfVLnspRYQPb5Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769585649; c=relaxed/relaxed;
	bh=d+idU3vVDBTNpjpZb6fDXI/33zTVPVcv5fl07/yf+ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aLJLoQjZckskbkDqu7UOTxxMShENSTa0cRN5Ic4q+TRLRJBHohOOk3Xx0M0ofyzkDK5zL2H0qEMPja2dgQY452QTpntdQGdYiwgRx/n8Qmb8kXR2zXPaX6FER4GkFG7zUYC6yBGucEUPY6wDbmUwwuxZTqvylKTqf+qkNkGOD7cNTBPg1CFD4DgQmSXI/aIE5u6rG65q7qcI4tth9Qven1804XKu1mpF7ygs8X9PVA/ej8YPJdB5dgleH+7rkbD9xg4/kGRIi1kfHC3fekFC5KQeNW8RM4VG672DVBDjD9uZ+cPXKOhVpbj0/76ZUFAq6qIq58gB8s74u+5100ux5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wTa1fZJx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wTa1fZJx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1DYB51cGz2xHt
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jan 2026 18:34:04 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769585639; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=d+idU3vVDBTNpjpZb6fDXI/33zTVPVcv5fl07/yf+ak=;
	b=wTa1fZJxKEzpEulsV7G1BroASvNDll/Om5n86cp9MuF2csJRVim0+Y2Zssg9TyEX3gz0KmjwqgHjxmoCyuZhArBGo0CHWiosMcd1G3gF3Zq8EQsSaIyExQsp+kKjiIWjh8h9JlRsgBd0q3BLseuE04bisoHmAbhjMcbBOR7qSpo=
Received: from 30.221.131.51(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wy2Zs8a_1769585633 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 15:33:54 +0800
Message-ID: <2fc3eaa7-6361-450a-a1cb-dea5069603fb@linux.alibaba.com>
Date: Wed, 28 Jan 2026 15:33:52 +0800
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
Subject: Re: [PATCH] erofs: mark inodes without acls in erofs_read_inode()
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20260128035408.2172802-1-hsiangkao@linux.alibaba.com>
 <bac55082-bb1b-4e7c-8a53-95394bb9a5ec@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <bac55082-bb1b-4e7c-8a53-95394bb9a5ec@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lihongbo22@huawei.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2229-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,huawei.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 2F19B9DC83
X-Rspamd-Action: no action



On 2026/1/28 15:03, Hongbo Li wrote:
> Hi, Xiang
> 
> On 2026/1/28 11:54, Gao Xiang wrote:
>> Similar to commit 91ef18b567da ("ext4: mark inodes without acls in
>> __ext4_iget()"), the ACL state won't be read when the file owner
>> performs a lookup, and the RCU fast path for lookups won't work
>> because the ACL state remains unknown.
>>
>> If there are no extended attributes, or if the xattr filter
>> indicates that no ACL xattr is present, call cache_no_acl() directly.
>>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   fs/erofs/inode.c |  5 +++++
>>   fs/erofs/xattr.c | 20 ++++++++++++++++++++
>>   fs/erofs/xattr.h |  1 +
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index bce98c845a18..2e02d4b466ce 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -137,6 +137,11 @@ static int erofs_read_inode(struct inode *inode)
>>           err = -EFSCORRUPTED;
>>           goto err_out;
>>       }
>> +
>> +    if (IS_ENABLED(CONFIG_EROFS_FS_POSIX_ACL) &&
>> +        erofs_inode_has_noacl(inode, ptr, ofs))
>> +        cache_no_acl(inode);
>> +
>>       switch (inode->i_mode & S_IFMT) {
>>       case S_IFDIR:
>>           vi->dot_omitted = (ifmt >> EROFS_I_DOT_OMITTED_BIT) & 1;
>> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
>> index 512b998bdfff..14d22adc1476 100644
>> --- a/fs/erofs/xattr.c
>> +++ b/fs/erofs/xattr.c
>> @@ -574,4 +574,24 @@ struct posix_acl *erofs_get_acl(struct inode *inode, int type, bool rcu)
>>       kfree(value);
>>       return acl;
>>   }
>> +
>> +bool erofs_inode_has_noacl(struct inode *inode, void *kaddr, unsigned int ofs)
>> +{
> 
> How about put the definition and declare of erofs_inode_has_noacl before the erofs_get_acl helper? Since it is no need to resolved the context conflicts for page sharing.

I've resolved it manually.

> 
> Otherwise it looks good to me:
> Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo


