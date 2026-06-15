Return-Path: <linux-erofs+bounces-3586-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T6CsEc5UL2pZ+gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3586-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2026 03:26:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F184682BD0
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Jun 2026 03:26:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=B+zuHAA9;
	dkim=pass header.d=huawei.com header.s=dkim header.b=B+zuHAA9;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3586-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3586-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdssM5vjnz2yT0;
	Mon, 15 Jun 2026 11:26:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781486791;
	cv=none; b=egseItS0mKtHXt6Yj8BRD7tzRKdktaqBPVNLB/CPFF/iE+QEBxXMhPhuJqJB2RSIKvo7P57hhEQhmJLjEF02pjB6BUTj8/Ccfhib/sIW+quxXpigTUDJc3cxJfYeq7Xkaxctov6ZeoIfxH31qD1OHwLorR8aRVmiiagr9tawq/0bVE+r1aPoOzHCVDTUhziJcD1AtSyjDUO98GeXkzX65u7VhlxPjZxZ9C3GCvWunvrGe0AgtMIs8jbejhjQdwbBljI9PBHg/1x1bkYpHcHi866LRzKoc5HUB6QCF7ANYWeqaLPiGUqrsVQMPcygtw4LKhWj5u41muwgFmyWKLHSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781486791; c=relaxed/relaxed;
	bh=tIUCnVj6NdE+05UAjJNPyabizqyUB0Qk7xKO+9pSNys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NA3qZRCq8/9rYzMc8vwX9cBuxJN8Ul4CERTz5voddl4P23K46DAC1qmE4SqdBQ/jtEKl/IiL/DL2o9LHOiIiCwz0//6xYKE1fWB+OhEiin4n4Si1ir1hk/S+oQ2C8R5AYW02uwEn75tE+ykJvmeqyXLb5kngESVEp/I5g7s57D+Oqh86Uxs8/s+bkAD5dcisC3yqPwXOvY/Do3CB4JcZYO2H+MKtqnQ0FbIzbdIRacHtLbb/IQVzUqilTcQFXpk9oPU/IbAameyWOGkzAD1CL4qmpcXKwest0C+R791vyNeopc/KoOQN62IBMSHb1EAj4yiuLnfq8KJn3FO6QOp+AQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=B+zuHAA9; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=B+zuHAA9; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdssJ2Klfz2yFc
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2026 11:26:28 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tIUCnVj6NdE+05UAjJNPyabizqyUB0Qk7xKO+9pSNys=;
	b=B+zuHAA9hrVqGLRH1sovzRe30h42jjkMT/0SjUlD1m5flyS8d6NCFlKWYKDTI51uj88XH+8po
	VELHh9jP4zU8SuQ4s1rabJIH9OJndaUnrF3sv9UBVQcvdzZZWQWuocjbgsb3s6LtWaQK0JF1OxD
	2qoIW1AZHYLwhtgwWy0wskY=
Received: from canpmsgout11.his.huawei.com (unknown [172.19.92.148])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gdsrm4NLYz1BGLR
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Jun 2026 09:26:00 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tIUCnVj6NdE+05UAjJNPyabizqyUB0Qk7xKO+9pSNys=;
	b=B+zuHAA9hrVqGLRH1sovzRe30h42jjkMT/0SjUlD1m5flyS8d6NCFlKWYKDTI51uj88XH+8po
	VELHh9jP4zU8SuQ4s1rabJIH9OJndaUnrF3sv9UBVQcvdzZZWQWuocjbgsb3s6LtWaQK0JF1OxD
	2qoIW1AZHYLwhtgwWy0wskY=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gdsgr05QtzKm4v;
	Mon, 15 Jun 2026 09:18:16 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 903004048B;
	Mon, 15 Jun 2026 09:26:15 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Jun 2026 09:26:15 +0800
Message-ID: <51c13a05-a4f5-4bbe-ad1a-ba167fa2e76c@huawei.com>
Date: Mon, 15 Jun 2026 09:26:14 +0800
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
Subject: Re: [PATCH] erofs: clean up erofs_ishare_fill_inode()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>, <oliver.yang@linux.alibaba.com>
References: <20260607172132.2695176-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260607172132.2695176-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3586-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F184682BD0



On 2026/6/8 1:21, Gao Xiang wrote:
>   - Use the shorthand `si` to replace the overly long `sharedinode`;
> 
>   - Introduce erofs_warn() and get rid of barely-used _erofs_printk();
> 
>   - Get rid of the variable `hash`;
> 
>   - Simplify error paths.
> 
> Cc: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/ishare.c   | 45 +++++++++++++++++++--------------------------
>   2 files changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4792490161ec..9e2ae7b61977 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -23,6 +23,8 @@
>   __printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
>   #define erofs_err(sb, fmt, ...)	\
>   	_erofs_printk(sb, KERN_ERR fmt "\n", ##__VA_ARGS__)
> +#define erofs_warn(sb, fmt, ...) \
> +	_erofs_printk(sb, KERN_WARNING fmt "\n", ##__VA_ARGS__)
>   #define erofs_info(sb, fmt, ...) \
>   	_erofs_printk(sb, KERN_INFO fmt "\n", ##__VA_ARGS__)
>   
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 6ed66b17359b..35cbd0bc04d7 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -40,49 +40,42 @@ static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>   bool erofs_ishare_fill_inode(struct inode *inode)
>   {
>   	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
> -	struct erofs_inode *vi = EROFS_I(inode);
>   	const struct address_space_operations *aops;
> +	struct erofs_inode *vi = EROFS_I(inode);
>   	struct erofs_inode_fingerprint fp;
> -	struct inode *sharedinode;
> -	unsigned long hash;
> +	struct inode *si;
>   
>   	aops = erofs_get_aops(inode, true);
>   	if (IS_ERR(aops))
>   		return false;
>   	if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
>   		return false;
> -	hash = xxh32(fp.opaque, fp.size, 0);
> -	sharedinode = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
> -				   erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
> -				   &fp);
> -	if (!sharedinode) {
> -		kfree(fp.opaque);
> -		return false;
> -	}
>   
> -	if (inode_state_read_once(sharedinode) & I_NEW) {
> -		sharedinode->i_mapping->a_ops = aops;
> -		sharedinode->i_size = vi->vfs_inode.i_size;
> -		unlock_new_inode(sharedinode);
> +	si = iget5_locked(erofs_ishare_mnt->mnt_sb,
> +			  xxh32(fp.opaque, fp.size, 0),
> +			  erofs_ishare_iget5_eq, erofs_ishare_iget5_set, &fp);
> +	if (si && (inode_state_read_once(si) & I_NEW)) {
> +		si->i_mapping->a_ops = aops;
> +		si->i_size = inode->i_size;
> +		unlock_new_inode(si);
>   	} else {
>   		kfree(fp.opaque);
> -		if (aops != sharedinode->i_mapping->a_ops) {
> -			iput(sharedinode);
> +		if (!si || aops != si->i_mapping->a_ops) {
> +			iput(si);
>   			return false;
>   		}
> -		if (sharedinode->i_size != vi->vfs_inode.i_size) {
> -			_erofs_printk(inode->i_sb, KERN_WARNING
> -				"size(%lld:%lld) not matches for the same fingerprint\n",
> -				vi->vfs_inode.i_size, sharedinode->i_size);
> -			iput(sharedinode);
> +		if (si->i_size != inode->i_size) {
> +			erofs_warn(inode->i_sb, "i_size mismatch (%lld != %lld) for the same fingerprint",
> +				   inode->i_size, si->i_size);
> +			iput(si);
>   			return false;
>   		}
>   	}
> -	vi->sharedinode = sharedinode;
> +	vi->sharedinode = si;
>   	INIT_LIST_HEAD(&vi->ishare_list);
> -	spin_lock(&EROFS_I(sharedinode)->ishare_lock);
> -	list_add(&vi->ishare_list, &EROFS_I(sharedinode)->ishare_list);
> -	spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
> +	spin_lock(&EROFS_I(si)->ishare_lock);
> +	list_add(&vi->ishare_list, &EROFS_I(si)->ishare_list);
> +	spin_unlock(&EROFS_I(si)->ishare_lock);
>   	return true;
>   }
>   

