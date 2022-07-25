Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3525657F94A
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Jul 2022 08:02:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LrqFB45tPz3bmL
	for <lists+linux-erofs@lfdr.de>; Mon, 25 Jul 2022 16:02:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=hsml1Hb3;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=hsml1Hb3;
	dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LrqF71S9nz302S
	for <linux-erofs@lists.ozlabs.org>; Mon, 25 Jul 2022 16:02:01 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id y15so9458559plp.10
        for <linux-erofs@lists.ozlabs.org>; Sun, 24 Jul 2022 23:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a91avjFOPv3IX1uwOizEjKNhTk/48F7Y96R961LVyww=;
        b=hsml1Hb32Wg8+N3SB5ZSXgPsSlJJC9z5YdONMl9EIb9A3uh+qkSENWqnBX7Z3RFHdC
         wK7E5TXxSPEEzVpHzgR1dz38SRLrW2hxC5ypIaox5hHQ2PPmu8R46AC3E4rp2EvyIXzL
         8AgMHsqvGI9xWnLSoId6tqbiU4KK6U0PqSIUUvhuI4AJxHZQbou2U8e64xilhZR/Arxw
         26pdiVpgRNM80aDTHoYzHFc7YxKv7RaAOWqb0Zc3lVmI3gwMp0IZIXeMFs2FuvhuWjby
         gW30wsJn85szWP2DBdkd10fRi4GnLs91J1v568VvmdrY21GogbHobHvmcYUi8IgGV8SU
         /JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a91avjFOPv3IX1uwOizEjKNhTk/48F7Y96R961LVyww=;
        b=sB1Fql3ITIllXR/Ovbox+rwxyqXyDOk5uGiUEbagL8MvK3il9RGMBOez/tIoFY3fA8
         cVsHCtDiDSK6j/bqADuXPyQLfpsMCCdqYfDrc9WtC55vcaXTlyFxMgD10/jIl1Tp/alT
         91w2SQ8Xu5h+QKbax3ssDGRZZLvIIwo5b+vQIsRLJoEBbjh5zfprvy8HELr2OTJbeZGt
         OX4lJGGOVyNSgzVcxDzBG0FSNFQoIscSXLEhFeAUnbCwuHPoruyQj3PYGACyDEjFSgH3
         ajiT2AfFqFaDlI/vgvLlbMut+bKL712qECcmsgd8BM99BJFwJmtSlkxuk+JTWXaB21IP
         jaaA==
X-Gm-Message-State: AJIora/teJhHBrfuYihSxTSwArhQ4yUGBR7OXInla/eMfgSQyhrKMy22
	0h23ENsYPdb0mpXHQUK9TKA=
X-Google-Smtp-Source: AGRyM1vlCv40z3OFJKki+uMKXJbE/lJ5Vb09AghIaHmcxUsISHl7PSTFzE4IT8bi5skPMgH42yWCiQ==
X-Received: by 2002:a17:902:8602:b0:16c:dfae:9afb with SMTP id f2-20020a170902860200b0016cdfae9afbmr11358055plo.35.1658728917897;
        Sun, 24 Jul 2022 23:01:57 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7990c000000b0052baa22575asm8506261pff.134.2022.07.24.23.01.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jul 2022 23:01:57 -0700 (PDT)
Date: Mon, 25 Jul 2022 14:03:34 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: fix a memory leak of compression
 type configuration
Message-ID: <20220725140334.000006c0.zbestahu@gmail.com>
In-Reply-To: <Yt4wli4X2aCpBNl7@B-P7TQMD6M-0146.local>
References: <20220725054549.23562-1-huyue2@coolpad.com>
	<Yt4wli4X2aCpBNl7@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Mon, 25 Jul 2022 13:56:38 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On Mon, Jul 25, 2022 at 01:45:49PM +0800, Yue Hu wrote:
> > Release the memory allocated for compression type configuration. And no
> > need to consider !optarg case since getopt_long() will do that.
> > 
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>
> > ---  
> 
> What's the difference between v1?

just fix 'configration' -> 'configuration' in summary line.

> The patch itself looks good to me, but I need to try later.
> 
> Thanks,
> Gao Xiang
> 
> >  lib/config.c | 3 +++
> >  mkfs/main.c  | 4 ----
> >  2 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/config.c b/lib/config.c
> > index 3963df2..c316a54 100644
> > --- a/lib/config.c
> > +++ b/lib/config.c
> > @@ -55,6 +55,9 @@ void erofs_exit_configure(void)
> >  #endif
> >  	if (cfg.c_img_path)
> >  		free(cfg.c_img_path);
> > +
> > +	if (cfg.c_compr_alg_master)
> > +		free(cfg.c_compr_alg_master);
> >  }
> >  
> >  static unsigned int fullpath_prefix;	/* root directory prefix length */
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index deb8e1f..9f5f1dc 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -212,10 +212,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
> >  				  long_options, NULL)) != -1) {
> >  		switch (opt) {
> >  		case 'z':
> > -			if (!optarg) {
> > -				cfg.c_compr_alg_master = "(default)";
> > -				break;
> > -			}
> >  			/* get specified compression level */
> >  			for (i = 0; optarg[i] != '\0'; ++i) {
> >  				if (optarg[i] == ',') {
> > -- 
> > 2.17.1  

