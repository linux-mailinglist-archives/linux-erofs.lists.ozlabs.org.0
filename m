Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC04DFC09
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 04:48:21 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46xycL3kM9zDqK5
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 13:48:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46xycC2YMgzDqDX
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Oct 2019 13:48:08 +1100 (AEDT)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 5486FDC4F8CF40EA04DB;
 Tue, 22 Oct 2019 10:48:00 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 22 Oct 2019 10:47:59 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 22 Oct 2019 10:47:59 +0800
Date: Tue, 22 Oct 2019 10:50:53 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <wylgf01@163.com>, Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH v1] erofs-utils: introduce long parameter option
Message-ID: <20191022025053.GA180717@architecture4>
References: <20191021181923.3773-1-wylgf01@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191021181923.3773-1-wylgf01@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Tue, Oct 22, 2019 at 02:19:23AM +0800, Li Guifu wrote:
> From: Li Guifu <blucerlee@gmail.com>
> 
> Only --help|-h is uesed right now

                    ^
typo in the commit message.


> 
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> ---
>  mkfs/main.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 71c81f5..f62b065 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -13,6 +13,8 @@
>  #include <limits.h>
>  #include <libgen.h>
>  #include <sys/stat.h>
> +#include <getopt.h>
> +
>  #include "erofs/config.h"
>  #include "erofs/print.h"
>  #include "erofs/cache.h"
> @@ -23,10 +25,16 @@
>  
>  #define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
>  
> +static struct option long_options[] = {
> +	{"help", no_argument, 0, 'h'},


How about removing '-h' from help message?
Thus we can keep '-h' for later usage instead of just print messages.

like,
	{"help", no_argument, 0, 1},


> +	{0, 0, 0, 0},
> +};
> +
>  static void usage(void)
>  {
>  	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
>  	fprintf(stderr, "Generate erofs image from DIRECTORY to FILE, and [options] are:\n");
> +	fprintf(stderr, " -h|--help print usage message then exit 0\n");

How about moving it to the last line with the following change?

	                "--help     display this help and exit"

and can we merge all fprintf into one line?


>  	fprintf(stderr, " -zX[,Y]   X=compressor (Y=compression level, optional)\n");
>  	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
>  	fprintf(stderr, " -x#       set xattr tolerance to # (< 0, disable xattrs; default 2)\n");
> @@ -95,8 +103,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  {
>  	char *endptr;
>  	int opt, i;
> +	int option_index = 0;
>  
> -	while ((opt = getopt(argc, argv, "d:x:z:E:T:")) != -1) {
> +	while((opt = getopt_long(argc, argv, "d:z:E:T:h", long_options,

	while((opt = getopt_long(argc, argv, "d:z:E:T:", long_options,

> +				 &option_index)) != -1) {
>  		switch (opt) {
>  		case 'z':
>  			if (!optarg) {
> @@ -146,6 +156,11 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  			}
>  			break;
>  
> +		case 'h':

		case 1:

> +		case '?':

remove this line.
If you don't care, I can post a modified version here.

Thanks,
Gao Xiang

> +			usage();
> +			exit(0);
> +
>  		default: /* '?' */
>  			return -EINVAL;
>  		}
> -- 
> 2.17.1
> 
