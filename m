Return-Path: <linux-erofs+bounces-2793-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDGpKUo7uWmKwAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2793-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 12:30:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EEA2A8BA3
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 12:30:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZqWW1DRhz2yjV;
	Tue, 17 Mar 2026 22:30:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773747015;
	cv=none; b=eSX6bjriZqEI841Sy9CwUt62hqZt0ZDwDAA5y0cxWnnEUmqBIGF++vgyrYYSIADjV8IeX3ZbamyqV8z9AXYwfBLCqljKsRIfO5SI0/qoz9eygwr0WW9d5f0W6P1zB9CDlOkrSBG2qtjtdUcpwuTdnSy4KPVBEdgESB17PmQ44lVs5JxvKMNmNjPVUcYKTIDzwGlVTAdH64gd5Lhe5DOIUurRrRG829rsErtRO8f3V5IYCe0jfEu91G2pu0+p/2WQL06+pYmPafGLoh6t+1hJ/NiidHmZRB9g0s3DnGug2wdRJD50HuFb9330mzYeFE2rsMlkPc55tWrEenhDg7G9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773747015; c=relaxed/relaxed;
	bh=d8SbDEpEgO4go5LhD2G/yFZRP0UVKYFTzzy4IOaWVXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWjFa3ne8RVipey/l/B/qZ9gSWdq+lZQgqstuCEVPy2qPN9nwRLpt3FdNoHI3oCGj/VaoWozA/v0JSNG+Hvi3c6fHunrEkuHxsiiluVOFmYUjGjExkxpIjD4JcA6uQexrSmjtP01vmNa5ZoqcXFV4hqnt0fn8hHtEns1X/nrk2QnGMjWG5+x0gbn0p1/ki5V40iERLPh4M8u6IJr4jZdbqnPcivVhTfGRCTJYbsLLHuZTTanlwgpFulm3WM+Olk/yVSvBBx892EJZsTP4sLTzAjyEoWLkzrqSX0DJWwU73erVgmPrjFqBgOFxqVlUPrdLk7H2Ylr0zaKquj1xxwnKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cFAPSS7D; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cFAPSS7D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZqWS4p6vz2yjN
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 22:30:11 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773747006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=d8SbDEpEgO4go5LhD2G/yFZRP0UVKYFTzzy4IOaWVXM=;
	b=cFAPSS7DYmN7E92Xfd3Ho+JL84piLjFI6QQhL8433H9vqjVaO+vI02m8Grp2jsZrkX3OktyrubFtnqyyPCsuqOFylrly0CKLD2mnxKUjCCIgmyIEa3QlvbdySymjHQvqv9iLhZ0jdTdRVsYO4qY6ffunuZbuAzkHczQI5X7xWos=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.Aps6M_1773747004;
Received: from 30.221.133.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.Aps6M_1773747004 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 19:30:05 +0800
Message-ID: <e8729997-91ca-4bf0-bb52-78eec7fc7f2f@linux.alibaba.com>
Date: Tue, 17 Mar 2026 19:30:04 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: validate h_shared_count in
 erofs_init_inode_xattrs()
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, yifan.yfzhao@gmail.com
References: <20260317111743.84988-1-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260317111743.84988-1-singhutkal015@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@gmail.com,m:yifanyfzhao@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-2793-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: B1EEA2A8BA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 19:17, Utkal Singh wrote:
> erofs_init_inode_xattrs() reads h_shared_count from the on-disk xattr
> ibody header and uses it to size a malloc and drive a loop that reads
> shared xattr IDs.  If h_shared_count exceeds the space available
> within xattr_isize, the loop reads past the intended ibody region
> and the malloc is oversized.
> 
> Validate that h_shared_count does not exceed the number of __le32
> entries that fit after the ibody header.  Return -EFSCORRUPTED with
> a diagnostic message on failure.
> 
> Reproducer:
>    mkdir testdir && echo hello > testdir/a.txt
>    setfattr -n user.test -v val testdir/a.txt
>    mkfs.erofs test.img testdir
>    # corrupt h_shared_count (offset = nid*32 + inode_size + 4) to 0xFF
>    # then: fsck.erofs --extract=/tmp/out --xattrs test_corrupted.img
>    # Without patch: silently processes invalid shared xattr IDs
>    # With patch: returns -EFSCORRUPTED
> 
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> ---
>   lib/xattr.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 565070a..5888602 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -1182,6 +1182,14 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
>   
>   	ih = it.kaddr;
>   	vi->xattr_shared_count = ih->h_shared_count;
> +	if (vi->xattr_shared_count >
> +	    (vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) /
> +	    sizeof(__le32)) {
> +		erofs_err("invalid h_shared_count %u in nid %llu",
> +			  vi->xattr_shared_count, vi->nid | 0ULL);
> +		erofs_put_metabuf(&it.buf);
> +		return -EFSCORRUPTED;
> +	}

Again, why not `vi->xattr_shared_count * sizeof(__le32) >
	vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)`?

Thanks,
Gao Xiang

