Return-Path: <linux-erofs+bounces-616-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D205AB04628
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Jul 2025 19:09:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgphq3NzTz3btt;
	Tue, 15 Jul 2025 03:09:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752512987;
	cv=none; b=FCepGtA95Ha5yq9gPTg/8wcZRlCAMrJrbzUqV7A5j32JiMpcsLKOol55thKZT/UP+NquqqBBdz7GFupkUNEIUzIL6t9U/h7oenMdV+Ng1aiWS0fLYxQkhdfVxaQFWEBZwx/O2Fbp/if/y9PDQ5VuJkgqJQUxsRYqB92t+OdZRDdhSLD39FnSQW0F30jtbLxghwRhKGE8/NWTrbaLATPtgFfwYVs1a6v4sKL9biOqkpsLdbUfOO1LVivTYc+0XaOfUG4efGpy8hL8K6rjE2bR8QjvR/Uf/fDI+11N+ik7xMwGlHKD+gKuG1vZkrhNF/aprj/9lyRoDY6JovTdXTi+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752512987; c=relaxed/relaxed;
	bh=VyHEpKyVp7PY37v8pyQYKpmC5WWAKNV8hySgfl9nMY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mJT2lrVHwOWvvI3tUHpbEM2sQ5A8aE3oYiYC+XOSeH8cuZPpXTWp0df1ykPcPCkZw5JqyLBX7HIGD6pmIT00DYu3Homczh6Mfntd792NrjeC/NmIVVymMp+/FNWTRIFXbm+LcJpLOrSOpjcj959GFMs92S3nOPYPNKFofU+IS8h9qeeO6DLxxCPy1L8AVrfQ2HFeuwhVB1RweOpaZBoDQ7gdw4NyYSg0l/dakNSwb/2yWY5ZLsNjSYst/7L1FExOVpiX9GoNcM8ri+62As3RcmddC53fI369tsTm/wt50tWo1md4OvUfrEQ5G2QHPrqT2dWNzKTFeX7NnEolenqKFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O6MQvRpB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O6MQvRpB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgphn607Xz3btT
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 03:09:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752512980; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VyHEpKyVp7PY37v8pyQYKpmC5WWAKNV8hySgfl9nMY8=;
	b=O6MQvRpBWNCjHEzutqqb8S9lE05ox9nzzFX9P7RIQgYucQsTkAyrKg5ss9n3zA7+8DV2WIqSfXUXe1awVpeJR9lGO4GokbQyq2Wb8BavBgOdfwCNgih3goXzdJNzLlTibHRwA2kI50Yo0OCYHL9QU9/e+0R6s4S+z3a70H1rYtE=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wiyycmx_1752512977 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 01:09:38 +0800
Message-ID: <c6316256-548b-48c7-aacd-ee863968688d@linux.alibaba.com>
Date: Tue, 15 Jul 2025 01:09:36 +0800
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
Subject: Re: [PATCH v2 2/2] erofs-utils: lib: fix memory leak in
 z_erofs_compress_exit
To: Yifan Zhao <stopire@gmail.com>, linux-erofs@lists.ozlabs.org
References: <234da676-1ba3-4824-9fd4-cd9b41de48b5@linux.alibaba.com>
 <20250714165542.17023-1-stopire@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250714165542.17023-1-stopire@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/15 00:55, Yifan Zhao wrote:
> Currently, `z_erofs_compress_exit` does not free `zmgr` if compression
> is disabled, causing a memory leak. Fix it.
> 
> Fixes: a110eea6d80a ("erofs-utils: mkfs: avoid erroring out if `zmgr` is uninitialized")
> Signed-off-by: Yifan Zhao <stopire@gmail.com>
> ---
> change since v1:
> - free `zmgr` in `z_erofs_compress_exit` rather than allocating it in `z_erofs_compress_init` conditionally.
> 
>   lib/compress.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/compress.c b/lib/compress.c
> index a57bb6a..3c87a28 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -2130,16 +2130,15 @@ int z_erofs_compress_exit(struct erofs_sb_info *sbi)
>   {
>   	int i, ret;
>   
> -	/* If `zmgr` is uninitialized, return directly. */
> -	if (!sbi->zmgr)
> -		return 0;

`sbi->zmgr` still can be NULL if z_erofs_compress_init() is not called,
or `sbi->zmgr = calloc(1, sizeof(*sbi->zmgr));` fails.

Thanks,
Gao Xiang

