Return-Path: <linux-erofs+bounces-3333-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UONOAADi5WnfowEAu9opvQ
	(envelope-from <linux-erofs+bounces-3333-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 10:21:20 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BFC428115
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Apr 2026 10:21:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzdjm116Jz2yqT;
	Mon, 20 Apr 2026 18:21:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776673276;
	cv=none; b=AetIDDu0bQLKOVAEP/PI5paahqan3yNz3Vt4YuEiEvtYbsACY86wquDpYDnw3fcwonbqKy8rec5quoQpx1KmrtQ/rjdsi6GYr9qe1IaxGGceHrknLU93ZglLLpFjITsdn6D1qs9H0HqSKvXvCMbs7eTD3LmkzHep2p+eJK1MJSzEkaf7+g4OJUog6UvWjbY7AupbtJvh40DOoPE+FSHj8UkooET5FEoAvMeRQoGy7CLG1WoGofN0ozmbzCekqfmMKOGgZcZmUWZNp4LVpiD1XyXDL21wXtz+zk/Cx7ra1j4vm92P9D4DuS9j7pp+wmfkLHINxlJGAHFi5qhkCmGTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776673276; c=relaxed/relaxed;
	bh=dG0iEpQkyBcPtKIdH71WBVSGudWH9LQTlowpsJ5NxD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmvLfbrXqexoDgv+SBkfcG84JELphMfSv1z94pjop8X9mFJ8BwGH/36m/rFIvpHZgrPx7YEj6hrEQ9pYpzPIBPS+uoKAG1xXC2vfjRqp7Xa17vBQTKOtiao/CG5DRXQnGR6XV22PauwyXBNCrPReMov011K4yi/uLRYbarbcvrNGwgEwaH4mK4tY0QXcthxHmeWIBaBtAjbAYnbvH6ZjNwbCys2QvdwCb85C0cbz5KciHU3g89hLcIyKIk/WaPSvB+5MnVQZbxGQZDvNhlsVEuOuZYVp/SOb5HKd+ENQ95T3gPOc2sHHfhyhA63fQeN04gBT/wZSA9csRjiciiLUlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CUnBOehr; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CUnBOehr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzdjj3B2Xz2ySf
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Apr 2026 18:21:10 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776673261; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dG0iEpQkyBcPtKIdH71WBVSGudWH9LQTlowpsJ5NxD4=;
	b=CUnBOehrM2eBYmpwrqM7hp4nHEJjAp9zmVtk3K8Z3i8BeDOjVx1YTxSPmppM1GHDF5mHzh36vL9Din3if6ZEZs2mJbuJbkX6Cm+fWsdkOA8zM8RJg+EZmtAPkcHrLJ+dSbmsdoJqpk2lKTkLpZ5if5qTZqh90LJs3b9oF5sGbJc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X1JCOZQ_1776673259;
Received: from 30.221.130.173(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1JCOZQ_1776673259 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Apr 2026 16:21:00 +0800
Message-ID: <3d2e0a50-abc7-4479-9437-d44066d891d5@linux.alibaba.com>
Date: Mon, 20 Apr 2026 16:20:59 +0800
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
Subject: Re: [PATCH experimental-tests] erofs-utils: tests: add test for
 rebuild fulldata
To: Lucas Karpinski <lkarpinski@nvidia.com>, linux-erofs@lists.ozlabs.org
Cc: jcalmels@nvidia.com
References: <20260417-b4-fulldata-test-v1-1-234654bdb930@nvidia.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260417-b4-fulldata-test-v1-1-234654bdb930@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3333-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lkarpinski@nvidia.com,m:linux-erofs@lists.ozlabs.org,m:jcalmels@nvidia.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 77BFC428115
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Lucas,

On 2026/4/18 04:06, Lucas Karpinski wrote:
> Add a regression test for building a self-contained image out of two other
> erofs images.
> 
> 1. Create img1 & img2 with various file types and sizes.
> 2. Rebuild a new self-contained image of img1 & img2.
> 3. Delete img1 & img2 to prove that this isn't use the blob based rebuild
>     path.
> 4. Mount the new self-contained image and compare the checksum to the
>     original folders.

Thanks for the patch. I wonder if it's possible to:
  1) Use a common dataset as the base layer (see other existing tests);
  2) Mount two overlayfs to get the incremental layers;
     - one to generate some artifacial dirs, files;
     - the other to change/delete some files, or delete dirs, new another
       dirs;
  3) Test typical metadata (whiteout, opaque), and data with:
     a) fsmerged erofs;
     b) overlayfs mount;
     fssum those two mounts.

Thanks,
Gao Xiang

