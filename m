Return-Path: <linux-erofs+bounces-3488-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF0CLrzEFmrOqgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3488-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2026 12:17:32 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E51A95E27D6
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2026 12:17:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQQXm5d8dz2xLs;
	Wed, 27 May 2026 20:17:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779877048;
	cv=none; b=hubU+DZ863JMhAMGEUk+T4ZBNB1395hhr+XebPw5BuEPIPYaehfb/dGEzvfuPy1zfiLL4vl/sbceJhiGypHvwToZodsfoBOV9ySeNubdCKvdY/xUPawQskIxSCzE/D5oZ6r/cyQGltdZqw0qUge9Uqk1wCZhEV6QlAFEdEcbMRY/Q9AqFkftDEN0s9BLJ448/Jhnfl4x8ok8TjOhLGPaFeiq2EUAslEl8u5NaA8zpUtcJ1pm2CJ3Ht7zN2nS5WQLlOFY2wviGsjPdgC+/bh1Bt67fq0+DB/UbFbQyATM4NzHGQBRyj4W4jnq89RpD6fwelS76ROxcmUBkYHeW3kFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779877048; c=relaxed/relaxed;
	bh=Zz/FBBjW/PsEGWtkxVKpXdqtXTFaFo15PAWptRErxRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhCi00GzTZonlJtQqzUZaLnk9WJcx3pk/TH/8zFCsxVvzIzKge8Bbug+YfYiFqRsa0/Y4VOMDu4QL5+QyMiBEGSepNg6/8/r6ZhLPpZ5ieCfy++Rft1cIfRiQSKJDQ9s9REyP3lpQJr0u/HnFpw+oSO6mQ6m/wX2qdZKxVwUKT25PuW2YG1XFhlMoEhWgezlEmlOaQ6thxyVY+u/Qn7s15aUudWs8Eq7OruHTJ6G26THDyrb920FVroUfpjhgTuNnV5nQoX+SU6sVIICQkQobaK5aFTLzJoOKKQOSdWWO4W2xbVQE6QEdsSPvDtTKvi+dTsx76jcOTORgaNAms2SFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uxAy6Nvj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uxAy6Nvj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQQXk4Bbhz2xHK
	for <linux-erofs@lists.ozlabs.org>; Wed, 27 May 2026 20:17:25 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779877038; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Zz/FBBjW/PsEGWtkxVKpXdqtXTFaFo15PAWptRErxRU=;
	b=uxAy6NvjVQ4SamVMgWwfQN1l9mR1stR7tsbqPXuju1muOTPLiMPLq0bwSNSr3stTtA6cMNgfvBQ/kPlRa8iFAs1NdM5mO390GxpVI+3tZQw76uefljc6zj5AgDXBouteQxnw6WUE9J0g8Ay4rhGG/wfNQrvoTPY3YgOb9yYwJas=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X3jQtKr_1779877036;
Received: from 30.221.132.72(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X3jQtKr_1779877036 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 May 2026 18:17:17 +0800
Message-ID: <5f9fc89e-a4b8-45fb-a266-a77dd3052ce4@linux.alibaba.com>
Date: Wed, 27 May 2026 18:17:16 +0800
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
Subject: Re: [PATCH] erofs-utils: build: drop stale liblzma path handling
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: guoxuenan@huawei.com, zhukeqian1@huawei.com
References: <20260527100558.980152-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260527100558.980152-1-zhaoyifan28@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-3488-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:linux-erofs@lists.ozlabs.org,m:guoxuenan@huawei.com,m:zhukeqian1@huawei.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[install.md:url,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,huawei.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: E51A95E27D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/27 18:05, Yifan Zhao wrote:
> liblzma now uses PKG_CHECK_MODULES() for path discovery, but a
> leftover assignment still rewrote liblzma_LIBS to plain `-llzma`,
> dropping pkg-config linker flags such as `-L${prefix}/lib`, which
> breaks custom liblzma path discovery.
> 
> Remove the redundant logic and drop the obsolete INSTALL.md reference
> to --with-liblzma-{incdir,libdir}.
> 
> Reported-by: Guo Xuenan <guoxuenan@huawei.com>
> Fixes: 37ada1b449ae ("erofs-utils: support liblzma auto-detection")
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>

Looks good to me.

Thanks,
Gao Xiang

