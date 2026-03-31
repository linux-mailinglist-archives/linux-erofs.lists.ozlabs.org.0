Return-Path: <linux-erofs+bounces-3139-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JZKLXdby2lJGwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3139-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 07:28:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A03723641D4
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 07:28:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flGqR4v9kz2ybQ;
	Tue, 31 Mar 2026 16:28:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774934899;
	cv=none; b=k++xM/20NW72i115xvZHdgs65SoqMxpKJSzKYhRZHlL/uEiZXfrBL0P22qk6REGd6Iyw6fXXtLsyLOhFFPMA1vTXvqHWVx5hi7PbeGAgdjcWPL/gAGr5b8MjCeGx2uQqRU21Fw2kfYb+M0NsXh6hESG+/X6bg46v5fIYBHOnBlQU/mN9/brs5nkYgUqCzw9KwD79qm7eVnDh2XouA94QUz4CVZRyqty8a3+QNw8bFVKfNaabK/Rehwbiafo7SwFUo8hBAKmIkWrUiS3IHUpbztH9Y1O8rxzBAHVvQOKSmQaGMvnJCWGr2/IbSXh4RlQ783oncuOHThsHwvyfY+67ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774934899; c=relaxed/relaxed;
	bh=ogj23MIlXy9IMvVJnKL5M0xMJOYH8/jMO86tAlwXGGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPDUk1Wb+ji2iYDmti9tPtOo6c5V/vkuJxwLPw2UrgbBg0UUkkEkHvnqXw/da4i5PCHqYBvEsGmF8XmkVjgKo3yW+kJW3M6j6cI4/Yt+HErmTBbi7+QaqRqTbiSxv9Itydio7wB7FqyXGZoedr0uFJ6K5GJk9+oIWZJFxFJUKr543VTj+mNu/dhdpkOvTcgsvfWabgdpKeU0d6+vLsutWkVSUxlp9zKctVv1dRZcIuseSNGSlHs2/TNYotTcHbYAu00azQNPVEkXVC6JJYHcnOWDAxd9YGwSSaE9V+MJLVjZGAyqo+IGUmDOGcEcpE96G0rGLmPZktexUljNwwqXbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EpsmJe6H; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EpsmJe6H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flGqN6RC2z2xlK
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 16:28:15 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774934890; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ogj23MIlXy9IMvVJnKL5M0xMJOYH8/jMO86tAlwXGGw=;
	b=EpsmJe6H1IEzvsaZrX5U4PdvDvmJEj0dUqjoBlOXZ7QJnB9xOD4XC3faohQ6cibNkvWO7wQU0b/k6wVNEfg4pCjyKaX1uHBsE9pgGvRMObUYNi2Nn18Rxo1l92iqKdZc0YHXbfx0LuAT2Pv1uMgEgcbwO2QGRYV0z5BT8ePciUU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X03DC23_1774934889;
Received: from 30.221.131.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X03DC23_1774934889 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 13:28:09 +0800
Message-ID: <c1ed5688-b70a-4bed-9292-27882feff265@linux.alibaba.com>
Date: Tue, 31 Mar 2026 13:28:08 +0800
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
Subject: Re: [PATCH] [PATCH v3] erofs: ensure all folios are managed in
 erofs_try_to_free_all_cached_folios()
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <1828ed19-e9d0-4908-926a-0e0a9c3d04af@linux.alibaba.com>
 <20260331050249.23662-1-zhanxusheng@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260331050249.23662-1-zhanxusheng@xiaomi.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
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
	TAGGED_FROM(0.00)[bounces-3139-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: A03723641D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/31 13:02, Zhan Xusheng wrote:
> folio_trylock() in erofs_try_to_free_all_cached_folios() may
> successfully acquire the folio lock, but the subsequent check
> for erofs_folio_is_managed() can skip unlocking when the folio
> is not managed by EROFS.
> 
> As Gao Xiang pointed out, this condition should not happen in
> practice because compressed_bvecs[] only holds valid cached folios
> at this point — any non-managed folio would have already been
> detached by z_erofs_cache_release_folio() under folio lock.
> 
> Fix this by adding DBG_BUGON() to catch unexpected folios
> and ensure folio_unlock() is always called.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

