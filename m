Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F665CC16
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 04:14:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nmvp63ynHz3bXL
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 14:14:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45; helo=out30-45.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nmvp22QqYz2xkD
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 14:14:01 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VYpmp7P_1672802035;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYpmp7P_1672802035)
          by smtp.aliyun-inc.com;
          Wed, 04 Jan 2023 11:13:57 +0800
Message-ID: <443a1f23-451a-c964-442b-843519ce9ec9@linux.alibaba.com>
Date: Wed, 4 Jan 2023 11:13:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 2/2] erofs-utils: dump: support fragments
To: Yue Hu <zbestahu@gmail.com>, linux-erofs@lists.ozlabs.org
References: <0e4797ef5f22ac3c2134aa4b005c489c233d2eec.1671443064.git.huyue2@coolpad.com>
 <8c66d0d7b0d4f5fa18566bedeaa0b38458b97aa7.1671443064.git.huyue2@coolpad.com>
From: Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <8c66d0d7b0d4f5fa18566bedeaa0b38458b97aa7.1671443064.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2022/12/19 17:50, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> Add compressed fragments support for dump feature.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>   dump/main.c              | 78 ++++++++++++++++++++++++++++++++--------
>   include/erofs/internal.h |  1 +
>   lib/zmap.c               |  2 +-
>   3 files changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index bc4f047..d387841 100644
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
> @@ -285,10 +288,12 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
>   	}
>   
>   	if (S_ISREG(vi.i_mode)) {
> -		stats.files_total_origin_size += vi.i_size;
> -		inc_file_extension_count(ctx->dname, ctx->de_namelen);
> +		if (!erofs_is_packed_inode(&vi)) {
> +			stats.files_total_origin_size += vi.i_size;
> +			inc_file_extension_count(ctx->dname, ctx->de_namelen);
> +			update_file_size_statistics(vi.i_size, true);
> +		}
>   		stats.files_total_size += occupied_size;
> -		update_file_size_statistics(vi.i_size, true);
>   		update_file_size_statistics(occupied_size, false);
>   	}
>   
> @@ -320,6 +325,10 @@ static void erofsdump_show_fileinfo(bool show_extent)
>   		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 " : %10" PRIu64 "..%10" PRIu64 " | %7" PRIu64 "\n",
>   		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 " : %10" PRIu64 "..%10" PRIu64 " | %7" PRIu64 "  # device %u\n"
>   	};
> +	const char *frag_ext_fmt[] = {
> +		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 "\n",
> +		"%4d: %8" PRIu64 "..%8" PRIu64 " | %7" PRIu64 "  # device %u\n"
> +	};

Why do we need another fmt rather than just fill fragment extent with 
physical addr 0?

>   	int err, i;
>   	erofs_off_t size;
>   	u16 access_mode;
> @@ -348,16 +357,31 @@ static void erofsdump_show_fileinfo(bool show_extent)
>   		}
>   	}
>   
> +	if (erofs_inode_is_data_compressed(inode.datalayout)) {
> +		err = z_erofs_fill_inode_lazy(&inode);
> +		if (err) {
> +			erofs_err("read inode map header failed @ nid %llu",
> +				  inode.nid | 0ULL);
> +			return;
> +		}
> +	}

Why do we need to call z_erofs_fill_inode_lazy here?

> +
>   	err = erofs_get_occupied_size(&inode, &size);
>   	if (err) {
>   		erofs_err("get file size failed @ nid %llu", inode.nid | 0ULL);
>   		return;
>   	}
>   
> -	err = erofs_get_pathname(inode.nid, path, sizeof(path));
> -	if (err < 0) {
> -		erofs_err("file path not found @ nid %llu", inode.nid | 0ULL);
> -		return;

Can we just ignore pathname if it doesn't exist?

> +	if (erofs_is_packed_inode(&inode) { > +		strncpy(path, EROFS_PACKED_INODE, sizeof(path) - 1);
> +		path[sizeof(path) - 1] = '\0';
> +	} else {
> +		err = erofs_get_pathname(inode.nid, path, sizeof(path));
> +		if (err < 0) {
> +			erofs_err("file path not found @ nid %llu",
> +				  inode.nid | 0ULL);
> +			return;
> +		}
>   	}
>   
>   	strftime(timebuf, sizeof(timebuf),
> @@ -372,9 +396,13 @@ static void erofsdump_show_fileinfo(bool show_extent)
>   		file_category_types[erofs_mode_to_ftype(inode.i_mode)]);
>   	fprintf(stdout, "NID: %" PRIu64 "   ", inode.nid);
>   	fprintf(stdout, "Links: %u   ", inode.i_nlink);
> -	fprintf(stdout, "Layout: %d   Compression ratio: %.2f%%\n",
> -		inode.datalayout,
> -		(double)(100 * size) / (double)(inode.i_size));
> +	if (inode.z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)
> +		fprintf(stdout, "Layout: %d   Fragment: %s\n",
> +			inode.datalayout, size ? "partial" : "full");
> +	else
> +		fprintf(stdout, "Layout: %d   Compression ratio: %.2f%%\n",
> +			inode.datalayout,
> +			(double)(100 * size) / (double)(inode.i_size));
>   	fprintf(stdout, "Inode size: %d   ", inode.inode_isize);
>   	fprintf(stdout, "Extent size: %u   ", inode.extent_isize);
>   	fprintf(stdout,	"Xattr size: %u\n", inode.xattr_isize);
> @@ -404,7 +432,8 @@ static void erofsdump_show_fileinfo(bool show_extent)
>   	if (!dumpcfg.show_extent)
>   		return;
>   
> -	fprintf(stdout, "\n Ext:   logical offset   |  length :     physical offset    |  length\n");
> +	fprintf(stdout, "\n Ext:   logical offset   |  length%s\n",
> +			size ? " :     physical offset    |  length" : "");
>   	while (map.m_la < inode.i_size) {
>   		struct erofs_map_dev mdev;
>   
> @@ -425,10 +454,17 @@ static void erofsdump_show_fileinfo(bool show_extent)
>   			return;
>   		}
>   
> -		fprintf(stdout, ext_fmt[!!mdev.m_deviceid], extent_count++,
> -			map.m_la, map.m_la + map.m_llen, map.m_llen,
> -			mdev.m_pa, mdev.m_pa + map.m_plen, map.m_plen,
> -			mdev.m_deviceid);
> +		if (map.m_flags & EROFS_MAP_FRAGMENT)
> +			fprintf(stdout, frag_ext_fmt[!!mdev.m_deviceid],
> +				extent_count++,
> +				map.m_la, map.m_la + map.m_llen, map.m_llen,
> +				mdev.m_deviceid);

except for the last fragment extent, the other extents all have physical 
addr and length...

> +		else
> +			fprintf(stdout, ext_fmt[!!mdev.m_deviceid],
> +				extent_count++,
> +				map.m_la, map.m_la + map.m_llen, map.m_llen,
> +				mdev.m_pa, mdev.m_pa + map.m_plen, map.m_plen,
> +				mdev.m_deviceid);
>   		map.m_la += map.m_llen;
>   	}
>   	fprintf(stdout, "%s: %d extents found\n", path, extent_count);
> @@ -537,6 +573,15 @@ static void erofsdump_print_statistic(void)
>   		erofs_err("read dir failed");
>   		return;
>   	}
> +	if (erofs_sb_has_fragments()) {
> +		err = erofsdump_readdir(&(struct erofs_dir_context) {
> +					.de_nid = sbi.packed_nid
> +					});

why do we need this?

Thanks,
Gao Xiang

> +		if (err) {
> +			erofs_err("read packed inode failed");
> +			return;
> +		}
> +	}
>   	erofsdump_file_statistic();
>   	erofsdump_filesize_distribution("Original",
>   			stats.file_original_size,
> @@ -563,6 +608,9 @@ static void erofsdump_show_superblock(void)
>   			sbi.xattr_blkaddr);
>   	fprintf(stdout, "Filesystem root nid:                          %llu\n",
>   			sbi.root_nid | 0ULL);
> +	if (erofs_sb_has_fragments())
> +		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
> +				sbi.packed_nid | 0ULL);
>   	fprintf(stdout, "Filesystem inode count:                       %llu\n",
>   			sbi.inos | 0ULL);
>   	fprintf(stdout, "Filesystem created:                           %s",
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 206913c..947894d 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -383,6 +383,7 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size);
>   
>   /* zmap.c */
>   int z_erofs_fill_inode(struct erofs_inode *vi);
> +int z_erofs_fill_inode_lazy(struct erofs_inode *vi);
>   int z_erofs_map_blocks_iter(struct erofs_inode *vi,
>   			    struct erofs_map_blocks *map, int flags);
>   
> diff --git a/lib/zmap.c b/lib/zmap.c
> index 89e9da1..41e0713 100644
> --- a/lib/zmap.c
> +++ b/lib/zmap.c
> @@ -29,7 +29,7 @@ int z_erofs_fill_inode(struct erofs_inode *vi)
>   	return 0;
>   }
>   
> -static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
> +int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
>   {
>   	int ret;
>   	erofs_off_t pos;
