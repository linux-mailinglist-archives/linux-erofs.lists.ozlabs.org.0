Return-Path: <linux-erofs+bounces-3711-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RppnHiT0OGotkgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3711-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 10:36:52 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D66ADCB1
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 10:36:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=tYuoYRRl;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3711-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3711-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkM4d2XVzz2yXj;
	Mon, 22 Jun 2026 18:36:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782117409;
	cv=none; b=jht1h20t5T+YiOub/6lp4iHTzd8Dct+hEZS5yBigRCmOZV8eskQEZFjxV1wRITaIGK2tmmcdMpv5wC7leaMkzK562ieT8woUkprN6CwnRT3XhB89+Pn/jmBmA/6eXXF1KR3KkNq3CYurKw9f2VsoT+3/fojXyspfnb7TePmdXzB6/Ov5AHEZBX8ugPbwIvwwXfqB/Nxvueu7HncNXnpIOW5VRuHZLLppqovW95cpX9uKXy7WhvYwce+Ljjbfxsi222B9Zokk8U9APcDRJavpYX9SD+6qDlqkrCT3JKGONScY89V6x914C5kmGL5mUBb6Ls6qQE/qAZJr3h5xl+bsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782117409; c=relaxed/relaxed;
	bh=7BH7itEF3mRjlqM+FpQ6A2AOLeIQy2CEWqh5t3jQ15k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaXyvtqYivWSOSt7295Xb0iFVCfYVfd/EKTyXUCt10JXAU4nSOVY32UJ6fSH7Fedin5GMX9AZ/4yXvfapSQPuciDdFkPVAulHYK8Cx5WFhOHJT/tL1kP1d/u8ZRQqVIyISK3dOBqDOgrbU9smrvY+PKp8ufaC/Wr9NdICCNoFdXyUp+t13hawmBX3SyOKgBISHrkw31nn9gdJED7MtUQijmtF/1SZ8tphbkhVE5rWGhA6k+3frIwrT4c7sF+2453uInRftVUz01fX6ilEGqeeBnjVQp0k4aa0PNezjTlob0PCp4GQEEjpTspNH/M9JPaB1xEA/ARXdeTp0LAHwnRRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tYuoYRRl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkM4Z2h8Pz2yVd
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 18:36:45 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782117400; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7BH7itEF3mRjlqM+FpQ6A2AOLeIQy2CEWqh5t3jQ15k=;
	b=tYuoYRRlS+5vIei6/972VRLGRyi51bTnOILEiAHLLnblMJlckqJ+U5WDFwgJxhoml98yhj/RvcrqjhX/hG0FNhSE1FHD4qUY3VNl3hk4SVpJ7nGpJoC529ZSMvzDAFW+wx4VCFiISAyZPQlVMTUao7X0jAh2Sj6d/kmX17X5nlY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5KMEH2_1782117398;
Received: from 30.221.130.114(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5KMEH2_1782117398 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 16:36:39 +0800
Message-ID: <c3f19333-780f-455a-8714-191d1b694a21@linux.alibaba.com>
Date: Mon, 22 Jun 2026 16:36:38 +0800
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
Subject: Re: [PATCH v2] erofs: handle 48-bit blocks_hi for compressed inodes
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <5cccd50c-cb18-4fb3-bce0-77bed389d00f@linux.alibaba.com>
 <20260622081136.2953243-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260622081136.2953243-1-zhanxusheng@xiaomi.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3711-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 851D66ADCB1



On 2026/6/22 16:11, Zhan Xusheng wrote:
> Combine i_nb.blocks_hi with i_u.blocks_lo when computing
> inode->i_blocks for compressed inodes, mirroring the startblk_hi
> handling for unencoded inodes a few lines above.  Also evaluate
> the shift in u64 to avoid truncation.
> 
> Fixes: efb2aef569b3 ("erofs: add encoded extent on-disk definition")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v2:
>   - Fix the Fixes: tag to efb2aef569b3 ("erofs: add encoded extent
>     on-disk definition"), the commit that introduced blocks_hi for
>     compressed inodes (Gao Xiang)
>   - Reorder to "blocks_lo | (blocks_hi << 32)" with explicit parentheses
>     and shorter lines (Gao Xiang)
> 
>   fs/erofs/inode.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index a188c570087a..dc0e3d6bb2b1 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -191,8 +191,9 @@ static int erofs_read_inode(struct inode *inode)
>   		err = -EFSCORRUPTED;
>   		goto err_out;
>   	} else {
> -		inode->i_blocks = le32_to_cpu(copied.i_u.blocks_lo) <<
> -				(sb->s_blocksize_bits - 9);
> +		inode->i_blocks = (le32_to_cpu(copied.i_u.blocks_lo) |
> +				   ((u64)le16_to_cpu(copied.i_nb.blocks_hi) << 32)) <<

I will change this line to
			((u64)le16_to_cpu(copied.i_nb.blocks_hi) << 32)) <<

to avoid overly long lines (since such alignment is not strictly necessary
but overly long lines should be avoided), otherwise it looks good to me,

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

