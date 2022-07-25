Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B643E57F940
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Jul 2022 07:56:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lrq794Vc3z3bmK
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Jul 2022 15:56:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lrq7430yCz302S
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Jul 2022 15:56:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VKHU8xS_1658728599;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VKHU8xS_1658728599)
          by smtp.aliyun-inc.com;
          Mon, 25 Jul 2022 13:56:41 +0800
Date: Mon, 25 Jul 2022 13:56:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: fix a memory leak of compression
 type configuration
Message-ID: <Yt4wli4X2aCpBNl7@B-P7TQMD6M-0146.local>
References: <20220725054549.23562-1-huyue2@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220725054549.23562-1-huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On Mon, Jul 25, 2022 at 01:45:49PM +0800, Yue Hu wrote:
> Release the memory allocated for compression type configuration. And no
> need to consider !optarg case since getopt_long() will do that.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---

What's the difference between v1?
The patch itself looks good to me, but I need to try later.

Thanks,
Gao Xiang

>  lib/config.c | 3 +++
>  mkfs/main.c  | 4 ----
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/config.c b/lib/config.c
> index 3963df2..c316a54 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -55,6 +55,9 @@ void erofs_exit_configure(void)
>  #endif
>  	if (cfg.c_img_path)
>  		free(cfg.c_img_path);
> +
> +	if (cfg.c_compr_alg_master)
> +		free(cfg.c_compr_alg_master);
>  }
>  
>  static unsigned int fullpath_prefix;	/* root directory prefix length */
> diff --git a/mkfs/main.c b/mkfs/main.c
> index deb8e1f..9f5f1dc 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -212,10 +212,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  				  long_options, NULL)) != -1) {
>  		switch (opt) {
>  		case 'z':
> -			if (!optarg) {
> -				cfg.c_compr_alg_master = "(default)";
> -				break;
> -			}
>  			/* get specified compression level */
>  			for (i = 0; optarg[i] != '\0'; ++i) {
>  				if (optarg[i] == ',') {
> -- 
> 2.17.1
