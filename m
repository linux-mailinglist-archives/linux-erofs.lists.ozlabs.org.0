Return-Path: <linux-erofs+bounces-3356-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO9jFgqE6GkNLQIAu9opvQ
	(envelope-from <linux-erofs+bounces-3356-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Apr 2026 10:17:14 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5B443570
	for <lists+linux-erofs@lfdr.de>; Wed, 22 Apr 2026 10:17:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0sX60MXmz2yqs;
	Wed, 22 Apr 2026 18:17:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776845829;
	cv=none; b=Lhxp/9s/dm31CTXbwbgFoFw/e5cpxTFoLsT8oNaY3OQ6jMGNtHTEPLICoh/eRtjAYtyhiCmgJs0t9Bfk0+p1VAHSwsF1eF0Jltrm4NQoy/uA8PJnYlqNCG+2zPUj4OTFX7h0WRtzuO4UOQ/hM0l8rXiUGGzE86q//AaGQtXQZBnK8b9lsGEPcFn7V74s8t/Q5qT+18bXeCvNuIFhZuPGC3wtLQxU5y96puUut4wG57rpS4iKFMXS0+tZ8VAhK0D6pk6sAG0qbGWw031N7di7Ve/mbcTbMNKah4a7w1l6+81zPjSINWmM8+XFvwzLNF0b5j32734T9k3/5q1ZygMcVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776845829; c=relaxed/relaxed;
	bh=sAStO4AfbcXAUNshJlf/AW0N7xM44pGATmdN/1AKQaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHBf0GUS/q3O2y2f64fhK7W7ozsYMXVUMzx6yAEZHlOGeRZwnWEErNdO+2I8E03bO45knQiTAqf4AkrByu77QKZgIOkfyeqxTejvEr2Um4wRg6BHhD01T+TgFhapSLlKxckzcuUfhUYgLqvkFkaP8izNCgycTzkHQEH+/wQ3JcZGfo51ymrNL6MckCAdk0kQEdPUqr0lRCN7YgTjotr2NGl+d3yaiplmm7zbPEirMnUB4vyCzjSPUPXZYY6u0AXG9xTpsny5UZE/6wa4WN5tHpSrbfARm4TKT1LgEEkyx7U2STQxonOcBTlrXTTxtJ2/+zMzuTzoH95h1h2BB/9T0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OI01qilu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OI01qilu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0sX33ZKNz2yql
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Apr 2026 18:17:05 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776845821; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sAStO4AfbcXAUNshJlf/AW0N7xM44pGATmdN/1AKQaM=;
	b=OI01qiluwUAt5/dg9mEYINwSOjbJjc+gaULv8LR5OV6O9Repj92mdrXcxEmxActdX2Het2Ybi/D0MZ2b/SeobOsFa0Hf4KepYs2RBB+OG3T+FI5UnR/GYLA9iHEpnda2QHaCCEZdegMnSvibI0V8hkyF3Yco46HQw/SYh9UslYw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X1VbIYe_1776845819;
Received: from 30.221.129.120(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1VbIYe_1776845819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Apr 2026 16:16:59 +0800
Message-ID: <f419d932-03c2-411d-b771-1b9fabbe5153@linux.alibaba.com>
Date: Wed, 22 Apr 2026 16:16:58 +0800
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
Subject: Re: [PATCH v2] erofs-utils: mkfs: support set fingerprint for tar
 sort=none mode
To: Yuezhang Mo <Yuezhang.Mo@sony.com>, linux-erofs@lists.ozlabs.org
Cc: Friendy Su <friendy.su@sony.com>, Daniel Palmer <daniel.palmer@sony.com>
References: <20260422073705.1828301-2-Yuezhang.Mo@sony.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260422073705.1828301-2-Yuezhang.Mo@sony.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3356-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:Yuezhang.Mo@sony.com,m:linux-erofs@lists.ozlabs.org,m:friendy.su@sony.com,m:daniel.palmer@sony.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6DF5B443570
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/22 15:37, Yuezhang Mo wrote:
> If "--tar=f" and "--sort=none" are enabled, ->datasource will be set
> to "EROFS_INODE_DATA_SOURCE_NONE".
> 
> In erofs_mkfs_begin_nondirectory(), erofs_set_inode_fingerprint() is
> only be called if ->datasource is EROFS_INODE_DATA_SOURCE_LOCALPATH
> or EROFS_INODE_DATA_SOURCE_DISKBUF.
> 
> EROFS_INODE_DATA_SOURCE_NONE means that metadata is done and mkfs
> dump will change nothing, so use erofs_setxattr() to set fingerprint
> at settings ->datasource to EROFS_INODE_DATA_SOURCE_NONE.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>

Thanks, will apply.

Thanks,
Gao Xiang

