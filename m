Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E06EB9778AE
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 08:13:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4kXB6YtLz2yn9
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 16:13:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726208022;
	cv=none; b=l5MVoMLoAa5bNFVXla8aSiDmr2HY2xqd3RGH41813looUsB7mjJzwJODlML5QDkZJqJ6QuyPyiE0cRrgZkK/Q2OilEawLu2OtFyeqra+tfGh2pM1pthIVN+CBxaQsdqFuz7TrsxpjH8pq2Hk8zuxIOoGnJ3UT+y+GGzKs2f1fihk3NfAugizk36LihX/cocoe2mjLtgVJZ461pbN46+CNq454cxAFE0VaN5YFOqrnyYhMFgPs49TDC9KyIwT1ru4dPAXaoSqauGVI3Q8dcF6pX2c+3FIxVnz7UeICtN/dEk/7GqxFe7+jcvT74W1Rm3vqCLNuRe3EGp5lQqesiUuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726208022; c=relaxed/relaxed;
	bh=mEL1aqsxMLCoNhLDq1j92lpVQjAmyYiEnRK38fgD0Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dNlSkCw+wzQyHcQjk1XKRiHuw00YyX3y7L7aq88AYiogRnR3yA9CDzuPMlO5M8J+x4ro01rYuv6AVXinnDe6OTGvXS0gdfGa6o6GmB9UVgmb/rkyMtM1xIuOe1GHnRVxKWXJNyzsQrW80AG3Zx0kfPrg9nzTyW3ryBIlGtHl6tYj/0KyrVOWivrJOymT0efvEsFLrIUoDSj3cO9CQ9O9XVXDnSAOUMOEfKHwN9mwtUlyg5kQHXyS9p8016uVrP6cY9NN+1NW2TzsL8b60e0wa7g8ywLyYkHAqprOmmvA52LJHoI6tvXO3U8Mf/0zKPr3RExZst6d6R7LnEandXwaaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xj+3PDy5; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xj+3PDy5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4kX46ngtz2yM6
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Sep 2024 16:13:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726208015; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mEL1aqsxMLCoNhLDq1j92lpVQjAmyYiEnRK38fgD0Z4=;
	b=xj+3PDy5te+f4dlVqsmIii2AfK/2cZskagZM2x/WimgFNx0AkHp2sTEp/dInub7S94WF/uyQhNsrvUJJOQIM5GMgVd64Hx1verJIB3BI5Zl6ExX116c6RsVfdMFyaKfvlXoMefeTKTjersORG3O9uL1TH6LuXgo485zVFTDGBIM=
Received: from 30.221.130.178(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEtqFow_1726208013)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 14:13:33 +0800
Message-ID: <4f72a713-73c8-4ac3-8c21-02abc5944bab@linux.alibaba.com>
Date: Fri, 13 Sep 2024 14:13:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] erofs-utils: fsck: introduce exporting xattrs
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240912131108.3742683-1-hongzhen@linux.alibaba.com>
 <20240912131108.3742683-2-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240912131108.3742683-2-hongzhen@linux.alibaba.com>
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



On 2024/9/12 21:11, Hongzhen Luo wrote:
> The current `fsck --extract` does not support exporting the extended
> attributes of files. This patch adds `--xattrs` option to dump the
> extended attributes, as well as the `--no-xattrs` option to not dump
> the extended attributes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v8: The code has been adjusted to look better.
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
> index 28f1e7e..af0c01f 100644
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
> +		size = ret;
> +		value = malloc(size);
> +		if (!value) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +		ret = erofs_getxattr(inode, key, value, size);
> +		if (ret < 0) {
> +			erofs_err("failed to get xattr `%s` @ nid %llu, because of `%s`", key,
> +				  inode->nid | 0ULL, erofs_strerror(ret));
> +			free(value);
> +			break;
> +		}
> +		if (fsckcfg.extract_path)
> +			ret = lsetxattr(fsckcfg.extract_path, key, value, size,
> +					0);
> +		else
> +			ret = 0;
> +		free(value);
> +		if (ret == -EPERM && !fsckcfg.superuser) {
> +			if (__erofs_unlikely(!erofs_xattr_prefix_matches(key,
> +					&index, &len))) {
> +				erofs_err("failed to match the prefix of `%s` @ nid %llu",
> +					  key, inode->nid | 0ULL);
> +				ret = -EINVAL;
> +				break;
> +			}
> +			if (index != EROFS_XATTR_INDEX_USER) {
> +				if (!ignore_xattrs) {
> +					erofs_warn("ignored xattr `%s` @ nid %llu, due to non-superuser",
> +						   key, inode->nid | 0ULL);
> +					ignore_xattrs = true;
> +				}
> +				ret = 0;
> +				continue;
> +			}
> +
> +		}
> +		if (ret) {
> +			erofs_err("failed to set xattr `%s` @ nid %llu because of `%s`",
> +				  key, inode->nid | 0ULL, erofs_strerror(ret));
> +			break;
> +		}
> +	}
> +out:
> +	free(keylst);
> +	return ret;
> +}
> +
>   static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>   {
>   	struct erofs_map_blocks map = {
> @@ -900,15 +990,23 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
>   		goto out;
>   	}
>   
> -	/* verify xattr field */
> -	ret = erofs_verify_xattr(&inode);
> -	if (ret)
> -		goto out;
> +	if (!fsckcfg.check_decomp) {

It should be `!(fsckcfg.check_decomp && fsckcfg.dump_xattr)`?

> +		/* verify xattr field */
> +		ret = erofs_verify_xattr(&inode);
> +		if (ret)
> +			goto out;
> +	}
>   
>   	ret = erofsfsck_extract_inode(&inode);
>   	if (ret && ret != -ECANCELED)
>   		goto out;
>   
> +	if (fsckcfg.check_decomp && fsckcfg.dump_xattrs) {
> +		ret = erofsfsck_dump_xattrs(&inode);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	/* XXXX: the dir depth should be restricted in order to avoid loops */
>   	if (S_ISDIR(inode.i_mode)) {
>   		struct erofs_dir_context ctx = {
> @@ -955,6 +1053,7 @@ int main(int argc, char *argv[])
>   	fsckcfg.overwrite = false;
>   	fsckcfg.preserve_owner = fsckcfg.superuser;
>   	fsckcfg.preserve_perms = fsckcfg.superuser;
> +	fsckcfg.dump_xattrs = false;
>   
>   	err = erofsfsck_parse_options_cfg(argc, argv);
>   	if (err) {
> diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
> index 393ae9e..fc862e2 100644
> --- a/man/fsck.erofs.1
> +++ b/man/fsck.erofs.1
> @@ -27,6 +27,9 @@ You may give multiple
>   .B --device
>   options in the correct order.
>   .TP
> +.BI "--[no-]xattrs"
> +Whether to dump extended attributes (default off).

Why is it placed here? (it should be located according
to alphabetic order)

Also better to be
`Whether to dump extended attributes during extraction (default off)`

Thanks,
Gao Xiang
