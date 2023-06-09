Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF8729590
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 11:40:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QcwzQ5ZyQz3f5K
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 19:40:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QcwzM4h2Kz3f05
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 19:39:59 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkhjU0b_1686303592;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VkhjU0b_1686303592)
          by smtp.aliyun-inc.com;
          Fri, 09 Jun 2023 17:39:54 +0800
Message-ID: <1532d357-0166-900c-ffb8-573d06324c02@linux.alibaba.com>
Date: Fri, 9 Jun 2023 17:39:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] erofs-utils: lib: unify all identical compressor
 print function
To: Guo Xuenan <guoxuenan@huawei.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230609085041.14987-1-guoxuenan@huawei.com>
 <20230609085041.14987-3-guoxuenan@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230609085041.14987-3-guoxuenan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/6/9 16:50, Guo Xuenan via Linux-erofs wrote:
> {dump,fsck}.erofs use the same compressor print function,
> available_compressors means which algothrims are currently
> supported by binary tools.
> supported_compressors including all algothrims that are ready
> for erofs.
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> ---
>   fsck/main.c              | 15 +-----------
>   include/erofs/compress.h |  3 ++-
>   lib/compressor.c         | 51 ++++++++++++++++++++++++++--------------
>   mkfs/main.c              | 15 +-----------
>   4 files changed, 38 insertions(+), 46 deletions(-)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index f816bec..978d198 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -49,19 +49,6 @@ static struct option long_options[] = {
>   	{0, 0, 0, 0},
>   };
>   
> -static void print_available_decompressors(FILE *f, const char *delim)
> -{
> -	unsigned int i = 0;
> -	const char *s;
> -
> -	while ((s = z_erofs_list_available_compressors(i)) != NULL) {
> -		if (i++)
> -			fputs(delim, f);
> -		fputs(s, f);
> -	}
> -	fputc('\n', f);
> -}
> -
>   static void usage(void)
>   {
>   	fputs("usage: [options] IMAGE\n\n"
> @@ -84,7 +71,7 @@ static void usage(void)
>   	      " --no-preserve-owner    extract as yourself\n"
>   	      " --no-preserve-perms    apply user's umask when extracting permissions\n"
>   	      "\nSupported algorithms are: ", stderr);
> -	print_available_decompressors(stderr, ", ");
> +	zerofs_print_available_compressors(stderr);

It'd be better to keep z_erofs for compression side.

