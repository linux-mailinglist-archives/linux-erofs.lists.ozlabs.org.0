Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE343E02C
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 13:44:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hg3d83k52z2yP9
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Oct 2021 22:44:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hg3d42sHzz2xt0
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 Oct 2021 22:44:35 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Uu.cfEW_1635421458; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uu.cfEW_1635421458) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 28 Oct 2021 19:44:19 +0800
Date: Thu, 28 Oct 2021 19:44:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v2 5/5] erofs-utils: manpage: add dump.erofs manpage.
Message-ID: <YXqNEfLdI5YDehw3@B-P7TQMD6M-0146.local>
References: <20211028105748.3586231-1-guoxuenan@huawei.com>
 <20211028105748.3586231-5-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211028105748.3586231-5-guoxuenan@huawei.com>
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
Cc: daeho43@gmail.com, linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Oct 28, 2021 at 06:57:48PM +0800, Guo Xuenan wrote:
> This patch adds dump.erofs manpage.
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> ---
>  man/Makefile.am  |  2 +-
>  man/dump.erofs.1 | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 1 deletion(-)
>  create mode 100644 man/dump.erofs.1
> 
> diff --git a/man/Makefile.am b/man/Makefile.am
> index d62d6e2..769b557 100644
> --- a/man/Makefile.am
> +++ b/man/Makefile.am
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  
> -dist_man_MANS = mkfs.erofs.1
> +dist_man_MANS = mkfs.erofs.1 dump.erofs.1
>  
>  EXTRA_DIST = erofsfuse.1
>  if ENABLE_FUSE
> diff --git a/man/dump.erofs.1 b/man/dump.erofs.1
> new file mode 100644
> index 0000000..d44c7b6
> --- /dev/null
> +++ b/man/dump.erofs.1
> @@ -0,0 +1,60 @@
> +.\" Copyright (c) 2021 Guo Xuenan <guoxuenan@huawei.com>
> +.\"
> +.TH DUMP.EROFS 1
> +.SH NAME
> +dump.erofs \- retrieve directory and file entries, show specific file
> +or overall disk statistics information from an EROFS-formated image.

                                                  ^ EROFS-formatted

> +.SH SYNOPSIS
> +.B dump.erofs
> +[
> +.B \--nid
> +.I inode number
> +]
> +[
> +.B \-e
> +]
> +[
> +.B \-s
> +]
> +[
> +.B \-S
> +]
> +[
> +.B \-V
> +]
> +.I DEVICE

But from the usage, it should be 'IMAGE' here?

> +.SH DESCRIPTION
> +.B dump.erofs
> +is used to retrieve erofs metadata (usually in a disk partition).
> +\fIdevice\fP is the special file corresponding to the device (e.g.
> +\fI/dev/sdXX\fP).

is used to retrieve erofs metadata from \fIimage\fP and demonstrate....

> +
> +Currently, it can demonstrate 1) a file information of given inode number, 2)
> +overall disk statistics, 3) file extent information,
> +4) erofs superblock information.
> +.SH OPTIONS
> +.TP
> +.BI \--nid " inode number"
> +Specify an inode number to print its file information.
> +.TP
> +.BI \-e
> +show the file extent information, the option depends on option --nid to specify nid.

	.It depends on "--nid" for a given inode.

> +.TP
> +.BI \-V
> +Print the version number and exit.
> +.TP
> +.BI \-s
> +Show superblock information of the an EROFS-formated image.

formatted

> +.TP
> +.BI \-S
> +Show statistics of the overall disk, including file type(by file extension)/size statistics and distribut$ion, number of compressed and uncompressed files, whole compression ratio of image etc.

Show EROFS disk statistics, including file type/size distribution, number of (un)compressed files, compression ratio of the whole image, etc. 

Thanks,
Gao Xiang

> +.SH AUTHOR
> +Initial code was written by Wang Qi <mpiglet@outlook.com>, Guo Xuenan <guoxuenan@huawei.com>.
> +.PP
> +This manual page was written by Guo Xuenan <guoxuenan@huawei.com>
> +.SH AVAILABILITY
> +.B dump.erofs
> +is part of erofs-utils package and is available from git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git.
> +.SH SEE ALSO
> +.BR mkfs.erofs(1),
> +.BR fsck.erofs(1)
> -- 
> 2.31.1
