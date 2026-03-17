Return-Path: <linux-erofs+bounces-2807-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBwdOFRzuWm8EgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2807-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 16:29:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9DF2AD0E3
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 16:29:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZwqP4G7tz2yh4;
	Wed, 18 Mar 2026 02:29:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773761361;
	cv=none; b=hZPUsljquXDox3ORCkY7m4lqIysjxGOs/LRaALb0EkRokbyvz/XVGcjZZFEYemsz8/NGx8LjHlDON5hkVFDcy6kkR7OLaP0uttzDmJ+bbAzvwfCRXEFqtt79pRTUO8Dw1IEba0QAUbocoBzeP3C5JRUfO/yES/n8S5Nod0fbhRddEP5YRV1dYd6jspmPF9CiFKVvCajuHXCFPYI6EBaDtC3oGsR8NEKU9ubnVSvU79VzOx4N35oAsb1F35Ka4M0qGZRzuHfv8Jv1ohP2a8bWAf3/32Z3tbJR+Mzw2OGZhL8o54ZeoKvgsPSRWIr8yiBxz2yGUxKIXl3w/mJT2wjd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773761361; c=relaxed/relaxed;
	bh=RzZEci4/CZBJSO+r5/JlimCbwBlpmsU6zqE3juQGk+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gfbW81TfxjgXxqzzKdgVdmKyRCUro65u6Zu0bSE2PF2o1lnWLraQ+KfBhPCkrsdOph/gwxaYkNvZWEV6qHgzTV/VF4UzkA3hxC2dqfixz2zwPp5rRmbDC6Zpfqq9DUzhDEIBvE8LEnb0Dg0EJ6PjAZLa4bzl3d2qIGkUG+pQQAxdsYn3WTAlQUIXnhbC9IkvR6jP/3rGq+79syHe0VBBiFN/9RbI1qQ5j+c8AhlhR1leJEY4lpyPrChVPBBBVv0LDo9Zp+Lid3IeFbgcuhVG7790qjHMu2zZHRLSbLAJHnztRmGnNULIYNzxfUpFEQRlWLfblS98gmt7u/4PRzheng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hRirBf31; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hRirBf31;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZwqN3ng2z2xVT
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 02:29:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773761356; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RzZEci4/CZBJSO+r5/JlimCbwBlpmsU6zqE3juQGk+g=;
	b=hRirBf311Fk/7RF74EIT9z8fYLGRbI7gFW45XVAIGeEWiwk+N2xbdWsnTDFY2kCsHexV2xTnBi/LfFq4zTjv++IYFNHLgopwUQ3YdieUo3ntjV1ByxW4uBtp13SuxqrstxXRKj6U47nqrrWi9Ct5EidnISrQbvXFbs9BaR1grgA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X.BSX3z_1773761354;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.BSX3z_1773761354 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 23:29:14 +0800
Message-ID: <194a4e01-1607-48ae-9925-e6128d5e3161@linux.alibaba.com>
Date: Tue, 17 Mar 2026 23:29:14 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: guard gzran zlib.h inclusion
To: Matthew Lear <matthew.lear@raspberrypi.com>, linux-erofs@lists.ozlabs.org
References: <CAPrOGNBjaSxMRnwpcear77Tk_6LnAhREA6aw-P1pAz4oMkdenA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAPrOGNBjaSxMRnwpcear77Tk_6LnAhREA6aw-P1pAz4oMkdenA@mail.gmail.com>
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
	FORGED_RECIPIENTS(0.00)[m:matthew.lear@raspberrypi.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-2807-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,raspberrypi.com:email]
X-Rspamd-Queue-Id: 0A9DF2AD0E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/17 20:24, Matthew Lear wrote:
> gzran.c unconditionally includes zlib.h which doesn't compile on
> systems without zlib.
> 
> Signed-off-by: Matthew Lear <matthew.lear@raspberrypi.com>

Thanks, applied.

Thanks,
Gao Xiang

