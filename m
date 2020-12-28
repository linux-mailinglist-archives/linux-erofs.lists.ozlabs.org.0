Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D522E35FF
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 11:48:58 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D4Dn36cPyzDqCD
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Dec 2020 21:48:55 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=HCf3EQtm; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCf3EQtm; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D4Dn06rRGzDqBt
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 21:48:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609152527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xT82RobTJ4dZa/RyrCcpMMwGJEBcxUinCviMz9VGtRE=;
 b=HCf3EQtm2ZLrjKi4SgvfNJc8z1nQ7nAUPNs0dsfNatpTEJjw6xtOy6/OmuQaRVlexvcJRD
 URyHdwk8rn/iqrqzBeyR0DgxiniXP0ZhlzOVYcNLKjwoPmCFrQh3Ntl7CXM06DnTJrLwJo
 zSQYGhLIjLXO3UnIU3O69XMrR3i0zgM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609152527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xT82RobTJ4dZa/RyrCcpMMwGJEBcxUinCviMz9VGtRE=;
 b=HCf3EQtm2ZLrjKi4SgvfNJc8z1nQ7nAUPNs0dsfNatpTEJjw6xtOy6/OmuQaRVlexvcJRD
 URyHdwk8rn/iqrqzBeyR0DgxiniXP0ZhlzOVYcNLKjwoPmCFrQh3Ntl7CXM06DnTJrLwJo
 zSQYGhLIjLXO3UnIU3O69XMrR3i0zgM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-EeVwMNBVNcywtYUBYXw2Aw-1; Mon, 28 Dec 2020 05:48:43 -0500
X-MC-Unique: EeVwMNBVNcywtYUBYXw2Aw-1
Received: by mail-pf1-f199.google.com with SMTP id l17so3372473pff.17
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Dec 2020 02:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=xT82RobTJ4dZa/RyrCcpMMwGJEBcxUinCviMz9VGtRE=;
 b=PXTLM3Zu3xzB3OxcHHIGsQXsskVkMTvPfnOVaRmvhzFRpHDU3R+g5z05MmfMjsQ7Rk
 VqK5f132UP6TEjWQs7bE0pT8i/kFJiyewQbOFTO/JeLtdgU/vYoZODMQ39z19bFRx3ur
 20wj659KSuxrDYfljZwPmcMQNmTYM/0OAPVxY7u9FT9b+80bn6IxfmWKHZ4s+efAmIr5
 w8D8PCgjcMRs12cRyuQ4oAhs+XXfmhsVJrfTp+Uf30zymCbN5JgXE+qJBX5ejyAa2L1Y
 r/1GcIAfVYf85k84d+t+kZQWj8UQRlE4mxNaTbe4peGuNQswl+2NpAl6pqSpwYkRBEcr
 87tg==
X-Gm-Message-State: AOAM532INt7yekp7IWprumgRzTOU0JZjlhROeQzJ82qoZ3cEwrREhnuZ
 /BH3zQzDXigtsSnKmVbWNwFTTPKJBqnzUfAeXVy9HYagwTDX5S6SoOSmOWvdI6Sa156rgnRXR0i
 CY455OwXtRZdWkMMM1dDzOIBJ
X-Received: by 2002:a62:b415:0:b029:1a6:8b06:68f4 with SMTP id
 h21-20020a62b4150000b02901a68b0668f4mr41141103pfn.43.1609152521986; 
 Mon, 28 Dec 2020 02:48:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1h4Wb9+SL4stQj1ag9890+Al2/7PmJt9zP8wdV/k7oJAVWFotH3QgkLn1xd6fB4+yRrC0uQ==
X-Received: by 2002:a62:b415:0:b029:1a6:8b06:68f4 with SMTP id
 h21-20020a62b4150000b02901a68b0668f4mr41141091pfn.43.1609152521778; 
 Mon, 28 Dec 2020 02:48:41 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j14sm13857326pjm.10.2020.12.28.02.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 02:48:41 -0800 (PST)
Date: Mon, 28 Dec 2020 18:48:30 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH] AOSP: erofs-utils: fix sub-directory prefix for canned
 fs_config
Message-ID: <20201228104830.GA2938609@xiangao.remote.csb>
References: <20201226062736.29920-1-hsiangkao.ref@aol.com>
 <20201226062736.29920-1-hsiangkao@aol.com>
 <94a271f5-2bfd-002e-a77a-93582282a6d0@oppo.com>
MIME-Version: 1.0
In-Reply-To: <94a271f5-2bfd-002e-a77a-93582282a6d0@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: zhangshiming@oppo.com, huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Dec 28, 2020 at 06:03:26PM +0800, Huang Jianan wrote:
> 
> 在 2020/12/26 14:27, Gao Xiang 写道:

...

> > +	if (!cfg.mount_point ||
> > +	/* have to drop the mountpoint for rootdir of canned fsconfig */
> > +	    (cfg.fs_config_file && IS_ROOT(inode))) {
> 
> Hi Xiang,
> 
> I have tested this patch with --fs-config-file, and the problem still
> exists.
> 
> IS_ROOT can't be used here to determine the root directory , because
> inode->i_parent is null at this time. It will be set after this function.
> 

Hi Jianan,

Thanks for your report! Sorry for the troublesome.
I need to turn back as the next version.... Very sorry about this!

Thanks,
Gao Xiang

> Thanks,
> 
> Jianan
> 
> > +		fspath = erofs_fspath(path);
> > +	} else {
> > +		if (asprintf(&decorated, "%s/%s", cfg.mount_point,
> > +			     erofs_fspath(path)) <= 0)
> > +			return -ENOMEM;
> > +		fspath = decorated;
> > +	}
> > +
> >   	if (cfg.fs_config_file)
> > -		canned_fs_config(erofs_fspath(path),
> > +		canned_fs_config(fspath,
> >   				 S_ISDIR(st->st_mode),
> >   				 cfg.target_out_path,
> >   				 &uid, &gid, &mode, &inode->capabilities);
> > -	else if (cfg.mount_point) {
> > -		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
> > -			     erofs_fspath(path)) <= 0)
> > -			return -ENOMEM;
> > -
> > +	else
> >   		fs_config(fspath, S_ISDIR(st->st_mode),
> >   			  cfg.target_out_path,
> >   			  &uid, &gid, &mode, &inode->capabilities);
> > -		free(fspath);
> > -	}
> > -	st->st_uid = uid;
> > -	st->st_gid = gid;
> > -	st->st_mode = mode | stat_file_type_mask;
> >   	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, "
> >   		  "capabilities = 0x%" PRIx64 "\n",
> > -		  erofs_fspath(path),
> > -		  mode, uid, gid, inode->capabilities);
> > +		  fspath, mode, uid, gid, inode->capabilities);
> > +
> > +	if (decorated)
> > +		free(decorated);
> > +	st->st_uid = uid;
> > +	st->st_gid = gid;
> > +	st->st_mode = mode | stat_file_type_mask;
> >   	return 0;
> >   }
> >   #else
> 

