Return-Path: <linux-erofs+bounces-2393-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKfVHPzCnWmsRwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2393-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 16:25:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4A8188F73
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 16:25:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL1kv0lMfz3cPW;
	Wed, 25 Feb 2026 02:25:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771946743;
	cv=none; b=T0FtF01PS69RMEPyLLQXwyJ/hw788YYGhTlIzgjCih+TD0+Yuc4LgQ0g3zGbFi+EVnATknFp++jWG+gYz9YW9dF/icrVAwII5bAmye1Agfgzy1YpVf5YjwCAMOa7ZjpMKgr5605lNsuoFDOnNb8Q5BnR0R8x0JX64VXNnQ02w5tbdR/gliALSs7i+M6L9CFRI4VOk1TqVGJjaeymElyFcISNFpNSIstodilc+aswJetJ/EXADs8ynMGnDgJJyzXiANUdOJ0lihn4dr82K8K8hQSzZa1i4C2s4dKS9NO91hSWsit1Zf/umG6FwGTN73X8ARyarG8dyPYFyzKbbb/z5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771946743; c=relaxed/relaxed;
	bh=uIS76D+V7N2v27MsLdeeaiTZ3dFrNxsAXFbF4D//GeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JY73LJACUJmsHzy5g4Qn4YXZ3hziTvwcD7rIT1zh6I0FWqp/jMkf3tuHK8gLq/E/C8pFS8DMFkqbPDKQXcLhGnS8svLLSmiJtgUfnpF/KN1YK+1sk+xKFHnS0EdvSWBN0r1Drm6HmK55vsHsT2sUaxbofMHUQkT/d0obG8FXa9Zc8a4k1sWwd9xfWAOud228N04FFRBJJ/8NNj5N2+nCO8Nc/g/0lQVJh0Ft1cdZzQP3Pq3otXT58AQWW/+vX9z9eiRKPpTU56h/eSXJeVLXetd88CIY5p5KcsCuNP8kUugweNxXW/4LurkvaGmZw4M4+a4rGWGEErYjsrNMWnE10w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JtuSz8rk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JtuSz8rk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL1kr4Y6Rz3cND
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 02:25:38 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771946733; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uIS76D+V7N2v27MsLdeeaiTZ3dFrNxsAXFbF4D//GeI=;
	b=JtuSz8rkvX3tU+V7WWJEaPZCrO9UojryhiDmzE9ru5XzPZLh61MxQx9zVRqmZPW77Ihf5jPWItXxpXenWjqoqtnYoFBFUxAHA1rN9jWTqf/8MafkyRipbcmm4bgyPv49oIa+AXbWrJTF1KJK7IMf9mRBkDTomsmMHN4jQIaWvR4=
Received: from 30.42.59.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wzjmxk9_1771946731 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Feb 2026 23:25:32 +0800
Message-ID: <feb908c4-5e9c-4ba8-9818-6b6b66e9b4ff@linux.alibaba.com>
Date: Tue, 24 Feb 2026 23:25:31 +0800
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
Subject: Re: mkfs.erofs: should MAX_BLOCK_SIZE be tied to build host page
 size?
To: Matthew Lear <matthew.lear@raspberrypi.com>, linux-erofs@lists.ozlabs.org
References: <CAPrOGNDb=Y1yt_m=NgMSj01Np0yCDF2TYTV_dY_nV585=eX6aA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAPrOGNDb=Y1yt_m=NgMSj01Np0yCDF2TYTV_dY_nV585=eX6aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matthew.lear@raspberrypi.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2393-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6B4A8188F73
X-Rspamd-Action: no action

Hi Matthew,

On 2026/2/24 23:09, Matthew Lear wrote:
> Hi,
> I'm writing to ask if there is scope to change how mkfs.erofs handles
> its max block size ceiling.
> 
> MAX_BLOCK_SIZE currently defaults to the page size of the system where
> erofs-utils is built, not where it executes. This means a that compiled
> mkfs.erofs built on a 4K page host permanently inherits the build
> host's 4K block size limit, even when running on a system with a 16K
> page kernel (e.g. like our 2712 Raspberry Pi5 kernel):
> 
> $ getconf PAGE_SIZE
> 16384
> $ mkfs.erofs -b 16384 test.img /lib
> <E> erofs: invalid block size 16384
> 
> Passing MAX_BLOCK_SIZE=16384 at erofs-utils configure time results in a
> binary that successfully creates 16K block images, regardless of the
> page size of the host it's executing on. The restriction seems to be a
> build-time constant rather than something which has runtime
> justification.
> 
> Also, since modern kernels now support large block sizes (LBS) where
> block size > page size, this seems to add weight to removal of the
> inherited host page size cap.

Yes, but EROFS doesn't support LBS.. yet.

> 
> Without this, users on 16K page kernels are forced into the experimental
> sub-page compressed block path:
> 
> erofs: (device mmcblk0p4): EXPERIMENTAL EROFS subpage compressed block
> support in use. Use at your own risk!
> 
> If I build erofs-utils on a 4K host and use its mkfs for a 16K target,
> the binary rejects -b 16384. I need to configure with
> MAX_BLOCK_SIZE=16384 in order to use -b 16384 otherwise I'm forced to
> produce 4K-block images that trigger the experimental sub-page warning
> on the target device. This isn't a problem, but it does feel like the
> utility should decouple its validation logic from the host's
> page size.
> 
> The baked-in behaviour also affects official distribution packages,
> which may typically be built on 4K page size build farms. So this is
> possibly a wider issue for the 16K page size ecosystem.
> 
> Is there scope to increase the default block size ceiling of mkfs.erofs
> to 16K (or perhaps increase it to 16K for aarch64 compilations)?

I think the reasonable maximum block size for EROFS should be no
more than 64k.

I think we could consider set the MAX_BLOCK_SIZE to 64k for
aarch64, but leave it to the page size if `-b` is unspecified.

Would you mind submitting a patch for this (checking the target
arch, if aarch64, set MAX_BLOCK_SIZE to 64k instead) since I've
already had a bunch of other stuffs.

Thanks,
Gao Xiang

> 
> Cheers,
> -- Matt


