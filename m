Return-Path: <linux-erofs+bounces-2401-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHBMGanknWlDSgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2401-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 18:49:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 663DB18ABA6
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 18:49:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL4wj55crz3cZn;
	Wed, 25 Feb 2026 04:49:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771955365;
	cv=none; b=R/QuEaL3ZrDobKvdsXh/DoQzOudX7CbGdLmOfVoJheAtY7IcFl4fd6ct4mdVyNpjxHpJVShz9hCpAFUW5CcQ+bv6gvVB9n95yvcsxDZMUGiCpVMbojuLv9FgPDlI/EZn+Uuqa9siGnxOGiTu/CrOoIcGM6ua1YJnDOcX0CMKPaOHQnZqprLb3BqA7wx5z19/v8Rg0Gf/S8ifWzVz0lqRYhgBdHrgXe/L6BzXNbOfltx0A1dHbgkK6gDUkGIgQxb28xUauGKVl5b8HUWh7nPOKNsuYhxS+2Ci1qnisLinrWnhNSfkZSIEWufwkkF3UTuupHkBThBCpWmiKY+LjtsWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771955365; c=relaxed/relaxed;
	bh=mYFexmvy1TM0kgUgbj+AklH9Eq/ukFKaQcdiNu4DC/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VopBm4vpDagVVLg4g58fw+17PhfEH98vlie8H8mthnbh7MRgL0JCRY8sWj6ZyZ4bOlBq5dX9zr50oOw7RQZ5we1qz2hiNjx+W2NR66NqkGtfFrKDFWKaKZFNTdceE4Ro6Y/S0XsXsKjUcIkai4CnFnPoBgwmYex9ZGtd/I9Vw2uOFPRAX6e4YdMELi5eg8yZhfpjNTYbEqD90AlM2XJv7gys3toVe3zjJpqSsO2pcWTQ4swI7xn+OuVaA2AametsHvJpj8dEwS4qj0pd0+7TS/66d1DX5QFnhu2J98+CtuFkWxlR2uTeZCnUuSYMo/aPXXmLxX2IOsvp7OiZrVTlwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MucPGBKA; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MucPGBKA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL4wg5qVlz3cZj
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 04:49:22 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771955358; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mYFexmvy1TM0kgUgbj+AklH9Eq/ukFKaQcdiNu4DC/Q=;
	b=MucPGBKALEVpsLJN8iM/6hvBQgPRCbQN8+sLPnetNTuWlRrz7n6PGwztI4NE1eFtlgrWAgc2c7ALX56/j5VpnNpMaDI18Xpe8NdDS0u3sMUPbWWlmN2DdVhaLdSQjMbmOoVUtGLgy7pi/lIRMK8HvfH5krHbGJesWp4aMWGWeOI=
Received: from 30.42.59.174(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wzjx-Dk_1771955356 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Feb 2026 01:49:17 +0800
Message-ID: <57cdeefb-b88b-4a70-b871-9aa3c38716bb@linux.alibaba.com>
Date: Wed, 25 Feb 2026 01:49:16 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: converted division to shift in
 z_erofs_load_compact_lcluster
To: Ashley Lee <yester1324@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20260224163149.60016-1-yester1324@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260224163149.60016-1-yester1324@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-2401-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:yester1324@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 663DB18ABA6
X-Rspamd-Action: no action

Hi Ashley,

On 2026/2/25 00:30, Ashley Lee wrote:
> perf on fsck.erofs reports that z_erofs_load_compact_lcluster was
> spending 20% of its time doing the div instruction. While the function
> itself is ~40% of the fsck.erofs runtime. In the source code, it seems
> that the compiler can't optimize the division by vcnt despite it only
> holding powers of two.
> 
> Running a benchmark on a lzma compressed freebsd source tree
> on x86 yields a ~3% increase in performance. The following
> test was run locally on an x86 machine.
> 
> $ hyperfine -w 10 -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" \
>    "./fsck.erofs ./bsd.erofs.lzma"
> 
> With shift optimization
> Time (mean ± σ):     360.0 ms ±  12.0 ms    \
>    [User: 236.3 ms, System: 120.6 ms]
> Range (min … max):   342.3 ms … 379.8 ms    10 runs
> 
> Original Dev Branch
> Time (mean ± σ):     371.1 ms ±  16.1 ms    \
>    [User: 254.8 ms, System: 115.0 ms]
> Range (min … max):   354.8 ms … 404.4 ms    10 runs

Which compiler are you using? Does both gcc and clang
behave the same?

I wonder if it's possible to refactor this a bit instead
of introducing another `vdiv`, also if the kernel
codebase behaves the same, we should improve the kernel too.

Thanks,
Gao Xiang

> 
> Signed-off-by: Ashley Lee <yester1324@gmail.com>
> 
> ---
>   lib/zmap.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/zmap.c b/lib/zmap.c
> index baec278..1ba52b5 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -112,7 +112,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>   	const unsigned int lclusterbits = vi->z_lclusterbits;
>   	const unsigned int totalidx = BLK_ROUND_UP(sbi, vi->i_size);
>   	unsigned int compacted_4b_initial, compacted_2b, amortizedshift;
> -	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
> +	unsigned int vcnt, vdiv, lo, lobits, encodebits, nblk, bytes;
>   	bool big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
>   	erofs_off_t pos;
>   	u8 *in, type;
> @@ -144,13 +144,16 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>   	pos += lcn * (1 << amortizedshift);
>   
>   	/* figure out the lcluster count in this pack */
> -	if (1 << amortizedshift == 4 && lclusterbits <= 14)
> +	if (1 << amortizedshift == 4 && lclusterbits <= 14) {
>   		vcnt = 2;
> -	else if (1 << amortizedshift == 2 && lclusterbits <= 12)
> +		vdiv = 1;
> +	} else if (1 << amortizedshift == 2 && lclusterbits <= 12) {
>   		vcnt = 16;
> -	else
> +		vdiv = 4;
> +	} else {
>   		return -EOPNOTSUPP;
> -
> +	}
> +
>   	in = erofs_read_metabuf(&m->map->buf, sbi, pos,
>   				erofs_inode_in_metabox(vi));
>   	if (IS_ERR(in))
> @@ -160,7 +163,7 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
>   	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
>   			 (vcnt << amortizedshift);
>   	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
> -	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
> +	encodebits = (((vcnt << amortizedshift) - sizeof(__le32)) * 8) >> vdiv;
>   	bytes = pos & ((vcnt << amortizedshift) - 1);
>   	in -= bytes;
>   	i = bytes >> amortizedshift;


