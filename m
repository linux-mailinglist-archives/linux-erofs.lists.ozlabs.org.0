Return-Path: <linux-erofs+bounces-3209-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNZVB4l41GlduQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3209-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 05:22:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217033A9632
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 05:22:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqWjJ2Nt0z2ydq;
	Tue, 07 Apr 2026 13:22:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775532164;
	cv=none; b=hx8yqwWd/LMWKayetB0/OPy+CwPbxiTD8kDulvtgoJtzUF7qFlUnC+cwhQzpanKcjvGEo2Kq/Sfn6vk/lYnXjJqZerz5IQmykVCC/Q/GOsJ2xS7PkJ203nWlSkdk3+fx1/PxU28I9oYOJluKKVUhkhyJKxd+zlx8TlCi1SIZgEG7pbKBOj2QAAeO9RqoYRKcnMoWnkyet4wutswy16bYG5GIwh6hYGjEESOS5DIQgsVCHkufVgFqTxvdT84MRlsJUDPwQPmGDs3gQKbjWH6X+f5yrKtjnmsgUTlCoaljDPZLtzQ76YABRqw7rxbCZvW6Xam6cU2o47dJT0LCbFpYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775532164; c=relaxed/relaxed;
	bh=yhCqghI0Du32l+1wAANoBjHt+8rq/oA4YAk/bnlJREI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BB7f/SrzTE/+tusY/v++mRScRbQPgNuNMQSz4MeY9CMCoCdHv0l5+r99dibayFwlaosjBfpXEDiRIg9IWjaawkuNe9Ya7BAy5bpxM7DcATtC40oJ48M8eC2gttm09UpJyM89Sn7azasp8tbjkoEE9gtn3++DrlBC8eu6XSKxr6pusvq0r+c5y1k9mtWFeLUL3uwOc8Od04FghsiuODsN6qbl0jxxM70KpetnEJFVI1ajGSqxL5v+gPlzFGpZ6B+nrexMti9Di9g8wwgQb4DurenG3gvAFL1Ye6ATKDl0dXBfekchsp//bP9uC8DE4mpcN6UEIArVQYV4qFrYGEtGSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k6AOK993; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k6AOK993;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqWjF5Pjfz2xQs
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 13:22:39 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775532155; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yhCqghI0Du32l+1wAANoBjHt+8rq/oA4YAk/bnlJREI=;
	b=k6AOK993/lCSHo+JHqPbgF8q5BMGM/vw5GSbTyxAFXDVKXHUzQ0T+xq2MbPGQXgwWcf3dxJFGabYhNRbSIvkFd6Sy+NI9kDTAVX7k9JjT+StvPMMO/g+J2XTYluYTJUgSAYSdJWVPq4lY6UXoPP/MzgViO7iyYvF7T7c9jOyFWM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X0aH6Ti_1775532154;
Received: from 30.221.130.92(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0aH6Ti_1775532154 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 11:22:34 +0800
Message-ID: <9e0696c4-95ff-4365-aced-2f67c7f08c85@linux.alibaba.com>
Date: Tue, 7 Apr 2026 11:22:34 +0800
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
Subject: Re: [PATCH erofs-utils v2 2/2] erofs-utils: handle 48-bit
 blocks/uniaddr for extra devices
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <12b129db-0206-44f3-a53c-9eec6fe3fda3@linux.alibaba.com>
 <20260403130546.76579-1-zhanxusheng@xiaomi.com>
 <20260403130546.76579-3-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260403130546.76579-3-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3209-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:linux-erofs@lists.ozlabs.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid,xiaomi.com:email]
X-Rspamd-Queue-Id: 217033A9632
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/3 21:05, Zhan Xusheng wrote:
> erofs_write_device_table() only writes blocks_lo and uniaddr_lo to
> the on-disk device slot, but does not write blocks_hi or uniaddr_hi.
> Similarly, erofs_init_devices() only reads the _lo fields for extra
> devices.
> 
> For extra devices whose blocks or uniaddr exceed 32 bits in a 48-bit
> EROFS image, the upper bits are silently lost in both read and write
> paths.  This is inconsistent with the primary device handling, which
> correctly writes blocks_hi (super.c:231) and reads it (super.c:125).
> 
> Also sync the erofs_deviceslot on-disk definition with the kernel:
> blocks_hi should be __le16 (not __le32), matching the 48-bit design
> where all block address high parts are 16-bit.
> 
> A corresponding kernel fix has been applied:
>    ("erofs: handle 48-bit blocks/uniaddr for extra devices")
> 
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>   include/erofs_fs.h |  4 ++--
>   lib/super.c        | 10 ++++++++--
>   2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index ff8ac78..5d12049 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -45,9 +45,9 @@ struct erofs_deviceslot {
>   	u8 tag[64];		/* digest(sha256), etc. */
>   	__le32 blocks_lo;	/* total blocks count of this device */
>   	__le32 uniaddr_lo;	/* unified starting block of this device */
> -	__le32 blocks_hi;	/* total blocks count MSB */
> +	__le16 blocks_hi;	/* total blocks count MSB */
>   	__le16 uniaddr_hi;	/* unified starting block MSB */
> -	u8 reserved[50];
> +	u8 reserved[52];
>   };
>   #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
>   
> diff --git a/lib/super.c b/lib/super.c
> index 86d50a1..fd7972c 100644
> --- a/lib/super.c
> +++ b/lib/super.c
> @@ -54,6 +54,8 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
>   	if (!sbi->devs)
>   		return -ENOMEM;
>   	pos = le16_to_cpu(dsb->devt_slotoff) * EROFS_DEVT_SLOT_SIZE;
> +	bool _48bit = erofs_sb_has_48bit(sbi);

It should be refined with the variable definitions.

I will manually fix it up instead.

Thanks,
Gao Xiang

