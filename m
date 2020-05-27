Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 703931E356A
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2020 04:17:30 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Wvc80BVTzDqNk
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2020 12:17:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.81;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=LMk6Xcxj; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LMk6Xcxj; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WvbR0g5YzDqPQ
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 May 2020 12:16:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590545804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=InsThuZ8Wr0Ic5slsD71FanZ+3qK3c7n/z1zP6Lw+7E=;
 b=LMk6XcxjnkiqFtxz8dE/7ENF0ZhPqZpz+iH7xymdPsWc/jYzJFYBH0yn5kXiK4F8m6ZQlY
 7OACOGaliJuWM+e+PVzco9xfbsrK1I1SXej0NXF7P62qinWuU7ty+syDjAa2G/JHbGc14Y
 5ayQ5kH1ZKspnHUMh+DPSvvU8hXWOBc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590545804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=InsThuZ8Wr0Ic5slsD71FanZ+3qK3c7n/z1zP6Lw+7E=;
 b=LMk6XcxjnkiqFtxz8dE/7ENF0ZhPqZpz+iH7xymdPsWc/jYzJFYBH0yn5kXiK4F8m6ZQlY
 7OACOGaliJuWM+e+PVzco9xfbsrK1I1SXej0NXF7P62qinWuU7ty+syDjAa2G/JHbGc14Y
 5ayQ5kH1ZKspnHUMh+DPSvvU8hXWOBc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-yyYyab6XOt2ToT8v7VJ33w-1; Tue, 26 May 2020 22:16:40 -0400
X-MC-Unique: yyYyab6XOt2ToT8v7VJ33w-1
Received: by mail-pj1-f72.google.com with SMTP id l7so1249363pjn.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 May 2020 19:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=InsThuZ8Wr0Ic5slsD71FanZ+3qK3c7n/z1zP6Lw+7E=;
 b=J2m4avt7q0xYKgY2t1jHJhdn09F0kzR8L6Enrl2H8EGlpIfiixOFb8WrEq13dX/6tj
 pnvRERU3zodOm80FFroTGVFSuAU6gZ4EzQEQ/Xh5tpiAkjnRcnOZSWMrlWZR8aymChIa
 yCUmjbjFlmyNfY2/PfzJn2rm0oGhaSEXt4oJIBo4U/xXd7L3O8C6g3YMuEXYsbLHc+Eg
 1NLSgxgNiEnANMfv5nksbyNSmuiHHUQz/tG+NVqmVYq6RmPsVWo5sA/vTEviDThDA+vg
 AkKsaXp+fG/qQlYUvWcWuuMJFgUTQbQIdrtEdNufQCSlWb9guyReYKYdKRGMapEM5Brv
 sasQ==
X-Gm-Message-State: AOAM533Vh9LHi/4yrx7GzQqOqVehlBSEbU4ySSoWEjpVuF8KTPpDU3mc
 P4iN2GGHaIrKkIHFCY8KO1vr9RyGYex1n9B1+nbNVOQubPMUuXbbWi1ieNKOjJrnLNtvM3K4sD1
 s5VeR0bpsSzQiDmADF+o6vGWR
X-Received: by 2002:a17:902:8546:: with SMTP id
 d6mr3539656plo.164.1590545799012; 
 Tue, 26 May 2020 19:16:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQn94NEVOuGuzOmbvKdvFQMt/OS83yOh237FJhb+jGBAYeN9x4VuJi2ZIRTJAkc1fI9gbisA==
X-Received: by 2002:a17:902:8546:: with SMTP id
 d6mr3539642plo.164.1590545798731; 
 Tue, 26 May 2020 19:16:38 -0700 (PDT)
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d18sm700862pfq.136.2020.05.26.19.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 19:16:38 -0700 (PDT)
Date: Wed, 27 May 2020 10:16:28 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] erofs: code cleanup by removing ifdef macro surrounding
Message-ID: <20200527021628.GA10771@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200526090343.22794-1-cgxu519@mykernel.net>
 <20200526094939.GB8107@hsiangkao-HP-ZHAN-66-Pro-G1>
 <4c4a7f7d-c3b7-9093-ae76-32ad258e29a6@mykernel.net>
 <20200526103522.GC8107@hsiangkao-HP-ZHAN-66-Pro-G1>
 <451e6933-0465-6863-7972-999bd1cdf61f@huawei.com>
MIME-Version: 1.0
In-Reply-To: <451e6933-0465-6863-7972-999bd1cdf61f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: cgxu <cgxu519@mykernel.net>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, May 27, 2020 at 09:55:17AM +0800, Chao Yu wrote:

...

> >>
> >> Originally, we set erofs_listxattr to ->listxattr only
> >> when the config macro CONFIG_EROFS_FS_XATTR is enabled,
> >> it means that erofs_listxattr() never returns -EOPNOTSUPP
> >> in any case, so actually there is no logic change here,
> >> right?
> > 
> > Yeah, I agree there is no logic change, so I'm fine with the patch.
> > But I'm little worry about if return 0 is actually wrong here...
> > 
> > see the return value at:
> > http://man7.org/linux/man-pages/man2/listxattr.2.html
> 
> Yeah, I guess vfs should check that whether lower filesystem has set .listxattr
> callback function to decide to return that value, something like:
> 
> static ssize_t
> ecryptfs_listxattr(struct dentry *dentry, char *list, size_t size)
> {
> ...
> 	if (!d_inode(lower_dentry)->i_op->listxattr) {
> 		rc = -EOPNOTSUPP;
> 		goto out;
> 	}
> ...
> 	rc = d_inode(lower_dentry)->i_op->listxattr(lower_dentry, list, size);
> ...
> }

This approach seems better. ;) Let me recheck all of this.
Maybe we could submit a patch to fsdevel for some further advice...

Thanks,
Gao Xiang

> 
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> >>
> >>
> >> Thanks,
> >> cgxu
> >>
> > 
> > .
> > 
> 

