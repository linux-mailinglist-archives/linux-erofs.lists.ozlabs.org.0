Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540802CFAAB
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 09:45:04 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cp36j41QYzDqlf
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 19:45:01 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=J9lMP7rI; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J9lMP7rI; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cp34n5pdZzDqWH
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 19:43:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607157797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zThnsonge8elQ0IV+cmf9KpNa/WKsbfnSqqsfSXwvQg=;
 b=J9lMP7rIHrQjA47SgTbL7ltu/MhMnr6D5K0UZTXEL4mWKjzRA4nCcwGzU+qXk/RafUWv1E
 ZpcLBWIsbLf2sW4Bg920q4K/NklRQCEcTmI+ycw8iwoVPpq2jkTwc7bNMwC8y9aL0nbart
 QauVVlUy1amGM8BnHcHkrB6NFC0LP2U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607157797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zThnsonge8elQ0IV+cmf9KpNa/WKsbfnSqqsfSXwvQg=;
 b=J9lMP7rIHrQjA47SgTbL7ltu/MhMnr6D5K0UZTXEL4mWKjzRA4nCcwGzU+qXk/RafUWv1E
 ZpcLBWIsbLf2sW4Bg920q4K/NklRQCEcTmI+ycw8iwoVPpq2jkTwc7bNMwC8y9aL0nbart
 QauVVlUy1amGM8BnHcHkrB6NFC0LP2U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-sioDJufZNPS6Chs3LB_J0A-1; Sat, 05 Dec 2020 03:43:14 -0500
X-MC-Unique: sioDJufZNPS6Chs3LB_J0A-1
Received: by mail-pj1-f70.google.com with SMTP id h2so4531418pjs.5
 for <linux-erofs@lists.ozlabs.org>; Sat, 05 Dec 2020 00:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zThnsonge8elQ0IV+cmf9KpNa/WKsbfnSqqsfSXwvQg=;
 b=cG9A5poy6gDq04OztSu6P/E7x2JzbkAHuIe5vilSjNcFUkbtaKbYe4e5q0cAdZqE52
 1we+Nk/zEZvTX9gpbh2dr5WyRIM5NY3LV2jO8agva7tO2Qzf3fS/heXR76A5Dv6Uo4yd
 rTO37z0HbadBGgGvUtqcMRdsV8aSmswswP3tvEDvVzUe4lPs+iGTdT5fy+J9GKthPM52
 2uS3DFncm+A4bBmWZidVhMiVHPPpm+Ze1j3jypV8VbMU8rPd40D5Bt1fyiTeGqpT6gP7
 /2514ZVRn99FOdEW0RgImvYv2/ebMXykYI2HXUubKoABB5Lsa4CyTbYVxIY26NKYyQ1j
 o5Fg==
X-Gm-Message-State: AOAM531nWzvfzolf2JmveNVm76q7esZ71ixR66SAgkO6upFbLCL9+km5
 AWqNCoHuy61vpBssb2vKuQG/Y5SrEZer0+zEPcbe61prVgFek46Fs99Fv+m3uUeC+fUElNH6sEF
 c8fkxSFlDEAxHnf2RTeK+8fNg
X-Received: by 2002:a63:943:: with SMTP id 64mr11003206pgj.80.1607157793855;
 Sat, 05 Dec 2020 00:43:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdsnqTZKmMWv7kBtkQdaTgIuVDmAHVWq8EcSKdVUH7bTDFLEpiHFGnA4WEdzYjao5/6vRKyQ==
X-Received: by 2002:a63:943:: with SMTP id 64mr11003195pgj.80.1607157793639;
 Sat, 05 Dec 2020 00:43:13 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w11sm7484538pfj.212.2020.12.05.00.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Dec 2020 00:43:13 -0800 (PST)
Date: Sat, 5 Dec 2020 16:43:03 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Li GuiFu <bluce.lee@aliyun.com>
Subject: Re: [PATCH] erofs-utils: update i_nlink stat for directories
Message-ID: <20201205084303.GB2333547@xiangao.remote.csb>
References: <20201205055732.14276-1-hsiangkao.ref@aol.com>
 <20201205055732.14276-1-hsiangkao@aol.com>
 <ed88d60a-77a9-f189-3586-a6d6aef510d9@aliyun.com>
 <20201205083837.GA2333547@xiangao.remote.csb>
MIME-Version: 1.0
In-Reply-To: <20201205083837.GA2333547@xiangao.remote.csb>
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

On Sat, Dec 05, 2020 at 04:38:37PM +0800, Gao Xiang wrote:
> On Sat, Dec 05, 2020 at 04:32:44PM +0800, Li GuiFu via Linux-erofs wrote:
> 
> ...
> 
> > 
> > > @@ -957,6 +974,10 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
> > >  			ret = PTR_ERR(d);
> > >  			goto err_closedir;
> > >  		}
> > > +
> > > +		/* to count i_nlink for directories */
> > > +		d->type = (dp->d_type == DT_DIR ?
> > > +			EROFS_FT_DIR : EROFS_FT_UNKNOWN);
> > >  	}
> > >  
> > It's confused that d->type was set to EROFS_FT_UNKNOWN when not a dir
> > It's not clearness whether the program goes wrong or get the wrong data
> > Actually it's a correct procedure
> 
> It's just set temporarily, since only dirs are useful when counting subdirs, so
> only needs to differ dirs and non-dirs here. (Previously d->type is unused
> at this time.)

btw, I once tried to set up d->type via dp->d_type here, but it increases a
lot of code and seems unnecessary (since deriving from i_mode is enough).
So again, here we only cares about dir and non-dirs (we don't care much about
the specific kind of non-dirs here).

Thanks,
Gao Xiang

> 
> ...
> 
> > > -		d->type = erofs_type_by_mode[d->inode->i_mode >> S_SHIFT];
> > > +		ftype = erofs_mode_to_ftype(d->inode->i_mode);
> > > +		DBG_BUGON(d->type != EROFS_FT_UNKNOWN && d->type != ftype);
> > > +		d->type = ftype;
> 
> The real on-disk d->type will be set here rather than the above.
> 
> Thanks,
> Gao Xiang
> 

