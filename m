Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EFA65CC22
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 04:22:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Nmvzw5wMrz3bTs
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 14:22:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=47.90.199.14; helo=out199-14.us.a.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out199-14.us.a.mail.aliyun.com (out199-14.us.a.mail.aliyun.com [47.90.199.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Nmvzq1NY8z2xbC
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 14:22:30 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VYpZ-L1_1672802543;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYpZ-L1_1672802543)
          by smtp.aliyun-inc.com;
          Wed, 04 Jan 2023 11:22:24 +0800
Message-ID: <e0b13df1-c5a7-724e-a724-f82cfc786c99@linux.alibaba.com>
Date: Wed, 4 Jan 2023 11:22:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs-utils: dump: add --ext # option to show top# file
 extensions
To: Qi Wang <mpiglet@outlook.com>, linux-erofs@lists.ozlabs.org
References: <OSZP286MB07099CC46D1B3F8EFA7EBAC6B2EC9@OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM>
From: Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <OSZP286MB07099CC46D1B3F8EFA7EBAC6B2EC9@OSZP286MB0709.JPNP286.PROD.OUTLOOK.COM>
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

Hi Qi,

On 2022/12/26 11:32, Qi Wang wrote:
> The --ext # option is used to let the user specify top# file extensions
> with higher occurrence, instead of hardcode some file extensions ahead.
> 
> Signed-off-by: Qi Wang <mpiglet@outlook.com>
> ---
>   dump/main.c | 131 ++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 101 insertions(+), 30 deletions(-)
> 
> diff --git a/dump/main.c b/dump/main.c
> index 49ff2b7..188ab34 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -6,6 +6,7 @@
>    *            Guo Xuenan <guoxuenan@huawei.com>
>    */
>   #define _GNU_SOURCE
> +#include <string.h>
>   #include <stdlib.h>
>   #include <getopt.h>
>   #include <time.h>
> @@ -15,6 +16,7 @@
>   #include "erofs/io.h"
>   #include "erofs/dir.h"
>   #include "../lib/liberofs_private.h"
> +#include "erofs/hashmap.h"
>   
>   #ifdef HAVE_LIBUUID
>   #include <uuid.h>
> @@ -29,17 +31,34 @@ struct erofsdump_cfg {
>   	bool show_subdirectories;
>   	erofs_nid_t nid;
>   	const char *inode_path;
> +	unsigned int show_ext_count;
>   };
>   static struct erofsdump_cfg dumpcfg;
>   
>   static const char chart_format[] = "%-16s	%-11d %8.2f%% |%-50s|\n";
>   static const char header_format[] = "%-16s %11s %16s |%-50s|\n";
> -static char *file_types[] = {
> -	".txt", ".so", ".xml", ".apk",
> -	".odex", ".vdex", ".oat", ".rc",
> -	".otf", ".txt", "others",
> +
> +struct postfix_statistics {

Thanks for the patch.  However what does postfix mean?

I think erofsdump_extension_statistics would be better..

> +	struct hashmap_entry ent;
> +	char postfix[16];

	char suffix[16];

> +	unsigned int count;
> +	unsigned long occupied_size;
> +	unsigned long original_size;
>   };
> -#define OTHERFILETYPE	ARRAY_SIZE(file_types)
> +
> +static int erofs_postfix_hashmap_cmp(const void *a, const void *b,
> +				  const void *key)
> +{
> +	const struct postfix_statistics *ps1 =
> +			container_of((struct hashmap_entry *)a,
> +				     struct postfix_statistics, ent);
> +	const struct postfix_statistics *ps2 =
> +			container_of((struct hashmap_entry *)b,
> +				     struct postfix_statistics, ent);
> +
> +	return strncmp(ps1->postfix, key ? key : ps2->postfix, sizeof(ps1->postfix));
> +}
> +
>   /* (1 << FILE_MAX_SIZE_BITS)KB */
>   #define	FILE_MAX_SIZE_BITS	16
>   
> @@ -65,7 +84,7 @@ struct erofs_statistics {
>   	/* [statistics] # of files based on inode_info->flags */
>   	unsigned long file_category_stat[EROFS_FT_MAX];
>   	/* [statistics] # of files based on file name extensions */
> -	unsigned int file_type_stat[OTHERFILETYPE];
> +	struct hashmap postfix_hashmap;
>   	/* [statistics] # of files based on the original size of files */
>   	unsigned int file_original_size[FILE_MAX_SIZE_BITS + 1];
>   	/* [statistics] # of files based on the compressed size of files */
> @@ -79,6 +98,7 @@ static struct option long_options[] = {
>   	{"device", required_argument, NULL, 3},
>   	{"path", required_argument, NULL, 4},
>   	{"ls", no_argument, NULL, 5},
> +	{"ext", required_argument, NULL, 6},

	{"extensions" ... } ?

>   	{0, 0, 0, 0},
>   };
>   
> @@ -111,6 +131,7 @@ static void usage(void)
>   	      " --ls            show directory contents (INODE required)\n"
>   	      " --nid=#         show the target inode info of nid #\n"
>   	      " --path=X        show the target inode info of path X\n"
> +	      " --ext=#         show the top # extension file info\n"

		show the file statistics for the top # extensions?

>   	      " --help          display this help and exit.\n",
>   	      stderr);
>   }
> @@ -164,6 +185,9 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
>   		case 5:
>   			dumpcfg.show_subdirectories = true;
>   			break;
> +		case 6:
> +			dumpcfg.show_ext_count = atoi(optarg);
> +			break;
>   		default:
>   			return -EINVAL;
>   		}
> @@ -208,20 +232,41 @@ static int erofsdump_get_occupied_size(struct erofs_inode *inode,
>   	return 0;
>   }
>   
> -static void inc_file_extension_count(const char *dname, unsigned int len)
> +static void inc_file_extension_count(const char *dname, unsigned int len,
> +		unsigned long occupied_size, unsigned long original_size)
>   {
>   	char *postfix = memrchr(dname, '.', len);
> -	int type;
> +	unsigned int hash, plen;
> +	struct postfix_statistics *ps;
> +	char pf[sizeof(ps->postfix)] = {0};
> +
> +	plen = len - (postfix - dname);
> +	if (plen > sizeof(ps->postfix))
> +		plen = sizeof(ps->postfix);

Do we need to have one entry for files without extension?

> +	if (postfix) {
> +		memcpy(pf, postfix, plen);
> +		hash = strhash(pf);
> +		ps = hashmap_get_from_hash(&stats.postfix_hashmap, hash, pf);
> +		if (ps) {
> +			ps->count++;
> +			ps->occupied_size += occupied_size;
> +			ps->original_size += original_size;
> +			return;
> +		}
> +		ps = malloc(sizeof(struct postfix_statistics));
> +		if (!ps) {
> +			erofs_err("memory allocation failed!");
> +			return;
> +		}
>   
> -	if (!postfix) {
> -		type = OTHERFILETYPE - 1;
> -	} else {
> -		for (type = 0; type < OTHERFILETYPE - 1; ++type)
> -			if (!strncmp(postfix, file_types[type],
> -				     len - (postfix - dname)))
> -				break;
> +		ps->count = 1;
> +		ps->occupied_size = occupied_size;
> +		ps->original_size = original_size;
> +		memset(ps->postfix, 0, sizeof(ps->postfix));
> +		strncpy(ps->postfix, pf, plen);
> +		hashmap_entry_init(&ps->ent, hash);
> +		hashmap_add(&stats.postfix_hashmap, ps);
>   	}
> -	++stats.file_type_stat[type];
>   }
>   
>   static void update_file_size_statatics(erofs_off_t occupied_size,
> @@ -298,7 +343,7 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
>   
>   	if (S_ISREG(vi.i_mode)) {
>   		stats.files_total_origin_size += vi.i_size;
> -		inc_file_extension_count(ctx->dname, ctx->de_namelen);
> +		inc_file_extension_count(ctx->dname, ctx->de_namelen, occupied_size, vi.i_size);
>   		stats.files_total_size += occupied_size;
>   		update_file_size_statatics(occupied_size, vi.i_size);
>   	}
> @@ -481,27 +526,50 @@ static void erofsdump_filesize_distribution(const char *title,
>   	}
>   }
>   
> -static void erofsdump_filetype_distribution(char **file_types, unsigned int len)
> +static int comp_postfix_statistics(const void *a, const void *b)
> +{
> +	const struct postfix_statistics *psa, *psb;
> +
> +	psa = a;
> +	psb = b;
> +	return psa->count < psb->count ? 1 :
> +		(psa->count > psb->count) ? -1 : 0;
> +}
> +
> +static void erofsdump_filetype_distribution(int topk)
>   {
>   	char col1[30];
> -	unsigned int col2, i;
> -	double col3;
> +	unsigned int col2, i, pos;
> +	double col3, compression_rate;
>   	char col4[401];
> -
> +	struct postfix_statistics *ps_array;
> +	struct postfix_statistics *ps;
> +	struct hashmap_iter iter;
> +
> +	pos = 0;
> +	ps_array = malloc(sizeof(struct postfix_statistics) * stats.postfix_hashmap.size);
> +	hashmap_iter_init(&stats.postfix_hashmap, &iter);
> +	while ((ps = hashmap_iter_next(&iter)))
> +		ps_array[pos++] = *ps;
> +
> +	DBG_BUGON(pos != stats.postfix_hashmap.size);
> +	qsort(ps_array, pos, sizeof(struct postfix_statistics),
> +			comp_postfix_statistics);
>   	fprintf(stdout, "\nFile type distribution:\n");
>   	fprintf(stdout, header_format, "type", "count", "ratio",
> -			"distribution");
> -	for (i = 0; i < len; i++) {
> +			"compression rate");
> +	for (i = 0; i < topk && i < pos; i++) {
>   		memset(col1, 0, sizeof(col1));
> -		memset(col4, 0, sizeof(col4));
> -		sprintf(col1, "%-17s", file_types[i]);
> -		col2 = stats.file_type_stat[i];
> +		sprintf(col1, "%-17s", ps_array[i].postfix);
> +		col2 = ps_array[i].count;
>   		if (stats.file_category_stat[EROFS_FT_REG_FILE])
>   			col3 = (double)(100 * col2) /
>   				stats.file_category_stat[EROFS_FT_REG_FILE];
>   		else
>   			col3 = 0.0;
> -		memset(col4, '#', col3 / 2);
> +		compression_rate = 100.0 * (double)ps_array[i].occupied_size /
> +				(double)ps_array[i].original_size;
> +		sprintf(col4, "%.2f%%", compression_rate);
>   		fprintf(stdout, chart_format, col1, col2, col3, col4);
>   	}
>   }
> @@ -543,6 +611,7 @@ static void erofsdump_print_statistic(void)
>   		.de_namelen = 0,
>   	};
>   
> +	hashmap_init(&stats.postfix_hashmap, erofs_postfix_hashmap_cmp, 0);
>   	err = erofsdump_readdir(&ctx);
>   	if (err) {
>   		erofs_err("read dir failed");
> @@ -555,7 +624,7 @@ static void erofsdump_print_statistic(void)
>   	erofsdump_filesize_distribution("On-disk",
>   			stats.file_comp_size,
>   			ARRAY_SIZE(stats.file_comp_size));
> -	erofsdump_filetype_distribution(file_types, OTHERFILETYPE);
> +	erofsdump_filetype_distribution(dumpcfg.show_ext_count);
>   }
>   
>   static void erofsdump_show_superblock(void)
> @@ -624,9 +693,11 @@ int main(int argc, char **argv)
>   	if (dumpcfg.show_superblock)
>   		erofsdump_show_superblock();
>   
> -	if (dumpcfg.show_statistics)
> +	if (dumpcfg.show_statistics) {
> +		if (dumpcfg.show_ext_count == 0)
> +			dumpcfg.show_ext_count = 10;
>   		erofsdump_print_statistic();
> -
> +	}

also do we have some logic to free hashmap and extension entries?

Thanks,
Gao Xiang

>   	if (dumpcfg.show_extent && !dumpcfg.show_inode) {
>   		usage();
>   		goto exit_dev_close;
