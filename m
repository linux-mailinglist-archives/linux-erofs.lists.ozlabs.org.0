Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EB26DBFE8
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 14:52:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PvX7H2b5Tz3cf0
	for <lists+linux-erofs@lfdr.de>; Sun,  9 Apr 2023 22:52:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PvX7B62mZz3cd5
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Apr 2023 22:52:06 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vfd1oIs_1681044719;
Received: from 30.213.177.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vfd1oIs_1681044719)
          by smtp.aliyun-inc.com;
          Sun, 09 Apr 2023 20:52:02 +0800
Message-ID: <e5a823d7-5d54-6543-1e1b-9391681cce65@linux.alibaba.com>
Date: Sun, 9 Apr 2023 20:51:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 5/5] erofs-utils: man: dump.erofs: wording/formatting
 touchups
To: =?UTF-8?Q?Ahelenia_Ziemia=c5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
References: <d80484200b3ba60127ff3b92e0c7660a2e8726bf.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
 <c556cbafa7124d5ab5d20979be068ba36a125ed6.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <c556cbafa7124d5ab5d20979be068ba36a125ed6.1681041325.git.nabijaczleweli@nabijaczleweli.xyz>
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



On 2023/4/9 19:56, Ahelenia Ziemiańska wrote:
> Some things that gave me pause or were weirdly formatted.
> 
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   man/dump.erofs.1 | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/man/dump.erofs.1 b/man/dump.erofs.1
> index 209e5f9..7316f4b 100644
> --- a/man/dump.erofs.1
> +++ b/man/dump.erofs.1
> @@ -9,18 +9,28 @@ or overall disk statistics information from an EROFS-formatted image.
>   .SH DESCRIPTION
>   .B dump.erofs
>   is used to retrieve erofs metadata from \fIIMAGE\fP and demonstrate
> +.br
>   1) overall disk statistics,
> +.br
>   2) superblock information,
> +.br
>   3) file information of the given inode NID,
> +.br
>   4) file extent information of the given inode NID.
>   .SH OPTIONS
>   .TP
>   .BI "\-\-device=" path
>   Specify an extra device to be used together.
> -You may give multiple `--device' options in the correct order.
> +You may give multiple
> +.B --device
> +options in the correct order.
>   .TP
>   .BI "\-\-ls"
> -List directory contents. An inode should be specified together.
> +List directory contents.
> +.I NID
> +or
> +.I path
> +required.
>   .TP
>   .BI "\-\-nid=" NID
>   Specify an inode NID in order to print its file information.
> @@ -29,16 +39,21 @@ Specify an inode NID in order to print its file information.
>   Specify an inode path in order to print its file information.
>   .TP
>   .BI \-e
> -Show the file extent information. An inode should be specified together.
> +Show the file extent information.
> +.I NID
> +or
> +.I path
> +required.
>   .TP
>   .BI \-V
>   Print the version number and exit.
>   .TP
>   .BI \-s
> -Show superblock information of the an EROFS-formatted image.
> +Show superblock information.
> +This is the default if no options are specified.
>   .TP
>   .BI \-S
> -Show EROFS disk statistics, including file type/size distribution, number of (un)compressed files, compression ratio of the whole image, etc.
> +Show image statistics, including file type/size distribution, number of (un)compressed files, compression ratio, etc.
>   .SH AUTHOR
>   Initial code was written by Wang Qi <mpiglet@outlook.com>, Guo Xuenan <guoxuenan@huawei.com>.
>   .PP
