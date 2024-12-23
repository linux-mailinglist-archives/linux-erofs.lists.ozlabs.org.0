Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0159FA9BC
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Dec 2024 04:32:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YGk9Z3VDrz300C
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Dec 2024 14:32:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734924753;
	cv=none; b=eKTpY14lG4uJbdcS80fLaW6okGl+e06m9b4aYfn4bNOP0N+a8qse61DvwiSUr5eca8hzYhny0gA9p6pTsVs/mQDRLBaQ9wvRyMAKrZRS5Ucd9sAN4k8D6MkF+4YD/WZsN8Uz2+PT2OsiBkBqodjF4PIg4o7VG38yyiIfaW+YDaSKijfcNj2PgxRnupvlRtl/gwClF/+0M6fXngiGwAu57eq+UmZHu4FsoRFNQHktADBGaSyRfQDYN21ztQglt6+ZsfLPKI6aKgSuXpoHK0EZZqA6D2XjW4Fp45H0EeFVhYPqoVJ9mwqMELPerXOXRYllihDoXMs8YC3BWB0QIiDrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734924753; c=relaxed/relaxed;
	bh=98fNWy5yCdP/W+2vnKIHC6AxFhaLbCoz9BL1fmQsfns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCUjAjdfgo0csh8OCkn2v8+Wj/d59K53pveYmTW/Y8ZYNcMC4EE3eoN9dYYewBG9jvsKN6/WqtuyR8I4jdl7q1v0UN0G4RILG2n4Sr6dvzYC4K3ZFwhX1RQDmssa9wZrPNqBmxrviemD2z9I8S6QMfjrZ2GCQltAmxylRqIPvXP3j8hhUIrXF91mqldJbutMjIYUeK+W/5CUrTzndjsydkm/CENDNZ7KisfB0MVromWkQt99UQHeXnvw8QRYxf8Pd7K9vuQt+xdx/2tQIR89atsTyjtgr4NunXXekuBKFQ0olg7LBlQ0BUwVMdNYNDZcZtlkRK7HZfdZdKwISoOQNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JOGZ4v2l; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JOGZ4v2l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YGk9V1ffQz2xG6
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Dec 2024 14:32:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734924741; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=98fNWy5yCdP/W+2vnKIHC6AxFhaLbCoz9BL1fmQsfns=;
	b=JOGZ4v2lJ7bofrO2bPHaGjB8ZQZgclV0jSCgcnsNq7W4J81uGmZDKbpkzYS3Rq02fcTOB7O82UGgb7GRwECM8v/iMbRdnQeHQZzwyQdXLA8I3UlSK2AMqgrUY1BcAjvDLwabjD2Eqxg2kVifFstDPc2uziEvnesoL4LKGOXetfo=
Received: from 30.221.130.83(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WM-EY0z_1734924739 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Dec 2024 11:32:20 +0800
Message-ID: <80a3e6ab-839e-47b6-9554-fbaf330ab4b8@linux.alibaba.com>
Date: Mon, 23 Dec 2024 11:32:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: erofs: xattr.c change kzalloc to kcalloc
To: Ethan Carter Edwards <ethan@ethancedwards.com>,
 "xiang@kernel.org" <xiang@kernel.org>
References: <i3CLJhMELKzBJr3DaRyv-hP_4m-3Twx0sgBWXW6naZlMtHrIeWr93xOFshX8qZHDrJeSjHMTiUOh8JmBZ9v0AB-S1lIYM_d-vasSRlsF_s4=@ethancedwards.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <i3CLJhMELKzBJr3DaRyv-hP_4m-3Twx0sgBWXW6naZlMtHrIeWr93xOFshX8qZHDrJeSjHMTiUOh8JmBZ9v0AB-S1lIYM_d-vasSRlsF_s4=@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/23 11:00, Ethan Carter Edwards wrote:
>  From 272d7ef4611e64269fada0ea3021eece590118b9 Mon Sep 17 00:00:00 2001
> From: Ethan Carter Edwards <ethan@ethancedwards.com>
> Date: Sun, 22 Dec 2024 21:23:56 -0500
> Subject: [PATCH] fs: erofs: xattr.c change kzalloc to kcalloc
> 
> Refactor xattr.c to use kcalloc instead of kzalloc when multiplying
> allocation size by count. This refactor prevents unintentional
> memory overflows. Discovered by checkpatch.pl.
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Although your raw patch format is incorrect.  You shouldn't
send the whole patch as the content, but just use
`git send-email` to send the patch.

I've fixed it up manually, no need to resend.

Thanks,
Gao Xiang

> ---
>   fs/erofs/xattr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index a90d7d649739..7940241d9355 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -478,7 +478,7 @@ int erofs_xattr_prefixes_init(struct super_block *sb)
>   	if (!sbi->xattr_prefix_count)
>   		return 0;
>   
> -	pfs = kzalloc(sbi->xattr_prefix_count * sizeof(*pfs), GFP_KERNEL);
> +	pfs = kcalloc(sbi->xattr_prefix_count, sizeof(*pfs), GFP_KERNEL);
>   	if (!pfs)
>   		return -ENOMEM;
>   

