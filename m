Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C339695DC
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 09:42:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wycyj6m2jz2yN1
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 17:42:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725349324;
	cv=none; b=en9Dl1aipo/YN5e9FMuqvQ9tfAmy+uuIoV5gJhcgpDLSghXyGOYpSv0Sz5o+Ulh2/icQcWSMzQV9WbySiiFO/k2LhTVrhvrQUCiCO/HeDiJVgEa97nAi7KVPp68PMfmRtdfu6kTEpML2lt7G9Qz1hxFC48Hjg0l/6JfAq8NFC8ygrfwURfkOyOKl19r1bjI5GvAWVrtKPYIIE8JwL1ZKcR9hHYOEpzmLNfnXvVE5Jtuqr/rfhK8Qe+gY8XLXS9bmMfude0PhIQMJ+WVBeAvmQIsYfynelEoWXm/YCt2g74rsPUpPxJf3BvQA2n0HEGxeaLr1R0TR9w6bLDbxG0RHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725349324; c=relaxed/relaxed;
	bh=cIgzNU9Tfn3P9K9ajRLn3iyfkx08AX9/kN9wxtfOM3M=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To:Content-Type; b=SfsGCNdOurP9UZrDk1Tksz78s9S/fTbC+iHTyndEJq1kIk13nuy4YXMpYst9ThtV7wGZb8q9xw+j+r0BM5msQ928vymfIyxHyT+jVmzNXeNPKOmpqlHKOau9n/bRQ4IyhMQpk+qzgO9YYPnmyQhba/KAlQua7BO5uR8/sgbdGXP/gjL9s4o6tv3K38fFMrd9x7NYbabYXDaUTp6pl0KHTYBVhgNMFYzMqGldiu566W8CACbhNTHLQ9Xvs6MZ49buL5KR/AnUN5uT4U5oUrc99xUNj77ruNfsGflg9De4HbXNp/QlmXnFKREj6DUmMSaabo2nHOVOIOJLT2zx2T7zyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KHzfFQM/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KHzfFQM/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wycyg1Jk4z2xb8
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2024 17:42:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725349318; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cIgzNU9Tfn3P9K9ajRLn3iyfkx08AX9/kN9wxtfOM3M=;
	b=KHzfFQM/VCByHW7CkSw9chBfnen2uFbuoHzluf6kM78Z/Zl4Vjba2pdrwC9KHdgzJEMxd+oQ28jrL5Fup7epXSQap078AC7Y+0uDsCfRxJOdfN5mLjb6gpodXBT59FaYWcWQJYQJVVV7Kv3yZXFxhYbhQdHDtaBlM4T8aRcygDI=
Received: from 30.221.130.74(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WECU.Qc_1725349316)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 15:41:56 +0800
Message-ID: <81e992e3-a5af-439f-b4bf-f8c8861b1b62@linux.alibaba.com>
Date: Tue, 3 Sep 2024 15:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: fsck: add --xattr option
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240903073517.3311407-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240903073517.3311407-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/3 15:35, Hongzhen Luo wrote:
> The current `fsck --extract` does not support exporting the extended
> attributes of files. This patch adds `--xattr` option to dump the
> extended attributes.

only `--xattrs` is not helpful, you'd better to add both
`--xattrs` and `--no-xattrs`, and makes `--xattrs` enabled
by default.

> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
>   fsck/main.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 28f1e7e..6a71791 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -9,6 +9,7 @@
>   #include <utime.h>
>   #include <unistd.h>
>   #include <sys/stat.h>
> +#include <sys/xattr.h>
>   #include "erofs/print.h"
>   #include "erofs/compress.h"
>   #include "erofs/decompress.h"
> @@ -31,6 +32,7 @@ struct erofsfsck_cfg {
>   	bool overwrite;
>   	bool preserve_owner;
>   	bool preserve_perms;
> +	bool xattr;

	bool dump_xattrs;

>   };
>   static struct erofsfsck_cfg fsckcfg;
>   
> @@ -48,6 +50,7 @@ static struct option long_options[] = {
>   	{"no-preserve-owner", no_argument, 0, 10},
>   	{"no-preserve-perms", no_argument, 0, 11},
>   	{"offset", required_argument, 0, 12},
> +	{"xattr", no_argument, 0, 13},

--xattrs, --no-xattrs

>   	{0, 0, 0, 0},
>   };
>   
> @@ -98,6 +101,7 @@ static void usage(int argc, char **argv)
>   		" --extract[=X]          check if all files are well encoded, optionally\n"
>   		"                        extract to X\n"
>   		" --offset=#             skip # bytes at the beginning of IMAGE\n"
> +		" --xattr                dump extended attributes\n"
>   		"\n"
>   		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
>   		"\n"
> @@ -225,6 +229,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>   				return -EINVAL;
>   			}
>   			break;
> +		case 13:
> +			fsckcfg.xattr = true;
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -411,6 +418,53 @@ out:
>   	return ret;
>   }
>   
> +static int erofs_dump_xattr(struct erofs_inode *inode)

erofsfsck_dump_xattrs

> +{
> +	char *keylst, *key;
> +	ssize_t kllen;
> +	int ret;
> +
> +	if (!fsckcfg.extract_path)

If extract_path is none, please keep reading the xattrs
but don't dump these.

> +		return 0;
> +	kllen = erofs_listxattr(inode, NULL, 0);
> +	if (kllen <= 0)
> +		return kllen;
> +	keylst = malloc(kllen);
> +	if (!keylst)
> +		return -ENOMEM;
> +	ret = erofs_listxattr(inode, keylst, kllen);
> +	if (ret < 0)
> +		goto out;
> +	for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
> +		void *value = NULL;
> +		size_t size = 0;
> +
> +		ret = erofs_getxattr(inode, key, NULL, 0);
> +		if (ret < 0)
> +			goto out;

why not just `break;` this?

> +		if (ret) {
> +			size = ret;
> +			value = malloc(size);
> +			if (!value) {
> +				ret = -ENOMEM;
> +				goto out;

same here.

> +			}
> +			ret = erofs_getxattr(inode, key, value, size);
> +			if (ret < 0) {
> +				free(value);
> +				goto out;

same here.

> +			}
> +			ret = setxattr(fsckcfg.extract_path, key, value, size, 0);
> +			free(value);
> +			if (ret)
> +				goto out;

same here.

Thanks,
Gao Xiang

> +		}
> +	}
> +out:
> +	free(keylst);
> +	return ret;
> +}
