Return-Path: <linux-erofs+bounces-3709-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 83uRApfnOGqUjwcAu9opvQ
	(envelope-from <linux-erofs+bounces-3709-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 09:43:19 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E26AD55E
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 09:43:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="oMdA/fNE";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3709-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3709-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkKtp3k79z2yVZ;
	Mon, 22 Jun 2026 17:43:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782114194;
	cv=none; b=dFp1K/0t/tlbY2iRw4UPgUjxV9JYcrb+hBLuPoyNfIPaN6tahlop1iM8aYLj9gpFKO1L2XObAoFyTZVqJePYMzJ40oMULFeW3gder2l0TW+ohOmkvcaDTzSpz+PEE6EDVrYATkcvj7CutS/Jr/NsRBYPztnxqgwRZwTY/C2Co8U91XE/wfuaHbsRFgaX1A0e5vdIbCd+rVwCLUFuBv55sfy7/EA5rBYHs2SE/vKAGXT9juufmxYVhryp1ZLbm747FQ1+AFICyudVjuNz4nEIMkfKRN82vMziMywto3UHaet0L1Qvdat+0K8KTlg15nNkeqXMf6ECZmaEORy/KdGiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782114194; c=relaxed/relaxed;
	bh=J2fYnqjCDE8tBTCVScf641JKO8z0KyHfKnYhzc9QNPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4osbksT5D4XHY9xzSYUH/FUTZY2uRo4WU5KPOXd9in4LtnMgRAQX+EapPsw/eHjc8UrxQFxx6IRK4y37EYmB9NZYT0txuqQhhg9QIu3UqRFi25JqeqJXEklRBK7UYjB28fjyO89O/90q/7puaDDSyUiZDvM9kD06bYMZSntmdE5lUL0/273OwO2l+PO+GvZiWZf7ftMtp+d2eWMDPZetq9RV7ktPt6dAM16+q+sbpgOFIJ48aus2GgOSUH1bkJzr4oMlpqbkDoXdRcTlfK6EJBU/UYd295W0LQvJR7pDP0cAbWuegTLGKowympNGWsE76uVX/NStLtN3J6M4Ch2pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=oMdA/fNE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkKtm1snGz2xyh
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 17:43:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782114187; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=J2fYnqjCDE8tBTCVScf641JKO8z0KyHfKnYhzc9QNPs=;
	b=oMdA/fNEGLnToYpolFXcrPMJXRe8SNCcbLMSB5ZdFxLAWYiy5+6ttme96NoF3/cHXZ1MsyCL4K3F4/Q4NaijjbchsEWHAJdqLyFfiCnvKCh0f0EMxmpzbECj2ZC4FS75fudfpvQcxsKv6OuSDvpeUfm9iNKpOaW+tbUPobji/n8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5K7Vyu_1782114184;
Received: from 30.221.130.114(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5K7Vyu_1782114184 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 15:43:05 +0800
Message-ID: <5cccd50c-cb18-4fb3-bce0-77bed389d00f@linux.alibaba.com>
Date: Mon, 22 Jun 2026 15:43:04 +0800
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
Subject: Re: [PATCH] erofs: handle 48-bit blocks_hi for compressed inodes
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260622073410.2934415-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260622073410.2934415-1-zhanxusheng@xiaomi.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3709-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D1E26AD55E

Hi Xusheng,

On 2026/6/22 15:34, Zhan Xusheng wrote:
> Combine i_nb.blocks_hi with i_u.blocks_lo when computing
> inode->i_blocks for compressed inodes, mirroring the startblk_hi
> handling for unencoded inodes a few lines above.  Also evaluate
> the shift in u64 to avoid truncation.
> 
> Fixes: 2e1473d5195f ("erofs: implement 48-bit block addressing for unencoded inodes")

It's not the right fix, it should be efb2aef569b3 since
the pcluster layout only allows 32-bit addresssing for now.

> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>   fs/erofs/inode.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index a188c570087a..cf2f00e13cae 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -191,8 +191,9 @@ static int erofs_read_inode(struct inode *inode)
>   		err = -EFSCORRUPTED;
>   		goto err_out;
>   	} else {
> -		inode->i_blocks = le32_to_cpu(copied.i_u.blocks_lo) <<
> -				(sb->s_blocksize_bits - 9);
> +		inode->i_blocks = ((u64)le16_to_cpu(copied.i_nb.blocks_hi) << 32 |
> +				   le32_to_cpu(copied.i_u.blocks_lo)) <<
> +				  (sb->s_blocksize_bits - 9);

I hope it could be:
		inode->i_blocks = (le32_to_cpu(copied.i_u.blocks_lo) |
			((u64)le16_to_cpu(copied.i_nb.blocks_hi) << 32)) <<
				(sb->s_blocksize_bits - 9);

to explicitly use "()" and avoid overly long lines.

Thanks,
Gao Xiang

>   	}
>   
>   	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {


