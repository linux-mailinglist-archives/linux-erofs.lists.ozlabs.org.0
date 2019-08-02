Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C35D87E795
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2019 03:43:17 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46090f0dCJzDqdn
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2019 11:43:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46090X3D0wzDqdP
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2019 11:43:06 +1000 (AEST)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A0D8C3B689D14364F706
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Aug 2019 09:43:00 +0800 (CST)
Received: from 138 (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 2 Aug 2019
 09:42:50 +0800
Date: Fri, 2 Aug 2019 10:00:04 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: error handling for incorrect dbg lvl &
 compression algorithm
Message-ID: <20190802014323.GA3911@138>
References: <20190801191809.13675-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190801191809.13675-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Fri, Aug 02, 2019 at 12:48:09AM +0530, Pratik Shinde wrote:
> handling the case of incorrect debug level.
> also, an early check for valid compression algorithm.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  mkfs/main.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index fdb65fd..4231d13 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -105,10 +105,22 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  				}
>  			}
>  			cfg.c_compr_alg_master = strndup(optarg, i);
> +			if (strcmp(cfg.c_compr_alg_master, "lz4")
> +			    && strcmp(cfg.c_compr_alg_master, "lz4hc")) {
> +				erofs_err("invalid compressor algorithm %s",
> +					  cfg.c_compr_alg_master);
> +				return -EINVAL;
> +			}

It should be do in the compressors, and we have:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/tree/lib/compressor.c?h=dev#n74

I'd like to know if some problems are out with the above code...

>  			break;
>  
>  		case 'd':
>  			cfg.c_dbg_lvl = parse_num_from_str(optarg);
> +			if (cfg.c_dbg_lvl < 0 || cfg.c_dbg_lvl > 9) {

I think we cannot directly do like the above since
not all compression algorithm levels are 0~9 (and the default level could be -1).
take a look at struct erofs_compressor and it has
	int default_level;
	int best_level;
I think maybe we have to define "worst_level" as well, and
it could be better do the above check in "int z_erofs_compress_init(void)"

Thanks,
Gao Xiang

> +				fprintf(stderr,
> +					"invalid debug level %d\n",
> +					cfg.c_dbg_lvl);
> +				return -EINVAL;
> +			}
>  			break;
>  
>  		case 'E':
> -- 
> 2.9.3
> 
