Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 739852E2419
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Dec 2020 04:46:09 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D1bb26n74zDqMt
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Dec 2020 14:46:06 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QcmE1LE4; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D1bZz2XnZzDqJh
 for <linux-erofs@lists.ozlabs.org>; Thu, 24 Dec 2020 14:45:59 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id m6so576423pfm.6
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Dec 2020 19:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cK5EjWpAV1CsL7GmokK9m3lLkXi8ebPuIywUAHfrOy8=;
 b=QcmE1LE4WCV0d6iUqFt47AtVdYqrPC6RbnlZ7dnpNuadyYAetYuelIDziY3W48q5le
 dNLTcv0MOa2GGmmbsH5+YJQMPOvQSSes/V4BMSqVfGPpHJgCpSNyvyfQYFt/nw2QehYb
 yg73kiVIntHvdlEMxV5wpifhm+pY2nlKTxkrRnuhv/ztETsWVyCutt6HR4Gnp7QPyqxR
 qI6cldyXHdKsKbgN7Absuivxc0PD3La48uKrwsNF5/AQhCYd2abFozAgw66TbjJSiHae
 InosybnGB2g3GBC58wtna8gMTnpCytdNwTKnRrxMDcxO3UKoO2Tv3kOVCGnKPl4L0//H
 dFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cK5EjWpAV1CsL7GmokK9m3lLkXi8ebPuIywUAHfrOy8=;
 b=WkOhj2WSgBsKejJ8gmITOw3eboeHdaouR05EO4KADJLUUAGFreo+p7t5OOQZLNt6Xh
 JT/deQ36/xCvOqjpeQj5odRgAVA5qI+AjSPD4QzQj12cXPZTvhDuSlO8hEHKQPS0C0IK
 VCZuzwE98lfy8BZkAYF/7JjrJzRv36AXKug8oZKl89ssgph9NH6eoDkJYRJmwxe2mmRg
 FCszX1k7Svi5PH5j6p6fA6V7R/fAlFB3GoGfjkyXTncy3Qzdj+abXJ1rA/LlpX37sJdM
 xpOeRchwSuJyYi7gTI8i9GYxYy/QNr+nGzYR7TgDIvOr7n/NT0X7zU8P6Q8i6UAdAH2u
 e36g==
X-Gm-Message-State: AOAM53156nr0n7k0dMyY7oJ4C2v8ezrmU4hu0azUCdd6xPZfzVKqQaDQ
 J6UmxdJWg5l8YlDZtuteAU0=
X-Google-Smtp-Source: ABdhPJzKP6R6JH8Kl6Tl2bT1lZlXhFRP1BE/YE0lIDM5t9hMYCdrKAsCjOGyq2PiOAaMKKhtLLqqsg==
X-Received: by 2002:aa7:8641:0:b029:1a1:e2f5:23de with SMTP id
 a1-20020aa786410000b02901a1e2f523demr25441180pfo.35.1608781556106; 
 Wed, 23 Dec 2020 19:45:56 -0800 (PST)
Received: from localhost ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id y23sm26365163pfc.178.2020.12.23.19.45.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Dec 2020 19:45:55 -0800 (PST)
Date: Thu, 24 Dec 2020 11:45:42 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@redhat.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub directory prefix path in
 canned fs_config
Message-ID: <20201224114542.0000461f.zbestahu@gmail.com>
In-Reply-To: <20201222104700.GB1831635@xiangao.remote.csb>
References: <20201222020430.12512-1-zbestahu@gmail.com>
 <20201222034455.GA1775594@xiangao.remote.csb>
 <20201222124733.000000fe.zbestahu@gmail.com>
 <20201222063112.GB1775594@xiangao.remote.csb>
 <20201222070458.GA1803221@xiangao.remote.csb>
 <20201222160935.000061c3.zbestahu@gmail.com>
 <20201222091340.GA1819755@xiangao.remote.csb>
 <20201222173014.000055d3.zbestahu@gmail.com>
 <20201222093952.GC1819755@xiangao.remote.csb>
 <20201222183411.00004854.zbestahu@gmail.com>
 <20201222104700.GB1831635@xiangao.remote.csb>
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
Cc: huyue2@yulong.com, xiang@kernel.org, linux-erofs@lists.ozlabs.org,
 zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 22 Dec 2020 18:47:00 +0800
Gao Xiang <hsiangkao@redhat.com> wrote:

> On Tue, Dec 22, 2020 at 06:34:11PM +0800, Yue Hu wrote:
> 
> ...
> 
> > > 
> > > Hmmm... such design is quite strange for me....
> > > Could you try the following diff?
> > > 
> > > diff --git a/lib/inode.c b/lib/inode.c
> > > index 9469074..9af6179 100644
> > > --- a/lib/inode.c
> > > +++ b/lib/inode.c
> > > @@ -698,11 +698,14 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
> > >  	/* filesystem_config does not preserve file type bits */
> > >  	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
> > >  	unsigned int uid = 0, gid = 0, mode = 0;
> > > +	bool alloced;
> > >  	char *fspath;
> > >  
> > >  	inode->capabilities = 0;
> > > -	if (!cfg.mount_point)
> > > -		fspath = erofs_fspath(path);
> > > +
> > > +	alloced = (cfg.mount_point && erofs_fspath(path)[0] != '\0');
> > > +	if (!alloced)
> > > +		fspath = (char *)erofs_fspath(path);
> > >  	else if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > >  			  erofs_fspath(path)) <= 0)
> > >  		return -ENOMEM;
> > > @@ -718,7 +721,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
> > >  			  cfg.target_out_path,
> > >  			  &uid, &gid, &mode, &inode->capabilities);
> > >  
> > > -	if (cfg.mount_point)
> > > +	if (alloced)
> > >  		free(fspath);
> > >  	st->st_uid = uid;
> > >  	st->st_gid = gid;
> > > 
> > > if it works, will redo a formal patch then....  
> > 
> > Works for me for canned fs_config.  
> 
> Ok, if it also works fine for non-canned fs_config on your side,
> I will redo a formal patch later... sigh :(

Hi Xiang,

I just remove the "--fs-config-file" in my test enviroment, after that,
build and boot are all working fine. 

If canned fs_config never used by others before, i think it's a bug. 

Thx.

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thx.  
> 

