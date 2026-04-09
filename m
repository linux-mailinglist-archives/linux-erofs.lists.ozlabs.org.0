Return-Path: <linux-erofs+bounces-3229-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ0cH1Up12m8LAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3229-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 06:21:41 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485B3C62D8
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 06:21:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frmwD3Ldnz2ySj;
	Thu, 09 Apr 2026 14:21:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775708492;
	cv=none; b=k4E2WVng3KPsM7b9NJut+5D0CE6JigmNDcRxA9mO1ttwuRl8TbGrde6kH/XfvGnA8PB1BWVXwwNbzYkNaSf1xufg8M62mIdd+ZhN2jN6550W5VPi2lwYtoRRe5bXI5zhEm3LvrIUgA0KB4x1VBpQYv7VgTAHwIASnq3VFt69I1d/hCq8+xuGGyZNhghPDyVjcB9fimcZFZCAjr0pQ6NqWY/mKBPARrmL8T0ZOeeyECYuYvSCwekWsVjiLca6595CM335ymKJF6/xHKrcgRkv4W91aC7mA51fuI1WG85MbOICijQZePiCsMH93gx19RPyDprEBfRwUkXNGymUrBEVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775708492; c=relaxed/relaxed;
	bh=iYFxrxg3WGet7uBCXVni4vHwH2KhF1GUIxkl5syLsEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuTCoO4CR+tvghIvM2OtgKFEPAIkBqU/fusOcTSwlaJPtEyanYQSlFZZMU+6YPfVkGXlxThLF4dUMWRJUtjI5fPgE0RzM8v7lfyH4UP+sT9HggvgWxa69pcVhLiPnaXTSDcH00Y3MBhQ/Nt2oM+1X8KbE9GLGjjqdixCNkLTrFPavBzR9SRLhr/6IAZ1pCrgouhxoqng7yk+ldxRZnc/EegFgV4I+0es/6WLFSo2I3qF8N01Dfvl3Ie4nYSBqpEQoCyVe3qSJvjqJeoqlJWOyv44/ftNvVlhpFUp144VFsv3aJT0XWJRfNaM1HxsWsK6RKLjty+rbxM8dkG23NadbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pa5nco7K; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pa5nco7K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frmwC3YXsz2ySc
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 14:21:30 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775708487; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iYFxrxg3WGet7uBCXVni4vHwH2KhF1GUIxkl5syLsEc=;
	b=pa5nco7K87Bg3Lyr4TMZgX1Xj8B3LjocLy+ckyUUgIZ3X3O8lr8quXLk83eplkjGwspEs0ufxT/t5llnljA3/4HQg8kOyEpx+0aG1apV/hKHOyCgzbGYNrb5XAllO5VGfAAeB/j3R+Y66hJYFt9sxs30H0a7LFyEnpzQIhL53rc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X0h1EII_1775708485;
Received: from 30.221.132.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0h1EII_1775708485 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 12:21:25 +0800
Message-ID: <4e08f088-9020-43da-b62a-89981a4b7238@linux.alibaba.com>
Date: Thu, 9 Apr 2026 12:21:24 +0800
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
Subject: Re: [PATCH 2/2] erofs-utils: mount: add --worker-log for detached
 workers
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, zhukeqian1@huawei.com
References: <20260403064230.914563-1-zhaoyifan28@huawei.com>
 <20260403064230.914563-2-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260403064230.914563-2-zhaoyifan28@huawei.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3229-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:jingrui@huawei.com,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 9485B3C62D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/3 14:42, Yifan Zhao wrote:
> Detached NBD and fanotify workers currently redirect stdout and stderr
> to /dev/null after fork(), which makes their runtime logs invisible once
> mount.erofs returns.
> 
> Add a `--worker-log=PATH` option so detached workers can append logs to
> a caller-provided file for better observability.
> 
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   mount/main.c | 58 ++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 43 insertions(+), 15 deletions(-)
> 
> diff --git a/mount/main.c b/mount/main.c
> index 45ac32e..40175e3 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -75,6 +75,7 @@ static struct erofsmount_cfg {
>   	char *options;
>   	char *full_options;		/* used for erofsfuse */
>   	char *fstype;
> +	char *worker_log_path;
>   	long flags;
>   	enum erofs_backend_drv backend;
>   	enum erofsmount_mode mountmode;
> @@ -119,10 +120,10 @@ static int erofsmount_worker_set_signal(int signum, sighandler_t handler)
>   	return 0;
>   }
>   
> -static int erofsmount_worker_detach(void)
> +static int erofsmount_worker_detach(const char *log_path)

how qemu-nbd works? Does it use the same option `--worker-log`?

Thanks,
Gao Xiang

