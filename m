Return-Path: <linux-erofs+bounces-1991-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D46D3A200
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 09:47:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvkbh2FScz2xSZ;
	Mon, 19 Jan 2026 19:47:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768812432;
	cv=none; b=G2fs88tgPNvwwS6pYYst+Gzv+ClNm7fDY+7AQEZEpdWMfjcZ5pJEuzZnOJ6YkZ/FC4s3jok74ONPaD3yHsqrMIGCdbuuR6O+djQarr/K6lpsh1lSzraVyqUszdoB3sbHDNOy4EoZmS7KnzumQrKWlc+qT+ANNZ3kUhXWxEs2vHcGPMroxsLTRn/2yjxtlx4Noz+Mc6qzqRxzh5Xu2Kj64tC0VQNom7sOgs6ASh3hfOfxsKtnxlYfdQ/KNF4fBHc4Mb65QhmSurzmCT67+WHJ04kQmWySLcg35fsdc4oTO/KF6qoMc3ZAZJyjK529JCMPnQ/4EincLoabVAeFZQpYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768812432; c=relaxed/relaxed;
	bh=NC8C/At5zudmMZYhU5gVrXR7KmnoAockZqNe5wllTKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WbShm91hxHr4EVFRa7kqfmcBRV270Ot7Aq8f0pRg+Ep+BFl/FOnNTzLblnif/0QX0NNhN5LiqsqUkOhXcut4Lw196jWpth0wAQChrZoyeJ8bl4xQJ59t+JlYINZiNatLB/IbHreuJ5h92zsOpgY7lfdYfetWE8SJaC2aD9GMNa0BtbW1TDvtigSzwK4CaC+vpmi6yBbTSOllOZpc0AYP212AzBWraiq4T1/cVDaiLFt8VJnpS58vmANHlwoGgV/ODMfsKUMEoZMS8geERKjaElNnho225Q4wU3KCOb561QXNdqi6yKOnP0jiPHQt40F/THbwBZnAmG7tErS2nBqunA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=YFoalJmp; dkim-atps=neutral; spf=pass (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=YFoalJmp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.220; helo=canpmsgout05.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvkbc1THVz2xHW
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 19:47:07 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NC8C/At5zudmMZYhU5gVrXR7KmnoAockZqNe5wllTKE=;
	b=YFoalJmpi/uB/ErMx6JuqFO0EqqNNdzlW4gmpwa5SHlO6dGfB5bbRJRqKQX5959tlLBIvcP4E
	u4Yi39FnG2NSUNP3Kws+z0T7gIjmz8xZfRNux9HvzJ01YJ9zBy4FtHby2EU4AvV/+0COe/o56hi
	XjUGvyWaa+NdkIejIfvGAhc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dvkVt3kwSz12LCj;
	Mon, 19 Jan 2026 16:43:02 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 10A34405A8;
	Mon, 19 Jan 2026 16:47:02 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 19 Jan 2026 16:47:01 +0800
Message-ID: <9b3ea89a-99fc-412b-99fd-10fa7b21ea17@huawei.com>
Date: Mon, 19 Jan 2026 16:47:00 +0800
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
Subject: Re: [PATCH v5] erofs-utils: lib: fix incorrect mtime under
 -Edot-omitted
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <oliver.yang@linux.alibaba.com>
References: <9c9312c9-1a0e-4c39-aad5-c805e1641a36@linux.alibaba.com>
 <20260119065536.2779283-1-hsiangkao@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20260119065536.2779283-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 2026/1/19 14:55, Gao Xiang wrote:
> From: Yifan Zhao <zhaoyifan28@huawei.com>
>
> `-Edot-omitted` enables `-E48bits`, which requires specific
> configurations for g_sbi.{epoch, build_time}. Currently, the call to
> `erofs_sb_set_48bit()` occurs too late in the execution flow, causing
> the aforementioned logic to be bypassed and resulting in incorrect
> mtimes for all inodes.
>
> This patch moves time initialization logic into `erofs_importer_init()`
> to resolve this issue.
>
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Tested-by: Yifan Zhao <zhaoyifan28@huawei.com>


Thanks,

Yifan

> ---
> it seems the previous reply version was broken due to invalid formats.
>
>   include/erofs/config.h   |  1 -
>   include/erofs/importer.h |  1 +
>   lib/config.c             |  1 -
>   lib/importer.c           | 11 +++++++++++
>   mkfs/main.c              | 26 +++++++++++---------------
>   5 files changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 525a8cd5ebfb..2a84fb515868 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -58,7 +58,6 @@ struct erofs_configure {
>   	char c_force_chunkformat;
>   	u8 c_mkfs_metabox_algid;
>   	u32 c_max_decompressed_extent_bytes;
> -	u64 c_unix_timestamp;
>   	const char *mount_point;
>   	u32 c_root_xattr_isize;
>   #ifdef EROFS_MT_ENABLED
> diff --git a/include/erofs/importer.h b/include/erofs/importer.h
> index a525b474f1d5..15e247e51b9c 100644
> --- a/include/erofs/importer.h
> +++ b/include/erofs/importer.h
> @@ -41,6 +41,7 @@ struct erofs_importer_params {
>   	u32 pclusterblks_def;
>   	u32 pclusterblks_packed;
>   	s32 pclusterblks_metabox;
> +	s64 build_time;
>   	char force_inodeversion;
>   	bool ignore_mtime;
>   	bool no_datainline;
> diff --git a/lib/config.c b/lib/config.c
> index 16b34fa840d3..5eb0ddeaa851 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -29,7 +29,6 @@ void erofs_init_configure(void)
>   	cfg.c_dbg_lvl  = EROFS_WARN;
>   	cfg.c_version  = PACKAGE_VERSION;
>   	cfg.c_dry_run  = false;
> -	cfg.c_unix_timestamp = -1;
>   	cfg.c_max_decompressed_extent_bytes = -1;
>   	erofs_stdout_tty = isatty(STDOUT_FILENO);
>   }
> diff --git a/lib/importer.c b/lib/importer.c
> index 958a433b9eaa..d686c519676b 100644
> --- a/lib/importer.c
> +++ b/lib/importer.c
> @@ -23,6 +23,7 @@ void erofs_importer_preset(struct erofs_importer_params *params)
>   		.fixed_uid = -1,
>   		.fixed_gid = -1,
>   		.fsalignblks = 1,
> +		.build_time = -1,
>   	};
>   }
>   
> @@ -83,6 +84,16 @@ int erofs_importer_init(struct erofs_importer *im)
>   
>   	if (params->dot_omitted)
>   		erofs_sb_set_48bit(sbi);
> +
> +	if (params->build_time != -1) {
> +		if (erofs_sb_has_48bit(sbi)) {
> +			sbi->epoch = max_t(s64, 0, params->build_time - UINT32_MAX);
> +			sbi->build_time = params->build_time - sbi->epoch;
> +		} else {
> +			sbi->epoch = params->build_time;
> +		}
> +	}
> +
>   	return 0;
>   
>   out_err:
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b45368f301f3..683c650db519 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -274,8 +274,10 @@ static struct erofsmkfs_cfg {
>   	/* < 0, xattr disabled and >= INT_MAX, always use inline xattrs */
>   	long inlinexattr_tolerance;
>   	bool inode_metazone;
> +	u64 unix_timestamp;
>   } mkfscfg = {
>   	.inlinexattr_tolerance = 2,
> +	.unix_timestamp = -1,
>   };
>   
>   static unsigned int pclustersize_packed, pclustersize_max;
> @@ -1096,8 +1098,8 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
>   			break;
>   
>   		case 'T':
> -			cfg.c_unix_timestamp = strtoull(optarg, &endptr, 0);
> -			if (cfg.c_unix_timestamp == -1 || *endptr != '\0') {
> +			mkfscfg.unix_timestamp = strtoull(optarg, &endptr, 0);
> +			if (mkfscfg.unix_timestamp == -1 || *endptr != '\0') {
>   				erofs_err("invalid UNIX timestamp %s", optarg);
>   				return -EINVAL;
>   			}
> @@ -1576,7 +1578,7 @@ int parse_source_date_epoch(void)
>   			  source_date_epoch);
>   		return -EINVAL;
>   	}
> -	cfg.c_unix_timestamp = epoch;
> +	mkfscfg.unix_timestamp = epoch;
>   	cfg.c_timeinherit = TIMESTAMP_CLAMPING;
>   	return 0;
>   }
> @@ -1702,7 +1704,6 @@ int main(int argc, char **argv)
>   	bool tar_index_512b = false;
>   	struct timeval t;
>   	FILE *blklst = NULL;
> -	s64 mkfs_time = 0;
>   	int err;
>   	u32 crc;
>   
> @@ -1727,17 +1728,12 @@ int main(int argc, char **argv)
>   	}
>   
>   	g_sbi.fixed_nsec = 0;
> -	if (cfg.c_unix_timestamp != -1) {
> -		mkfs_time = cfg.c_unix_timestamp;
> -	} else if (!gettimeofday(&t, NULL)) {
> -		mkfs_time = t.tv_sec;
> -	}
> -	if (erofs_sb_has_48bit(&g_sbi)) {
> -		g_sbi.epoch = max_t(s64, 0, mkfs_time - UINT32_MAX);
> -		g_sbi.build_time = mkfs_time - g_sbi.epoch;
> -	} else {
> -		g_sbi.epoch = mkfs_time;
> -	}
> +	if (mkfscfg.unix_timestamp != -1)
> +		importer_params.build_time = mkfscfg.unix_timestamp;
> +	else if (!gettimeofday(&t, NULL))
> +		importer_params.build_time = t.tv_sec;
> +	else
> +		importer_params.build_time = 0;
>   
>   	err = erofs_dev_open(&g_sbi, cfg.c_img_path, O_RDWR |
>   				(incremental_mode ? 0 : O_TRUNC));

