Return-Path: <linux-erofs+bounces-3151-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAJyHdy8zGliWQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3151-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 08:36:12 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73637542B
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 08:36:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flwHF0Cvhz2ySY;
	Wed, 01 Apr 2026 17:36:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775025368;
	cv=none; b=esswR0UQD/434L8FP9NfJYIWIB7TBBtFjKW698yqjtpn9jJQ9TIAQnBuLLESbXJIzXoGkKz0e2+75suSQxnCBArk0LkiWxRYR4K7eQXtrnPd7khs+ewYz/TCC0u+zoYKaMp69OMfnUkiqbXdS/OKC1syHDdQHU6y/iZuN8YFgNvF6xddj6zkB6mebKoPufWNSQWoVDMThIBCBHnB2t7Q+8j9eNbmxMl684ZpVhtixELcflArZ0o2h97m6maGEdrPe3/uoeB0xEuXhYFPh9+WWNQDsVuzoMYm8IMIF3XWKhskBv1wczJccKZc17SWwnfObIcGrxcXEVJXQcjvD6a4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775025368; c=relaxed/relaxed;
	bh=F4Kbel5TllgyJsqP32ubgPCtgCl4AdK/hMxmN7OxCJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cd6hIYbwigY2EgFlfQ5qot9mJvD5EVbuUcKTJrHiFRl0ZFYEX0S5TmBQTmHxQNWd0QC1/ICzQ6LM8mGi5yPnFaTOUUsSrquWcb1PI4DzoKOV9w7RgZrv8uH91m6rEE1TTomyemeFyErDHYVXZZjhXqOAk54WD5wwYJJok5sPZdiCMnYwzofEI0b9lAjHKskigXp1B+gQV9qCCdpZNwg0SK2OXB1zX4TigMmp3kxwcDwWpYEmvj+0ShhWWHqL32CmST++mLTAaJBDCxyymsrV/ypxnZg1rWlZXgUv7C2WdL6oE9KvFoIN/H2JoMk3ckgyEdOLWC+GzgHaFO/a6mIynQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tWjp8+Dd; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tWjp8+Dd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flwH64C1kz2xb3
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 17:36:00 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775025356; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F4Kbel5TllgyJsqP32ubgPCtgCl4AdK/hMxmN7OxCJY=;
	b=tWjp8+DdlFR0Wp/JMLBe7ezvHXJQFCEIhfsjfAjbNpSDU8KDYiWzKRRPmUrxQM+iuukqDeZDzL+XAhmnmAJ2n3TDmaKGDedX6z5oKQHNkYG1CEl9D9m7jGT00hw73EPDOLgpYw0C8H7yyxb/N3YtqrojZWxwl+/1oA5IIYdO5yM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X08JxhR_1775025354;
Received: from 30.221.131.203(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X08JxhR_1775025354 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 01 Apr 2026 14:35:55 +0800
Message-ID: <58d926d8-c34a-451d-a19f-8176e3726495@linux.alibaba.com>
Date: Wed, 1 Apr 2026 14:35:54 +0800
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
Subject: Re: [PATCH] erofs: include the trailing NUL in FS_IOC_GETFSLABEL
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260401061342.40166-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260401061342.40166-1-zhanxusheng@xiaomi.com>
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
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3151-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,xiaomi.com:email,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 9E73637542B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/1 14:13, Zhan Xusheng wrote:
> erofs_ioctl_get_volume_label() passes strlen(sbi->volume_name) as
> the length to copy_to_user(), which copies the label string without
> the trailing NUL byte.  Since FS_IOC_GETFSLABEL callers expect a
> NUL-terminated string in the FSLABEL_MAX-sized buffer and may not
> pre-zero the buffer, this can cause userspace to read past the label
> into uninitialised stack memory.
> 
> Fix this by using strlen() + 1 to include the NUL terminator,
> consistent with how ext4 and xfs implement FS_IOC_GETFSLABEL.
> 
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Thanks,

Fixes: 1cf12c717741 ("erofs: Add support for FS_IOC_GETFSLABEL")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

