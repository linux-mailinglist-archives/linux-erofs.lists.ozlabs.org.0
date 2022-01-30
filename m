Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A722F4A32D2
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jan 2022 01:26:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JmX793Jrnz30QD
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Jan 2022 11:26:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JmX75486Rz2yMt
 for <linux-erofs@lists.ozlabs.org>; Sun, 30 Jan 2022 11:26:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V37wmdu_1643502372; 
Received: from B-P7TQMD6M-0146(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V37wmdu_1643502372) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 30 Jan 2022 08:26:14 +0800
Date: Sun, 30 Jan 2022 08:26:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Igor Ostapenko <igoreisberg@gmail.com>
Subject: Re: [PATCH] erofs-utils: add missing errors and normalize errors to
 lower-case
Message-ID: <YfXbJDnwV2qzkiB3@B-P7TQMD6M-0146>
References: <YfT1Hdr4w6pQKgeA@B-P7TQMD6M-0146.local>
 <20220129194532.26-1-igoreisberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220129194532.26-1-igoreisberg@gmail.com>
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

On Sat, Jan 29, 2022 at 09:45:32PM +0200, Igor Ostapenko wrote:
> From: Igor Eisberg <igoreisberg@gmail.com>
> 
> Had second thoughts about this change I made, because it's making
> an assumption about the default value of extract_pos (being 0).
> 
> Signed-off-by: Igor Ostapenko <igoreisberg@gmail.com>

Thanks for these. I've folded this patch into the previous one
and apply to experimental branch. You can always resend the whole
patch based on -dev or -experimental branch before it's applied
to -dev branch (which I will not rebase).

Also, a minor suggestion, it'd be better to do one thing (or some
related stuffs) in one patch. So here, even extract_pos
modification is needed, IMO, it would be better with a new patch.

Thanks,
Gao Xiang

> ---
>  fsck/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 3be5d66..e669b44 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -136,9 +136,10 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
>  					return -ENOMEM;
>  				strncpy(fsckcfg.extract_path, optarg, len);
>  				fsckcfg.extract_path[len] = '\0';
> -				/* update position only if path is not root */
> -				if (len > 1 || fsckcfg.extract_path[0] != '/')
> -					fsckcfg.extract_pos = len;
> +				/* if path is root, start writing from position 0 */
> +				if (len == 1 && fsckcfg.extract_path[0] == '/')
> +					len = 0;
> +				fsckcfg.extract_pos = len;
>  			}
>  			break;
>  		case 3:
> -- 
> 2.30.2
