Return-Path: <linux-erofs+bounces-3179-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNsCEeERzmmnkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3179-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:51:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F8A384B92
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:51:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmXZ56ZJBz2ySk;
	Thu, 02 Apr 2026 17:51:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775112669;
	cv=none; b=Hg4YtKQrYyQ9uUtebiRoGFRr8QEU4XHQPACuxZ52KBpWbx1bN4j8ZzRurcTDcwG0i9uN6Xgmc/2MgoG6hF4RkIXW5hiRiBXfZeg08iF/JLXjtTwBhV6FlBHz4kHw5dK8oQRTKKpfSVHX+l5g3yj81Y0TAwLdTX5/bdShn7puXFg4CyYJSN2mPCZNA+ldJpWIBVV8NPalQOctDd1nvhCoLdnS2f/RzZNKR2eqiuNKwwVz2/A/GQTEmiIauDuqnSfAfyICczl4txVsfm92SepPP1bCjeU/C7oHvbT3SLeV5g/WCBz0kMcFJzrhYniSzqgsKxA47FhKS+348gGmn9ZKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775112669; c=relaxed/relaxed;
	bh=XPub3ttwgo1nF3b7aGMRD7d4QMa8fEtpxpmqHPa6yDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpRFk+Re3q/l2zn4LYcSJxkJlIoyVuxOyxGvBETfPyQuPqVfR9Tpf/Y+amgApTPZH5Aib4gMmdCVgX59r9+BR4UyDQOMd55pnuHfDooI0dgUETkUJ7vC5VcuSGvHZ8gmtFVn1+ujFQt2BL9frvWrB7M1DYHFkuGnoJgs/kzvNsz++RJxqamLijiPnCeYtWbRP/m40kQ1GvyEhOdPBKn7kZJ6AEoYyTM6Afao/jkV3w8+OUc/WUM+uFDFAILVVAUQ0ju9afnR0rFs0F3ViA+Vnx398pnrJkZ4eys8IvVdcEEvKoGhGRwNe8tGi1OWd+2ZVro8KW2R671qUum05FAB/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QW5miK0T; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QW5miK0T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmXZ23Fvmz2xln
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:51:05 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775112661; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XPub3ttwgo1nF3b7aGMRD7d4QMa8fEtpxpmqHPa6yDM=;
	b=QW5miK0TzjxKPWv6VY/3cmbqxXo4n0m/RW7PWAkSPWjVpylse6ujtdo3NIrlxkl1A0k5lzCHq6zx5+MC7/cI2+1nzWzccMAf3vF2AtGCocYsH5uBFS4jUjC8jWG0+KG/VEE0puJGsBXFuUOHAJohcgJEPxKDdfB+h2VwHBUHV7o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X0GCdqV_1775112660;
Received: from 30.221.132.8(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0GCdqV_1775112660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Apr 2026 14:51:01 +0800
Message-ID: <9ada4eca-3dfa-4f25-8ae4-04ece5d1acbb@linux.alibaba.com>
Date: Thu, 2 Apr 2026 14:50:59 +0800
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
Subject: =?UTF-8?Q?Re=3A_Request_for_Late_Proposal_Submission_=E2=80=93_Medi?=
 =?UTF-8?Q?cal_Emergency_During_Application_Period_=5B_ref=3A!00D1U013lbu=2E?=
 =?UTF-8?Q?!500Kd0300s0L=3Aref_=5D?=
To: GSoC Support <gsoc-support@google.com>
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "bushrahz.giki@gmail.com" <bushrahz.giki@gmail.com>
References: <CA+ug3icM1dnMfjtesxSFtM9yJWCxzfG6oyeur1KGPQ8384G-Qw@mail.gmail.com>
 <d_rMO000000000000000000000000000000000000000000000TCTM2J00loEVDwndQfigB8rc9Ozi4Q@sfdc.net>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d_rMO000000000000000000000000000000000000000000000TCTM2J00loEVDwndQfigB8rc9Ozi4Q@sfdc.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TAGGED_FROM(0.00)[bounces-3179-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gsoc-support@google.com,m:linux-erofs@lists.ozlabs.org,m:bushrahz.giki@gmail.com,m:bushrahzgiki@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[g.co:url]
X-Rspamd-Queue-Id: 62F8A384B92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Admins,

On 2026/4/1 23:08, GSoC Support wrote:
> Registration and proposal submissions for Google Summer of Code 2026 closed on March 31 at 18:00 UTC.
> 
> To maintain fairness for all participants, we do not grant extensions or exceptions for any reason. This includes:
> 
> Misinterpretations of the timeline
> Technical issues or submission errors
> Internet outages
> Any other reason
> 
> As stated in our guidelines, it is the applicant's responsibility to submit well in advance of the deadline.
> 
> While the window for this year has closed, we encourage you to:
> 
> Review the Contributor Guide at g.co/gsoc: Specifically the "Choosing an Organization" section.
> Stay Connected: Engage with organizations independently to prepare for future applications.
> 
> Note: Due to our team's small size, we cannot respond to further inquiries regarding missed deadlines. We hope to see your application in a future cycle!

Thanks for the reply!

Yeah, we already have enough applications, and we don't
consider (or have any bandwidth to consider) any late
application as well.

Thanks,
Gao Xiang


> 
> Best,
> 
> GSoC Admins

