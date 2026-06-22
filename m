Return-Path: <linux-erofs+bounces-3707-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f2XaLkjkOGr6jgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3707-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 09:29:12 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066756AD3C3
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 09:29:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=WypENWiN;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3707-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3707-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkKZV2nj0z2xyh;
	Mon, 22 Jun 2026 17:29:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782113346;
	cv=none; b=UCMEB4ncdXs9I+yZWc/HP45c6ArG1JN90UlIEgsThuccHr7f42SulUOHqnFKVhS3GMjgsqn/Lkdmi15jr/CDFFpJJLsuZYKVKNhyMuH7j2u6mn+GTx7zP0QoJCi2hIEakTe7KSUezAlz68iYgPuG4X3L6TQZ2BFrbvEFYysjnILU53+sMKYTJyCZ963akeWG7ZY4ifO8P6ynjxjYYXMShhR+JqPEcH8snhtDm0qu1cfu6I9yaL9DK9Y90YczzH5GxOyQPAKzgohFrqdCTPpA6Oos6TDwnEwjxxIY6gKLhhEVX077VgiccFLs8tlg7LpG74uUYokp5CfG3oOGy3Ik6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782113346; c=relaxed/relaxed;
	bh=Y/W7rSUjnKgG0WzmclmvOeTXnTTDaaWYvYZ2/M3Zw3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVw0zxTDYZo6hZQJGwo6VNIxNEBmrK8zydpDMHHxQu7AK4kkpfYJesvznL/4DDiscK3MKHAgxnwvRHWKa8ZHqkxhgR3IoBq94c/NcxVVsK4iuQQtsQM/kviIqyCSY2rsb83FPdbBvB8C1M6rxILnr9gi9VpWcxcVRDrKmGxrpdI9KVT3e3fC8WLVwK14KxODk2KJczYss0MC9/7645CCJMht6rEeeygipp13nLRu3Vt17XdT7d9UapD5Bn4LAj7/fMLvTw0PbDS5HD/vc7X/97vKA5e1uIvOm2NPciW92D9SDSEnWfiHK9pr9Bbw6RdbcJJj0XXjS0EaNnhZJoJcFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WypENWiN; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkKZS1C7Kz2xSN
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 17:29:02 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782113338; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Y/W7rSUjnKgG0WzmclmvOeTXnTTDaaWYvYZ2/M3Zw3U=;
	b=WypENWiN+k6nInh1niAOO9OpRSl05Ybqxmd7HWFDLNWyl3gv4TvRjmkULuogk/G1xmphmd+VdTKdnUUmLnPx4eRJnCDLz+37mwp71U6ANNOdDWQcJgFpXc6zmC1wbhgSVEzx2SYOuKliz1++hjOzEizQXhESBGvFTm/ONFpBHj4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X5JQKay_1782113336;
Received: from 30.221.130.114(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5JQKay_1782113336 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 15:28:57 +0800
Message-ID: <1e4cb452-3066-4c61-a896-c2f814352ba7@linux.alibaba.com>
Date: Mon, 22 Jun 2026 15:28:55 +0800
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
Subject: Re: [PATCH 1/2] ublk: support ublk recovery
To: Chengyu <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: Chengyu Zhu <hudsonzhu@tencent.com>
References: <20260619041922.64521-1-hudson@cyzhu.com>
 <20260619041922.64521-2-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260619041922.64521-2-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3707-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hudson@cyzhu.com,m:linux-erofs@lists.ozlabs.org,m:hudsonzhu@tencent.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 066756AD3C3

Hi Chengyu,

On 2026/6/19 12:19, Chengyu wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Enable ublk user recovery so erofsmount can reattach a daemon to a
> recoverable ublk device after the previous userspace server exits.
> 
> Store the recovery source information in a ublk-specific runtime record,
> create ublk devices with user recovery enabled, and add the mount-side
> reattach path for existing recoverable ublk devices.
> 
> Also encode ublk IO uring command opcodes explicitly for non-legacy kernels,
> and initialize the control ring before querying whether a ublk device is
> recoverable.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>
> ---
>   lib/backends/ublk.c |  23 ++++++---
>   mount/main.c        | 115 ++++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 122 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/backends/ublk.c b/lib/backends/ublk.c
> index a8ecad9..49191de 100644
> --- a/lib/backends/ublk.c
> +++ b/lib/backends/ublk.c
> @@ -258,7 +258,16 @@ static unsigned int erofsublk_formalize_cmd_op(unsigned int op)
>   	DBG_BUGON(_IOC_DIR(op) != 0);
>   	DBG_BUGON(_IOC_SIZE(op) != 0);
>   
> -	if (op < ARRAY_SIZE(ctrl_cmd_op) && !erofs_ublk_use_legacy_cmds)
> +	if (erofs_ublk_use_legacy_cmds)
> +		return op;
> +
> +	/* IO opcodes live above the ctrl table and need explicit encoding */
> +	if (op == UBLK_IO_FETCH_REQ)
> +		return UBLK_U_IO_FETCH_REQ;
> +	if (op == UBLK_IO_COMMIT_AND_FETCH_REQ)
> +		return UBLK_U_IO_COMMIT_AND_FETCH_REQ;
> +
> +	if (op < ARRAY_SIZE(ctrl_cmd_op))
>   		return ctrl_cmd_op[op];
>   	return op;

	if (!erofs_ublk_use_legacy_cmds) {
		if (op == UBLK_IO_FETCH_REQ)
			return UBLK_U_IO_FETCH_REQ;
		if (op == UBLK_IO_COMMIT_AND_FETCH_REQ)
			return UBLK_U_IO_COMMIT_AND_FETCH_REQ;
		if (op < ARRAY_SIZE(ctrl_cmd_op))
			return ctrl_cmd_op[op];
	}
	return op;

?


>   }
> @@ -528,11 +537,6 @@ static inline unsigned int user_data_to_tag(u64 user_data)
>   	return user_data & 0xffff;
>   }

..

>   
> +static int ublk_dev_id_from_path(const char *path);

Can we avoid forward declaration?

> +
> +static int erofsmount_ublk_reattach(int dev_id)
> +{
> +	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
> +	char *recp;
> +	FILE *f;
> +	int err;
> +
> +	if (!erofs_ublk_is_recoverable(dev_id))
> +		return -EINVAL;
> +
> +	if (asprintf(&recp, EROFSMOUNT_UBLK_REC_FMT, dev_id) <= 0)
> +		return -ENOMEM;
> +
> +	f = fopen(recp, "r");
> +	if (!f) {
> +		err = -errno;
> +		free(recp);
> +		return err;
> +	}
> +
> +	err = erofsmount_open_recovery_source(&ctx, f);
> +	if (err) {
> +		free(recp);
> +		return err;
> +	}
> +
> +	if (fork() == 0) {
> +		err = erofs_ublk_recover_dev(dev_id, erofsmount_ublk_handler,
> +					     ctx.vd);
> +		if (err) {
> +			erofs_err("ublk recover dev %d failed: %s",
> +				  dev_id, strerror(-err));
> +			erofs_io_close(ctx.vd);
> +			exit(EXIT_FAILURE);
> +		}
> +		err = erofs_ublk_start(dev_id, -1);
> +		erofs_ublk_destroy(dev_id);
> +		erofs_io_close(ctx.vd);
> +		(void)unlink(recp);
> +		exit(err ? EXIT_FAILURE : EXIT_SUCCESS);
> +	}
> +
> +	erofs_io_close(ctx.vd);
> +	free(recp);
> +	return 0;
> +}
> +
>   static int erofsmount_reattach(const char *target)
>   {
>   	struct erofsmount_nbd_ctx ctx = { .vd = &ctx._vd };
> @@ -1450,6 +1528,10 @@ static int erofsmount_reattach(const char *target)
>   	if (err < 0)
>   		return -errno;
>   
> +	nbdnum = ublk_dev_id_from_path(target);
> +	if (S_ISBLK(st.st_mode) && nbdnum >= 0)
> +		return erofsmount_ublk_reattach(nbdnum);
> +
>   	if (!S_ISBLK(st.st_mode) || major(st.st_rdev) != EROFS_NBD_MAJOR)
>   		return -ENOTBLK;

	if (!S_ISBLK(st.st_mode))
		return -ENOTBLK;

	nbdnum = ublk_dev_id_from_path(target);
	if (nbdnum >= 0)
		return erofsmount_ublk_reattach(nbdnum);

	if (major(st.st_rdev) != EROFS_NBD_MAJOR)
		return -ENOTBLK;

?


Thanks,
Gao Xiang

