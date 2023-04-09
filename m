Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE76DC030
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 15:53:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvYVL5rQCz3cdj
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 23:53:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PvYVC5RP3z3cd4
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 23:53:38 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfdC-pE_1681048410;
Received: from 30.213.177.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfdC-pE_1681048410)
          by smtp.aliyun-inc.com;
          Sun, 09 Apr 2023 21:53:32 +0800
Message-ID: <ed3d5397-616f-8a74-0b89-1c101eace03d@linux.alibaba.com>
Date: Sun, 9 Apr 2023 21:53:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/5] erofs-utils: man: fsck.erofs: wording/formatting
 touchups
To: =?UTF-8?Q?Ahelenia_Ziemia=c5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
References: <38744cc8-f791-90e9-67d4-83eecbe81c5e@linux.alibaba.com>
 <nrjslxj7x6fufnvg4qavwm6zy5gues42wbjf23fgxpihsxyrrc@ddkzmz2usmyl>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <nrjslxj7x6fufnvg4qavwm6zy5gues42wbjf23fgxpihsxyrrc@ddkzmz2usmyl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/4/9 21:41, Ahelenia Ziemiańska wrote:
> Some things that gave me pause or were weirdly formatted.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
> Yep :)

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> 
>   man/fsck.erofs.1 | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
> index f3e9c3b..364219a 100644
> --- a/man/fsck.erofs.1
> +++ b/man/fsck.erofs.1
> @@ -2,7 +2,7 @@
>   .\"
>   .TH FSCK.EROFS 1
>   .SH NAME
> -fsck.erofs \- tool to check the EROFS filesystem's integrity
> +fsck.erofs \- tool to check an EROFS filesystem's integrity
>   .SH SYNOPSIS
>   \fBfsck.erofs\fR [\fIOPTIONS\fR] \fIIMAGE\fR
>   .SH DESCRIPTION
> @@ -22,15 +22,18 @@ Print total compression ratio of all files including compressed and
>   non-compressed files.
>   .TP
>   .BI "\-\-device=" path
> -Specify an extra device to be used together.
> -You may give multiple `--device' options in the correct order.
> +Specify an extra blob device to be used together.
> +You may give multiple
> +.B --device
> +options in the correct order.
>   .TP
>   .B \-\-extract
> -Check if all files are well encoded. This will induce more I/Os to read
> -compressed file data, so it might take too much time depending on the image.
> +Check if all files are well encoded. This read all compressed files,
> +and hence create more I/O load,
> +so it might take too much time depending on the image.
>   .TP
>   .B \-\-help
> -Display this help and exit.
> +Display help string and exit.
>   .SH AUTHOR
>   This version of \fBfsck.erofs\fR is written by
>   Daeho Jeong <daehojeong@google.com>.
