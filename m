Return-Path: <linux-erofs+bounces-740-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF459B17DBF
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 09:39:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btdBd5Y1Hz3bmC;
	Fri,  1 Aug 2025 17:39:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754033977;
	cv=none; b=nZ01mtCn2Jeq08ki2YZEWoLJBpo7n7C/4CV2XySeEiPOA92dqpPnRdjPlI/an3QXTFZGOazW9C1NB3uD8+Dj0ARBvpVjNGsEsfhoRYjgJHeF6iddImtdrIjON0UdL+yDrMs151mfb84Fef6x6xHm5WrxivSfKu3E8ImRWNWNR0n4qKrpD8V/bn56obALcjLqT4Ozjq3j6oEM2l9p1ByYHEGW97jfa9xl8IvuVEQVkQxjR9kSyJalcoMh7PTjwBRBrd77htd1mcdFJJI0hzg7HG4upn4RTMNg3mTEou2cPZJxE3OelyFl+jMP+sd3MILs79hY7TiQcKUeFlnpLwedfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754033977; c=relaxed/relaxed;
	bh=o5+EX3Ibn4Eyi74PTYxyxlTfTcRxtmM3iMmJAkEEejQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byscBL/FVRrOkUmjSMdIwfHxcZcCkn3XMcuYQZ2KUzoT87do5t0zshaHTPJq2phzlxIxkHAyEkEH5raKcB74/cT60VA7hvTt6rhg1hTFi3YYMVXa4naozPbTFlor52E9X/JuO2JyN7ttdd9d7peMKkZ0xgCVp/UGnYBHE2OtzIOEnd4KcEyjmlUFB16A1ocVqECEFvAqxQNL172rPSo7ypzcdH8TbOJEopNPPmM/4Wo1/yj4OvZ2gwqls2LKC+vXyUtolXYEunmYZa6NaQNTMYSX2iogOwhNFPL5ojn9zpSgEnafGOzoU+KQesfm7lP25OukK6M6kQnx5qzsfGH1zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tKoAqHXh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tKoAqHXh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btdBb33Jpz2yfL
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 17:39:34 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754033970; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o5+EX3Ibn4Eyi74PTYxyxlTfTcRxtmM3iMmJAkEEejQ=;
	b=tKoAqHXhriQ5NhI8LUjsoWkl8cZza/wRlCqA8fc4VPCliuWU+u3GN2j1KCFT4rHWwofCUTTd5j1Ta16GaghEFdKRLPdMOnHjo5HvdH7qVAxawtzQ6gz2zqeQVaJeTXR8Awlkw0yh/V3+VENn0uH/zJnkKMoF2uZKwnh8nlu+Jzc=
Received: from 30.221.131.201(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkdFdYc_1754033967 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Aug 2025 15:39:28 +0800
Message-ID: <c25002cd-25ea-46f1-9bd1-16d479f418c4@linux.alibaba.com>
Date: Fri, 1 Aug 2025 15:39:27 +0800
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
Subject: Re: [PATCH v2 2/4] erofs-utils: introduce build support for libcurl,
 openssl and libxml2 library
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, lihongbo22@huawei.com
References: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
 <20250801073046.1900016-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250801073046.1900016-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/1 15:30, Yifan Zhao wrote:
> From: zhaoyifan <zhaoyifan28@huawei.com>
> 
> This patch adds additional dependencies on libcurl, openssl and libxml2 library
> for the upcoming S3 data source support, with libcurl to interact with S3 API,
> openssl to generate S3 auth signature and libxml2 to parse response body.
> 
> The newly introduced dependencies are optional, controlled by the `--enable-s3`
> configure option.

Use 72-char per line at maximum...

> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
> change since v1:
> - rebase on the latest `experimental` branch
> - rename: lib/s3.c => lib/remotes/s3.c
> - configure.ac: introduce `subdir-objects` option as s3.c in a subdir
> - move include/erofs/s3.h in the following patch
> 
>   configure.ac     | 43 ++++++++++++++++++++++++++++++++++++++++++-
>   lib/Makefile.am  |  4 ++++
>   lib/remotes/s3.c |  6 ++++++
>   mkfs/Makefile.am |  3 ++-
>   4 files changed, 54 insertions(+), 2 deletions(-)
>   create mode 100644 lib/remotes/s3.c
> 
> diff --git a/configure.ac b/configure.ac
> index 2d42b1f..82ff98e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -24,7 +24,7 @@ esac
>   # OS-specific treatment
>   AM_CONDITIONAL([OS_LINUX], [test "$build_linux" = "yes"])
>   
> -AM_INIT_AUTOMAKE([foreign -Wall])
> +AM_INIT_AUTOMAKE([foreign subdir-objects -Wall])
>   
>   # Checks for programs.
>   AM_PROG_AR
> @@ -165,6 +165,10 @@ AC_ARG_WITH(xxhash,
>      [AS_HELP_STRING([--with-xxhash],
>         [Enable and build with libxxhash support @<:@default=auto@:>@])])
>   
> +AC_ARG_ENABLE(s3,
> +   [AS_HELP_STRING([--enable-s3], [enable s3 image generation support @<:@default=no@:>@])],
> +   [enable_s3="$enableval"], [enable_s3="no"])
> +
>   AC_ARG_ENABLE(fuse,
>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
>      [enable_fuse="$enableval"], [enable_fuse="no"])
> @@ -578,6 +582,32 @@ AS_IF([test "x$with_xxhash" != "xno"], [
>     ])
>   ])
>   
> +AS_IF([test "x$enable_s3" != "xno"], [
> +  # Paranoia: don't trust the result reported by pkgconfig before trying out
> +  saved_LIBS="$LIBS"
> +  saved_CPPFLAGS=${CPPFLAGS}
> +  PKG_CHECK_MODULES([libcurl], [libcurl])
> +  PKG_CHECK_MODULES([openssl], [openssl])
> +  PKG_CHECK_MODULES([libxml2],  [libxml-2.0])


I wonder if it's possible to introduce
`--with-libcurl`
`--with-openssl`
`--with-libxml`

and `--enable-s3`, and if users disable any library,
it should fail.

I think why it should behave as this, because libcurl
openssl and libxml can be used for other use cases
(e.g. oci registry support), users can always link
these libs

Thanks,
Gao Xiang

