Return-Path: <linux-erofs+bounces-741-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FAAB17DCB
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Aug 2025 09:46:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btdLQ4qbKz2ymc;
	Fri,  1 Aug 2025 17:46:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754034382;
	cv=none; b=Ex5z92VIfRbuFiGDVUHz/cmWCHGx2PufetgbuWPI0nIkEzZjxX/uCL36l8k7lxG2/YygwKx2vchl6dpX6gW+83+IXG9bgu24XLkDpAkE8fXadITxYZDENh7/tfhOmDgznaAyKSQ10ATTRxb5eMpL7gqEg8oal2k+UVezrC4/L5uGP9w8VBbmo49HGuo6OSByP81weqLG1d1BO497QgtpOL9rFA/QNg+jswysvoYv8mt8C8EWbZvoD993f/dTHa2PcWltShk07mJkAocMJygho6c6sAo2EOXW7F1fyPsiyYEtZijs91qZ9FIsaD8TEed5TOOPAZ9xyy/3j6DdyaeWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754034382; c=relaxed/relaxed;
	bh=nbaBMUjweBE26p9xkSxJ60TrE2JIFTtYwahBE8e9jEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbmpRSKrXsJ1+YftwfcwU46mKXqZeppRadwnK9Y76h9eUDFJtOB0SoS2Kfvb8GGMWm+LoPPblV3tTDGOZ5fUA8mHW/Hs8xNKCgJ59Z8dhf3cgWih9ew8qf6OLaR/nKjax2AT6A/uPow5yg80L2sxtn8kdb3NqJs3M0k0LE7pbAZ3UFssVkhWP8F4Vtv3vRyimS3e4PmsndxL23UVkap75cR6zZJeCGSo3DagsX2zl2928a7l8gDK2oP1ffRf/WtZJrp/SsZ7ekdWBKPiWkMilJi+PX0K+U8vor4WycFoCDdQ/BFZ1bTVKW4mtVeP514R7179dZaFECQofbvA2AH9vQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jKCieI01; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=jKCieI01;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btdLN5k9lz2yfL
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Aug 2025 17:46:19 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754034376; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nbaBMUjweBE26p9xkSxJ60TrE2JIFTtYwahBE8e9jEQ=;
	b=jKCieI01ioLGn2CPf2/MzazznBA4fixen1jxXd0RwEk9/3RP62/Xz4DGozFyzGOSlkrx+WMPXsdEr6YT3fdARc/6MI3QqbEn6+Z7Ht0Xm2C56DtsA5+2R+cElD7iYqzY1eZHayhpfpDWAozaf1iEiJMlo4j2D4s0Xw5RGc9M2Tg=
Received: from 30.221.131.201(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WkdX2Zr_1754034374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 01 Aug 2025 15:46:15 +0800
Message-ID: <26bee370-2cd1-43d3-b83e-af6e91253939@linux.alibaba.com>
Date: Fri, 1 Aug 2025 15:46:13 +0800
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
Subject: Re: [PATCH v2 3/4] erofs-utils: mkfs: introduce `--s3=...` option
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: jingrui@huawei.com, lihongbo22@huawei.com
References: <97aa3cdb-076b-4af2-a110-79250b74fc7a@linux.alibaba.com>
 <20250801073046.1900016-1-zhaoyifan28@huawei.com>
 <20250801073046.1900016-2-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250801073046.1900016-2-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/1 15:30, Yifan Zhao wrote:
> From: zhaoyifan <zhaoyifan28@huawei.com>
> 
> This patch introduces configuration options for the upcoming experimental S3
> support, including configuration parsing and passwd_file reading logic.
> 
> User could specify the following options:
> - S3 service endpoint (Compulsory)
> - S3 credentials file, in the format of "$ak:%sk" (Optional)
> - S3 API calling style (Optional)
> - S3 API signature version, only sigV2 supported yet (Optional)
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> ---
> change since v1:
> - rename: include/erofs/s3.h => lib/liberofs_s3.h
> - add liberofs_s3.h in this patch rather than previous one
> 
>   lib/liberofs_s3.h |  40 +++++++++
>   lib/remotes/s3.c  |   3 +-
>   mkfs/main.c       | 220 ++++++++++++++++++++++++++++++++++++++++------
>   3 files changed, 233 insertions(+), 30 deletions(-)
>   create mode 100644 lib/liberofs_s3.h
> 
> diff --git a/lib/liberofs_s3.h b/lib/liberofs_s3.h
> new file mode 100644
> index 0000000..16a06c9
> --- /dev/null
> +++ b/lib/liberofs_s3.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +/*
> + * Copyright (C) 2025 HUAWEI, Inc.
> + *             http://www.huawei.com/
> + * Created by Yifan Zhao <zhaoyifan28@huawei.com>
> + */
> +#ifndef __EROFS_S3_H
> +#define __EROFS_S3_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +enum s3erofs_url_style {
> +    S3EROFS_URL_STYLE_PATH,          // Path style: https://s3.amazonaws.com/bucket/object
> +    S3EROFS_URL_STYLE_VIRTUAL_HOST,  // Virtual host style: https://bucket.s3.amazonaws.com/object
> +};
> +
> +enum s3erofs_signature_version {
> +	S3EROFS_SIGNATURE_VERSION_2,
> +	S3EROFS_SIGNATURE_VERSION_4,
> +};
> +
> +#define S3_ACCESS_KEY_LEN 256
> +#define S3_SECRET_KEY_LEN 256
> +
> +struct erofs_s3 {
> +	const char *endpoint, *bucket;
> +	char access_key[S3_ACCESS_KEY_LEN + 1];
> +	char secret_key[S3_SECRET_KEY_LEN + 1];
> +
> +	enum s3erofs_url_style url_style;
> +	enum s3erofs_signature_version sig;
> +};
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> \ No newline at end of file
> diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
> index ed2b023..358ee91 100644
> --- a/lib/remotes/s3.c
> +++ b/lib/remotes/s3.c
> @@ -3,4 +3,5 @@
>    * Copyright (C) 2025 HUAWEI, Inc.
>    *             http://www.huawei.com/
>    * Created by Yifan Zhao <zhaoyifan28@huawei.com>
> - */
> \ No newline at end of file
> + */
> +#include "liberofs_s3.h"
> \ No newline at end of file
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 3aa1421..f524f45 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -31,6 +31,7 @@
>   #include "../lib/liberofs_private.h"
>   #include "../lib/liberofs_uuid.h"
>   #include "../lib/liberofs_metabox.h"
> +#include "../lib/liberofs_s3.h"
>   #include "../lib/compressor.h"
>   
>   static struct option long_options[] = {
> @@ -59,6 +60,9 @@ static struct option long_options[] = {
>   	{"gid-offset", required_argument, NULL, 17},
>   	{"tar", optional_argument, NULL, 20},
>   	{"aufs", no_argument, NULL, 21},
> +#ifdef HAVE_S3
> +	{"s3", required_argument, NULL, 22},
> +#endif
>   	{"mount-point", required_argument, NULL, 512},
>   	{"xattr-prefix", required_argument, NULL, 19},
>   #ifdef WITH_ANDROID
> @@ -197,6 +201,12 @@ static void usage(int argc, char **argv)
>   		" --root-xattr-isize=#  ensure the inline xattr size of the root directory is # bytes at least\n"
>   		" --aufs                replace aufs special files with overlayfs metadata\n"
>   		" --sort=<path,none>    data sorting order for tarballs as input (default: path)\n"
> +#ifdef HAVE_S3

HAVE_S3 is a bit odd, how about using
S3_ENABLED (like LZ4_ENABLED?)


> +		" --s3=X                generate an index-only image from s3-compatible object store backend\n"
> +		"   [,passwd_file=Y]    X=endpoint, Y=s3 credentials file\n"

What's s3 credentials file? Is it documented
somewhere? Why is it named as passwd_file?

Can we have an option to pass in accesskey
too?


> +		"   [,style=Z]          S3 API calling style (Z = vhost|path) (default: vhost)\n"
> +		"   [,sig=<2,4>]        S3 API signature version (default: 2)\n"
> +#endif
>   		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
>   		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
>   		"                                            headerball=file data is omited in the source stream)\n"
> @@ -247,6 +257,10 @@ static struct erofs_tarfile erofstar = {
>   static bool incremental_mode;
>   static u8 metabox_algorithmid;
>   
> +#ifdef HAVE_S3
> +static struct erofs_s3 s3cfg;
> +#endif
> +
>   enum {
>   	EROFS_MKFS_DATA_IMPORT_DEFAULT,
>   	EROFS_MKFS_DATA_IMPORT_FULLDATA,
> @@ -257,6 +271,9 @@ enum {
>   enum {
>   	EROFS_MKFS_SOURCE_DEFAULT,

EROFS_MKFS_SOURCE_LOCALDIR,

Thanks,
Gao Xiang

