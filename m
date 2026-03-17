Return-Path: <linux-erofs+bounces-2796-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L0iGMFBuWnp9wEAu9opvQ
	(envelope-from <linux-erofs+bounces-2796-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 12:57:53 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263F2A95DD
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 12:57:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZr7K0Qlnz2yfP;
	Tue, 17 Mar 2026 22:57:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773748668;
	cv=none; b=I1aN+MxI3LNQkOhNBYtlWKsYE14j00l/45XxcUHb1ZUN7JgCk0DYtf/5hkFKtAhxx9zbcVnRmDg2sP3T0kOiwxhO0Sfg51u3SppuFD365M9nIJRNWeLtq2a+RGB/HSyWOyp2vm4eBsrfQ81fdaK1Lu7I2/zrDNXCdV9L5Cwj8HQ9W62Ll8swF7QV89CvM0SJc7zQNJXD3Vxe2ZvOHAYXnUUG4a1JOlvKiDvm+8fLBrN1H7vv5v/x/Y3ZEBB878RbZYjV9LgrGJ/grw5k63ijgKraOPiC/GaivtiAJCDnymgq6Ym7FCboeSyuFDvxA+FGqDCN6HMC1IKvGYXK7Jpj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773748668; c=relaxed/relaxed;
	bh=3BffAOUbcfKa/72hEWsCNqq+mJSj/ReN7Tx3Pt3phvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9G4MdLAZ1TjWB9+OmWKhAVPWPYjt9/vwExXZWYBjOIe4My4s+5jT7u+OI/3gXVQxC8mA6tLJngokozhHbp0+g4GXSK8csZlrDe1bJ9Ag9sdzNnwCpilrqFboUKZdNjJ2BwrSI8igWrOtd8PWcJD9sZYYrSJL4Ngm9mRHOQhM0fhOmcB1wJK7Q93HBJGfzgOB+MjecX8kYe0z2EEjt8ItKf1O/RYTOQLWw7OtrvgwxRxmiWU3scgx0oDP5suwfdQSosojJ/aXJgVo+4zDdkes/qJcqGq0guW7tavPAKPIxK31Wc1iZz+cmAk9Fau1MyxlRl2Ia4w0PW8HaNDVnhyMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NEmrGrPp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NEmrGrPp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZr7F6bYlz2ySq
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 22:57:43 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773748659; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3BffAOUbcfKa/72hEWsCNqq+mJSj/ReN7Tx3Pt3phvk=;
	b=NEmrGrPpAgLBCuS59p3SXjmDmaxwjGwI3DJcvkUmEpE5ygucrT0AA9KOoI+vNmnfh3XLVgsOISVb9wx5F0lgprAwL5EmiPKOtsm5g8RUrw2PpceFKExAQ430Plq1WOrLQpL+zQNv2pQdOyZBEfns2ZWNdIfo7Jhdg74VQP1bNLY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.B.QUv_1773748657;
Received: from 30.221.133.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.B.QUv_1773748657 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 19:57:37 +0800
Message-ID: <c4b2f0de-c3d3-44c9-992c-4a49c4b8b23e@linux.alibaba.com>
Date: Tue, 17 Mar 2026 19:57:36 +0800
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
Subject: Re: [PATCH v3] erofs-utils: lib: validate h_shared_count in
 erofs_init_inode_xattrs()
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, yifan.yfzhao@gmail.com
References: <PASTE-MESSAGE-ID-HERE>
 <20260317113021.88187-1-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260317113021.88187-1-singhutkal015@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@gmail.com,m:yifanyfzhao@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-2796-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 0263F2A95DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 19:30, Utkal Singh wrote:
> h_shared_count is read from the on-disk xattr ibody header and used
> to size a heap allocation and drive a loop reading shared xattr IDs.
> If the value is corrupted to exceed the space available in xattr_isize,
> the loop reads past the ibody region and the malloc is oversized.
> 
> This does not affect system stability but results in silently
> processing garbage data from corrupted images across all library
> consumers (dump.erofs, erofsfuse, rebuild).
> 
> Validate h_shared_count against the available ibody space.
> Return -EFSCORRUPTED on failure.
> 
> Reproducer:
>    mkdir testdir && echo hello > testdir/a.txt
>    setfattr -n user.test -v val testdir/a.txt
>    mkfs.erofs test.img testdir
>    # corrupt h_shared_count (offset = nid*32 + inode_size + 4) to 0xFF
>    # then: fsck.erofs --extract=/tmp/out --xattrs test_corrupted.img
>    # Without patch: silently processes invalid shared xattr IDs
>    # With patch: returns -EFSCORRUPTED

Let's try to rephrase the commit message a bit:

Subject: erofs-utils: lib: harden h_shared_count in erofs_init_inode_xattrs()

`u8 h_shared_count` indicates the shared xattr count of an inode. It is
read from the on-disk xattr ibody header, which should be corrupted if
the size of the shared xattr array exceeds the space available in
`xattr_isize`.

It does not cause harmful consequence (e.g. crashes), since the image is
already considered corrupted, it indeed results in the silent processing
of garbage metadata.

Let's harden it to report -EFSCORRUPTED earlier.

Reproducer:
   mkdir testdir && echo hello > testdir/a.txt
   setfattr -n user.test -v val testdir/a.txt
   mkfs.erofs test.img testdir
   # corrupt h_shared_count (offset = nid*32 + inode_size + 4) to 0xFF
   # then: fsck.erofs --extract=/tmp/out --xattrs test_corrupted.img
   # Without patch: silently processes invalid shared xattr IDs
   # With patch: returns -EFSCORRUPTED

Also are you interested in submitting a kernel patch as well? You need
to get the latest erofs -fixes branch, and port this one into the kernel.

If you don't have enough experience on this for now, I could help you
submit one immediately, and I will Cc you as well.

Thanks,
Gao Xiang

> 
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
> ---
>   lib/xattr.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 565070a..9d52a18 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -1182,6 +1182,13 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
>   
>   	ih = it.kaddr;
>   	vi->xattr_shared_count = ih->h_shared_count;
> +	if (vi->xattr_shared_count * sizeof(__le32) >
> +	    vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) {
> +		erofs_err("invalid h_shared_count %u in nid %llu",
> +			  vi->xattr_shared_count, vi->nid | 0ULL);
> +		erofs_put_metabuf(&it.buf);
> +		return -EFSCORRUPTED;
> +	}
>   	vi->xattr_shared_xattrs = malloc(vi->xattr_shared_count * sizeof(uint));
>   	if (!vi->xattr_shared_xattrs) {
>   		erofs_put_metabuf(&it.buf);


