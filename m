Return-Path: <linux-erofs+bounces-2907-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPHwOoqfvmnoUgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2907-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 14:39:22 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C92E5916
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 14:39:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdLBZ61Hjz2yZN;
	Sun, 22 Mar 2026 00:39:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774100358;
	cv=none; b=RWNYUIJrKlrmL8iJSfhMWy4wO8pwuY/zp0Z9VbUIxu16Uqpw+iilXRGte0SVa4NKhOCMm4CBmzVht1PnKseWQg4JRm1XGq+hJSzWumeC5l2CDQ3y+WA+sWSxnqKgtCQieFc8SAQbe0FCZ8yMF5fjNHYiT0d8Zf9fG0H8nUKf6yO7dZNny5RHc5rarnZauyhcORI7Xexb2yNFjg4HaN1m8A1FozlXxf3auhUPghQtv5xgblmjaX9f6QT37XZgh4nO03MGgMh82qeniwuVJstoRiScFtWlqzi0evQgXEDKVXSXUBktO3Eaew7iRImgKcQoorJ25ge4Yx5hLTA72DKrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774100358; c=relaxed/relaxed;
	bh=O8nOpWvuwodnXSrZzbuKR4IwQ3cpjF/NiFwmG3l02L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIE/+Lbo61pD/Ww+Yfequm3dlsiaq8d90UaKDW5jN9zN89VfcteaFAkrW7JEKlNUeyIJFD1GWAPSsPT4Mk564uza0Tm+hfgYdeZzfRu0V0zfUTQmvx2HD7a3nLBysvigf7A0EVR7GjF8eezreFJ/FD46zOUWF9QyKUh239YsrkOH2kTaaZZ92jhkZTrKdxmiVC8p6CeB04DUTTFzZF0ttM4Jka4nNZNrG1Mq0QEYPCN92RrhfY0eImz2ZWTctmAMPoAMgbBIgXns5bykBM5f/vWtASnxISEQ8Jftd1/Z1M4LA23RbXb2XcO9B84wbboFDr/OREdmORmUFh5RrWeQjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ntKuouRy; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ntKuouRy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdLBV513hz2yYq
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 00:39:10 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774100342; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O8nOpWvuwodnXSrZzbuKR4IwQ3cpjF/NiFwmG3l02L0=;
	b=ntKuouRyW3dflUsOypNHgWWfT7grTTGSuvDl8opsGBYDMSQKxjQiq05s1a4vVSnfuFfepGILd4sGFZPanijRBfi3cX3QnaFwYMP7Odzx0l6KbZJuOi2ZKuu6QykY5o7t4FF+ymT/C3x5lcVl+2pFtwkACyoaEeSPnx/aZow6TsE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X.OvyzD_1774100341;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.OvyzD_1774100341 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Mar 2026 21:39:01 +0800
Message-ID: <a2c19923-89fb-4225-a468-b1629cc07328@linux.alibaba.com>
Date: Sat, 21 Mar 2026 21:39:01 +0800
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
Subject: Re: [PATCH] erofs-utils: fix resource leaks and missing returns on
 error paths
To: Nithurshen <nithurshen.dev@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, newajay.11r@gmail.com, xiang@kernel.org
References: <d8e7345e-a1cb-4234-b03f-a3089f7a1c27@linux.alibaba.com>
 <20260321071542.80503-1-nithurshen.dev@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260321071542.80503-1-nithurshen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:newajay.11r@gmail.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,m:newajay11r@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-2907-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 744C92E5916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/21 15:15, Nithurshen wrote:
> Hi Xiang,
> 
> Thanks for the suggestion.
> 
> I have started working on formalizing the truncated image
> scenario into a test case for experimental-tests. I'll
> implement it so that we can automate the image corruption
> and verify the FUSE daemon's error-handling behavior in
> future.
> 
> Since there is already a test-case I sent with code 028,
> is it okay if I send this one with 029?

Any number is fine, or just use 99 when submitting.

> 
> I will send the patch for the test case shortly.
> 
> Thanks and Regards,
> Nithurshen


