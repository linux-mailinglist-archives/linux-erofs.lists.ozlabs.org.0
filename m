Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDC82E36B8
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 12:39:11 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4Fv03rY0zDqC5
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 22:39:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034;
 helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=DZ0A5Oi8; dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4Ftx0CkfzDqBb
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 22:39:01 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id lb18so5801661pjb.5
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 03:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8QyGqACoNsp7umAIqU/gTyWq2/V+9KSOEYdEldt0Sdo=;
 b=DZ0A5Oi851yq+vd94yGc1t+kzvATMdNrQTtTD9Ptq3GGv+KzrQhYtAetH+sskx5Mfp
 Ayb6tKz82DRrfzv5Dw4217UstEN+iQZZ6vIujf11mUDzLPqq7BlVXaR+zw9QB8WcfX+o
 ow/5M1Tl3PIfI+5Z04s3qI2Tuc71jEzCLfzYiMBDlUyUFTWk/jaBjzzZ+FPV1hdTJAM9
 s90X6H+GBcS0anFOPdGyzQzm3bp2m4U7rH5qO460G2Qrc+l8UgakSF3gC64H5rVNws5R
 UeRsUuOAQshbIkHq8R0B8AQJCAXJts8XERWa4HXcC50Ilg454efBXZOM0p56+ucaEvnu
 gCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8QyGqACoNsp7umAIqU/gTyWq2/V+9KSOEYdEldt0Sdo=;
 b=P0SwH3VZ+t/sEZBSo3d36gVNsHwJriowRfnQHMS6S6XnBb9ot/3/QMfnayuvx4uiId
 6utEfJknnarQKkwwIElNA6HeuSnVw5+NB2RLdpXxI4n2QkQjF3g3cmfKJfep1CDKxIhv
 1zxM1ja/mSH1xeVNEPS3UPkqZp5nsRwz8nqxex8sYPHWQOzLbgBJqMccQqgU1D5d7sPS
 2gDNbzbYWAohPRzsmu/FTi5mBKcxxK39mrTdNGnMdRRCXNMES91B+yOBU1SV2zhwDyz2
 qFKXlQUnGNOllfNcJozmBNFzp4SEjJBVlp5A0keDdAolp6JCko8+WDt+H7vC1wMbpfd3
 2iZQ==
X-Gm-Message-State: AOAM533O66LatI2d4dsl0a26A8L71CN8aqCq/9BlMU01oRUSHg6bVu6J
 KoblymdgZ0hor8Awr8EIjUc=
X-Google-Smtp-Source: ABdhPJwEsxqkx1Rn43xkI7mPlhmMS8f3NmD2KvI3SNj3JXyfPMni6WzbZEJ/M1H/qe3V5BQ5+GOpTg==
X-Received: by 2002:a17:902:a711:b029:dc:2f27:c67f with SMTP id
 w17-20020a170902a711b02900dc2f27c67fmr43112060plq.74.1609155537901; 
 Mon, 28 Dec 2020 03:38:57 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id t5sm13489792pjr.22.2020.12.28.03.38.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Dec 2020 03:38:57 -0800 (PST)
Date: Mon, 28 Dec 2020 19:39:00 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH v2] AOSP: erofs-utils: fix sub-directory prefix for
 canned fs_config
Message-ID: <20201228193900.000051ef.zbestahu@gmail.com>
In-Reply-To: <20201228113247.GA2944077@xiangao.remote.csb>
References: <20201226062736.29920-1-hsiangkao@aol.com>
 <20201228105146.2939914-1-hsiangkao@redhat.com>
 <20201228192048.00006a93.zbestahu@gmail.com>
 <20201228113247.GA2944077@xiangao.remote.csb>
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
Cc: Yue Hu <huyue2@yulong.com>, zhangwen@yulong.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 28 Dec 2020 19:32:47 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> Hi Yue,
> 
> On Mon, Dec 28, 2020 at 07:20:48PM +0800, Yue Hu wrote:
> > On Mon, 28 Dec 2020 18:51:46 +0800
> > Gao Xiang <hsiangkao@redhat.com> wrote:  
> 
> ...
> 
> > > @@ -696,32 +696,43 @@ int erofs_droid_inode_fsconfig(struct
> > > erofs_inode *inode, /* filesystem_config does not preserve file
> > > type bits */ mode_t stat_file_type_mask = st->st_mode & S_IFMT;
> > >  	unsigned int uid = 0, gid = 0, mode = 0;
> > > -	char *fspath;
> > > +	const char *fspath;
> > > +	char *decorated = NULL;
> > >  
> > >  	inode->capabilities = 0;
> > > +	if (!cfg.fs_config_file && !cfg.mount_point)
> > > +		return 0;
> > > +
> > > +	if (!cfg.mount_point ||
> > > +	/* have to drop the mountpoint for rootdir of canned
> > > fsconfig */
> > > +	    (cfg.fs_config_file && erofs_fspath(path)[0] ==
> > > '\0')) {
> > > +		fspath = erofs_fspath(path);
> > > +	} else {
> > > +		if (asprintf(&decorated, "%s/%s",
> > > cfg.mount_point,
> > > +			     erofs_fspath(path)) <= 0)
> > > +			return -ENOMEM;
> > > +		fspath = decorated;
> > > +	}
> > > +
> > >  	if (cfg.fs_config_file)  
> > 
> > Whether we can use the first "cfg.fs_config_file" when loading
> > canned fs-config to reduce/simplify these duplicated calling?  
> 
> Not sure what you mean... If you mean why not using some

Sorry for my typo. I mean duplicated 'check' to cfg.fs_config_file.

> "fs_config_func" as squashfs did, that is I'd like to 1) avoid such
> unneeded indirect function pointers, and 2) no need to introduce such
> function prototype (I don't want to maintain such function pointer
> type) since fs_config and canned_fs_config implement differently (and
> it seems they also behave differently so no need to mix them at all).

Ok.

> 
> Thanks,
> Gao Xiang
> 

