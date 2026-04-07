Return-Path: <linux-erofs+bounces-3214-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIZ+BeLP1GksxwcAu9opvQ
	(envelope-from <linux-erofs+bounces-3214-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 11:35:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369D63AC1CB
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 11:35:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqgzK4wRVz2yYY;
	Tue, 07 Apr 2026 19:35:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775554525;
	cv=none; b=KiDW8A2es5lrX+s/zMPzjjcf2SpZGVR2zG3oeUi9YvAaNFjrUwbFXNnNE7x6U+usavqZZ/52VVuDo15+fTgQBtmjeRp7XgxdGIgEA5+/M9Pm4VmCpU3GQjzWDMlhZVwDZoxfnUSp5Qn4lWdjl4BGdRk20i2Izm+MY1K6Z0nFkiR7V6ggwSa4baOBPbqOLkH5fKk3LmQ9cacHGY4271O0mWhOQNhq4jhJYZgX2CAAHj9YI806m4UGqENp4Gbf23Nps4Neqbm/xNYADid+fPrGS+xyGUGGS8Ej4ILTFy1v1hIf2DGp7MSf8nCcP0DZrAeoPZSkVSrdJp95zJNwN6O5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775554525; c=relaxed/relaxed;
	bh=RWmVR3JL2iWvuoyof4ibKccR2zPRao4kyzFCOQcCGac=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M2khe/kloIUHr97t8LJmX+CR5OCt+78hjCeiC6v/E1ntk/ylXAtbSzet33P1RPCE/QCMN1RYfCUOeUVyQf3eIeiF1LypttafD1RuXML9dKhYqan6sTkGCMcjSiuM8W5LzvC8qQzDgx5gDovMcPVa901VyxKHb3BF2cLfWArkcMj9oZJQ7aP/TmB1xuTB5+Yl1vhhujxUd7yncJeFeBL20d6ZuOXRK49z+uhahwYA4wKVjsDHiewsbYcs6yXdoH0FVXzOnBbHUC7MNvzfvMPNXKjJbCFfSInNoV6krdFDe7Hn3Z8sig13BdKj5CJlL2Vwox6ECy0w5qB42G2xog55Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lU2nuCsi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lU2nuCsi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqgzG1hFmz2ySk
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 19:35:20 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775554515; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RWmVR3JL2iWvuoyof4ibKccR2zPRao4kyzFCOQcCGac=;
	b=lU2nuCsiDqVq7t0V4sn0zzUfey+0iXSpMY7NwSaf0wXZCrIwnEk0y7Mz+R3yvbekgawWduwFbPgv3kz+/YtuEtYX2ESrjO7D7OSbVUvTnnXOWd49ziZlnh+5ly/pNYQDse+XP2DVGMnMvCpdKgzCLnLa8iNPl0Wm373zdlQVvo0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X0bMn5O_1775554513;
Received: from 30.221.130.92(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0bMn5O_1775554513 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 17:35:14 +0800
Message-ID: <7228eca8-8688-438e-a3c1-95b322d5940e@linux.alibaba.com>
Date: Tue, 7 Apr 2026 17:35:13 +0800
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
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-3214-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ch@vnsh.in,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 369D63AC1CB
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

Provide a testcase for this?

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


