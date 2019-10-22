Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B77DAE09AC
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Oct 2019 18:50:46 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46yKJM5Dn5zDqMK
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 03:50:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1571763043;
	bh=LpR9Xbm7O54F5DAUzuVzEHSCT/3cXMT2h1gUMn6Jh2g=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=IXFrLuplDwhV4C+GFpcU6eeWUzF3ow19CpDZtvUa+Y0ZPIDc3vSZpiwDLwZtd1JvK
	 ojaE/YWlVIyaD6Kws48UQx9wtNVlB0ZpqP3uyOUH6eIMCuyUg8ewSFfupmW4hCSvWj
	 BVIFjgd0YZwI8T/reBsrnT7pHMDgweTi9VJQtfBXZIdUpiGd6VhbSxoC9/yvpdX4mb
	 EpMsFsSUzieMmEZtITprRHFHu2FWDa1I0fUzLqCaYgd6r2btCGK0yjjxONiFCImezP
	 hMY3WNI4dEM+PmfJubGQ734YQz+lU2fCvhHDMlvftAi4psBi+Kbbo2hHyIkhv5A2Gk
	 m0ll1yiKbjqOw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.146; helo=sonic317-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="k3VGdrpd"; 
 dkim-atps=neutral
Received: from sonic317-20.consmr.mail.gq1.yahoo.com
 (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46yKJD23KxzDqLx
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 03:50:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1571763030; bh=i6bFCpLw1FUQBOguBmGyYqpn7yIbmXYPO2W4iWuBdlU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=k3VGdrpdVsjlZxldMU9qHOA9psE1Ke0ub3imGAGYx1mbq3n04KionsyHIKzV186kbCWAocpbQ5Jq3kSxWyQTNNStYEWo9Y1uql5CXx4D0qJTKVGgnOxUAkUOR7N2ilRhegVQhRjh+Cx2AuBAmUiL3LWYI1ch7L+WROemxEdreSoFSHeDppySW3ExdsR0oXzuhIa9mezPeNYK1QEPbWdrUovDiCUWujqG6lSADAMEHbzhoW5uzZVihpYWuctBO9okDPPFmWI9zCDcIItkbEFRWfd61e/wWAwU7MTmgaE+gXCJlNDDz38hE9I7XOaZppcnURbMZzYERZIMzVVRDgwkXw==
X-YMail-OSG: v_VIW_QVM1mFnec4f6P2N1Vi_RwzTpRkNyOD8HGMYMVyHUwdS1gdDIhxCoZQOLG
 C2c_tYVxmzMPU14pzE3cvEKp2nwq_vm3m8FDEGgTzkRAB3.T5hfhb4hwCNd3KsEKwJ4Fziji1X7w
 ZjF.9NgLcvstucyiE8ZdMikGmfWyX_29TMOzpgKPZeQYe4hfVmwCfbLX3lQlzkXaGrWK0rZ.ppzT
 tyIeg8kfKJ8BMdEEs8Lr0G_kVQSvB0Ckvl7uCuI.emzbuD0EZ7noulQpW7kSJl7O_94EJhcBYzFO
 _QVlVB2pNU4oW2yda_OAtSpiwgRMv7QDm6lMTazrAE5TRF9N7aioVl0tpvkKkQNwihAOiZnDlN4d
 K2ofG.Mx1UobveSOIC.PumohdK.ioUbZ3BS.dOJaHLqYsMdTHNXVAlNCgbC.7S6VZK_RMUoPKwah
 G4LN.aMRK8CZlIbteFWIj1R1vnMOvJXqFIUP8iODSygb6GP44eDHTTqo_GAJ5UPy17LkR536KFGH
 rsOpPzgOLhGW3EYSO_cjOWs_.gyvUXxXeWd3h6kpGNnbY04nq8vUCuQRiWFGrsvfAGih2QU6vpJO
 gtNeJ4aXwqjvDlwPZC4iZoikkoY4w6.NR164OIbJQ4OsJ7422cTsVEIODiDrYz2BMUCZVmN51GeH
 1mkdAHiwGxvug4tR.4Smtm4WGOZdfBjdQDzj2hNimKLHLHsTxJRgTsc18Y02QVB0HzzZBb7iE9Up
 PjWhOhEfPrkWN4IZhYt54G6FVdhbWoLhcPv7y_rkMP1kAR609MT83rTuUnnqS_QF0L1qXfUknHVP
 7PyjiCyfQMol4iZAXK5s6V7X7bYjbEYLrQ7zVpVwCdniPhDA9Gsl74m9eIzNAnwHvfKrdvIH_.je
 mctkzT8mG5SCk0zjW3lyBfQFTID1drGBJOaXNYj3ggtUcHWA15iha6_S8Y3AX.6bKaOej2ALThPM
 g52FWqVISwsYPC9HvfnsU_nZVT7rDJf9vRQsPX35FqWgh83dplp.PA1.HUaGv.aKrRNRNbXN9vXr
 EfRdxMDbjDFDKrLLsov1Gh0GrNBTxodhDfJZJ0zkvqw53DShN.MZdVsO5BEtLMHijqC57McsybHN
 nqv9AqAZpS8VJjOgYtf6MuiRSqUXHw7ggKbxSOoGM9tGuTCKXV328t4azTgNbbbut90yjB7RLp28
 EPTMi9jOrsT3QG8HUi4GY.X7Wh__QIMgHZvBgsPQ3J46hFhqs0kI1JpEJdp.pYsQD.v_1QfJKCER
 JFCUtjY.8va72ZDD.LcqQ0sefyduqAckKYa3A3AQ4CJ8Bi.5l33XQDRtaMUeYApkbj2Vvdf52P12
 ptFPNpB8QzpE5.bjSOgZDyJEBIPTWDyFcJQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Tue, 22 Oct 2019 16:50:30 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 1afd44aae795d5704f004eba2ab57465; 
 Tue, 22 Oct 2019 16:50:26 +0000 (UTC)
Date: Wed, 23 Oct 2019 00:50:18 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: list available compressors for help
 command
Message-ID: <20191022164954.GA4132@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <6a0f0b47-1bb7-7e82-770f-8b039ab634f4@gmail.com>
 <20191022163616.4118-1-blucerlee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022163616.4118-1-blucerlee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Wed, Oct 23, 2019 at 12:36:16AM +0800, Li Guifu wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> Users can get knowledge of supported compression
> algorithms then.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> ---

That is a good idea, how about adding some changelogs
at this place (you could try this from now on), e.g:

changes since v1:
 - update according to
   https://lore.kernel.org/r/6a0f0b47-1bb7-7e82-770f-8b039ab634f4@gmail.com

>  include/erofs/compress.h |  2 ++
>  lib/compressor.c         | 23 ++++++++++++++---------
>  lib/compressor.h         |  1 +
>  lib/compressor_lz4.c     |  1 +
>  lib/compressor_lz4hc.c   |  1 +
>  mkfs/main.c              | 15 +++++++++++++++
>  6 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index e0abb8f..fa91873 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -21,5 +21,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode);
>  int z_erofs_compress_init(void);
>  int z_erofs_compress_exit(void);
>  
> +const char *z_erofs_list_available_compressors(unsigned int i);
> +
>  #endif
>  
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 8cc2f43..6502437 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -12,6 +12,15 @@
>  
>  #define EROFS_CONFIG_COMPR_DEF_BOUNDARY		(128)
>  
> +static struct erofs_compressor *compressors[] = {
> +#if LZ4_ENABLED
> +#if LZ4HC_ENABLED
> +		&erofs_compressor_lz4hc,
> +#endif
> +		&erofs_compressor_lz4,
> +#endif
> +};
> +
>  int erofs_compress_destsize(struct erofs_compress *c,
>  			    int compression_level,
>  			    void *src,
> @@ -36,18 +45,14 @@ int erofs_compress_destsize(struct erofs_compress *c,
>  	return ret;
>  }
>  
> +const char *z_erofs_list_available_compressors(unsigned int i)
> +{
> +	return (i >= ARRAY_SIZE(compressors)) ? NULL : compressors[i]->name;

no need extra parentheses

	return i >= ARRAY_SIZE(compressors) ? NULL : compressors[i]->name;

> +}
> +
>  int erofs_compressor_init(struct erofs_compress *c,
>  			  char *alg_name)
>  {
> -	static struct erofs_compressor *compressors[] = {
> -#if LZ4_ENABLED
> -#if LZ4HC_ENABLED
> -		&erofs_compressor_lz4hc,
> -#endif
> -		&erofs_compressor_lz4,
> -#endif
> -	};
> -
>  	int ret, i;
>  
>  	/* should be written in "minimum compression ratio * 100" */
> diff --git a/lib/compressor.h b/lib/compressor.h
> index 6429b2a..4b76c4c 100644
> --- a/lib/compressor.h
> +++ b/lib/compressor.h
> @@ -14,6 +14,7 @@
>  struct erofs_compress;
>  
>  struct erofs_compressor {
> +	const char *name;

add a blank line?

>  	int default_level;
>  	int best_level;
>  
> diff --git a/lib/compressor_lz4.c b/lib/compressor_lz4.c
> index 0d33223..a9cbb80 100644
> --- a/lib/compressor_lz4.c
> +++ b/lib/compressor_lz4.c
> @@ -39,6 +39,7 @@ static int compressor_lz4_init(struct erofs_compress *c,

How about moving
 32 static int compressor_lz4_init(struct erofs_compress *c,
 33                                  char *alg_name)
 34 {
 35         if (alg_name && strcmp(alg_name, "lz4"))
 36                 return -EINVAL;

to compress.c?

>  }
>  
>  struct erofs_compressor erofs_compressor_lz4 = {
> +	.name = "lz4",
>  	.default_level = 0,
>  	.best_level = 0,
>  	.init = compressor_lz4_init,
> diff --git a/lib/compressor_lz4hc.c b/lib/compressor_lz4hc.c
> index 14e0175..a160c1a 100644
> --- a/lib/compressor_lz4hc.c
> +++ b/lib/compressor_lz4hc.c
> @@ -52,6 +52,7 @@ static int compressor_lz4hc_init(struct erofs_compress *c,

ditto.

Thanks,
Gao Xiang

>  }
>  
>  struct erofs_compressor erofs_compressor_lz4hc = {
> +	.name = "lz4hc",
>  	.default_level = LZ4HC_CLEVEL_DEFAULT,
>  	.best_level = LZ4HC_CLEVEL_MAX,
>  	.init = compressor_lz4hc_init,
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 31cf1c2..1161b3f 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -29,6 +29,19 @@ static struct option long_options[] = {
>  	{0, 0, 0, 0},
>  };
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
>  static void usage(void)
>  {
>  	fprintf(stderr, "usage: [options] FILE DIRECTORY\n\n");
> @@ -39,6 +52,8 @@ static void usage(void)
>  	fprintf(stderr, " -EX[,...] X=extended options\n");
>  	fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");
>  	fprintf(stderr, " --help    display this help and exit\n");
> +	fprintf(stderr, "\nAvailable compressors are: ");
> +	print_available_compressors(stderr, ", ");
>  }
>  
>  static int parse_extended_opts(const char *opts)
> -- 
> 2.17.1
> 
