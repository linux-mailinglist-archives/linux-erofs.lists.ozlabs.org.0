Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A5086C619
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 10:55:37 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QrMGvIfj;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tlmn24M9Rz3dVZ
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 20:55:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QrMGvIfj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tlmmy372Lz3d40
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 20:55:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709200525; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tzsLI3hs05gsK+PQum/UnmxAJeVRYiDMgKyZU/LhHMU=;
	b=QrMGvIfjE0q4ySZInVRjChM/Uszg9JoibXEU8nr4yIQjlJcyDAZpSHLflESvkqIg14xjUqii9+xiwpmSeAdD24L4de2mvx4epgCbg2PmNO19eWBKOw2HX7Dj/D84DW+hctsI76FAm5McQtA7C7P7bZJAo7aXB+nZfUq8uliumz4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W1Sfl.8_1709200522;
Received: from 30.97.48.246(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1Sfl.8_1709200522)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 17:55:24 +0800
Message-ID: <8e353acb-0656-4951-8e24-0878c8edf184@linux.alibaba.com>
Date: Thu, 29 Feb 2024 17:55:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] erofs-utils: mkfs: add --worker=# parameter
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
References: <20240228161652.1010997-1-zhaoyifan@sjtu.edu.cn>
 <20240228161652.1010997-4-zhaoyifan@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240228161652.1010997-4-zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/2/29 00:16, Yifan Zhao wrote:
> This patch introduces a --worker=# parameter for the incoming
> multi-threaded compression support. It also introduces a segment size
> used in multi-threaded compression, which has the default value 16MB
> and cannot be modified.
> 
> It also introduces a concept called `segment size` to split large files
> for multi-threading, which has the default value 16MB for now.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
> ---
>   include/erofs/config.h |  4 ++++
>   lib/config.c           |  4 ++++
>   mkfs/main.c            | 38 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 46 insertions(+)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 73e3ac2..d2f91ff 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -75,6 +75,10 @@ struct erofs_configure {
>   	char c_force_chunkformat;
>   	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
>   	int c_inline_xattr_tolerance;
> +#ifdef EROFS_MT_ENABLED
> +	u64 c_segment_size;
> +	u32 c_mt_workers;
> +#endif
>   
>   	u32 c_pclusterblks_max, c_pclusterblks_def, c_pclusterblks_packed;
>   	u32 c_max_decompressed_extent_bytes;
> diff --git a/lib/config.c b/lib/config.c
> index 947a183..2530274 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -38,6 +38,10 @@ void erofs_init_configure(void)
>   	cfg.c_pclusterblks_max = 1;
>   	cfg.c_pclusterblks_def = 1;
>   	cfg.c_max_decompressed_extent_bytes = -1;
> +#ifdef EROFS_MT_ENABLED
> +	cfg.c_segment_size = 16ULL * 1024 * 1024;
> +	cfg.c_mt_workers = 1;
> +#endif
>   
>   	erofs_stdout_tty = isatty(STDOUT_FILENO);
>   }
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 258c1ce..ce9c28b 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -74,6 +74,9 @@ static struct option long_options[] = {
>   	{"ungzip", optional_argument, NULL, 517},
>   #endif
>   	{"offset", required_argument, NULL, 518},
> +#ifdef EROFS_MT_ENABLED
> +	{"workers", required_argument, NULL, 519},
> +#endif
>   	{0, 0, 0, 0},
>   };
>   
> @@ -179,6 +182,9 @@ static void usage(int argc, char **argv)
>   		" --product-out=X       X=product_out directory\n"
>   		" --fs-config-file=X    X=fs_config file\n"
>   		" --block-list-file=X   X=block_list file\n"
> +#endif
> +#ifdef EROFS_MT_ENABLED
> +		" --workers=#            set the number of worker threads to # (default=1)\n"
>   #endif
>   		);
>   }
> @@ -408,6 +414,13 @@ static void erofs_rebuild_cleanup(void)
>   	rebuild_src_count = 0;
>   }
>   
> +#ifdef EROFS_MT_ENABLED
> +static u32 mkfs_max_worker_num() {

static unsigned int erofs_mkfs_max_worker_num()
{
	return erofs_get_available_processors() ? : 16;
}

> +	u32 ncpu = erofs_get_available_processors();
> +	return ncpu ? ncpu : 16;
> +}
> +#endif
> +
>   static int mkfs_parse_options_cfg(int argc, char *argv[])
>   {
>   	char *endptr;
> @@ -650,6 +663,21 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   				return -EINVAL;
>   			}
>   			break;
> +#ifdef EROFS_MT_ENABLED
> +		case 519:
> +			cfg.c_mt_workers = strtoul(optarg, &endptr, 0);
> +			if (errno || *endptr != '\0') {
> +				erofs_err("invalid worker number %s", optarg);
> +				return -EINVAL;
> +			}
> +			if (cfg.c_mt_workers > mkfs_max_worker_num()) {
> +				erofs_warn(
> +					"worker number %s is too large, setting to %ud",
> +					optarg, mkfs_max_worker_num());
let's not break erofs_{err,warn,...} print line, it means:

				cfg.c_mt_workers = mkfs_max_worker_num();
				erofs_warn("worker number %s is too large, reseting to %ud",
					   optarg, cfg.c_mt_workers);

> +				cfg.c_mt_workers = mkfs_max_worker_num();
> +			}
> +			break;
> +#endif
>   		case 'V':
>   			version();
>   			exit(0);
> @@ -803,6 +831,16 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>   		}
>   		cfg.c_pclusterblks_packed = pclustersize_packed >> sbi.blkszbits;
>   	}
> +
> +#ifdef EROFS_MT_ENABLED
> +	if (cfg.c_mt_workers > 1 &&
> +	    (cfg.c_dedupe || cfg.c_fragments || cfg.c_ztailpacking)) {
> +		cfg.c_mt_workers = 1;
> +		erofs_warn("Please note that dedupe/fragments/ztailpacking"
> +			   "is NOT supported in multi-threaded mode now, using worker=1.");
> +	}
> +#endif

This part would be better to go with the next patch.

Thanks,
Gao Xiang
