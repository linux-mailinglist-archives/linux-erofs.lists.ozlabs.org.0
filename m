Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A24035255A
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Apr 2021 04:18:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FBNxg3xDDz3btn
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Apr 2021 13:17:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JEcttR69;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JEcttR69;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=JEcttR69; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JEcttR69; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FBNxd3hL2z2yRX
 for <linux-erofs@lists.ozlabs.org>; Fri,  2 Apr 2021 13:17:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617329874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zx3aULVDJraeYjCJxieoxBhScn2V2VESwLcYZMChRnE=;
 b=JEcttR69ypgcEpS3vES71JLK2JD84vYE6euthWJOIvL+xN4iJEGBgPMFsGn95+rNe+2hfH
 Ln8xEEwvK3L/Ils0cEF/e63ULv6aFvFCllb3nh+16TTqn+ohUxLMGWa/Ej26nOX/oBwOpW
 2ZqFQ2nbhAniPz3iyUWEtPSKmTgT8AA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617329874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zx3aULVDJraeYjCJxieoxBhScn2V2VESwLcYZMChRnE=;
 b=JEcttR69ypgcEpS3vES71JLK2JD84vYE6euthWJOIvL+xN4iJEGBgPMFsGn95+rNe+2hfH
 Ln8xEEwvK3L/Ils0cEF/e63ULv6aFvFCllb3nh+16TTqn+ohUxLMGWa/Ej26nOX/oBwOpW
 2ZqFQ2nbhAniPz3iyUWEtPSKmTgT8AA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-4T-8_yR_OAu-XEUz9KQ5XQ-1; Thu, 01 Apr 2021 22:17:52 -0400
X-MC-Unique: 4T-8_yR_OAu-XEUz9KQ5XQ-1
Received: by mail-pl1-f199.google.com with SMTP id k9so3859187pls.13
 for <linux-erofs@lists.ozlabs.org>; Thu, 01 Apr 2021 19:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Zx3aULVDJraeYjCJxieoxBhScn2V2VESwLcYZMChRnE=;
 b=cxfWzlGvjRUNzlcvalEvV90CG/enp7so7vfY+PnVbgHmtk5IW1SMqA6Vl4VzgTREVU
 39GXIqc0Ax03c9W+lSuhJO5XrEa3N43r/BnrUOiG74ix9pmydmFiFWb13thujr0IT9BE
 z/w9F8SEsbgScI5RS2YPJixMGPfIA+sUMQdQVGzpms2m/htlIf4g/po+rGoIoMeH+0vP
 YWZahykjGZMZWYkBUGM3OuUO3XgRArbnzfKEXXN5o+8aW5zJhyMHcqfafkFiHRNV7xtQ
 NzUdkXKCczZJRySWhfTasJkge9nbY/CsIqLgwuQ8BHSUvh2ZyHyrIrlbeGgbKi0Y1PA1
 MChg==
X-Gm-Message-State: AOAM533HBPZjgs0UBL/hfBPkhaETyWm4Bqr1PZH6cVMl2uhIcKGlxASQ
 ZCVLGsj+kdwhLOauHcRU4AxaIyb86r8VbKbZ1Lm+m6eHANtJCBQmw6Kny3d9OwmYBp8aTCuTH4Y
 8TofU4lgHJoN5xTBbWUi2RUF0
X-Received: by 2002:a63:e746:: with SMTP id j6mr9908609pgk.91.1617329871567;
 Thu, 01 Apr 2021 19:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx26axO0VIYfx0bYeMNOeVjTQF7C0uIMabXXyjFrjskuajeK0s8BJIfvb5BV5zHqqjhvEkIyQ==
X-Received: by 2002:a63:e746:: with SMTP id j6mr9908597pgk.91.1617329871309;
 Thu, 01 Apr 2021 19:17:51 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n16sm6556712pff.119.2021.04.01.19.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 19:17:50 -0700 (PDT)
Date: Fri, 2 Apr 2021 10:17:41 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Hu Weiwen <sehuww@mail.scut.edu.cn>
Subject: Re: [PATCH] erofs-utils: use qsort() to sort dir->i_subdirs
Message-ID: <20210402021741.GB4011659@xiangao.remote.csb>
References: <20210401135251.59785-1-sehuww@mail.scut.edu.cn>
 <20210402021250.GA4011659@xiangao.remote.csb>
MIME-Version: 1.0
In-Reply-To: <20210402021250.GA4011659@xiangao.remote.csb>
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

On Fri, Apr 02, 2021 at 10:12:50AM +0800, Gao Xiang wrote:
> Hi Weiwen,
> 
> On Thu, Apr 01, 2021 at 09:52:51PM +0800, Hu Weiwen wrote:
> > Original implementation use insertion sort, and its time complexity is
> > O(n^2). This patch use qsort instead. When I create a directory with
> > 100k entries, this reduces the user space time from around 3 mins to
> > 0.5s.
> > 
> > Create such a large directory for benchmark with:
> > mkdir large; cd large; touch $(seq 100000);
> > 
> > Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
> 
> Thanks for your work. Yeah, it's another path that needs to be
> optimized for huge dirs.
> 
> The overall looks good to me, some nits below...
> 
> > ---
> >  lib/inode.c | 53 +++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 33 insertions(+), 20 deletions(-)
> > 
> > diff --git a/lib/inode.c b/lib/inode.c
> > index d52facf..9217127 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -96,21 +96,6 @@ unsigned int erofs_iput(struct erofs_inode *inode)
> >  	return 0;
> >  }
> >  
> > -static int dentry_add_sorted(struct erofs_dentry *d, struct list_head *head)
> > -{
> > -	struct list_head *pos;
> > -
> > -	list_for_each(pos, head) {
> > -		struct erofs_dentry *d2 =
> > -			container_of(pos, struct erofs_dentry, d_child);
> > -
> > -		if (strcmp(d->name, d2->name) < 0)
> > -			break;
> > -	}
> > -	list_add_tail(&d->d_child, pos);
> > -	return 0;
> > -}
> > -
> >  struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
> >  				   const char *name)
> >  {
> > @@ -122,7 +107,7 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
> >  	strncpy(d->name, name, EROFS_NAME_LEN - 1);
> >  	d->name[EROFS_NAME_LEN - 1] = '\0';
> >  
> > -	dentry_add_sorted(d, &parent->i_subdirs);
> > +	list_add_tail(&d->d_child, &parent->i_subdirs);
> >  	return d;
> >  }
> >  
> > @@ -156,10 +141,19 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
> >  	return 0;
> >  }
> >  
> > +static int comp_subdir(const void *a, const void *b)
> > +{
> > +	const struct erofs_dentry *d_a, *d_b;
> > +
> > +	d_a = *((const struct erofs_dentry **)a);
> > +	d_b = *((const struct erofs_dentry **)b);
> > +	return strcmp(d_a->name, d_b->name);
> > +}
> 
> How about just use `da' and `db' for size?

... for these...

> 
> > +
> > -int erofs_prepare_dir_file(struct erofs_inode *dir)
> > +int erofs_prepare_dir_file(struct erofs_inode *dir, unsigned int nr_subdirs)
> >  {
> > -	struct erofs_dentry *d;
> > -	unsigned int d_size, i_nlink;
> > +	struct erofs_dentry *d, **all_d;
> > +	unsigned int d_size, i_nlink, i;
> >  	int ret;
> >  
> >  	/* dot is pointed to the current dir inode */
> > @@ -172,6 +166,22 @@ int erofs_prepare_dir_file(struct erofs_inode *dir)
> >  	d->inode = erofs_igrab(dir->i_parent);
> >  	d->type = EROFS_FT_DIR;
> >  
> > +	/* sort subdirs */
> > +	nr_subdirs += 2;
> > +	all_d = malloc(nr_subdirs * sizeof(d));
> 
> maybe just use `sorted' name here?
> 
> > +	if (!all_d)
> > +		return -ENOMEM;
> > +	i = 0;
> > +	list_for_each_entry(d, &dir->i_subdirs, d_child)
> 
> I think we could list_del here, and use list_for_each_entry

Ah, I meant list_for_each_entry_safe. The reply was somewhat
buggy as well..

> 
> > +		all_d[i++] = d;
> > +	DBG_BUGON(i != nr_subdirs);
> > +	qsort(all_d, nr_subdirs, sizeof(d), comp_subdir);
> > +	init_list_head(&dir->i_subdirs);
> 
> After list_del, no need to init_list_head again.
> The another reason is that some list_add_tail implementation
> could check elements isn't in a list first.
> 
> > +	for (i = 0; i < nr_subdirs; i++)
> > +		list_add_tail(&all_d[i]->d_child, &dir->i_subdirs);
> > +	free(all_d);
> > +	all_d = NULL;
> 
> no need to NULLify it..
> 
> Thanks,
> Gao Xiang
> 

