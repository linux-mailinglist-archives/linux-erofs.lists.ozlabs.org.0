Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6507B2E367C
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 12:33:14 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4Fm73Bz2zDqCC
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 22:33:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=hQyO7f8m; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hQyO7f8m; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4Fm351F5zDqBd
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 22:33:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609155182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RbtMfYOITbrjFWag5Xb/+M7EKqmnZB5fPr2Fby6zuH8=;
 b=hQyO7f8mzQ+2nd23uVR3jPhRsl3e7sP0basWkpy90Z+7VKGa/ZGUsZ7EpdXZKkpKPZyFj+
 CDJJDFBAcvyX1nL4KLnrlOxRfEccUVTum0+xZr6JvUgIqFj+YgxOEWCbZtDDp1ISu0rywh
 hUMAU/WyADfGq/+wKTTbAsc/YDrqsTQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609155182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RbtMfYOITbrjFWag5Xb/+M7EKqmnZB5fPr2Fby6zuH8=;
 b=hQyO7f8mzQ+2nd23uVR3jPhRsl3e7sP0basWkpy90Z+7VKGa/ZGUsZ7EpdXZKkpKPZyFj+
 CDJJDFBAcvyX1nL4KLnrlOxRfEccUVTum0+xZr6JvUgIqFj+YgxOEWCbZtDDp1ISu0rywh
 hUMAU/WyADfGq/+wKTTbAsc/YDrqsTQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-90fJCD5vOjagIZYdC-rmgA-1; Mon, 28 Dec 2020 06:33:00 -0500
X-MC-Unique: 90fJCD5vOjagIZYdC-rmgA-1
Received: by mail-pl1-f199.google.com with SMTP id ba10so5643862plb.11
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 03:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RbtMfYOITbrjFWag5Xb/+M7EKqmnZB5fPr2Fby6zuH8=;
 b=FiVgOyem7ZU4qrp1irD1nP8mcGG3RKIEoZwcP/dfxTWy/F+b/+JiTxrAc3GtSoj5uP
 vY9rNX3zz+BTbgRlkozq+rOfkcBbf2aDgeQ3JxDsVGdd7oJRH7FJQtZy131OKRzC2K4O
 TOi1EaRRRSiBWcUHnLRr/xzQUccs/t9EZrBEx8Xaxc4oM8kmCE4y7mwZQFqm7AmzjcX7
 uZdmQHSTE7cC+Frj7PN7Kwvy8D2Ynirzh2MubvF/4Y63IDjSWY/cODcRZwgH4vUFCj8h
 h0Hn/rz4DWUFjoTfNUT8K1iP7Mi1EO/TFQ5bCcy4KpEQ2SPbTuaa2bHd3zsfCt4WMu8X
 duOg==
X-Gm-Message-State: AOAM532UcIFGovQ0dokyNH6Hi4xHPRtQW1+8J0i860K0fPtoWTZH6ujS
 Bdhfx4sHHgn2As7rtnltOsYN1xuZb++yTfuIWxjHM+ZRnFYQZQG0PsU5Samht32KKhflFSBxuQq
 BTCU6B4W6NxCIHGsd20Oiblds
X-Received: by 2002:aa7:9707:0:b029:19d:c5a8:155e with SMTP id
 a7-20020aa797070000b029019dc5a8155emr40623378pfg.62.1609155179800; 
 Mon, 28 Dec 2020 03:32:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKJZDmv9PyCglBSBl7DX7REdLkmMAyfqaOTp9b6Q9vI4BW7MOyBX723/5tQsSEjpztjPhbKA==
X-Received: by 2002:aa7:9707:0:b029:19d:c5a8:155e with SMTP id
 a7-20020aa797070000b029019dc5a8155emr40623364pfg.62.1609155179600; 
 Mon, 28 Dec 2020 03:32:59 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g30sm36121950pfr.152.2020.12.28.03.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 03:32:59 -0800 (PST)
Date: Mon, 28 Dec 2020 19:32:47 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v2] AOSP: erofs-utils: fix sub-directory prefix for
 canned fs_config
Message-ID: <20201228113247.GA2944077@xiangao.remote.csb>
References: <20201226062736.29920-1-hsiangkao@aol.com>
 <20201228105146.2939914-1-hsiangkao@redhat.com>
 <20201228192048.00006a93.zbestahu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201228192048.00006a93.zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Hi Yue,

On Mon, Dec 28, 2020 at 07:20:48PM +0800, Yue Hu wrote:
> On Mon, 28 Dec 2020 18:51:46 +0800
> Gao Xiang <hsiangkao@redhat.com> wrote:

...

> > @@ -696,32 +696,43 @@ int erofs_droid_inode_fsconfig(struct
> > erofs_inode *inode, /* filesystem_config does not preserve file type
> > bits */ mode_t stat_file_type_mask = st->st_mode & S_IFMT;
> >  	unsigned int uid = 0, gid = 0, mode = 0;
> > -	char *fspath;
> > +	const char *fspath;
> > +	char *decorated = NULL;
> >  
> >  	inode->capabilities = 0;
> > +	if (!cfg.fs_config_file && !cfg.mount_point)
> > +		return 0;
> > +
> > +	if (!cfg.mount_point ||
> > +	/* have to drop the mountpoint for rootdir of canned
> > fsconfig */
> > +	    (cfg.fs_config_file && erofs_fspath(path)[0] == '\0')) {
> > +		fspath = erofs_fspath(path);
> > +	} else {
> > +		if (asprintf(&decorated, "%s/%s", cfg.mount_point,
> > +			     erofs_fspath(path)) <= 0)
> > +			return -ENOMEM;
> > +		fspath = decorated;
> > +	}
> > +
> >  	if (cfg.fs_config_file)
> 
> Whether we can use the first "cfg.fs_config_file" when loading canned
> fs-config to reduce/simplify these duplicated calling?

Not sure what you mean... If you mean why not using some "fs_config_func"
as squashfs did, that is I'd like to 1) avoid such unneeded indirect
function pointers, and 2) no need to introduce such function prototype (I
don't want to maintain such function pointer type) since fs_config and
canned_fs_config implement differently (and it seems they also behave
differently so no need to mix them at all).

Thanks,
Gao Xiang

