Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF22FF79
	for <lists+linux-erofs@lfdr.de>; Thu, 30 May 2019 17:33:26 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FBS404VYzDqWr
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 01:33:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559230404;
	bh=qDQNnIdDCEG52HNtMfcifoQuTpoMhe6aDWfOC71/NtU=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aKnyxdQ95X1+r8RzVoShVpjtFXHm7HJJfylRNrc/okTNMlD6CS+i3jBkVdTJffnMG
	 BJ15oof9+ZWRfOhQTiBstF0Vr6nIjgTEsK+sC88DlU2/6qGUfPMRK9bGvYEQax9gQz
	 IItMfMnHwobYTeN6ClYE4mci7UT7zy90nAHODkhafUN6qjAxCi1e0PTQlxZ2ri2SBx
	 JYUWz8vIHEaeMtRollKYN8rndxgw1ct5P8voSrn0tCh2sucQwTj++kX6mr8TkSUyuM
	 g5LWEwBolM4eyXTZmeUXZEUkRq+Y3g13CLJqne7ZvPorvUc9492voZ54BwooUyG7ev
	 kseKWzmFjQVuQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=87.248.110.83; helo=sonic302-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="Qsco+MnJ"; 
 dkim-atps=neutral
Received: from sonic302-20.consmr.mail.ir2.yahoo.com
 (sonic302-20.consmr.mail.ir2.yahoo.com [87.248.110.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FBRl2vZkzDqW5
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 01:33:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559230375; bh=uTTAoAasBsRPDwk5FnsGOJWQb+Jp2qhYvhvav7uakh4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=Qsco+MnJv5kDPM2H/iD5Hke19b2waxAfTVvBvR6LWb7/IdsMEhLwIM4JkwoIrk14cP70wIRPPj73HGPJM7hgp+jYQ6mVooyyBwpbJQ3NH1MM9Cusj8xYlJipbkXOhznblX6Xwi6Xs1iNwI6O5tlza5u8NYm4Ymjoy+WOH9BkBAIfMXYZIa+VedbnmUNfILJ/WhG8x4u+YSxGyc/OaQbojHm1lKsNady8j5z+d1BDhO5+5yGDg8L1Jc2OCb5yTB9yKgFAf7/09WUCiw2+M+16Oug/oX+tz3bUw2Rk+sbKSkHqzMDKEMP/FrhplconeHu7TsiO46y7I2tU4mymiQ2QkA==
X-YMail-OSG: Rm05KRcVM1k61mdni6ZOPGy1vWipbtCQzBpE93jCI7dpaQAKKZz551jtls.rlTF
 1Tw7ZwAOWeJBGr_6lGzxy1tvFO4U_yTnPbO8vG9WTIcgrY.OKhOLhWAV6tTZGkS3KkSM22TaTs1X
 TDKdApEKUM0tW8XZBz5thdJnvLUkyHH1wb3rzTUlPL_9gt57aake52Ae03wVjbJ_TNfsvOh51rNK
 n6joC8HBD4tjfBEHVaHXuNNaJEwQFKhNQLsir_BrnKOhXzxNaNvtvWdBqpJNvz7R.n29f0kNJGVs
 NkSCDWjVrziI.Qfeibn7A3IOw.FFOOkHmspkVwYsUKpqZNG8RuGdoKlIDg_vQcBF.Q9GwVIvO5xd
 iBNReiZWoDaD_hUeMDCXS9eejJH4JQs_YB3actD_miOqLRkx1AAzIiaLW98XwrHvi.o7HkfM5izI
 T1DkAJ.jFgJ0c1kZSsu_esg04U4lIWz60Fa.rb3c8KOUwzD82qaVXYtsnQBNvp5V2Y3df4zqqyj.
 6Wh5Z9vhmd58ZEkjU5QEx61Vd8sIUFtgXLXUlp1mIhgoPfeXvmvdCfuvabViGl6TxPw72lETC5wI
 yc.inZFR1dXWwNS1FLqK_NAW82VSGDW.dKgPHBlSjcAsskxtXzo3UNJUNGtePu.vskF6sJaq.h30
 XEmusSVobj6ixx74BPz6uFpN4o7sFFusM4m1qPp2JGogGfkE59TDUXQ60G0lAeMctW1WN.VWzHSB
 GTi3BTrpRDwKNoEYJS7MUBjs7gy0pKd7JI51iHg9ycInlt6nlUu5aRNcEPCaHHmADz1fQPMPX9L9
 8s5kJlWwVav8RcRUKCAXYAP79kMygeRgZubmIxOe8KTij4r1QMXsEiWzn3YhSYuaPRBS6P3nsVIc
 ETuXuD_I7s7pvrk5.D7IPsUCdkSfwn9YHwhL5j_ZQrbGoPEU6G_EagxQ.JA.Gg8COwWwGHMTujPK
 ooHfut1.P79pE3XiS1knGlrvBWSdtrK3Pa0QUdrMDef63CdPaaU2fceikGsrNjLbMGdYPc05mt18
 zxYF7dP.UAL1OuefAWYB8IBPmkT_63McS9saZrpJsgyo03VEhlnKY4lb6KLyVGGt1FfLG_.BhaWR
 8KIA1ScaB9mHdUW2XDHz0SJMXxjp59OlWXLv1.DXaO9hN9WsO6vSt1PMdi58y_5U43QenekYvTmi
 _wcxRaKt58IBpmlTOlgK5E7eFDQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ir2.yahoo.com with HTTP; Thu, 30 May 2019 15:32:55 +0000
Received: from 125.120.86.223 (EHLO [192.168.0.101]) ([125.120.86.223])
 by smtp419.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 87a485c7abb0b750484c02afc81f35e7; 
 Thu, 30 May 2019 15:32:54 +0000 (UTC)
Subject: Re: [PATCH] erofs-utils: remove AC_FUNC_MALLOC check
To: Yue Hu <zbestahu@gmail.com>
References: <20190530095850.5260-1-zbestahu@gmail.com>
Message-ID: <82e79e9a-5c90-677b-376e-f4c04e580f23@aol.com>
Date: Thu, 30 May 2019 23:32:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530095850.5260-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: linux-erofs@lists.ozlabs.org, huyue2@yulong.com, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On 2019/5/30 ??????5:58, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Below erros happened when building for ARM64, rpl_malloc is not
> supplied in that case, remove AC_FUNC_MALLOC can fix the errors.
> 
> mkfs_file.c: In function 'erofs_compress_file':
> mkfs_file.c:600:2: error: implicit declaration of function 'rpl_malloc' [-Werror=implicit-function-declaration]
>   inode->i_inline_data = malloc(EROFS_BLKSIZE);
>   ^
> mkfs_file.c:600:23: error: assignment makes pointer from integer without a cast [-Werror]
>   inode->i_inline_data = malloc(EROFS_BLKSIZE);
>                        ^
> mkfs_file.c: In function 'erofs_init_compress_context':
> mkfs_file.c:874:17: error: assignment makes pointer from integer without a cast [-Werror]
>   ctx->cc_srcbuf = malloc(erofs_cfg.c_compr_maxsz);
>                  ^
> mkfs_file.c:875:17: error: assignment makes pointer from integer without a cast [-Werror]
>   ctx->cc_dstbuf = malloc(erofs_cfg.c_compr_maxsz * 2);
>                  ^
> cc1: all warnings being treated as errors
> make[2]: *** [mkfs_erofs-mkfs_file.o] Error 1
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Thanks for your report and patch, applied to mkfs-dev branch.
And as for new erofs-utils, it will be folded into the original patch
and I will send the whole series soon.

Thanks,
Gao Xiang

> ---
>  configure.ac | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 8e3f703..40ee765 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -98,7 +98,6 @@ AC_CHECK_MEMBERS([struct stat.st_rdev])
>  AC_TYPE_UINT64_T
>  
>  # Checks for library functions.
> -AC_FUNC_MALLOC
>  AC_CHECK_FUNCS([ftruncate getcwd gettimeofday memset realpath strdup strerror strrchr strtoull])
>  
>  # Configure lz4.
> 
