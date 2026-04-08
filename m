Return-Path: <linux-erofs+bounces-3222-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHY1FEvN1WmR+AcAu9opvQ
	(envelope-from <linux-erofs+bounces-3222-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Apr 2026 05:36:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F643B69A7
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Apr 2026 05:36:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr7yw09VKz2ydn;
	Wed, 08 Apr 2026 13:36:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775619399;
	cv=none; b=X/5RQw4t/xroRdOw40iwGaZQGFTS+O2cyHIYqi1eP+Lp9JjomlTccZOBQAsR9tp6qYUnIKU4F0MZ1dcPascweanbCueApfT78Pmke1xY66lCY7MES0OtfilrbR2yEtLdBIIHCQmvsaU5FhDc7+YbYDlDFhloHdNgZ9JfRbwOuUzZqIty0Bb5Nft4UcqQM8ZjPIp0nlhyuxxHcEwoQdVe1tQErogTvdJWsI2EZJSHGYShnrsLCOLgizNS3I/4MT9TeKKtzOPkkNwCaL7X7RE+ho/uMO9aFxqp5QodR/PV1qhZIgVrqtZsNooWSqnoWzlDb9Hn4Dh0mGIvjBn7L0XVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775619399; c=relaxed/relaxed;
	bh=4MHijQjG2bP25TIpFO3zMYLA0vLjEK/38H/kSgLO5U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SSGzoCzpbsfymM7F80Wrh8/qGD4+knrE//5+X8Hdn+UvIBEQSxCym5n6VaIqnUvJ0InWx+v1suYvN7uvr2t1ln/Zqy3JPodH+yEv+RFM4tJuVHf9CIHJAvLjwsyDPLeuiHnWOVXT8Tm0ilZuDoKO2Cv3gO5KpkPwVYQ8afcaBP8qPqVTWpBxUwrpopN+sAJan21FWAOdaL964/m1Ommha1tBnvHKhkv9NEDbsaoOwRygMXCkCNQ3wm5P+vopiP+CCe7QW0e69zVKEAlA27A9MH1o3RIqdYD/kt5vw0dWVPP8x9Cc2nofWJpPz4caPZFjtZrtDV7IjEhccEzboo8jBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l5mRtQhL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l5mRtQhL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr7yv0mSqz2yYJ
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Apr 2026 13:36:38 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775619394; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4MHijQjG2bP25TIpFO3zMYLA0vLjEK/38H/kSgLO5U8=;
	b=l5mRtQhLdzkPjaYHGccCY+yFH72WgstNPGQXAaj5EcTsEtYOZGXwI+mwVawmCICN63vdXl9twbwtkDz20Hlhi6XnTlLt78C0k9qVk8pvQM2ou+Pc1BdvazDL/15i1nXE3Uz/xN1ChLYZlBhq8zEpwXGF8OtjKN7hpS+0w1Eu+PA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X0dMbUK_1775619391;
Received: from 30.221.132.195(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0dMbUK_1775619391 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Apr 2026 11:36:32 +0800
Message-ID: <ecdd65aa-0dc1-41fc-afb1-d949ca8f5fa9@linux.alibaba.com>
Date: Wed, 8 Apr 2026 11:36:31 +0800
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
Subject: Re: [PATCH] erofs-utils: tar: fix negative GNU base-256 number
 parsing
To: Vansh Choudhary <ch@vnsh.in>, linux-erofs@lists.ozlabs.org
References: <20260405101830.34127-1-ch@vnsh.in>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260405101830.34127-1-ch@vnsh.in>
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ch@vnsh.in,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3222-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B2F643B69A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/5 18:18, Vansh Choudhary wrote:
> GNU base-256 fields use a 0xff prefix for negative values, but
> tarerofs_parsenum() currently accumulates them in signed long long.
> That does not sign-extend negative values correctly and can also
> trigger signed-overflow undefined behavior while shifting.
> 
> Handle positive and negative GNU base-256 fields separately and do the
> byte accumulation in unsigned long long instead.
> 
> This fixes GNU base-256 decoding for negative tar metadata values such
> as mtime, uid, gid and device numbers.
> 
> Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
> Signed-off-by: Vansh Choudhary <ch@vnsh.in>

I ran the test but it succeeds, so is it just a UB or it really
impacts end users?

Thanks,
Gao Xiang

> ---
>   lib/tar.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/tar.c b/lib/tar.c
> index 871779a..05d1a74 100644
> --- a/lib/tar.c
> +++ b/lib/tar.c
> @@ -328,17 +328,26 @@ static long long tarerofs_otoi(const char *ptr, int len)
>   
>   static long long tarerofs_parsenum(const char *ptr, int len)
>   {
> +	const u8 *p = (const u8 *)ptr;
> +
>   	errno = 0;
>   	/*
>   	 * For fields containing numbers or timestamps that are out of range
>   	 * for the basic format, the GNU format uses a base-256 representation
>   	 * instead of an ASCII octal number.
>   	 */
> -	if (*(char *)ptr == '\200' || *(char *)ptr == '\377') {
> -		long long res = 0;
> +	if (*(char *)ptr == '\200') {
> +		unsigned long long res = 0;
>   
>   		while (--len)
> -			res = (res << 8) | (u8)*(++ptr);
> +			res = (res << 8) | *(++p);
> +		return res;
> +	}
> +	if (*(char *)ptr == '\377') {
> +		unsigned long long res = -1ULL;
> +
> +		while (len--)
> +			res = (res << 8) | *(p++);
>   		return res;
>   	}
>   	return tarerofs_otoi(ptr, len);


