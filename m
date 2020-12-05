Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7CC2CFABF
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 10:09:51 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp3gJ4yYhzDqk9
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 20:09:48 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=aFwRMQen; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aFwRMQen; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp3gC3hqRzDq8F
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 20:09:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607159380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gecV/gH482+Xw3GgpYHPDQgme36/4knyiAKGgAX2OKI=;
 b=aFwRMQenWRsZRCCNkR+397z/+Gvg0pNG1SITFxEUl/LsoSG3C2fp+GCtKLiAwFD1UNKC26
 mdagB66UX8nUYBXq02YbQuLUl6VCRuVqKeU+9YHOEiCs0Csx0lNeaqC/EJRtSFgAkf8cUJ
 3lOt4Ez/IbiKPdvcgN8pcIsgRmvblzw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607159380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gecV/gH482+Xw3GgpYHPDQgme36/4knyiAKGgAX2OKI=;
 b=aFwRMQenWRsZRCCNkR+397z/+Gvg0pNG1SITFxEUl/LsoSG3C2fp+GCtKLiAwFD1UNKC26
 mdagB66UX8nUYBXq02YbQuLUl6VCRuVqKeU+9YHOEiCs0Csx0lNeaqC/EJRtSFgAkf8cUJ
 3lOt4Ez/IbiKPdvcgN8pcIsgRmvblzw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-m968r-w_O4WbooaEjkoaJw-1; Sat, 05 Dec 2020 04:09:38 -0500
X-MC-Unique: m968r-w_O4WbooaEjkoaJw-1
Received: by mail-pf1-f200.google.com with SMTP id e68so5396795pfe.4
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Dec 2020 01:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gecV/gH482+Xw3GgpYHPDQgme36/4knyiAKGgAX2OKI=;
 b=A6/IersObaLEbCipGlu5pUM7prF+wWoMI4SL/wiX/XYBAKZC2GaUx6zErkVDkNZhhU
 XCOMz1aUVrnIwyHKUOJtapQXveCHP7TFF/q0Aq/4z+748rDwtChTlXfueyXKcbG85kKJ
 ygR/0IoPuBXwIncmcWAi5HDCTuP5C/MIBRBM8qFW189ukfiI8ICZS6oo/BtCqeXKIhB/
 3IExWkSRzNwHH30IeUlKe2+N7DzL7B4RgsrLI1M1HvWV1L/bKBdDGHvHusiG2dFhQmyP
 Q2wdv7Iv9zFVEheRy1KBRf4E28EAKTQwB6T+h/nngutHBb25elJouNHlttihnJXT1frx
 MsPQ==
X-Gm-Message-State: AOAM532zbdyTmbn1Q7LUZHuCbqx2QGiNpfe9ZvMT5OLdLsABPU2UhIRm
 FHJ/wB2v0CNspdT0COwVqCKLA960rVOTtENUJbjfPHDqCKc2TfDONocLhM9jleUaR/hLlIIWPvY
 6o+cWaiXXxoKMf8WZAJ3OQmG4
X-Received: by 2002:a62:68c7:0:b029:197:c7e0:6d8f with SMTP id
 d190-20020a6268c70000b0290197c7e06d8fmr7816544pfc.74.1607159377516; 
 Sat, 05 Dec 2020 01:09:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytAgDDE6zFq6AWHXlKgRYZeU1IZVYB2/cfeqhBAEYEEiWSX5QKf9uAfIuJ0lOSo+xU5hjbow==
X-Received: by 2002:a62:68c7:0:b029:197:c7e0:6d8f with SMTP id
 d190-20020a6268c70000b0290197c7e06d8fmr7816523pfc.74.1607159377230; 
 Sat, 05 Dec 2020 01:09:37 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e66sm6929363pfe.165.2020.12.05.01.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Dec 2020 01:09:36 -0800 (PST)
Date: Sat, 5 Dec 2020 17:09:26 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Li GuiFu <bluce.lee@aliyun.com>
Subject: Re: [PATCH] erofs-utils: update i_nlink stat for directories
Message-ID: <20201205090926.GD2333547@xiangao.remote.csb>
References: <20201205055732.14276-1-hsiangkao.ref@aol.com>
 <20201205055732.14276-1-hsiangkao@aol.com>
 <ed88d60a-77a9-f189-3586-a6d6aef510d9@aliyun.com>
 <20201205083837.GA2333547@xiangao.remote.csb>
 <20201205084303.GB2333547@xiangao.remote.csb>
 <e3594931-7cf2-b91e-cd0c-76c1d1750ab0@aliyun.com>
MIME-Version: 1.0
In-Reply-To: <e3594931-7cf2-b91e-cd0c-76c1d1750ab0@aliyun.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Dec 05, 2020 at 05:05:35PM +0800, Li GuiFu wrote:

...

> >>>
> >>>> @@ -957,6 +974,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
> >>>>  			ret = PTR_ERR(d);
> >>>>  			goto err_closedir;
> >>>>  		}
> >>>> +
> >>>> +		/* to count i_nlink for directories */
> >>>> +		d->type = (dp->d_type == DT_DIR ?
> >>>> +			EROFS_FT_DIR : EROFS_FT_UNKNOWN);
> >>>>  	}
> >>>>  
> >>> It's confused that d->type was set to EROFS_FT_UNKNOWN when not a dir
> >>> It's not clearness whether the program goes wrong or get the wrong data
> >>> Actually it's a correct procedure
> >>
> >> It's just set temporarily, since only dirs are useful when counting subdirs, so
> >> only needs to differ dirs and non-dirs here. (Previously d->type is unused
> >> at this time.)
> > 
> > btw, I once tried to set up d->type via dp->d_type here, but it increases a
> > lot of code and seems unnecessary (since deriving from i_mode is enough).
> > So again, here we only cares about dir and non-dirs (we don't care much about
> > the specific kind of non-dirs here).
> > 
> > Thanks,
> > Gao Xiang
> > 
> >>
> >> ...
> >>
> >>>> -		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
> >>>> +		ftype = erofs_mode_to_ftype(d->inode->i_mode);
> >>>> +		DBG_BUGON(d->type != EROFS_FT_UNKNOWN && d->type != ftype);
> >>>> +		d->type = ftype;
> >>
> >> The real on-disk d->type will be set here rather than the above.
> Yes, what it makes confused is here, EROFS_FT_UNKNOWN is just temporary.
> So how about change to ASSERT at EROFS_FT_DIR
> 
> DBG_BUGON(d->type == EROFS_FT_DIR && ftype != EROFS_FT_DIR);
> 

Ok, how about the following statement:
DBG_BUGON(ftype == EROFS_FT_DIR && d->type != ftype);

It will save some words. I will send the next version soon.

Thanks,
Gao Xiang


