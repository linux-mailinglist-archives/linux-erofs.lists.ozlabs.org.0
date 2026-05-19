Return-Path: <linux-erofs+bounces-3453-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMHSG6IfDGqoWgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3453-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 10:30:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBBA57A108
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 10:30:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKSXt6j9nz2xwH;
	Tue, 19 May 2026 18:30:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779179422;
	cv=none; b=o3CwpsG8T31wPg6LedYlt9q0UBJ+5QuJq7GNNt89fRiucFOdHSt8pNKirtsNn3iyvterTX7dKMxzZqqKKFBMNyzJ/RJ0ECF0IVO1GM+7O+MtodicjM7GGkKb0tzVn7i2JrUzZNjt6wO2iDe1+wfFEHTXPdh7srII4FJWT5arMg+Il4VA86upEzFkLPgjLy1YcIaESyGNO933tQBwStwHyMkO6p/2QjIphaau5OGzx3cHC9MWf+FCOha0EINMyhAEWgpUd0uBQ7UZQvewH/xUZHrToHgU0En0SeHc7Ywe+2hczlkx6Bv7wMWvW7nBvBrkNw1Si/F8Ag+4N2yKdLKPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779179422; c=relaxed/relaxed;
	bh=xiG0p/ZAMAiKRXd3nedvcuYqErL/geueHTwHjY9wIzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRQg1ZO25/iFFlr48hX2IAp8+e1cOVSMJgCbKs4r7smTdP/AT6Kk2TaV72fJIrnl+Irq2PwcmD6yPSDzGGUgmMOAkmi8xh0Lr9yXW3KSxDR+9G0jUQYWQpwNY6ibvj4sxqc9r9LQD1/5EMvhxwowrjve5wCpW/loXPnxtOiy8mNh98lpecFKeu8AeDusph348eIj7EG3TZyZeNQ3X3EmKqiMehVdBoto04vwpdmc+tU7Pe+A5bc7AWHxadBPoapDkV9go3BYd+QFK2oUgRefmMgpmf323zQJ9lBejwmnaiRTHnF8G/DmHaACQaupkTn5WsCkS6GZ93OG+yQKcUqf7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pgpbSWSi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pgpbSWSi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKSXr6Y5Rz2xqv
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 18:30:20 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779179415; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xiG0p/ZAMAiKRXd3nedvcuYqErL/geueHTwHjY9wIzA=;
	b=pgpbSWSiajME2vPZ50IX7XAgx5s7PX4UokPMwZmYStcnQS5QEfHWU8q/kijh1zA5hi6fqeqfqozESAXzN0GWP5Y2308YZYaCS3orfJrNDhk60047nqOhCxhnAfRqF6yd61vI690aZG8SvyXepEwsmGvgksgjoJs3kSsEaEaZYX0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X3Ex0o6_1779179413;
Received: from 30.221.134.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X3Ex0o6_1779179413 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 19 May 2026 16:30:13 +0800
Message-ID: <aa5cbd3f-9df8-49de-a9b1-d1cf68d7d12a@linux.alibaba.com>
Date: Tue, 19 May 2026 16:30:12 +0800
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
Subject: Re: [PATCH v2] erofs-utils: mkfs: fix to handle last compacted_2B
 pack in z_erofs_drop_inline_pcluster
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, linux-erofs@lists.ozlabs.org
References: <1779173589-18216-1-git-send-email-zhiguo.niu@unisoc.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1779173589-18216-1-git-send-email-zhiguo.niu@unisoc.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3453-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhiguo.niu@unisoc.com,m:niuzhiguo84@gmail.com,m:ke.wang@unisoc.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,unisoc.com,lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,alibaba.com:email,unisoc.com:email]
X-Rspamd-Queue-Id: 6BBBA57A108
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/19 14:53, Zhiguo Niu wrote:
> With ztailpacking enabled, the current process assumes that a compacted_4b_end
> always exists in the compacted pack. However, in some specific files, the
> compacted pack may not have a compacted_4b_end. This leads to an incorrect
> modification of the last compacted_2B entry, resulting in incorrect modification
> of its clusterofs. In subsequent fsck operations, incorrect parameters will
> affect the decompression of the penultimate pcluster.
> 
> This patch also handle the last compacted_2B pack correctly.
> 
> Fixes: a7c1f0575ef8 ("erofs-utils: lib: refine tailpcluster compression approach")
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Applied to -experiemntal with some very minor updates..

Thanks,
Gao Xiang

