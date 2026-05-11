Return-Path: <linux-erofs+bounces-3391-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DmYCLZUAWpvVQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3391-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 06:01:58 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F4E507C60
	for <lists+linux-erofs@lfdr.de>; Mon, 11 May 2026 06:01:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDQyn2j8Zz2xQB;
	Mon, 11 May 2026 14:01:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778472113;
	cv=none; b=IowzkMDhy9SKc3Uc6b2iwQKGDnkoZoeimeGlBrcqhmcNEm879uZ+8Y3GzPq1eT3KXvntgUFP2gi2Kv+L2HdkHesJ6DCBpqdZnjuVNeWbXsRFkMg2yeqF+wWtwxoWTPBrpJvPTwq0r2niuR4hDeHefvHC3BxTCzeSa7a9xubi4b9nzGFY4mjRrCem4tFyQaGFXTNdGP6jH7yWS0CVR4nXZfpyLdi0TUmPLsHTjo2/Xf4wmW6aCWqM6Jxg4oBY05nZH66fK8QH4s7Ws87YYwvpYFE+BGcaeF+Q5EZf/bJqMMWDYaZYvPd9ii15ByhoN/3xFgDlg6K1LrIvPS7fW0edAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778472113; c=relaxed/relaxed;
	bh=rE+Q6UPWWQ1oC/sAQGNy8A9SUWlnTwUNv8DAOK0GVa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zttw+joz987fKrUAguD73VtvA408fj9BI6GUq2Lr4JHY+9IOvYInPAnHhT5C4idditLcam5JcVHT3x+eplpOpF8ZusxKUkvfdXHnRUb0Ep6GDyli+2Pf4JxWoBHJQqbslpSkwKKYs8kmr+vssC/NcosbkjwPESZHsGN0eS4WNSc5ZBfZzqUOtjV6z81NNzwjH+kL1c5EhjuIyeqB2XKzPPWIcUqcOdBC6pW6Lio9uoVt9a70T+Kbb8kVQlP+FKiawpw/dMUDm60jCpbzW35QzymX3+SKn2WIQNNiHI7G69DfWOQGMFTyqIb8cRcktTgYoud2+g3H5poTFbjF7O+2vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FGhWidfj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FGhWidfj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDQyl0GkPz2xHF
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 May 2026 14:01:48 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778472103; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rE+Q6UPWWQ1oC/sAQGNy8A9SUWlnTwUNv8DAOK0GVa8=;
	b=FGhWidfjVFHZV2HWuQgcCOXNb89NJm63Y/MEy/eLS9fzNDxQ/DNQ/n2ckrDFdaOb3RPtRKF2OxnGFoBmXz6SrcSCyX3TtnklYZzidrrKrPQrwZRnU6Fa5o+MnzBvE2gZvJkxudbBnUwPpC7zmrbwgykK+ZI9e/7v6Kz5O0p0QXI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X2e5vNy_1778472101;
Received: from 30.221.132.95(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X2e5vNy_1778472101 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 12:01:42 +0800
Message-ID: <e4701c42-1ed5-40a6-8f5d-927c40e3856b@linux.alibaba.com>
Date: Mon, 11 May 2026 12:01:41 +0800
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
Subject: Re: [PATCH] erofs-utils: mkfs: also handle last compacted 2B pack in
 z_erofs_drop_inline_pcluster
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, linux-erofs@lists.ozlabs.org
References: <1777449565-22154-1-git-send-email-zhiguo.niu@unisoc.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1777449565-22154-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 81F4E507C60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3391-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhiguo.niu@unisoc.com,m:niuzhiguo84@gmail.com,m:ke.wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,unisoc.com,lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unisoc.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

Hi Zhiguo,

On 2026/4/29 15:59, Zhiguo Niu wrote:
> With ztailpacking enabled, the current process assumes that a compacted_4b_end
> always exists in the compacted pack. However, in some specific files, the
> compacted pack may not have a compacted_4b_end. This leads to an incorrect
> modification of the last compacted_2B entry, resulting in incorrect modification
> of its clusterofs. In subsequent fsck operations, incorrect parameters will
> affect the decompression of the penultimate pcluster.
> 
> This patch determines whether the last entry of the current compacted pack
> belongs to compacted 2B or 4B and then updates the correct bits accordingly.
> 
> Fixes: a7c1f0575ef8 ("erofs-utils: lib: refine tailpcluster compression approach")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Sorry for late response.

I do think the issue is valid, but either the previous
solution or the proposed one is ugly.

I wonder if there exists a better way to fixup the last lcluster
type into plain instead: I've thought about for a while but without
any valid suggestion.

Thanks,
Gao Xiang

