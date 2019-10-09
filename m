Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109FD1D11
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2019 01:52:13 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46pWGf294jzDqYq
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2019 10:52:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570665130;
	bh=Lp6NkpOOeYSOyXbBrLg5P7y1eZzERcsuqEYUxAClwlY=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Q0vjs1TPLlkix55ORkXM284rVpykzaDnsthx64xaK/yQaFi6zzp3gSoNn5VVpFKPT
	 khaP3srx3qIl10cb2aj0yZuahn+Z+shm+Aldl1BJdWDPM3MQrFLt2iiQWdqaNeeV0p
	 u3zCpQQ0aFR6JT4fkYT7E+NNwXOl7wGTv4GdhZpLX3FmXKojSOJ4p+Jki7HJ7tyqWb
	 1eAykrMVqIBMOQ7tXchw2BGVGzoxZCDGj0ERbw7BBuXfCrqJ4Aax9v3os2smWWGqPA
	 /XAJRSEgo75Yqkex1t6cqcPt9nDy2GlBKhvIRaKQsYucV54Hr25QFy+KHpkZD3eT/d
	 Cnhe4lKFlHO+g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.97; helo=sonic312-26.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="oxV99omc"; 
 dkim-atps=neutral
Received: from sonic312-26.consmr.mail.ir2.yahoo.com
 (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46pWGQ0895zDqY5
 for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2019 10:51:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570665109; bh=0QkzeXmozlTYWuLckxZUoniT3DMJ8wQcBDu/VgUBN6I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=oxV99omcsetIBA3xmTxCGgV37EADd3KKwP9udd6PF+fBu1V2ZNMugMxRzI/WgrlmPqx5bjekLfoBRhJCisTYcKSmHFGBOXcCfrazT9PdrPBEV0r9yIk+cn8MDLKVqoawK6KYmQiyHqSECw6v2BvAHrhKPfLEIomTYHB2HTXBBuFM/u77jYace84/Ms5mZHpewbxoe9cFxeUegjRX7Lg/D9w6MPmJCnF/pcF0jlCW3DdSB3euRmZrX8J1eZwOm7X3qMOQI2oqI6qqmagk4nkIAPSY1Lg1pYS0quSfQz22dajTfuph6ahXpJ2B6og6OPxYexwB76ZQhn2hnXz+0v1FoA==
X-YMail-OSG: 932D8jQVM1mGQvk9yTsdGblGMu1pyItD9W60ELGy0ZsI58euSaWXwx4SsqWh9qE
 8okirubYlaAfZQ.g0mKUTGuyxw6kIA8mIff5bql.xyM0jhZn47z45GLFCL4xKNAejarG6q1UnH2U
 yuIG2v57TyvH4cfPSdJ.2EwJXLwt8e9M5Mzur5H3JejMFsrER209fVhHzmi_1jvGXV4QBW47Pb7r
 FZpy.DKh_F2DcVRApHgZ1.8oipxaNHaShzq4cJBNkJ3JQpb_hcRiLeHMjwxpIOqhGL5NYahszdzF
 6VLDViJ.ZLDR6hnhOna3.MmNYKSF1Z3WMzzsbsPjz3Oc1utGJtekDWlfTrLFBt1NphHsMEZEunui
 2eAFNb46gb.5GYRySEqqjED0XBobfAyHBNA8sJayjY2LwNtdc.xnSzvfyTV8R9gT2VIKmfrcTyWR
 OFahM2gLmhM5oc8bfG0FSJM10cdt9bEQY8rV8MwL4wp9pG.n11kZOFlRCBD7r6wao9UgM99_ow3.
 8sjj_1DOpiJMJ_KIypcHZ6HBX9ZpwLACY0rA7yYs_NV.BPef5jaJrI0QbiYhIvdM2IWnVkQ4DVkU
 gC6RlinArcNrr4J5CenT3YqvTEX5GshTWj_diYQn2FzDfJQgcmPEW8m8OO6_3jF11uAZbZpY6Qle
 b1R0uKEbYfBAXMI.IL0RK6fP7FNgAVjpghBCt8Yw4D6tqVUjXq4LUFGOej7RqG7zWdsAPBS9lROe
 .5Ao8fKJ0mrAL7uxzXO3MfmF4PRDk_sv_siCrC0y7Gip9Q9_N.1ofW_vPqoVkGhrDL1EzAXvVLZs
 iaJ_cOUC851sRc2NhHEszHyyBv1xBVGai_4UBmlanVapenitT7rOT7BwKtcXNCKNoSpy9cMtssUe
 AZLiBJZrFHjS2V0zPdxyr4Uub9ti6lbLa0Iy4aWEpVofEXcZihE.srGq7HDUPSaq8GekRNIZj63X
 _cUdYPpXk0TtikQ3bIJNkgKP9VzE_cfeugZ0RniUNPRyiyjJBC.di8dHXbpYJqeQHqSE.Rw_diBg
 ZawuR6ypT3BGfVQHdDk5SeDwQ7n4ja69Ba_bendi3eijAr0ZpWqHm37wsig7HWPktH0MbutwIhEg
 2vXC0mMqxqnGjCUlROu.bUHjxuBPLqHYFKr7Et1mowM6pXaQD26au6p64zHE.WlGCmLBFe.mV90X
 9n2X3Z6vuPyZCK3Plg4bMUkpH6D5Kz8JgW8xmJRhVzJI7TgylLAkMZTorN7_V6LRyfkYo3I6GOSl
 EUIHTMo9xcf.Vy7cL6VNWEIgggfEyTcAn3FJwnO5Hdc_a7sZo7ymfZonkpaa.7SRLb3_rSZkUta0
 A8ukyim1z.A--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.ir2.yahoo.com with HTTP; Wed, 9 Oct 2019 23:51:49 +0000
Received: by smtp423.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 227b73246f0fd19a0e5d9428fd239f41; 
 Wed, 09 Oct 2019 23:51:48 +0000 (UTC)
Date: Thu, 10 Oct 2019 07:51:43 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH preview][] erofs-utils:introduce fixed timestamp using "-T"
Message-ID: <20191009235126.GB7683@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191009164336.15596-1-blucerlee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009164336.15596-1-blucerlee@gmail.com>
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

On Thu, Oct 10, 2019 at 12:43:36AM +0800, Li Guifu wrote:
> Introduce option "-T" for timestamp.
> 
> Signed-off-by: Li Guifu <blucerlee@gmail.com>

A few suggestions here...

It should be better marked the version such as "PATCH",
"PATCH v2", "PATCH vN" in the subject line
"[PATCH preview][] erofs-utils:introduce fixed timestamp using",
e.g.
[PATCH v2] erofs-utils: introduce fixed timestamp using

And the subject prefix is odd and no whitespace after semicolon
...
You could take care of it if you then do any sorts of kernel
development when you send out patches...

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

It seems not very useful.. Could we just remove it?

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

fprintf(stderr, " -T#       set a fixed UNIX timestamp # to all files\n");

>  }
>  
>  static int parse_extended_opts(const char *opts)
> @@ -93,7 +94,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  {
>  	int opt, i;
>  
> -	while ((opt = getopt(argc, argv, "d:z:E:")) != -1) {
> +	while ((opt = getopt(argc, argv, "d:z:E:T::")) != -1) {

Can we avoid two colons since this is a GNU extension?
It seems we don't need an optional arg here.

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

no EROFS_FIXED_TIMESTAMP here, useless.

Thanks,
Gao Xiang

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
