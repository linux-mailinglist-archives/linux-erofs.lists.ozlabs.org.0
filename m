Return-Path: <linux-erofs+bounces-2395-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IbTMDLNnWnfSAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2395-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 17:09:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A61898FD
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 17:09:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL2jC0S8wz3cSV;
	Wed, 25 Feb 2026 03:09:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771949359;
	cv=none; b=UmVNk4GtXcA/n9UaYciat9YGLlQlnUobWVfO6CCZc+oI7T+dFYZe4dZjawPDYy3WVbCj8kLALUPNWmpdMzO/IF/LiPFXpQmhMbPC5LKZZjeRWTChPfBplfYRd+JfNEeEsDi9kLg9SHSP0zG9V+LB85m7S8Q4JLNFmwHtNSnRDfDNiIhb8A6fR1Gc3bTlWTATUdSMrCIsqs2xJAzzy5hh9tKNw1OJuemdOWE13zq0Qyysa9p7+QN7UrN5E2VDyv/81rrYEcXCMzbcnwX0UC6kxAG7W9MrchAzEotBtjO2Um5ELcMukHvySLkwD8HMBqbAVe28Fpdh+Ie06jmu/+6z5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771949359; c=relaxed/relaxed;
	bh=qvmuiZWqc480c4SIt9LAjbeBJkTuEj7NyoK2BuwBftw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gqOR7jk7n1p7fuS9o17qiohnyamEJLgK8ZKKdRBqSbbMjNviMjZyln7pdvSLbkTeu9Ved4bV/Y/Z4wBcNmUVr+aBh6FKtxomYlrshMVbQRz0u9A6hTSkb0X7xkmPQuc+wWWxbiV5n3lJUJg1y04KmE1onBzApJxQggFCUD+/tbgrs515CMR8y18hugU4vnhfIcn/oPMn3AbcFSJ5uaeZvA+QXd6iboc0guvh4w8FnJAHIe6Bb8pESodx2ncXo1GdbMVb4/YX5g6KW4pdBYOrTUZd970V4U1LGRE4bImrEEUkb8CdFST7t+BrV5xev9R1UiA2SKwEP0TgsjrzX2lIMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e3Y3a1ql; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=e3Y3a1ql;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL2j75l6dz3cR1
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 03:09:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771949350; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qvmuiZWqc480c4SIt9LAjbeBJkTuEj7NyoK2BuwBftw=;
	b=e3Y3a1qlWT92b9fvw9n/5bNt1lokPxOekXYJ/fB/q/NrM/whJXlsHZa3VinBxudaRaddGL8UU6dzBPbMeLJwFHrp5N5lr4lHndqPoaLzgvgz3Em/KpLSG4G0xBd385rBnfu4ejD9iF+Y+LWgRUaFNPsUzIPslkcvXUPdyi+VPKM=
Received: from 30.42.59.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzjqkQT_1771949348 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 00:09:08 +0800
Message-ID: <450ee7cb-8c30-420f-a7f0-c29238e2ae90@linux.alibaba.com>
Date: Wed, 25 Feb 2026 00:09:07 +0800
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
 <feb908c4-5e9c-4ba8-9818-6b6b66e9b4ff@linux.alibaba.com>
 <CAPrOGNDnCBYdUjOiXBiVKSmLcPW_jxZbHXLdgMgj-T6LnXo0ig@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAPrOGNDnCBYdUjOiXBiVKSmLcPW_jxZbHXLdgMgj-T6LnXo0ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matthew.lear@raspberrypi.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2395-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: AB1A61898FD
X-Rspamd-Action: no action



On 2026/2/25 00:02, Matthew Lear wrote:
> Hi Gao Xiang,
> 
> Thank you for the quick reply.
> 
>>> Is there scope to increase the default block size ceiling of mkfs.erofs
>>> to 16K (or perhaps increase it to 16K for aarch64 compilations)?
>>
>> I think the reasonable maximum block size for EROFS should be no
>> more than 64k.
>>
>> I think we could consider set the MAX_BLOCK_SIZE to 64k for
>> aarch64, but leave it to the page size if `-b` is unspecified.
>>
>> Would you mind submitting a patch for this (checking the target
>> arch, if aarch64, set MAX_BLOCK_SIZE to 64k instead) since I've
>> already had a bunch of other stuffs.
> 
> A change in configure.ac to do this looks straight-forward enough (I
> think), but there may be justified concerns about the knock-on effects,
> particularly as MAX_BLOCK_SIZE is used in various arrays. With 16K (4x
> today), these would all increase quite a bit:
> 
> lib/liberofs_cache.h:  struct list_head watermeter[META +
> 1][2][EROFS_MAX_BLOCK_SIZE];
> lib/namei.c:           char buf[EROFS_MAX_BLOCK_SIZE];
> lib/dir.c:             char buf[EROFS_MAX_BLOCK_SIZE];
> lib/data.c:            u8 buf[EROFS_MAX_BLOCK_SIZE];
> lib/super.c:           u8 data[EROFS_MAX_BLOCK_SIZE];
> 
> With 64K, the memory footprint would be significantly larger.
> What do you think?

I understand your concern although I think they are just
for temporary use, and 64k is still not too huge and
the userspace stack is less worried.

Or how about just use max(PAGE_SIZE, 16k) instead for
aarch64? then you will get 16k for most of the time
unless PAGE_SIZE > 16k.

Thanks,
Gao Xiang

> --  Matt


