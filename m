Return-Path: <linux-erofs+bounces-1857-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B87D1D365
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jan 2026 09:46:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drfqX6pWWz2xPB;
	Wed, 14 Jan 2026 19:46:48 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768380408;
	cv=none; b=bqjIR9k9miBrut9tVCCiBXbBakBcw6oKkTEcCYps4QSUO/QWDrkq+zR2rjhxgTp7eHeJc1QpvHzah0HpFD6hHAaO3vB2pjDvXSiTiJMPfs4/pcWygekzhTI5qvxtCj8NSfbsH7mhW0DKIhqbqyKkAL6+iFH5pJkOp4Sqgqcg2I2kuaaXHY7WgWaMpdsZ/YaU+xD/RTTbOiMhHk0D+GL5RD2qBPULIGxWwH/Tz/t86cPMt+e+s8HxHRShVjA3Xwops2XLqbgJxyzdAp8eg/JlBYuLXtqW3VEXkeF2oRJbmRYddYrsQP80PP0a15kaKzYLuHCrR8H5ucafHdx9kyjnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768380408; c=relaxed/relaxed;
	bh=LDzmLVELuJxPR5htttnP3WjPPjgAPAVLDEPizy2L5gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofYd0bgLNXy3Y7bQRYw9YsP8gtnFMw8kObO+bYX3bIRzT68Y86DekbAkhKY983tYGZCq0Itud0tvZ9CIgJCX3412fOjEEnsiSGALztZxXiyB8XoojvwhNkXLeJRCzfH5WTFD1fgyAZzOVLm+1pJQjBhK5pkk+4B2HN29D3nU2H3nPVPpxFRUbLlVG2cudpDTsREEnn9xCQ3UeZiI6wOr0w+9rlspXup+J0eDtJEijGnbusnr7rxDlJSvMbUQaV+zLN9VDMFAMUtqI/bD8GQ16hao528WsbABPCcg3sWVQuhTXtBvXIhuqYz9yL4ab8kFbdX3cqFH9NTCuc9F0n55ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oZGBwZWa; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oZGBwZWa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drfqV3tPsz2xHP
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jan 2026 19:46:44 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768380399; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LDzmLVELuJxPR5htttnP3WjPPjgAPAVLDEPizy2L5gM=;
	b=oZGBwZWajtK5l6deY33f+M4dLWnxoH3VbPOsKuinO34IxBsHTG0jNsXpjsi3Exy9VwFf799vLi+YhcmY+2TqF1npVM09gjTFryW/exrzyQJtmcS9SAY51AHMlhdf3nDX4IO37sxID/VSONSGaRfLe81kVC28is5oeCxgFp4ctPg=
Received: from 30.221.131.219(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx1kpmi_1768380398 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 16:46:38 +0800
Message-ID: <6a32c587-c471-4d7a-8e88-3d381d484760@linux.alibaba.com>
Date: Wed, 14 Jan 2026 16:46:38 +0800
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
Subject: Re: [PATCH v3] erofs-utils: lib: correctly set {u,g}id in
 erofs_make_empty_root_inode()
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, wayne.ma@huawei.com
References: <8cda58e0-e917-4e9c-ae68-d34336deb446@linux.alibaba.com>
 <20260114083537.3645314-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260114083537.3645314-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/14 16:35, Yifan Zhao wrote:
> In rebuild mode, the {u,g}id of the root inode is currently defaulted
> to 0 and is not controlled by --force_{u,g}id. This behavior also causes
> the {u,g}id of intermediate dir inodes created by
> `erofs_rebuild_mkdir()` to be set to 0.
> 
> This patch fixes the behavior by explicitly setting permissions for the
> root inode:
> 
> - If --force-{u,g}id is not specified, it now defaults to the current
>     user's {u,g}id.
> - If --force-{u,g}id is specified, it correctly updates the ownership
>     for all files and directories.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>

Applied now.

