Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D3D80A6A
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 12:17:46 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461cKM4wQczDqbf
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 20:17:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1564913863;
	bh=Cv9pMgh4AkENF8v3o461xOtN/eRhY/dCU2pvkL2GcmQ=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=NXfA81/8sTVejJv8+cRQVMqV1+hYOGS8DhWVrV8UtDqREKRsQz15OStABgX35u+Jl
	 vn5/IMmDq/tegCt2BhEyfEEbLddEPUOrnuYhzeBtRtJeVL3IjD4H6sfBCQwIKKYfk8
	 EmIMUrEsBm7HAz6aV6TflpSSgSYlcPCpi9fMwJcJov72dZRrykg0ng8U0Pqs2if2tp
	 i2RBf1zP6iC24oPMkAdJTxMN69bxCWAQnlY1ovrmbuFaM75DQZUggPj4Co/+UlWKUC
	 T0T7djtr3WReP50WrqPpSdfzm/o/KszeeDcnYj9Fc7d8sUnPRRl2IJbgUhFOqkETmF
	 LyPfBGPa4RoRg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.82; helo=sonic306-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic306-19.consmr.mail.gq1.yahoo.com
 (sonic306-19.consmr.mail.gq1.yahoo.com [98.137.68.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461cK66YgRzDqT9
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Aug 2019 20:17:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1564913832; bh=EqFv3igTPDiL0oo7UHNkhX5ZQA2vsv48kEywHQf/gBQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=Lnc7GhoqgXxhsMRWKA63be/9iqXtoQ0SzI8CLd2S+OYLqFyzSP4lFE0hLIQx7mQNFZK6DmHatrk+cIEn/uQsqTYCKpNKyFdc2qIW5bO3SgtB9UJk3wwPRpL/QNrO7FaOj6WwAIPubjOaZAdGn9lyai83S4ACUp9dsog0Kb440sdArb7vgP+++hzG+y9qvpaEt8I0JVG8bCD4RPx4Rrh5nJ5IO3wWQNo9Sz92uQUm6VtPMS5aeN4VTzxBgOcDm4Nsa6KxpxDF5rtJjt8ylmM2Z/QcKyoU/1iKwJqJf/fwgHiR4TPjQQ+7tPa/fuR05Rj+hPdElg4lyXRceDKwOYRHNg==
X-YMail-OSG: eAsWtG8VM1nDLozeneuZm0xNQO3LZMxIe6GzPV2cdF02eXDwL9oIq61uLH_4pbd
 4ioHo786ISeL6SpPiCSJAIyi9QigyDLZneSqP8S5XYbVOvBei4jwNpy2WJZuQDWV75CNYOQTDUI0
 Fiz4T1_PjxRXTfV2noiKo7xwC_xs0FGD6GbowQ2CI1OOGPxyfsfaEoN3.p26PBLeaNK_ovbLQaQq
 LQwFiCUPpB3NaXrLDnyEkrcfeU28GfSN3F1t.dn8QjLvBj_j5rGCDtxLG3FrNsIap7mRqmyCczMV
 C6MLd5OykMHQmTG9k0BXlmCCMW5JxobEBaerfnz0oHuR4KkPLfyx4mJ2.zRm05ZAcHtOS4SzPVFF
 WWX4lT6QYIKl3QdncOQrSgxq.7DqPOPPnb8DSm4n55jK4Rbv5eDa4cTY7ykK.o7UWd7UWzEucmiN
 _IzmkFyS49lRAJjfTvXuDhbaW5MWCTxBIivvsr2SYawKMbk6qv9kRn0hONXViLNEzG5NKujWRU50
 TCNt1Wa_flEU53rzjoJm8o8I0z_XOX3PvU9a_YQiC5cQwK_OFJ9M0HMTo1JJ9tzEWZljEDi.2b8_
 oHmbWuGPvcIzeQCZSLsXjOz2qAuMxjOaaU8lF.NaOt_p9IkN99cPdZrnllqrHAzE6sq2.99WL59g
 r3i7frV_inr6milA6MFfb6mvX9zqoaJcnTVP8eQ33vR35AgO2r0FdHwFFORxzE5rVqlu68xEYDgo
 ibLR3MG8DjNz_j8CyXCCab6bXl8YuTal3HT1UUAV9ikyfdg98ZprWSf._u9vbNx4SqzcDsKVaL6Z
 X1arFGFfUZKbKIlRdgAjiX21KgVhsPaQBPCYWoJTX5yiYZEaVFjqRLpQSm_t9E14j86MyJkeA9mr
 1a1MhjRfQN5w6ThfRXuGPT9y4bkYC5.wr6XkqxIlcXs_Nr5R89EIOmYrvctJvFIJT8pHuqTBrZC5
 NgCPFgd_4X7PAXU4UmILan.6AMvvcBxwrqGaac3UkPlKAJSqnJXvQb6FtF6zx8WIsw.sFvg.FkHq
 Hw2KI1STCOU99lwIRY7dsqF3dtheVGSPUtdVozZLk34HeC0o4O9qEBe_hxpXb0iZZ.ip3svB5iis
 kwOLtpC..4UDgDxh5d3NqrfK5S2btJpyoxpv9b0yQAbwlk2zsJzl7petF3g.iFTCGButQyo7HZ.7
 wUrKPa.WP2qyFTW4wjUWHNXKhQ6veFJV1W0aUSECMv.WSnR59RE0cRdXKHEp4Gro.3cvaMDhZh1h
 JV23h5s5kE7LAhoQ6SJOt_Q--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 4 Aug 2019 10:17:12 +0000
Received: by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 3edc1ebed2e0f0d7708a04d4a3db1850; 
 Sun, 04 Aug 2019 10:17:07 +0000 (UTC)
Date: Sun, 4 Aug 2019 18:16:58 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: code for handling incorrect debug level.
Message-ID: <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190804081943.20666-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804081943.20666-1-pratikshinde320@gmail.com>
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde wrote:
> handling the case of incorrect debug level.
> Added an enumerated type for supported debug levels.
> Using 'atoi' in place of 'parse_num_from_str'.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> ---
>  include/erofs/print.h | 18 +++++++++++++-----
>  mkfs/main.c           | 19 ++++++++-----------
>  2 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/include/erofs/print.h b/include/erofs/print.h
> index bc0b8d4..296cbbf 100644
> --- a/include/erofs/print.h
> +++ b/include/erofs/print.h
> @@ -12,6 +12,15 @@
>  #include "config.h"
>  #include <stdio.h>
>  
> +enum {
> +	EROFS_MSG_MIN = 0,
> +	EROFS_ERR     = 0,
> +	EROFS_WARN    = 2,
> +	EROFS_INFO    = 3,
> +	EROFS_DBG     = 7,
> +	EROFS_MSG_MAX = 9
> +};
> +
>  #define FUNC_LINE_FMT "%s() Line[%d] "
>  
>  #ifndef pr_fmt
> @@ -19,7 +28,7 @@
>  #endif
>  
>  #define erofs_dbg(fmt, ...) do {				\
> -	if (cfg.c_dbg_lvl >= 7) {				\
> +	if (cfg.c_dbg_lvl >= EROFS_DBG) {			\
>  		fprintf(stdout,					\
>  			pr_fmt(fmt),				\
>  			__func__,				\
> @@ -29,7 +38,7 @@
>  } while (0)
>  
>  #define erofs_info(fmt, ...) do {				\
> -	if (cfg.c_dbg_lvl >= 3) {				\
> +	if (cfg.c_dbg_lvl >= EROFS_INFO) {			\
>  		fprintf(stdout,					\
>  			pr_fmt(fmt),				\
>  			__func__,				\
> @@ -40,7 +49,7 @@
>  } while (0)
>  
>  #define erofs_warn(fmt, ...) do {				\
> -	if (cfg.c_dbg_lvl >= 2) {				\
> +	if (cfg.c_dbg_lvl >= EROFS_WARN) {			\
>  		fprintf(stdout,					\
>  			pr_fmt(fmt),				\
>  			__func__,				\
> @@ -51,7 +60,7 @@
>  } while (0)
>  
>  #define erofs_err(fmt, ...) do {				\
> -	if (cfg.c_dbg_lvl >= 0) {				\
> +	if (cfg.c_dbg_lvl >= EROFS_ERR) {			\
>  		fprintf(stderr,					\
>  			"Err: " pr_fmt(fmt),			\
>  			__func__,				\
> @@ -64,4 +73,3 @@
>  
>  
>  #endif
> -
> diff --git a/mkfs/main.c b/mkfs/main.c
> index fdb65fd..d915d00 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -30,16 +30,6 @@ static void usage(void)
>  	fprintf(stderr, " -EX[,...] X=extended options\n");
>  }
>  
> -u64 parse_num_from_str(const char *str)
> -{
> -	u64 num      = 0;
> -	char *endptr = NULL;
> -
> -	num = strtoull(str, &endptr, 10);
> -	BUG_ON(num == ULLONG_MAX);
> -	return num;
> -}
> -
>  static int parse_extended_opts(const char *opts)
>  {
>  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  			break;
>  
>  		case 'd':
> -			cfg.c_dbg_lvl = parse_num_from_str(optarg);
> +			cfg.c_dbg_lvl = atoi(optarg);
> +			if (cfg.c_dbg_lvl < EROFS_MSG_MIN
> +			    || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
> +				fprintf(stderr,
> +					"invalid debug level %d\n",
> +					cfg.c_dbg_lvl);

How about using erofs_err as my previous patch attached?
I wonder if there are some specfic reasons to directly use fprintf instead?

I will apply it with this minor fixup (no need to resend again), if you have
other considerations, reply me in this thread, thanks. :)

Thanks,
Gao Xiang

> +				return -EINVAL;
> +			}
>  			break;
>  
>  		case 'E':
> -- 
> 2.9.3
> 
