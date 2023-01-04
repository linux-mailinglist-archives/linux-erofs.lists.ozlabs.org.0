Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756065CFB5
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 10:37:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nn4Js1pjlz3bYW
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 20:37:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.12; helo=out199-12.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com [47.90.199.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nn4Jk6nj4z2yyZ
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 20:37:40 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VYrHRLE_1672825052;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYrHRLE_1672825052)
          by smtp.aliyun-inc.com;
          Wed, 04 Jan 2023 17:37:35 +0800
Message-ID: <3baffc9e-e0b8-e617-645b-5ed6f778dde6@linux.alibaba.com>
Date: Wed, 4 Jan 2023 17:37:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] erofs-utils: dump: support fragments
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20230104085130.21085-1-zbestahu@gmail.com>
From: Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230104085130.21085-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, mpiglet@outlook.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/1/4 16:51, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Add compressed fragments support for dump feature.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
> v2:
> - get rid of frag_ext_fmt
> - remove z_erofs_fill_inode_lazy call and related
> - record pathname for !packed_file
> - use 0..0 | 0 for fragment extent's physical part
> - add a new helper erofsdump_read_packed_inode instead of calling
>    erofsdump_readdir(sbi.packed_nid)
> - show "File :" -> "Path :"
> - improve the print format for packed nid
> 
>   dump/main.c | 69 +++++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 59 insertions(+), 10 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index bc4f047..bdea301 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -14,6 +14,8 @@
>   #include "erofs/inode.h"
>   #include "erofs/io.h"
>   #include "erofs/dir.h"
> +#include "erofs/compress.h"
> +#include "erofs/fragments.h"
>   #include "../lib/liberofs_private.h"
>   
>   #ifdef HAVE_LIBUUID
> @@ -96,6 +98,7 @@ static struct erofsdump_feature feature_lists[] = {
>   	{ false, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
>   	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
>   	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
> +	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
>   };
>   
>   static int erofsdump_readdir(struct erofs_dir_context *ctx);
> @@ -264,6 +267,32 @@ static int erofsdump_dirent_iter(struct erofs_dir_context *ctx)
>   	return erofsdump_readdir(ctx);
>   }
>   
> +static int erofsdump_read_packed_inode(void)
> +{
> +	int err;
> +	erofs_off_t occupied_size = 0;
> +	struct erofs_inode vi = { .nid = sbi.packed_nid };
> +
> +	if (!erofs_sb_has_fragments())
> +		return 0;
> +
> +	err = erofs_read_inode_from_disk(&vi);
> +	if (err) {
> +		erofs_err("failed to read packed file inode from disk");
> +		return err;
> +	}
> +
> +	err = erofsdump_get_occupied_size(&vi, &occupied_size);
> +	if (err) {
> +		erofs_err("get packed file size failed");
> +		return err;
> +	}
> +
> +	stats.files_total_size += occupied_size;
> +	update_file_size_statistics(occupied_size, false);
> +	return 0;
> +}
> +
>   static int erofsdump_readdir(struct erofs_dir_context *ctx)
>   {
>   	int err;
> @@ -354,10 +383,13 @@ static void erofsdump_show_fileinfo(bool show_extent)
>   		return;
>   	}
>   
> -	err = erofs_get_pathname(inode.nid, path, sizeof(path));
> -	if (err < 0) {
> -		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
> -		return;
> +	if (!erofs_is_packed_inode(&inode)) {
> +		err = erofs_get_pathname(inode.nid, path, sizeof(path));
> +		if (err < 0) {
> +			erofs_err("file path not found @ nid %llu",
> +				  inode.nid | 0ULL);
> +			return;
> +		}


Could we just

err = erofs_get_pathname(inode.nid, path, sizeof(path));
if (err < 0) {
	[ path = "(not found)"; ...]

	and go on?
}

>   	}
>   
>   	strftime(timebuf, sizeof(timebuf),
> @@ -366,7 +398,8 @@ static void erofsdump_show_fileinfo(bool show_extent)
>   	for (i = 8; i >= 0; i--)
>   		if (((access_mode >> i) & 1) == 0)
>   			access_mode_str[8 - i] = '-';
> -	fprintf(stdout, "File : %s\n", path);
> +	fprintf(stdout, "Path : %s\n",
> +		erofs_is_packed_inode(&inode) ? "packed_file" : path);
>   	fprintf(stdout, "Size: %" PRIu64"  On-disk size: %" PRIu64 "  %s\n",
>   		inode.i_size, size,
>   		file_category_types[erofs_mode_to_ftype(inode.i_mode)]);
> @@ -425,13 +458,21 @@ static void erofsdump_show_fileinfo(bool show_extent)
>   			return;
>   		}
>   
> -		fprintf(stdout, ext_fmt[!!mdev.m_deviceid], extent_count++,
> -			map.m_la, map.m_la + map.m_llen, map.m_llen,
> -			mdev.m_pa, mdev.m_pa + map.m_plen, map.m_plen,
> -			mdev.m_deviceid);
> +		if (map.m_flags & EROFS_MAP_FRAGMENT)
> +			fprintf(stdout, ext_fmt[!!mdev.m_deviceid],
> +				extent_count++,
> +				map.m_la, map.m_la + map.m_llen, map.m_llen,
> +				0, 0, 0, mdev.m_deviceid);
> +		else
> +			fprintf(stdout, ext_fmt[!!mdev.m_deviceid],
> +				extent_count++,
> +				map.m_la, map.m_la + map.m_llen, map.m_llen,
> +				mdev.m_pa, mdev.m_pa + map.m_plen, map.m_plen,
> +				mdev.m_deviceid);
>   		map.m_la += map.m_llen;
>   	}
> -	fprintf(stdout, "%s: %d extents found\n", path, extent_count);
> +	fprintf(stdout, "%s: %d extents found\n",
> +		erofs_is_packed_inode(&inode) ? "packed_file" : path, extent_count);

					(packed file)

Thanks,
Gao Xiang
