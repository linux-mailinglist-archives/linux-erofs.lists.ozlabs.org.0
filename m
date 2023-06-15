Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6FC7315B9
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 12:47:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qhf9t65vzz3bPJ
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 20:46:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qhf9q3QJMz30FW
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 20:46:55 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VlAPVOo_1686826010;
Received: from 30.221.131.153(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VlAPVOo_1686826010)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 18:46:51 +0800
Message-ID: <bccba1a8-b934-ea2e-04db-42da6ee63e3a@linux.alibaba.com>
Date: Thu, 15 Jun 2023 18:46:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/4] erofs-utils: lib: unify all identical compressor
 print function
To: Guo Xuenan <guoxuenan@huawei.com>, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org
References: <20230615101727.946446-1-guoxuenan@huawei.com>
 <20230615101727.946446-3-guoxuenan@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230615101727.946446-3-guoxuenan@huawei.com>
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



On 2023/6/15 18:17, Guo Xuenan via Linux-erofs wrote:
> {dump,fsck}.erofs use the same compressor print function,
> available compressors means which algothrims are currently
> supported by binary tools.
> supported compressors including all algothrims that are ready
> for your erofs binary tools.
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
> index f816bec..e559050 100644
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
> +	erofs_print_available_compressors(stderr);
>   }
>   
>   static void erofsfsck_print_version(void)
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index 08af9e3..f1b9bbd 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -22,7 +22,8 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd);
>   int z_erofs_compress_init(struct erofs_buffer_head *bh);
>   int z_erofs_compress_exit(void);
>   
> -const char *z_erofs_list_available_compressors(unsigned int i);
> +void erofs_print_available_compressors(FILE *f);
> +void erofs_print_supported_compressors(FILE *f, unsigned int mask);
>   
>   static inline bool erofs_is_packed_inode(struct erofs_inode *inode)
>   {
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 88a2fb0..da8d1b9 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -10,18 +10,6 @@
>   
>   #define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
>   
> -static const struct erofs_compressor *compressors[] = {
> -#if LZ4_ENABLED
> -#if LZ4HC_ENABLED
> -		&erofs_compressor_lz4hc,
> -#endif
> -		&erofs_compressor_lz4,
> -#endif
> -#if HAVE_LIBLZMA
> -		&erofs_compressor_lzma,
> -#endif
> -};
> -
>   /* for compressors type configuration */
>   static struct erofs_supported_algothrim {
>   	int algtype;
> @@ -119,9 +107,38 @@ int erofs_compress_destsize(const struct erofs_compress *c,
>   	return ret;
>   }
>   
> -const char *z_erofs_list_available_compressors(unsigned int i)
> +void erofs_print_supported_compressors(FILE *f, unsigned int mask)
>   {
> -	return i >= ARRAY_SIZE(compressors) ? NULL : compressors[i]->name;
> +	unsigned int i = 0;
> +	int comma = false;
> +	const char *s;
> +
> +	while (i < erofs_ccfg.erofs_ccfg_num) {
> +		s = erofs_ccfg.compressors[i].name;
> +		if (s && (mask & (1 << erofs_ccfg.compressors[i++].algorithmtype))) {
> +			if (comma)
> +				fputs(", ", f);
> +			else
> +				comma = true;
> +			fputs(s, f);
> +		}
> +	}
> +	fputc('\n', f);
> +}
> +
> +void erofs_print_available_compressors(FILE *f)
> +{

Should just erofs_print_supported_compressors(f, ~0) and avoid this helper?

Thanks,
Gao Xiang
