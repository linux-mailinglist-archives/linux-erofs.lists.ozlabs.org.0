Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 590B11E35BE
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2020 04:35:54 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Ww1L2ljbzDqNd
	for <lists+linux-erofs@lfdr.de>; Wed, 27 May 2020 12:35:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.120;
 helo=us-smtp-1.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aKmCoWGw; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKmCoWGw; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Ww171W6TzDqMg
 for <linux-erofs@lists.ozlabs.org>; Wed, 27 May 2020 12:35:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590546933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXIbFlcligOocUhwVZfBnNqTVwWd7DDDybv21J6rdig=;
 b=aKmCoWGwPTmxfIEB0dpekMsffr6eNcpMVS2VD8DcqSClRIzY/tE8mDoSbPy4gFiiOoQC4P
 kE5d6CrcZlFd0jHQJYrNzdkJGxrrKw58m6KuqASesJvApGk1Xj4rHjN3zqrLqKOvtf8jXw
 i6hYrfCAdFWIgSKS97nO7QeoGUJomtk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590546933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXIbFlcligOocUhwVZfBnNqTVwWd7DDDybv21J6rdig=;
 b=aKmCoWGwPTmxfIEB0dpekMsffr6eNcpMVS2VD8DcqSClRIzY/tE8mDoSbPy4gFiiOoQC4P
 kE5d6CrcZlFd0jHQJYrNzdkJGxrrKw58m6KuqASesJvApGk1Xj4rHjN3zqrLqKOvtf8jXw
 i6hYrfCAdFWIgSKS97nO7QeoGUJomtk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-r9CpvnsqMSypTjfFuPAfwA-1; Tue, 26 May 2020 22:35:30 -0400
X-MC-Unique: r9CpvnsqMSypTjfFuPAfwA-1
Received: by mail-pj1-f72.google.com with SMTP id mt16so1315093pjb.5
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 May 2020 19:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=qXIbFlcligOocUhwVZfBnNqTVwWd7DDDybv21J6rdig=;
 b=T6Inf8rIy2LwLR2jOm8CbMXhjZG30HR6WpfZgDO0a/ZA8YJKVaMeNttmkG/WjcbKxD
 0Zey6kc9IVoK3LYOFkaESxkuF2blmSUclIF0p6EnCsHCtN1DF6XXcAGSNaamJ0q1oXwi
 1WroAjkZ0WZqp6wXq4w60hd1vZoLniUgG+hLCsjkNiQTJFcemGZhl3TlQpoEtpcRzUw7
 WQPxkkqDl8wQ9XFb7EdA/5rnLeytoGI/yVwA18IsGWvjJeiInnZsLG2H3QPZG6qqFOQ4
 wWcWF9z7Lad/aB37BtbJPu2Wbi91DBFWRnkuqF2NB7xb90sqz4FXgt9neCh1SaT0+9z3
 udVg==
X-Gm-Message-State: AOAM533Xx/QKu0KzXKiU4XDXkvPyK45M+peg0QnwbceoLrQBrEwBC9NE
 HYoyq61/7uzF41z7nV6s1TpKyq96dcHSjTwaJOiZJukOPaQqFDImN7sFmHH2LrGO47swXIB5iGz
 Ublqjx56XSI8jesqYN0JvqTdQ
X-Received: by 2002:a17:902:7786:: with SMTP id
 o6mr3913771pll.279.1590546929762; 
 Tue, 26 May 2020 19:35:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymRxkk426BfgrsK0Ae+wgOrxu7uS4g7bJ4osQeiZwD9VTiTTmYXLaOrFqqtHFgohwSafWavg==
X-Received: by 2002:a17:902:7786:: with SMTP id
 o6mr3913752pll.279.1590546929446; 
 Tue, 26 May 2020 19:35:29 -0700 (PDT)
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s75sm763147pgc.13.2020.05.26.19.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 19:35:29 -0700 (PDT)
Date: Wed, 27 May 2020 10:35:19 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: cgxu <cgxu519@mykernel.net>
Subject: Re: [PATCH] erofs: code cleanup by removing ifdef macro surrounding
Message-ID: <20200527023519.GB10771@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200526090343.22794-1-cgxu519@mykernel.net>
 <20200526094939.GB8107@hsiangkao-HP-ZHAN-66-Pro-G1>
 <4c4a7f7d-c3b7-9093-ae76-32ad258e29a6@mykernel.net>
 <20200526103522.GC8107@hsiangkao-HP-ZHAN-66-Pro-G1>
 <451e6933-0465-6863-7972-999bd1cdf61f@huawei.com>
 <20200527021628.GA10771@hsiangkao-HP-ZHAN-66-Pro-G1>
 <5d650808-e326-142c-048b-2c574741cd96@mykernel.net>
MIME-Version: 1.0
In-Reply-To: <5d650808-e326-142c-048b-2c574741cd96@mykernel.net>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, May 27, 2020 at 10:24:14AM +0800, cgxu wrote:
> On 5/27/20 10:16 AM, Gao Xiang wrote:
> > On Wed, May 27, 2020 at 09:55:17AM +0800, Chao Yu wrote:
> > 
> > ...
> > 
> > > > > 
> > > > > Originally, we set erofs_listxattr to ->listxattr only
> > > > > when the config macro CONFIG_EROFS_FS_XATTR is enabled,
> > > > > it means that erofs_listxattr() never returns -EOPNOTSUPP
> > > > > in any case, so actually there is no logic change here,
> > > > > right?
> > > > 
> > > > Yeah, I agree there is no logic change, so I'm fine with the patch.
> > > > But I'm little worry about if return 0 is actually wrong here...
> > > > 
> > > > see the return value at:
> > > > http://man7.org/linux/man-pages/man2/listxattr.2.html
> > > 
> > > Yeah, I guess vfs should check that whether lower filesystem has set .listxattr
> > > callback function to decide to return that value, something like:
> > > 
> > > static ssize_t
> > > ecryptfs_listxattr(struct dentry *dentry, char *list, size_t size)
> > > {
> > > ...
> > > 	if (!d_inode(lower_dentry)->i_op->listxattr) {
> > > 		rc = -EOPNOTSUPP;
> > > 		goto out;
> > > 	}
> > > ...
> > > 	rc = d_inode(lower_dentry)->i_op->listxattr(lower_dentry, list, size);
> > > ...
> > > }
> > 
> > This approach seems better. ;) Let me recheck all of this.
> > Maybe we could submit a patch to fsdevel for some further advice...
> > 
> 
> I agree that doing the check in vfs layer looks tidy and unified.
> However, we should be aware this change may break user space tools.

I think I already sorted out the reason, it actually seems a
regression due to multiple commits, let me try to submit a patch
for some advice...

Thanks,
Gao Xiang

> 
> 
> Thanks,
> cgxu
> 

