Return-Path: <linux-erofs+bounces-2945-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHx2APXxwGkUOwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2945-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 08:55:33 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 160062EDE94
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 08:55:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffQSx50ypz2yds;
	Mon, 23 Mar 2026 18:55:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774252529;
	cv=none; b=jQh5MTK2ZOn2fJfJvxV5tCvZOhN+9LeyQ5Df38YtckeufQkY1ep9NOOdkEtEqsdESvvNPkFmWlkqOKMJJEOFqoEcLoyBwfVAtTPNgpaNhToXkT6eDYeLEqg7nohiIfidtQlnpO0OSwChITVk7eVbb6PFJBJlkybISa3d00dRv+QhkTNGyHZgoNEzizlisIxW8bcFx3+zvN/oKndCFe/GPTbdR3GrWAlJXxuOqm9le0s/Dr0UquuJtJs3QEs6AWqMBIwGtFLeQ26F4vRDJ/Sq/bVxcG7ywdqkRf4Gwh/I1SOuw887PcEKgKIwDfMBc/KCppsjtQqP8BWvKoa6xICNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774252529; c=relaxed/relaxed;
	bh=Ln27PU6iTQhPj8tFQuQHGkfOiUwIVWgP9XLp448zqaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbpuKP80Nv0CzTTrOdQXiZnUpEBWjR4LeIP6vfWd0xN5dj8YPOvNeQtnTaLDsuqIcsKF0Bws2zjz8ma+qt2VQx6S9egQITvkN+P6pdj+9w7hjXgxL2rcGmoOGLx4YxkfTz7Bcw9z6T8PEDEz8bt5wrZDpeXRuIR2uDgONoUIQnuYBsMslQl+pp7+DOa1Tah0oFALJer8CR8liZaj+73TvwOyQo0G3VvjyO885mnZW9gRgCofU1L+DoV6oBH15iu/i24qltHzd4BztrQcih6LWRfHfUOc/M94ShhpGsURODk7/Te/qKvFwZD6lScH4sgWbf/k35BnF5uZdqLbVCxchA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z0guAxiK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z0guAxiK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffQSw3d4Cz2yYy
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Mar 2026 18:55:27 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774252523; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ln27PU6iTQhPj8tFQuQHGkfOiUwIVWgP9XLp448zqaw=;
	b=Z0guAxiKm/Xml7V/hUzsHtwVqZdIrcRfn5ZWGlriPfRcyX5pwUSeQnWp4JK9IYHMs4oJonShbQ2L60AfePKFv4MJ9UuxjDx69lXZOMK+0s0eeFqAXwaUXOMoYNU5gnJR/9ESy1KWKQH2NE1TcR+qHU6Wt+qTJ0tNplUyMfdoH3g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X.UhD8J_1774252520;
Received: from 30.221.131.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.UhD8J_1774252520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 15:55:21 +0800
Message-ID: <a53e8e57-c54e-4fdd-8738-7e423e6ca37b@linux.alibaba.com>
Date: Mon, 23 Mar 2026 15:55:19 +0800
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
Subject: Re: [PATCH 6.1 0/1] erofs: Fix the slab-out-of-bounds in
 drop_buffers()
To: Denis Arefev <arefev@swemel.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20260323074809.4542-1-arefev@swemel.ru>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260323074809.4542-1-arefev@swemel.ru>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2945-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:arefev@swemel.ru,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:xiang@kernel.org,m:chao@kernel.org,m:huyue2@coolpad.com,m:jefflexu@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 160062EDE94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Denis,

On 2026/3/23 15:48, Denis Arefev wrote:
> Syzbot reported that a KASAN slab-out-of-bounds bug was discovered in the drop_buffers()
> function [1].
> 
> The root cause is that erofs_raw_access_aops does not define .release_folio and
> .invalidate_folio. When using iomap-based operations, folio->private may contain
> iomap-specific data rather than buffer_heads. Without special handlers, the kernel
> may fall back to generic functions (e.g., drop_buffers), which incorrectly treat
> folio->private as a list of buffer_head structures, leading to incorrect memory
> interpretation and out-of-bounds access.
> 
> This can be fixed by explicitly setting .release_folio and .invalidate_folio to
> iomap_release_folio and iomap_invalidate_folio, respectively, but there is a
> commit ce529cc25b184e93397b94a8a322128fc0095cbb in upstream  that implicitly
> fixes this bug.

See my previous reply to the patch.

Thanks,
Gao Xiang

> 
> Please commit it to the stable branch v6.1.y .
> 
> [1] https://syzkaller.appspot.com/bug?id=c6aeabd0c4ad2466f63a274faf2a123103f8fbf7
> 
> Jingbo Xu (1):
>    erofs: enable large folios for iomap mode
> 
>   fs/erofs/data.c  | 2 ++
>   fs/erofs/inode.c | 2 ++
>   2 files changed, 4 insertions(+)
> 


