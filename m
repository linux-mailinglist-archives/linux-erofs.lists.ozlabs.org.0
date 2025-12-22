Return-Path: <linux-erofs+bounces-1532-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977DBCD4EEC
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Dec 2025 09:08:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZW3Q17pVz2xpm;
	Mon, 22 Dec 2025 19:08:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766390882;
	cv=none; b=ZO6sbz1EUJh+Xy0sSsvOxraGWKmjuuvoWYor+pkpW+ZF5zLOLy2c1s3KWYuJkrTWlOOzcJx5CaBzPQ0dy+rxVEWRQzTEdqT1nOPJlk8Kzdi08xn0IQcUZcGoePfkf7AAt6TbQyUYpd0IVtOFfamIR03KHv9Jc3dSdEEBXFwRr4kKfVuBoIPddglhqCubXPoPyajnjT9YpiyG31U62OxO8iIb/w7pvB9OdbwUJfpK2jYi6xbsnNrY2fGPKS9MmOYCszea0oPhnf+kuwvgbANWGkthGZe9w0IuqXkyDi6a5DasXAQ8notDVHLHWmzVeXLvLq65vqtbAdhMENMPWIhSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766390882; c=relaxed/relaxed;
	bh=GvtwB6ReeFxy4zC4Zh2GgWPosIkK2X0542oITEQsNRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTVN//9YuNPv8HACbN5u1ZkkOXDIpjg3kpEGdb3DkfIOXiokkjIsE8YFb2ogfr1w2Q1tviPJ1lwmhMd3JLUPiRbKckez1wnP1I9ICsSYiAEbxNHiZNIxonWBs1+DulGSUuHo2LGFVcBB5G3B1DAWOHHdAaOh5BUHmoVriykJsH5d51DT4l6+lLKI5/KX0F4PIbWOM9FV85jHdv7iqCAaY7zdDC6uCKSbm6xZmV3Mf65sqvGVZQq17/schc9Ave2Z1reZ7xJwn2EWAhuM8Tq+nTnSKzpK6/B3yqECmnRnFidF9WQXe/zyww+MBADguQdUHdsYgTcW7Ud0omZT7AgGXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w+4jhWmz; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=w+4jhWmz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZW3M4v1wz2xSZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Dec 2025 19:07:57 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766390873; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GvtwB6ReeFxy4zC4Zh2GgWPosIkK2X0542oITEQsNRY=;
	b=w+4jhWmz+COyWbF3ZivIrcDHpX1crBZ+jtVxjYYoZYUzHtaAjQljvRqB4aFt7nrNjyzFWZM78sTrSEOBJE8zQJk7nHsXsgd0ScfVo8CSfCFEtG/3v4wE+ANIOTEHyh/Ewkw7kx/1m4Ww4B/S6GjrhCHeMuAlrv/CArEY88Ai/yk=
Received: from 30.221.132.255(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvNY7fE_1766390870 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 16:07:50 +0800
Message-ID: <56b44498-a1d2-419c-9655-887976cc4d3d@linux.alibaba.com>
Date: Mon, 22 Dec 2025 16:07:50 +0800
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
Subject: Re: [PATCH] erofs-utils: mount: add manpage and usage info for
 oci.insecure option
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: hudson@cyzhu.com, jingrui@huawei.com, wayne.ma@huawei.com
References: <20251222075421.171161-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251222075421.171161-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/22 15:54, Yifan Zhao wrote:
> Add manpage and cmdline usage help for the newly introduced
> `oci.insecure` option in mount.erofs. Also fix an indent error.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
>   man/mount.erofs.8 | 3 +++
>   mount/main.c      | 3 ++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/man/mount.erofs.8 b/man/mount.erofs.8
> index 6b3a32b..856e07f 100644
> --- a/man/mount.erofs.8
> +++ b/man/mount.erofs.8
> @@ -117,6 +117,9 @@ Path to a tarball index file for hybrid tar+OCI mode.
>   .TP
>   .BI "oci.zinfo=" path
>   Path to a gzip zinfo file for random access to gzip-compressed tar layers.
> +.TP
> +.BI "oci.insecure"
> +Use HTTP instead of HTTPS to access the image registry.
>   .SH NOTES
>   .IP \(bu 2
>   EROFS filesystems are read-only by nature. The \fBrw\fR option will be ignored.
> diff --git a/mount/main.c b/mount/main.c
> index ed6bcdc..1463dee 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -94,7 +94,7 @@ static void usage(int argc, char **argv)
>   		" -t type[.subtype]	filesystem type (and optional subtype)\n"
>   		" 			subtypes: fuse, local, nbd\n"
>   		" -u 			unmount the filesystem\n"
> -		"    --reattach		reattach to an existing NBD device\n"
> +		" --reattach		reattach to an existing NBD device\n"

Not quite sure if we will switch to this style, so
don't touch this line for now?

Thanks,
Gao Xiang

