Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FA032255B
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 06:28:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dl6yd14hZz30QW
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 16:28:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ig+ke+cG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKaT+Q6t;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ig+ke+cG; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKaT+Q6t; 
 dkim-atps=neutral
X-Greylist: delayed 89016 seconds by postgrey-1.36 at boromir;
 Tue, 23 Feb 2021 16:28:06 AEDT
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dl6yZ3BMnz30NQ
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 16:28:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614058081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JP8BZNEYe8HK8zjKUD5vM6SEeD44TdAOAL+tQOP8FIY=;
 b=ig+ke+cGDsqs7FSei7oDYXjk44qM7F3YZmrgoP2cybl+xHrusPVEDf6df64WmG4oX5w61P
 qFvCvpdHQ9b+4/scPPVTMjdNH6r37+tfXN5cEeh1G7weNfKI4kzBaoFxVKWh6krIq0Q0Zt
 Tr0u/T2AcnqR9QHlgooHJqyOHmJ6Xkk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614058082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JP8BZNEYe8HK8zjKUD5vM6SEeD44TdAOAL+tQOP8FIY=;
 b=XKaT+Q6t3BdVhQiWgkof6uIisDwSc1pGYe5pp8mxCJpWp9XLHq9lDhzYbTT97MmPd716KL
 roLPj0iqXEXZZvwC1prb+dq76tAR2VOa3u229CGDshK+UGWwUbvM1OnGAamkkFM1p5xpGn
 i7TYmWHwzY8kttRrpdAgF8SkuE1anbk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-f5zx7IsiOuSuoYt7BORkDQ-1; Tue, 23 Feb 2021 00:26:11 -0500
X-MC-Unique: f5zx7IsiOuSuoYt7BORkDQ-1
Received: by mail-pf1-f199.google.com with SMTP id h17so8533349pfc.19
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Feb 2021 21:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JP8BZNEYe8HK8zjKUD5vM6SEeD44TdAOAL+tQOP8FIY=;
 b=a6v/gR0FfPfypxWchY8Rr34XtB/W0HEXv49/LXoLV1DWkN3HFhCkSVfFhzvehBfMzp
 m53oXzH1zye3kiSM4ndnZ5iGyWpHn1rzPPgOBnzAUgb4o4JEpFP8Kzz6TVR1qD4kvGDD
 5olXx545wicnZSV0dWqLqlPPGyFQEhWrvQP19x1vHjRPFGinqm0OnKbdmVClsRffnEzs
 WsmVntt529/WLXLrM99zB40OdCvgGlHUVnOXTMcoKScQKukgYE5qJCx6DbOPWpZUSALX
 MnC9dM+IkXm9st5mONVEpV40Icmp+CJohN+RlVETEKFVmh+EAE4HNieKVF957T8mJ3XR
 EdgQ==
X-Gm-Message-State: AOAM531j3StS5VHqNkkz3MnI53mEu9kcbjyE3EnZvTwphlD5Z5OERoh+
 8hITZXntQpnbnypVgA05LD14OJrG1SFqcfahp+D2bQGwkiAyt0st2YvwR1BxhAWC3So+fajarFq
 lr0GzimsH7AobZeXx1R529VIQ
X-Received: by 2002:a17:90a:b016:: with SMTP id
 x22mr3207270pjq.161.1614057969936; 
 Mon, 22 Feb 2021 21:26:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpnt3C/L6BzHK8iud/yFdLHTq9zLeWs7YlwD0343Bs/iKI/BS4iGOoGOYKvtl/84R4ksqqoQ==
X-Received: by 2002:a17:90a:b016:: with SMTP id
 x22mr3207238pjq.161.1614057969564; 
 Mon, 22 Feb 2021 21:26:09 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o189sm21216324pfd.73.2021.02.22.21.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 21:26:08 -0800 (PST)
Date: Tue, 23 Feb 2021 13:25:58 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v2] erofs: support adjust lz4 history window size
Message-ID: <20210223052558.GC1225203@xiangao.remote.csb>
References: <20210223043634.36807-1-huangjianan@oppo.com>
 <20210223051926.GB1225203@xiangao.remote.csb>
MIME-Version: 1.0
In-Reply-To: <20210223051926.GB1225203@xiangao.remote.csb>
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
Cc: zhangshiming@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(cont. the previous reply)

On Tue, Feb 23, 2021 at 01:19:26PM +0800, Gao Xiang wrote:

...

> > +	__le16 lz4_max_distance;	/* lz4 max distance */

unneeded comment.

> > +	__u8 reserved2[42];
> >  };
> >  
> >  /*
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index 67a7ec945686..7457710a763a 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -70,6 +70,9 @@ struct erofs_sb_info {
> >  
> >  	/* pseudo inode to manage cached pages */
> >  	struct inode *managed_cache;
> > +
> > +	/* lz4 max distance pages */
> > +	u16 lz4_max_distance_pages;

useless comment as well... maybe we could add some descriptive
words, e.g.

/* # of pages needed for EROFS lz4 rolling decompression */

Thanks,
Gao Xiang

