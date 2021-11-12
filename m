Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1944E192
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 06:36:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hr6lm5sLdz2yfn
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 16:36:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hr6lg1sHFz2yNG
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 16:36:43 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0Uw8mH23_1636695393; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uw8mH23_1636695393) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 12 Nov 2021 13:36:35 +0800
Date: Fri, 12 Nov 2021 13:36:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v5 1/2] erofs: add sysfs interface
Message-ID: <YY39YZcn/a6F0PMh@B-P7TQMD6M-0146.local>
References: <20211112023003.10712-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112023003.10712-1-huangjianan@oppo.com>
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Fri, Nov 12, 2021 at 10:30:02AM +0800, Huang Jianan wrote:
> Add sysfs interface to configure erofs related parameters later.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> ---
> since v4:
> - Resend in a clean chain.
> 
> since v3:
> - Add description of sysfs in erofs documentation.
> 
> since v2:
> - Check whether t in erofs_attr_store is illegal.
> - Print raw value for bool entry.
> 
> since v1:
> - Add sysfs API documentation.
> - Use sysfs_emit over snprintf.
> 
>  Documentation/ABI/testing/sysfs-fs-erofs |   7 +
>  Documentation/filesystems/erofs.rst      |   8 +
>  fs/erofs/Makefile                        |   2 +-
>  fs/erofs/internal.h                      |  10 +
>  fs/erofs/super.c                         |  12 ++
>  fs/erofs/sysfs.c                         | 240 +++++++++++++++++++++++
>  6 files changed, 278 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-fs-erofs
>  create mode 100644 fs/erofs/sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> new file mode 100644
> index 000000000000..86d0d0234473
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -0,0 +1,7 @@
> +What:		/sys/fs/erofs/features/
> +Date:		November 2021
> +Contact:	"Huang Jianan" <huangjianan@oppo.com>
> +Description:	Shows all enabled kernel features.
> +		Supported features:
> +		lz4_0padding, compr_cfgs, big_pcluster, device_table,
> +		sb_chksum.

Please help submit a patch renaming lz4_0padding to 0padding globally
since LZMA and later algorithms also need that...

Also, lack of chunked_file and compr_head2 as well?

Thanks,
Gao Xiang
