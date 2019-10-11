Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC21BD36B6
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2019 03:08:14 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46q8vv3F0FzDqMf
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2019 12:08:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570756091;
	bh=QH4AOJqQC9vn8lXh6UbfQXzwZOa4iHvB3UN8GbGPjRk=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=A1YYr95gTNE91du1MKV3uihJcVIFUT9MALQ4yBCR7AIYHxvElZR0f5OkO/TiML72B
	 rJCIbPqqjEsiGTOhO+nGERfjWDh1pKbUUbFxE/g4nED/zdrhdZxx+7W5elCNuce6ZW
	 QvxJva0mqVG3X/qP8UhyXCiMDB2CsiTnpEjbE1rbR3iHHtVM/eGSMgWMi0AjqD0F3s
	 x08yrUrqCHCdnhtae3UgIMKM5xmtHgJZXVcNAy6znTVsNVXRB9BP9kA01W52sIqPIQ
	 +HAdnvQAZWxdVyEVWZG41MStvs3VjlXtVij9JBATCmCZloLFLI4Vc46j8WR5dcyNKP
	 n3Tr3aEOG3dDw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.206; helo=sonic304-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="DMZbdAY6"; 
 dkim-atps=neutral
Received: from sonic304-25.consmr.mail.gq1.yahoo.com
 (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46q83Y2sbfzDqZT
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2019 11:29:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570753772; bh=RIFizND9Pp9OHPj5FhIvzuiC3b/uDf+/g2939aqFGxk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=DMZbdAY63oX/TjCgGOQH3KCHaXjLNMTv8iVyC6eUu/JdCXcKf/c1tntxcizpssCkkzsRAaJ8EUXCgsq7BOo9x5Q+JabpLQcIponrCTR6rFXF7qu6ycjBAHEINIC73fwrJln3NY8iuS7GhN1Oqfd4Hbip2HbdEXigm3IDGsBPnK/hfPCyqvJQgqIWcEUnY+vxUV5s8IRcjf1EKBhGHyB5d8AMYof+eDwjyEXN0Pcz4oohD2UKvNBsA812zimwkIFAFL83NU1vlVMKcaegF+5jRpDAmjGqMH0uHeFY9VLzYE0B04aPoeKNpy6lm9nPqbVSA+/npZHLlvdUWKfBc15YJQ==
X-YMail-OSG: 3aKUq.sVM1lPKj_p6XRCZJDZIfcv1HT5jviOizp6IKE0wCABGhJaOw_hREHBA3Y
 9haZAgEYgbFwg6qA6nPh27R.Ampf9SdGCPQ7NDFwVxVOg1B8HY2oFeX.u5.1PfqvFNNtRWpM5QLm
 fuDaD4DRxc2cxzAfSbeU0U8GElwFczzxfElPkZtkqcJoL926s4BioOIGwSvW2yBnBd65gfto7JSt
 fel2JV2xbXm8RLCcl6VOeG_4gKzcA9rGHdEYTlc1iVOjh9cFHn_9IfsN.9uIr.OaqwvmB0GzL0sw
 5ggQYdj9T1ea5t2deBaRS9BcMWAs2TxQNFFSfIeH1kfV_WZS39CTv1Zs1MO53GkzbD8kFEohNL7d
 PuHFEAUUs_VnWA8G0kzisgcoJ0A3Vd0OYJNIvz1TuM7NfZMiz2bmubaC0wOkG6oGAVkdEjmah18f
 JqlPkY_rqMsYJIgl0aMVlODVxSNufnclNFhasyRCyCBMt6PZ4iuwdk4DDFF2jWADRVuBTzkuzifd
 7zBP9a8imhaDB_3bgtihe2gnf.wEOmtaoFJ3EcTo74mTNa_zN1nHIQlZFxlMzWGJkndH6MYGFH1m
 SDVAED37.RfaP4gSIbibTuKQwWU_b0dJrm.KVfNIlSJ5oXyItQjsynvkI99nW9VVJokiJwGiIbM.
 BgCIwOFrtpIY05B9oKQ3VMfrnfyZK5aosUO1.Il4tNZxdllrkFJLHST.PfduHWqnMgl5RL7VbhC7
 I2wak5jbVsO2o7uBV5e0DiC6qsKcfySqdBlI.r_wHdmqbYi_QbiKJ0RsA8hYBLDNcRD6pRI4V64w
 8gbBqWpC_yIZPK1kAcg88.ON0V47osaM0EtWj5wvVX2T3juUlD3pt71xZbn2ErjWRr_j.HJ5a6YI
 Lu2z8auWzLa5q_45GyKUKJHpZQ1KgBX0mxKBOJlcswrmk93qnOoIijJc843A.uRP4wit4GDTHZY.
 MALmpwczfKzX4bjdXYoUTz9j0UUdsPLxr2xEZNFBY.UY1Cjp8MxCX0aNuwnfhSY0w9ew3JQS1xR6
 lTGZJKq7udiCxA4hcslzV6xpyBrVGeVZKAIRJ_P.b1qZsNczouUCdRjOzFkFIGvPJLfodE2tn2AN
 c4p4V.5Qer0RxcUAWnpdcizDvoh0wKlpT_ApbQqqEOYOslcjMleGf9Sj9rBcS5Y8snRkHJDyQW5K
 Rsmg75ymeNRE5OJHZ55PXOWgU5gTVknmQ7.AXH8AAeWqVEjbzcvJyhdF_wrRknJV0oAJ0ZGmBKoR
 OOoy._4QfS8ZC2.PJbsX9OeOnIOfkF.1NNHRnVaPjHeLYN6mwQXW7cdrpO20pmLW35lKn1nkKNZu
 E
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 11 Oct 2019 00:29:32 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID aaa42dbb8a1a02ea52aaba4cad44bc78; 
 Fri, 11 Oct 2019 00:29:29 +0000 (UTC)
Date: Fri, 11 Oct 2019 08:29:24 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH v1] erofs-utils: introduce fixed timestamp
Message-ID: <20191011002920.GB10489@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191010170455.2169-1-blucerlee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010170455.2169-1-blucerlee@gmail.com>
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

On Fri, Oct 11, 2019 at 01:04:55AM +0800, Li Guifu wrote:
> Introduce option "-T" for timestamp.

This is actually PATCH v3... and BTW, v1 in PATCH v1
should be omitted...

> 
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> ---
>  include/erofs/config.h |  3 +++
>  lib/config.c           |  1 +
>  mkfs/main.c            | 14 ++++++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index fde936c..61f5c71 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -11,6 +11,8 @@
>  
>  #include "defs.h"
>  
> +#define EROFS_FIXED_TIMESTAMP 1569859200 // 2019/10/1 00:00:00
> +

No any modification? Haven't you see my comments?
or you have another thoughts on this?

Thanks,
Gao Xiang

>  enum {
>  	FORCE_INODE_COMPACT = 1,
>  	FORCE_INODE_EXTENDED,
> @@ -30,6 +32,7 @@ struct erofs_configure {
>  	int c_force_inodeversion;
>  	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
>  	int c_inline_xattr_tolerance;
> +	long long c_timestamp;
>  };
>  
>  extern struct erofs_configure cfg;
> diff --git a/lib/config.c b/lib/config.c
> index dc10754..6141497 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -24,6 +24,7 @@ void erofs_init_configure(void)
>  	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
>  	cfg.c_force_inodeversion = 0;
>  	cfg.c_inline_xattr_tolerance = 2;
> +	cfg.c_timestamp = -1;
>  }
>  
>  void erofs_show_config(void)
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 978c5b4..85b8f34 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -30,6 +30,7 @@ static void usage(void)
>  	fprintf(stderr, " -zX[,Y]   X=compressor (Y=compression level, optional)\n");
>  	fprintf(stderr, " -d#       set output message level to # (maximum 9)\n");
>  	fprintf(stderr, " -EX[,...] X=extended options\n");
> +	fprintf(stderr, " -T#       set a fixed timestamp to files and dirs\n");
>  }
>  
>  static int parse_extended_opts(const char *opts)
> @@ -93,7 +94,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  {
>  	int opt, i;
>  
> -	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> +	while ((opt = getopt(argc, argv, "d:z:E:T::")) != -1) {
>  		switch (opt) {
>  		case 'z':
>  			if (!optarg) {
> @@ -126,6 +127,12 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  			if (opt)
>  				return opt;
>  			break;
> +		case 'T':
> +			if (optarg)
> +				cfg.c_timestamp = strtoll(optarg, NULL, 10);
> +			else
> +				cfg.c_timestamp = EROFS_FIXED_TIMESTAMP;
> +			break;
>  
>  		default: /* '?' */
>  			return -EINVAL;
> @@ -224,7 +231,10 @@ int main(int argc, char **argv)
>  		return 1;
>  	}
>  
> -	if (!gettimeofday(&t, NULL)) {
> +	if (cfg.c_timestamp != -1) {
> +		sbi.build_time      = cfg.c_timestamp;
> +		sbi.build_time_nsec = 0;
> +	} else if (!gettimeofday(&t, NULL)) {
>  		sbi.build_time      = t.tv_sec;
>  		sbi.build_time_nsec = t.tv_usec;
>  	}
> -- 
> 2.17.1
> 
