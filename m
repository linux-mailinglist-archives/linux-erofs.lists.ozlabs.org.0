Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7CDE0839
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 18:05:44 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yJJP1gwgzDqLd
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 03:05:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=blucerlee@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tW6zlYj1"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yJJC0tBYzDqKS
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 03:05:30 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id q7so10923138pfh.8
 for <linux-erofs@lists.ozlabs.org>; Tue, 22 Oct 2019 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ulRT4OdZ42f/Xa8i43rlgTUaEBsDiPl/A9tf1xC/FtU=;
 b=tW6zlYj1mfnv/JTSbcwKvYt+SEsu6sDPq/VmjZ6HCgSZLMDPEyQapD8hWwsqlSHMmv
 aH3463dI0Xje89pUot+pu9/4qlbI9pIx4H1t2YRY3ibLGAlVGPwIhYRf5+7Xt77zhTBH
 G4UQ4FiONu+ZsFr9uuqfxrTKQux0mIteUiu8kzKhMbuXKocHOh9xGTJhxcKEZNmHD+BR
 GHLlgqDclSZqDe6QKWIkaOWuaNEppSE0FFgYk8kysRPPwa9y4NTb0gEbOeAo0epF5ndI
 oroejXh2FPeMqELxABfxafEUqfJSowpsSdp6l1P/fyJY5yhp1Li+ePQtpCKomHyvCvRe
 BptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ulRT4OdZ42f/Xa8i43rlgTUaEBsDiPl/A9tf1xC/FtU=;
 b=Wh+Yj+Agg23nvmM8x1nDhgxzO/aLZvK3GItxa4WGeAngDB8299lrj7NNOVb7ZVYbuk
 wVt/JegoM2FRH80HoiHv4x+/wJfbC7vKuP+nJiJMoRvSw0A0WS4oMUN7H9H8KN4KQV0d
 SAoy6dIasG37Ml+143+rtxQVj0PJcEoYu4IBXB70c7riuqxw4pNTtj7DbtjgORLtcjx2
 7Sy0hhuCvYQtwODFcShs5ORtOpbmjBNw9oaS3s+2iC3vDGS8RTVGMry9mhwOJpZMtEk4
 BACsVnyu2uQg+gkidsjCPBvL13wVYlvikEENTgLkxmrRZd/FmDfxDI1svHNDT8zR6Dkv
 Ht1Q==
X-Gm-Message-State: APjAAAUv04gl/YRVx3otvb5TaWherlb+lrAKGw5o9xw6N9VwBZSg4tSt
 tqgUcrTtRKZjaduPvRTA0eHvTWk5
X-Google-Smtp-Source: APXvYqxw5C9rfsr0ezkV/qZE/SN2LgSD2/uqAeU9q0mS3ywgCPXjTVEUdKt5v+mn+nVt4o7bczQ7TA==
X-Received: by 2002:a63:9dc6:: with SMTP id i189mr4512024pgd.273.1571760326660; 
 Tue, 22 Oct 2019 09:05:26 -0700 (PDT)
Received: from [0.0.0.0] (li1104-154.members.linode.com. [45.79.5.154])
 by smtp.gmail.com with ESMTPSA id u3sm18615489pfn.134.2019.10.22.09.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 09:05:25 -0700 (PDT)
Subject: Re: [PATCH] erofs-utils: list available compressors for help command
To: Gao Xiang <gaoxiang25@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>
References: <20191022042002.61999-1-gaoxiang25@huawei.com>
From: Li Guifu <blucerlee@gmail.com>
Message-ID: <6a0f0b47-1bb7-7e82-770f-8b039ab634f4@gmail.com>
Date: Wed, 23 Oct 2019 00:05:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191022042002.61999-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao Xiang

What do you think put the compressor's name into structure of 
erofs_compressor ?
So compressor's name will be matched to its implement not represented
at two place.


On 2019/10/22 12:20, Gao Xiang wrote:
> Users can get knowledge of supported compression
> algorithms then.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>   include/erofs/compress.h |  2 ++
>   lib/compressor.c         | 17 +++++++++++++++++
>   mkfs/main.c              | 15 +++++++++++++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index e0abb8f1c422..fa918732b532 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -21,5 +21,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode);
>   int z_erofs_compress_init(void);
>   int z_erofs_compress_exit(void);
>   
> +const char *z_erofs_list_available_compressors(unsigned int i);
> +
>   #endif
>   
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 8cc2f438479b..c593c769d46f 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -36,6 +36,23 @@ int erofs_compress_destsize(struct erofs_compress *c,
>   	return ret;
>   }
>   
> +const char *z_erofs_list_available_compressors(unsigned int i)
> +{
> +	static const char *compressors[] = {
> +#if LZ4_ENABLED
> +#if LZ4HC_ENABLED
> +		"lz4hc",
> +#endif
> +		"lz4",
> +#endif
> +		NULL,
> +	};
> +
> +	if (i >= ARRAY_SIZE(compressors))
> +		return NULL;
> +	return compressors[i];
> +}
> +
>   int erofs_compressor_init(struct erofs_compress *c,
>   			  char *alg_name)
>   {
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 31cf1c2408d1..1161b3f0f7cc 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -29,6 +29,19 @@ static struct option long_options[] = {
>   	{0, 0, 0, 0},
>   };
>   
> +static void print_available_compressors(FILE *f, const char *delim)
> +{
> +	unsigned int i = 0;
> +	const char *s;
> +
> +	while ((s = z_erofs_list_available_compressors(i)) != NULL) {
> +		if (i++)
> +			fputs(delim, f);
> +		fputs(s, f);
> +	}
> +	fputc('\n', f);
> +}
> +
>   static void usage(void)
>   {
>   	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
> @@ -39,6 +52,8 @@ static void usage(void)
>   	fprintf(stderr, " -EX[,...] X=extended options\n");
>   	fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");
>   	fprintf(stderr, " --help    display this help and exit\n");
> +	fprintf(stderr, "\nAvailable compressors are: ");
> +	print_available_compressors(stderr, ", ");
>   }
>   
>   static int parse_extended_opts(const char *opts)
> 
