Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1739B0FD
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jun 2021 05:39:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fx7mQ2dhzz300X
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jun 2021 13:39:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57;
 helo=out30-57.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
X-Greylist: delayed 304 seconds by postgrey-1.36 at boromir;
 Fri, 04 Jun 2021 13:39:12 AEST
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fx7mJ4j2hz2yRD
 for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jun 2021 13:39:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0UbCy5Vt_1622777627; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UbCy5Vt_1622777627) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 04 Jun 2021 11:33:48 +0800
Date: Fri, 4 Jun 2021 11:33:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] erofs-utils: manpage: only install erofsfuse.1 with the
 command
Message-ID: <YLmfGgPplj/7YndG@B-P7TQMD6M-0146.local>
References: <87lf7q3dn2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lf7q3dn2.fsf@gmail.com>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Thu, Jun 03, 2021 at 04:18:57PM -0400, David Michael wrote:
> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> ---
> 
> Hi,
> 
> Can the erofsfuse man page be made to install only when the program is
> installed?  This will clean up packaging a little bit.
> 
> Thanks.

Yeah, very sorry about the stupid mistake.

Reviewed-by: Gao Xiang <xiang@kernel.org>

(Will apply hours later.)

Thanks,
Gao Xiang

> 
> David
> 
>  man/Makefile.am | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/man/Makefile.am b/man/Makefile.am
> index ffcf6f8..0df947b 100644
> --- a/man/Makefile.am
> +++ b/man/Makefile.am
> @@ -1,5 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  # Makefile.am
>  
> -dist_man_MANS = mkfs.erofs.1 erofsfuse.1
> +dist_man_MANS = mkfs.erofs.1
>  
> +EXTRA_DIST = erofsfuse.1
> +if ENABLE_FUSE
> +man_MANS = erofsfuse.1
> +endif
> -- 
> 2.31.1
