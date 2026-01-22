Return-Path: <linux-erofs+bounces-2141-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ5rE0brcWl6ZAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2141-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 10:17:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675776466E
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 10:17:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxb7l00rMz2yFm;
	Thu, 22 Jan 2026 20:17:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769073474;
	cv=none; b=Q7Vig1z4l2yBaSSH3T+7IRkgcAPE7K1qik/J7LSJQAWyPCMz6BcML3ihecyNZXd5qsmowdJuRcqnUvA3amW/CRZGy2ysQIrAwzJiYAWWg46k5MnyBAo9sqlNDjtGzVI8sQpQ+DExDLu3HJ5Y3zemEm5tMG7D6UbDAfMTE6GBsha7dBEU0QmNmIW3fKeagJwMrFPd2M5MuFlLucT7nVWHL3cq8Kpo34fJ8nfeTBFoVKfixmLAbi4/Qwd5DKkPOGgSjBfeaaokXd8bmvKvsaoBnxFQMGYgl8/VCG+UFGvrMH7u1moHkcbLP7baoshk8nMHvssVr0IPgqWKKtOLsNg8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769073474; c=relaxed/relaxed;
	bh=dVzhAVVW8h6proDBcB6B+2wgIKO8epu78jjLFXmf1Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmK2SlUXRLxWl3IjPs2NtfG7apR1JkcwsE5yT1+VWsK+EbXdgqLuXbK1uYiPCFQPrrgZDuQEJK9PJiFvjCWQSUEIsabdAVU0t8jvsXMo5ECVrvDPpVEde5HJMnl1cmDu7vb+HWSZ8jDDF7MH4ymyuK58uGzlHVMPgN+LKrGcP4h6AHjOlAjt+DEcgadpV51C9kUIMe0f/BF+xewaSdf198l88n9aX1+Tncrzp0kWzbBdSEVjNSBEjbrpXM00r0KAkjeY05ebD/w0qyLtGku4zkOULIHHMo75x5ZEZ58/pkW3cPSTNG/FXPFRU2c3wt+WKNG2nbOYtCj3XddVEdWZUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CnVd8m5/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CnVd8m5/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxb7h5fB8z2xS5
	for <linux-erofs@lists.ozlabs.org>; Thu, 22 Jan 2026 20:17:51 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769073467; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dVzhAVVW8h6proDBcB6B+2wgIKO8epu78jjLFXmf1Rk=;
	b=CnVd8m5/wteZgEUA43oCI+sKUh++gcXfc2pvaVKO0ZaGBvCwF6Yi85YHOmmPJrIkcGWnwAHJf07Ngvp8AAsb6IZiU2B8r/VsaOJVbKZX8sxwmeWhhSA4kBaLBmXpSgDDuBV6XmN+mwPfBUko2F1bMPIppXGeGeBRvqAPwjhjNjw=
Received: from 30.221.131.199(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxboPyl_1769073464 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 Jan 2026 17:17:45 +0800
Message-ID: <35fbeb9d-efb2-4f8f-9d71-53038bca289e@linux.alibaba.com>
Date: Thu, 22 Jan 2026 17:17:44 +0800
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
Subject: Re: [PATCH 1/4] erofs: fix incorrect early exits for invalid
 metabox-enabled images
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251229092949.2316075-1-hsiangkao@linux.alibaba.com>
 <3ade0cad-2053-42e9-b340-2eb2f6066675@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <3ade0cad-2053-42e9-b340-2eb2f6066675@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2141-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 675776466E
X-Rspamd-Action: no action



On 2026/1/22 17:06, Chao Yu wrote:
> On 12/29/2025 5:29 PM, Gao Xiang wrote:
>> Crafted EROFS images with metadata compression enabled can trigger
>> incorrect early returns, leading to folio reference leaks.
>>
>> However, this does not cause system crashes or other severe issues.
>>
> 
> Will be better to add:
> 
> Cc: stable@kernel.org

Hi Chao,

will add later, I current have some environment issue.

Thanks,
Gao Xiang

> 
>> Fixes: 414091322c63 ("erofs: implement metadata compression")
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,


