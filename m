Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929197791D
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 09:06:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4ljT6CMkz2yp9
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 17:06:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726211211;
	cv=none; b=k8MLKJgWAae22zJ9f8YfQ+qKDvd6L2B72anSFSSvOxLYeEOnF1SBz/cceCp0//ecMQwhx27oSItm9uwIPClHMRTltg+MwtFe8g1XYAXTN9Z1ZJPooZZycLyjCR4iYTdWthz9cDmgqEbwUJ0oBLubgToplBNoHEkhgzNT+XGuNUnaf9ztssmygpFod/JUHOWLVbP+RMX3nEVqRbN09swYEZSDqXCBcONiLtFafEoG24t513w/BQop+QB9qoctSfZFRlCQ3PhTY1AAbmmlG95RmNNKct1pjMnTF4ThRiuk6pLbfYGKgDEkdV+7EFwdOeQmWiKyT2VhFtve+gfo23D13A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726211211; c=relaxed/relaxed;
	bh=J9UfnObRALGxfj05t5qb6UGTqrLB2yjcNaO3OID4XIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IQuo2ziS30+S/cS7QTVzpkrGmAKip2TeVnpqUq2Y4CBHXXNfqKRgL1CZfI9b1kPokOk4WaR/LZdiTlA7djnbDHMZCehCZ+q1omMUW+ctWWA34lsM8F5O4Vbze44moxk3u6Mc90pPBQ65mINAA2EL7w19JJBq6WRugTmzYWErTslSxMOE7XrsM8t8pvbYyVRHws/D0GSds99tpHPZa1ZTrrfqumHJBZLa2K6RSlTU42tmJszMMjU73gOEI4U1mQF/iQ8lOj4grXOtlH/qVQQySdyug2Pxgc/0x6fvbAq4NjtGCEM0+YAMCqIdhF6NjJcMrlJfys8v2UxHUjEt+AEtDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tHi2/ukL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tHi2/ukL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4ljQ0p9Kz2yYy
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Sep 2024 17:06:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726211204; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=J9UfnObRALGxfj05t5qb6UGTqrLB2yjcNaO3OID4XIA=;
	b=tHi2/ukL6zJ73/LAJjNoU5DwnEL0lzrwaS86nN9ibXJybgYj+jED187Mm3sPgvwG+RglgpvfwGFyUORVBoXCATcDOybIJ2HhM/3Nu8uKx6HHNwQrb/HE+zuNxAnetFb3tMEbmoCNQyWQmaZrSTq8eB2FkFDaIgcajsjd5lm9jFQ=
Received: from 30.221.130.178(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEtz5yc_1726211202)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 15:06:43 +0800
Message-ID: <3cae76a9-2fff-4df5-a1fc-1497aefdf085@linux.alibaba.com>
Date: Fri, 13 Sep 2024 15:06:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] erofs-utils: fsck: introduce exporting xattrs
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240913064913.537850-1-hongzhen@linux.alibaba.com>
 <20240913064913.537850-2-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240913064913.537850-2-hongzhen@linux.alibaba.com>
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



On 2024/9/13 14:49, Hongzhen Luo wrote:
> Currently `fsck --extract` does not support exporting
> extended attributes. This patch adds the `--xattrs` option
> to dump extended attributes and the `--no-xattrs` option to
> omit them (the default behavior).
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v9: Adjust the contents of fsck.erofs.1.
> v8: https://lore.kernel.org/all/20240912131108.3742683-2-hongzhen@linux.alibaba.com/
> v7: https://lore.kernel.org/all/20240906095853.3167228-2-hongzhen@linux.alibaba.com/
> v6: https://lore.kernel.org/all/20240906083849.3090392-2-hongzhen@linux.alibaba.com/
> v5: https://lore.kernel.org/all/20240906022206.2725584-1-hongzhen@linux.alibaba.com/
> v4: https://lore.kernel.org/all/20240905113723.1937634-1-hongzhen@linux.alibaba.com/
> v3: https://lore.kernel.org/all/20240903113729.3539578-1-hongzhen@linux.alibaba.com/
> v2: https://lore.kernel.org/all/20240903085643.3393012-1-hongzhen@linux.alibaba.com/
> v1: https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
> ---
>   fsck/main.c      | 107 +++++++++++++++++++++++++++++++++++++++++++++--
>   man/fsck.erofs.1 |   3 ++
>   2 files changed, 106 insertions(+), 4 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 28f1e7e..83f29c5 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -9,10 +9,12 @@
>   #include <utime.h>
>   #include <unistd.h>
>   #include <sys/stat.h>
> +#include <sys/xattr.h>
>   #include "erofs/print.h"
>   #include "erofs/compress.h"
>   #include "erofs/decompress.h"
>   #include "erofs/dir.h"
> +#include "erofs/xattr.h"
>   #include "../lib/compressor.h"
>   
>   static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
> @@ -31,6 +33,7 @@ struct erofsfsck_cfg {
>   	bool overwrite;
>   	bool preserve_owner;
>   	bool preserve_perms;
> +	bool dump_xattrs;
>   };
>   static struct erofsfsck_cfg fsckcfg;
>   
> @@ -48,6 +51,8 @@ static struct option long_options[] = {
>   	{"no-preserve-owner", no_argument, 0, 10},
>   	{"no-preserve-perms", no_argument, 0, 11},
>   	{"offset", required_argument, 0, 12},
> +	{"xattrs", no_argument, 0, 13},
> +	{"no-xattrs", no_argument, 0, 14},
>   	{0, 0, 0, 0},
>   };
>   
> @@ -98,6 +103,7 @@ static void usage(int argc, char **argv)
>   		" --extract[=X]          check if all files are well encoded, optionally\n"
>   		"                        extract to X\n"
>   		" --offset=#             skip # bytes at the beginning of IMAGE\n"
> +		" --[no-]xattrs          whether to dump extended attributes (default off)\n"
>   		"\n"
>   		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
>   		"\n"
> @@ -225,6 +231,12 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>   				return -EINVAL;
>   			}
>   			break;
> +		case 13:
> +			fsckcfg.dump_xattrs = true;
> +			break;
> +		case 14:
> +			fsckcfg.dump_xattrs = false;
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -411,6 +423,84 @@ out:
>   	return ret;
>   }
>   
> +static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
> +{
> +	static bool ignore_xattrs = false;
> +	char *keylst, *key;
> +	ssize_t kllen;
> +	int ret;
> +
> +	kllen = erofs_listxattr(inode, NULL, 0);
> +	if (kllen <= 0)
> +		return kllen;
> +	keylst = malloc(kllen);
> +	if (!keylst)
> +		return -ENOMEM;
> +	ret = erofs_listxattr(inode, keylst, kllen);
> +	if (ret != kllen) {
> +		erofs_err("failed to list xattrs @ nid %llu",
> +			  inode->nid | 0ULL);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	ret = 0;
> +	for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
> +		unsigned int index, len;
> +		void *value = NULL;
> +		size_t size = 0;
> +
> +		ret = erofs_getxattr(inode, key, NULL, 0);
> +		if (ret <= 0)
> +			break;

When does erofs_getxattr() return <= 0?

Should we add some print messages too? like:
		erofs_err("failed to get xattr value size of `%s` @ nid %llu",
			  key, inode->nid | 0ULL);

Otherwise this patch looks good to me.

Thanks,
Gao Xiang
