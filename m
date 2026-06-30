Return-Path: <linux-erofs+bounces-3791-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RwDgBrNEQ2o1WQoAu9opvQ
	(envelope-from <linux-erofs+bounces-3791-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 06:23:15 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637EA6E0403
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 06:23:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=ySADXtWq;
	dkim=pass header.d=huawei.com header.s=dkim header.b=ySADXtWq;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3791-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3791-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq94F1b2mz2yY1;
	Tue, 30 Jun 2026 14:23:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782793389;
	cv=none; b=DI347Fns37vLJPxmYXjX83ZlWvw75w96lRqdzvY0AW4oR55VM7GEA93UYAPyQlhfP29NMzQ38yunKU2tyx4F3QmBJJSZmNMXENBTqdkSiI397a1jbknjR1HU2Q9Ggjubxn3gqqxRU4FBEWgDiwALZeq79OGp380mEvRdL35grl/bNv0q0H+Q/GNJLVxQHuKc9DXtIMV7JneA85W9K15eIYojgiWqzHlouVN2NjYpeRFn6/jMe+pme3XipiA1Zr/umGKOdtQoxJKq/j3TXXAbIKJrjsDa/dA52GQMZgZ9uZpoJ3RkW2SFsUUgv/8nmAJ0XzmeMNRbKgFX1Sl9C0p0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782793389; c=relaxed/relaxed;
	bh=xEq4M/Souy/rcjkT35CY4+LDISAjhtTD/kChBJzZJfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a7M34D/LHnt/KC8v1NZgY1IvwfWqXuZae1gBCeG+yMmVcoCzxcUy0vHqob5Dr1KeZpbEo+4CWy5eYIBuDYoYhwrVzOjIPkM5TGDvLreX/Yb6eu/T8htB2KPjD/z/Cf7RtZ8gsaiyMf7/oGvB0hEOnshRRgXb/VbXDY+PlJWaJhycmqcLLMyCeerPRlcJOsE/KN4bx07cjd6YJbukXKcH6gvViyWjPIX7bPPPohgv4SQKcqrx7kIeStFOcdtao2f/ZCYsj/OiOJAlEtjbIvdPVMmKYLp1UTm4lypm5FR5FF6e49tYi/MnDUZsWlDh4Y9X1+iYObLZ5pmb/pA0GtVeQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ySADXtWq; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ySADXtWq; dkim-atps=neutral; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq94B0c0yz2xHK
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 14:23:05 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xEq4M/Souy/rcjkT35CY4+LDISAjhtTD/kChBJzZJfw=;
	b=ySADXtWqT9Q/R5zeec5L/kepyiu4vCtqwIxybGKeJR9PiDQQJFNoA7IZ09IbYWXYSsyeVdJDV
	jOf/iBN5n2yZwibWwpLWIEdkP7jT7H0/wZ5OlvEirJczbI9WVGnYWam0xqm2YW7HTNrX5klU3re
	Uics+4R72XpXJzc0m60fyu0=
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gq9382xrQz1BGXb
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:22:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xEq4M/Souy/rcjkT35CY4+LDISAjhtTD/kChBJzZJfw=;
	b=ySADXtWqT9Q/R5zeec5L/kepyiu4vCtqwIxybGKeJR9PiDQQJFNoA7IZ09IbYWXYSsyeVdJDV
	jOf/iBN5n2yZwibWwpLWIEdkP7jT7H0/wZ5OlvEirJczbI9WVGnYWam0xqm2YW7HTNrX5klU3re
	Uics+4R72XpXJzc0m60fyu0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gq8sK21zfzRhQg
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:13:41 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E26F540538
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:22:48 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Jun 2026 12:22:48 +0800
Message-ID: <f3729d34-c160-46e6-adb1-e02b87165514@huawei.com>
Date: Tue, 30 Jun 2026 12:22:47 +0800
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
Subject: Re: [PATCH] erofs: use more informative s_id for file-backed mounts
To: <linux-erofs@lists.ozlabs.org>
References: <20260630031813.3992408-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260630031813.3992408-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-3791-lists,linux-erofs=lfdr.de];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 637EA6E0403



On 2026/6/30 11:18, Gao Xiang wrote:
> For file-backed mounts, set sb->s_id to the MAJOR:MINOR of sb->s_dev
> (which fstat() will return) so that kernel messages and the sysfs
> name are more informative rather than just "erofs: (device erofs): ...".
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   fs/erofs/super.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 86fa5c6a0c70..c5881bb8d52b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -595,17 +595,6 @@ static const struct export_operations erofs_export_ops = {
>   	.get_parent = erofs_get_parent,
>   };
>   
> -static void erofs_set_sysfs_name(struct super_block *sb)
> -{
> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -
> -	if (erofs_is_fileio_mode(sbi))
> -		super_set_sysfs_name_generic(sb, "%s",
> -					     bdi_dev_name(sb->s_bdi));
> -	else
> -		super_set_sysfs_name_id(sb);
> -}
> -
>   static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   {
>   	struct inode *inode;
> @@ -657,12 +646,14 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   		err = super_setup_bdi(sb);
>   		if (err)
>   			return err;
> +
> +		snprintf(sb->s_id, sizeof(sb->s_id),
> +			 "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
>   	} else {
>   		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
>   			errorfc(fc, "failed to set initial blksize");
>   			return -EINVAL;
>   		}
> -
>   		sbi->dif0.dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
>   				&sbi->dif0.dax_part_off, NULL, NULL);
>   	}
> @@ -740,7 +731,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   	if (err)
>   		return err;
>   
> -	erofs_set_sysfs_name(sb);
> +	super_set_sysfs_name_id(sb);
>   	err = erofs_register_sysfs(sb);
>   	if (err)
>   		return err;

