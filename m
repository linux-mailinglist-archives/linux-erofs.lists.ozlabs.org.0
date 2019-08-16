Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A150B8FC3D
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 09:25:15 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468vwk27cmzDrCS
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 17:25:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468vq8314VzDrcF
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 17:20:20 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 28A8BF1A7F1DEFD40379
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 15:20:16 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 16 Aug 2019 15:20:15 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 16
 Aug 2019 15:20:14 +0800
Date: Fri, 16 Aug 2019 15:37:21 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils : Fail the image creation when source path
 is not a directory file.
Message-ID: <20190816073721.GA26737@138>
References: <20190816070846.21557-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190816070846.21557-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Fri, Aug 16, 2019 at 12:38:46PM +0530, Pratik Shinde wrote:
> In the erofs.mkfs utility, if the source path is not a directory,image
> creation should not proceed.since root of the filesystem needs to be a directory.
> 
> In the erofs kernel code, we return error in case root inode(read from disk) is not
> a directory.But the mkfs utility lets you create an image based on Regular file
> (S_IFREG) too.

Yes, You are right. :)

Just a minor suggestion, how about moving the logic to main()?

194         err = mkfs_parse_options_cfg(argc, argv);
195         if (err) {
196                 if (err == -EINVAL)
197                         usage();
198                 return 1;
199         }

            ^ here
200
201         err = dev_open(cfg.c_img_path);
202         if (err) {
203                 usage();
204                 return 1;
205         }

Does it sound good to you? and I will test this patch later :)

Thanks,
Gao Xiang

> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  mkfs/main.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 93cacca..e72b9e2 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -12,6 +12,7 @@
>  #include <stdlib.h>
>  #include <limits.h>
>  #include <libgen.h>
> +#include <sys/stat.h>
>  #include "erofs/config.h"
>  #include "erofs/print.h"
>  #include "erofs/cache.h"
> @@ -76,8 +77,8 @@ static int parse_extended_opts(const char *opts)
>  
>  static int mkfs_parse_options_cfg(int argc, char *argv[])
>  {
> -	int opt, i;
> -
> +	int opt, i, ret;
> +	struct stat64 st;
>  	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
>  		switch (opt) {
>  		case 'z':
> @@ -135,7 +136,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  			  erofs_strerror(-errno));
>  		return -ENOENT;
>  	}
> -
> +	ret = lstat64(cfg.c_src_path, &st);
> +	if (ret)
> +		return -EINVAL;
> +	if ((st.st_mode & S_IFMT) != S_IFDIR) {
> +		erofs_err("root of the filesystem is not a directory - %s",
> +			  cfg.c_src_path);
> +		return -EINVAL;
> +	}
>  	if (optind < argc) {
>  		erofs_err("Unexpected argument: %s\n", argv[optind]);
>  		return -EINVAL;
> -- 
> 2.9.3
> 
