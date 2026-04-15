Return-Path: <linux-erofs+bounces-3308-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C0e9AbFC32nLRAAAu9opvQ
	(envelope-from <linux-erofs+bounces-3308-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 09:48:01 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 55092401884
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 09:47:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwYCb11GZz2yvL;
	Wed, 15 Apr 2026 17:47:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776239275;
	cv=none; b=NMNCZl+eppiI/6lVehdzdc3ajxtyCQrd33LgnFGQgL7/A0GsHO8Ri6PwrYpJ0gmDVgqLcQSkprc45zHscP7MXyymiV17GyrpZoyf5mQ+t3R0SH2LbRvjoh/oVjRNtpy26koVAT2tht6m0zTvv3x4Q7aUuQ8L2TPKWi05+B2hnbhoJ93h48lADaaMMbj9J+wQifcM+3Gfdo88n7zrRUcKzpy7R2kHlkzZuPWC+uZ4gxXQOk73xhjR5p0JbbvzxUEwzzZQp0uFqxZZprGKAG6B1/N4KBbe5TpQ0lcgJch4c6Psm0isyvCv3hbeDqb24OZjWBl1kd/WFowM010vADyWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776239275; c=relaxed/relaxed;
	bh=mqcFLVh0uZ3Bls1K6e7Ku75MvUv8IagPJc/SLA+nBnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOJYAJFtXk1iO+bBqsSpUOrLbx0iVSLAv7YjCpi8Y9RYMP+MWCJ0WviRksycqTxb8dyRSdt7XDEEeT9NntDdya02eANbLEcroqknDQpEBRnUAN9ayeJbmLEYVoFMPX799W3yseO3FpLwWmZA40szm9nP5pXdeZ+gccBsTScaDO4VS4nAXJ6uFTuI9XhVO76jrMWhcqEwPJwK8crZ3elRnjQtrdHSPXrM6crdDZsTAx+vtXICuEyf6qFFfpVrIj9JhOh/Ji5kJRIMn5Y8fc1js/us7mqaftrdz/DkckDRiNTj6TS1y+kB4cAp/iQJ1NE4+uy2YMbCVJgNDqk8e2p8UQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sPEaroRu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sPEaroRu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwYCX13xdz2yrM
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 17:47:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776239266; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mqcFLVh0uZ3Bls1K6e7Ku75MvUv8IagPJc/SLA+nBnU=;
	b=sPEaroRuxE3bpTdqPKBW+8GYB1kdW3W0nOUlfdfqKPSHEYZ6LDIpWQhoohgRkjOip85c2d6h9MmuWof3+IqIxJrLOB7K2TfYrghXySwrEUCK18h6x0w0zovQF5nxnaL3IbRaBWr3yfLWb+Mj8Hsgw+SLGe8MQgnr7TvwaNuszYA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X13t8vd_1776239263;
Received: from 30.221.132.134(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X13t8vd_1776239263 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Apr 2026 15:47:44 +0800
Message-ID: <cc8eda08-ba1d-4c0c-b4df-16ebc65dcbea@linux.alibaba.com>
Date: Wed, 15 Apr 2026 15:47:42 +0800
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
Subject: Re: [PATCH v3 3/4] erofs-utils: mfks: add rebuild FULLDATA for
 combined EROFS images
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>,
 Lucas Karpinski <lkarpinski@nvidia.com>, linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com
References: <20260414-merge-fs-v3-0-266bd1367fd2@nvidia.com>
 <20260414-merge-fs-v3-3-266bd1367fd2@nvidia.com>
 <3d420aa9-b123-4ba8-be3c-0b395dabb070@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3d420aa9-b123-4ba8-be3c-0b395dabb070@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3308-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:lkarpinski@nvidia.com,m:linux-erofs@lists.ozlabs.org,m:jcalmels@nvidia.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[performance.md:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 55092401884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/15 11:35, zhaoyifan (H) wrote:
> This patch incorrectly handles inline inode:
> 
> Reproduce in erofs-utils directory:
>      mkfs/mkfs.erofs 1.erofs man/
>      mkfs/mkfs.erofs 2.erofs docs/
>      mkfs/mkfs.erofs --clean=data merged.erofs 1.erofs 2.erofs
> 
> Then PERFORMANCE.md in merged.erofs contains incorrect data after offset 0x2000.
> 
> Fixed with following diff:
> 
> diff --git a/lib/inode.c b/lib/inode.c
>    index bd10e26..36dce56 100644
>    --- a/lib/inode.c
>    +++ b/lib/inode.c
>    @@ -683,6 +683,13 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
> 
>          /* read the tail-end data */
>          if (inode->idata_size) {
>    +             /*
>    +              * If inode->idata is already present, the caller has prepared
>    +              * the tail data and nothing more needs to be done here.
>    +              */
>    +             if (inode->idata)
>    +                     return 0;

Yes, it should be fixed as:
	/*
	 * Read the tail-end data if inode->idata is NULL; if the tail data
	 * has been prepared then nothing more needs to be done here.
	 */
	if (inode->idata_size && !inode->idata) {
	}

...

>> +#include "liberofs_cache.h"
> Unnecessary include `liberofs_cache.h`

That would be nice to be addressed too.


I've applied [PATCH 1 and 2], could you send v4 to address this?

Thanks,
Gao Xiang

