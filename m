Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C40D4B56
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2019 02:20:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46qlp51tgjzDqbh
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Oct 2019 11:20:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1570839613;
	bh=ni6X6OiEBA40qlkPhmcbQ7OhD7SgK4/gZEA2TOi/tfc=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=og3ZSIkGpb1xboEhzG3GAq2qnRhjCSSSmmUW2LSvQIU6kaKKSSLRwNx6+YfD8bO0G
	 RSc2ZAp7hQl4DyFhMmeriFDms/TE+wvTtf59dw3++ZXcigdjc4Ad8a0RZ+zfE4gd1k
	 lPf9cduWrXsNF6qQ6SAAP2mjrpbL+sYABGlUnEtfbaBeMfI/Sr8VJzSJstiLOPfAya
	 9Igx+UC+pdcDY9sA9X3QNFl799ihKSxJV7E65tG9bsLr+pgbSs7qWW8qZ1eaRZluzy
	 lUBB11RYLEmUo/p0CYKU7NLfmRr/lSDSY+Vo6Jp5Ij1RF3QW/uNorFQoxHhRGbUNe1
	 GYl6C/KlzIZ0A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=87.248.110.84; helo=sonic302-21.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="sbO2JwEh"; 
 dkim-atps=neutral
Received: from sonic302-21.consmr.mail.ir2.yahoo.com
 (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46qlnz2NkPzDqYp
 for <linux-erofs@lists.ozlabs.org>; Sat, 12 Oct 2019 11:20:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1570839599; bh=x1WK0fzV9WIc2u8ZBnVGJ42mwQqJ/tWi1hU50Z/tqCo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=sbO2JwEhBjOGeDN3jY3zTbXZnxuxh+YWrCszPYxpm25GXZ7oIQNU5oDlLH48eU5tXmF/l19nIJK/3bwrJjZfUuyGg5c10vQYbMJs/CaOEbipsvojYBlrHI1svPAChStPgVdnb9DekTEysgpPJyz2pbi5wwDK3D42P2ZQjFPWk9xI1o/+0YDl4eyQexisuLPEog0NyV9HN03y2NC6+wNz41MsFOILwpSd+U25a13hXEFQxtEc0nM2CkJtGKiqqrwmOSOKBV21TKXTPw2c/Rv9myYDXP69+ueFSkYBlM9TKmdgSDtg/h/CLSGztqxcyLmFv6avWOjAbaUxe3Iuz/+gvQ==
X-YMail-OSG: ZcOsCb0VM1kmNJDcoWPdAR.NuC1uAq53UbVx8RWUOdMHUquHuajpVGrZaHh14ED
 p8VV_vDcf5kXSaCgaHm6FRYrXDZQJqreBxKl4rI9oXNgdkpDq7YBn_roh5cvmnrk8_qkn2g52bQP
 cjqAPx8LB05yb3OY0qKe9H_eMl23pXyzOV6R2j7sH4Cf6TvFLs9ZNPryNOCWIYEdp48TLbYqiZ6D
 OdL0W6GBA6rJvoe_nLkQNk4cuPwcDUDQI9viF3qOZ712HXJ9i8J_jOKXu4R606EoBI7puB4E5fbF
 A1ru_WGxP72NPsxs_8sy4lIh0rSZGoJb1ME1aMLkXscAuxE4ZlGQbqE13C6LW55VMN_IKf4GnZMr
 VfoFQazvuvLGIg28hhEsngevsPz_tMYWOThtqARiLP40ws5NaWP63NH.HAnZzzc_EFHfq1ECS3uP
 gut8yTKwMiExx5q3W2uQtUR4fLR2Vsm3oeLIaMTWLc.0TeuM9rel.IVC4OkMjmMPTETQZxcPzFo5
 HPUNxeVXGk1ouzP20UD8ibroB48WCyctzPGtsOQyhOFkvb8BN5.0w7elRG9siQMpOjHPsjJ8aexx
 xX_UriRPTeRwatZ103RX9Gm3VKO5pO7kE5Be7luAq4EkBGmBFs5MWe0hxedG.fMA.UP0kUuETq01
 IS6HSbJDb9pYe8HWcdNrxfmBRVdJDDAawtMNbID2G5QFYWLZRcZdbWskunf1ZJcrpcfLDli6WSQp
 I9T5TjA5G3_5GZ54CdrxGCwPym2ThjEW5EgjYbEnlWpOsRAW4NT0ph1rLtw43JgSbb6pPw6o_JPg
 TiCDJ91HZt3mNA3Mpqhcj4cR1U_raHK6_0SLKf1JDKcBBGV2ZMxClN6qodLoEB0EGN_o9hGpZ2S8
 k8TYh3NyEY5PJVRJVMATTT0wF_uCUhW05pMYhuG3eE_q5sg._WxFyxHjj5VXjHZh28T1pNczRpIS
 KzHfOdY5i0ss_tfQdPsgbdac9mBvBRo9SCt_w7RptDlKeE.3PAUbwjrJy5MTgG09L8791hQxsscn
 kD3rfNBlNxdKCzIcC2lD8jr.6EtnxwK5AygXGGV3TwVCzcnY3M5owzD.YovtOraKmylTBx1kuUjG
 njyGzllAg.KUUVTIxTHloYoUzZFsuND14.ZiejGNdJzYWc0Pd3dO24.GQ.p7vbrYuGYUKbC3oXJR
 GrvyFmT5sFxV4X94QsQ65DDoKfN5ILQd2TMwjNepzQ3qks3IvVIWkRmcaEtBWQbrvCXKjhezylTI
 ODtUiTC.D_lvHveSb2AKzfuqqKPH0qwEC4LhCZndsbLTaU79TqeAiigPckZn.1sXnVsb.oNCVnad
 qtA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sat, 12 Oct 2019 00:19:59 +0000
Received: by smtp419.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID fca763c3cf8568adfff2f7a344077536; 
 Sat, 12 Oct 2019 00:19:57 +0000 (UTC)
Date: Sat, 12 Oct 2019 08:19:52 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH v4][ 2/2] erofs-utils: fix error handler notes when
 parameter miss
Message-ID: <20191012001949.GB5701@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191011170953.6267-1-blucerlee@gmail.com>
 <20191011170953.6267-2-blucerlee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011170953.6267-2-blucerlee@gmail.com>
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

On Sat, Oct 12, 2019 at 01:09:53AM +0800, Li Guifu wrote:
> If a parameter isnot input, mkfs's error handler cannot give
> a correct notes, fix it.
> 
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> ---
>  mkfs/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 77a4b78..adfc79c 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -143,7 +143,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
>  	if (!cfg.c_img_path)
>  		return -ENOMEM;
>  
> -	if (optind > argc) {
> +	if (optind >= argc) {
>  		erofs_err("Source directory is missing");
>  		return -EINVAL;
>  	}
> -- 
> 2.17.1
>

Already applied.

Thanks,
Gao Xiang

