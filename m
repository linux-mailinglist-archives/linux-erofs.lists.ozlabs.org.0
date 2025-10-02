Return-Path: <linux-erofs+bounces-1153-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDCEBB2238
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Oct 2025 02:21:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccXXr66Ymz2ywC;
	Thu,  2 Oct 2025 10:21:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759364508;
	cv=none; b=lTAuBnrc9JvjnO3ou2JCz0emyrlwqgfcVzff/p9WlKdMZpRAkeJP8ZXYTwU1PZimJEWLj4JvS0UtwdVMlzN54FO4xPoxbfmBCPzOqPCjHkdEYOrHgHuB8VIdXB8MNQc3vieU8CPP28gSj1HsTJ/n+UCm8xmJ9abi2Cp79jc+KkJIQs39ihq2u+KR3Shq/T3ej8JSYEPzq7Z9997O35V5K3X/BkZpGM0ceglAOL2iIJB7jCEBs9immFJMaQF7E1K5s6NLKsF9Ns0FohT3cGZr4vURMZhan1iDCINDzyZjLGqXeD6u8ElcertAhMyi32u2vkVZRyqotzTSDhfPumHSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759364508; c=relaxed/relaxed;
	bh=qDa8fxLJsd7z4h6GWAOG27xrw8volJxkihmW5WpoFww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYvn6G2ntN6bBfbLj+Yp5y4UrR5KtLzjz49Ob9yvRFVGVqJsGen55+YooqVGS7H1d0clDdPiCjkzrZ9r2Brt9O4SGzn32nrmDvtRrhiRWfzxgULMdFbVQ5M/6qU41LWbu9/LGH7mC3InvvRiP2TCVDHwy3s0tpvyR8pAERYfjro7mEhaYVcYnkCZaJLETiWX9mp/AgZvT6xWNrlceIQPMo3kyS4EZ4kqma8gBQgwkY4N5QUrfrmZhSpCRDq8qztubP1RQX1CyYIQV+8gYI/RpJ3Q+4eoQdKdL9G3dkd2AqAuU39U5P5Syt9tmzboeuCBxMNVovmfpSvCtbBfThImVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sMAk1zJz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sMAk1zJz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccXXq0stHz2yN1
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Oct 2025 10:21:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759364501; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qDa8fxLJsd7z4h6GWAOG27xrw8volJxkihmW5WpoFww=;
	b=sMAk1zJzQZiKt3CQDJNMNuukN8e1BAjl6SF8yIN/r7DEOEIneyJ1Z9p1edN49KVJdh5r0J1l2iBI5DEWz8C7GIUU5BXDgo7my7awL3E7XRRlvhnL2bKGeo4VGijdmN+WjI61gTNMUxyK4yPgGBSJDHQ4D06Jh7XeDlQ9fyA43Vw=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpGDzFt_1759364499 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Oct 2025 08:21:40 +0800
Message-ID: <47cc49b9-e800-4f9f-91b9-fc78c4c1e77d@linux.alibaba.com>
Date: Thu, 2 Oct 2025 08:21:38 +0800
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
Subject: Re: z_erofs_extent.plen == 0x2000000 can lead to crash
To: rtm@csail.mit.edu, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
References: <75022.1759355830@localhost>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <75022.1759355830@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Robert,

On 2025/10/2 05:57, rtm@csail.mit.edu wrote:
> Here's a corrupt erofs image that can cause a crash:
> 
> # wget http://www.rtmrtm.org/rtm/erofs4a.img
> # mount -t erofs -o loop erofs4a.img /mnt
> # cat < /mnt/d/y > /dev/null
>   kernel BUG at block/blk-mq.c:1152!
>   Oops: invalid opcode: 0000 [#1] SMP PTI
>   CPU: 11 UID: 0 PID: 1315 Comm: cat Not tainted 6.17.0-01737-g50c19e20ed2e #29 PREEMPT(voluntary)
>   Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
>   RIP: 0010:blk_mq_end_request+0x28/0x30
> 
> The problem is that the inner "do" loop of z_erofs_submit_queue() runs
> without bound submitting read requests, because bvec.bv_len is zero.
> The reason for the zero is that the broken filesystem image contains
> an z_erofs_extent.plen of 0x2000000. This looks non-zero to the
> 
>          } else if (map->m_plen) {
> 
> in z_erofs_map_blocks_ext(), but then the code does
> 
>                          map->m_plen &= Z_EROFS_EXTENT_PLEN_MASK;
> 
> causing m_plen to be zero.

Thanks for the report, I will fix.

Thanks,
Gao Xiang

> 
> If CONFIG_EROFS_FS_DEBUG, the problem is caught by
> z_erofs_submit_queue()'s
> 
>                                  DBG_BUGON(bvec.bv_len < sb->s_blocksize);
> 
> Robert Morris
> rtm@mit.edu
> 


