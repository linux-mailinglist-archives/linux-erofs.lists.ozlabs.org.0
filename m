Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5CD49F2C7
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 06:12:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JlQZb0cMWz3bPR
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jan 2022 16:12:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JlQZW4fJNz2ynD
 for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jan 2022 16:12:46 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V312jUh_1643346754; 
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V312jUh_1643346754) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 28 Jan 2022 13:12:36 +0800
Date: Fri, 28 Jan 2022 13:12:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Ostapenko <igoreisberg@gmail.com>
Subject: Re: [PATCH] erofs-utils: fsck: fix issues related to --extract=X
Message-ID: <YfN7Qsd3jAnk79bG@B-P7TQMD6M-0146>
References: <YfNvloN0RAX0mHRn@B-P7TQMD6M-0146>
 <20220128045018.26-1-igoreisberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220128045018.26-1-igoreisberg@gmail.com>
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

On Fri, Jan 28, 2022 at 06:50:18AM +0200, Igor Ostapenko wrote:
> From: Igor Eisberg <igoreisberg@gmail.com>
> 
> Fix compile
> 
> Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>

Many thanks, I will fold these two patches into the first one
for applying.

Thanks,
Gao Xiang

> ---
>  fsck/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 2f13870..6f17d0e 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -196,7 +196,7 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>  			return -EINVAL;
>  		}
>  		if (fsckcfg.preserve_owner || fsckcfg.preserve_perms ||
> -			  fsckcfg.no_preserve_owner || fsckcfg.no_preserve_perms) {
> +			  no_preserve_owner || no_preserve_perms) {
>  			erofs_err("--[no-]preserve[-owner/-perms] must be used together with --extract=X");
>  			return -EINVAL;
>  		}
> -- 
> 2.30.2
