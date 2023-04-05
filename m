Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 780C96D79EC
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 12:39:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps1Mr2bPJz3cDG
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 20:39:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZ+80HHy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZ+80HHy;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZ+80HHy;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZ+80HHy;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps1Mm2STlz3bZj
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 20:39:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680691153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sBkFB8fAWBN3smTHXDCk9Sdy8T63XJRLVaCuva4Dlh8=;
	b=IZ+80HHyflA0PA7JbWhpmorV4w26vqCt95GTbtlvNBsGt1R1wNgXV+S9kHlYM/EbLUW1p9
	gaCq4dIKPNr/PRlXUCsiQnZZM+ko1a6jwgAMCVBqJ6n9jT+5egVYiKZsJ53tz1GpGircO9
	Lp7SmEsPz5jWvo51V5SivpQin+t8f0A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680691153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sBkFB8fAWBN3smTHXDCk9Sdy8T63XJRLVaCuva4Dlh8=;
	b=IZ+80HHyflA0PA7JbWhpmorV4w26vqCt95GTbtlvNBsGt1R1wNgXV+S9kHlYM/EbLUW1p9
	gaCq4dIKPNr/PRlXUCsiQnZZM+ko1a6jwgAMCVBqJ6n9jT+5egVYiKZsJ53tz1GpGircO9
	Lp7SmEsPz5jWvo51V5SivpQin+t8f0A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-JFXyxVNwONqDzUoq25vSAw-1; Wed, 05 Apr 2023 06:39:11 -0400
X-MC-Unique: JFXyxVNwONqDzUoq25vSAw-1
Received: by mail-qk1-f200.google.com with SMTP id 195-20020a3705cc000000b00746a3ab9426so15973997qkf.20
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Apr 2023 03:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBkFB8fAWBN3smTHXDCk9Sdy8T63XJRLVaCuva4Dlh8=;
        b=sjfPb8z6+rJVCU08eWjdhrWfBqqs2R7eF1B4Ka9bb2fznHkcjd6/JMY29LSRSCGw8e
         OUWYQ1JOzWLZa7Yr2k4MnSwNAtEmgmi59sVvI47plKW6+20tddyjGYVdvM86O1avOUJR
         whjnI+srA5f56v+RQ7zuVa3TeOvLPWROmg8bSC4aBAVDYUx2Yu3rwDJY9fC1j6vcJFtq
         YO/BVsNKYq38sNm0twMRsIENzl3MpBlefgcYbRecpYrdT6MfrHXHcrttR4MxgRYPuqqf
         /MQ0GCR3of4LfcB9eyRqroSErEfnk8KU8bL38Y9sj7FPDF6xSbLZohgg/aqfTOnicQn8
         LIYw==
X-Gm-Message-State: AAQBX9fpE96WVvGFk4pOoN6ovJSC1A0Iz9ZcuOsLxmfuI4k7Z+6ETaKf
	phrq+wurNMgcUgqJyCe08CdWWMtBVDejaV4rJw9tuunyK7dsmVFUbzUH6/0069bjblSfFsXDMy4
	VSZk+L5iXtVbrRqCiXxeqYJU=
X-Received: by 2002:ac8:7e96:0:b0:3b6:323d:bcac with SMTP id w22-20020ac87e96000000b003b6323dbcacmr4150868qtj.32.1680691151322;
        Wed, 05 Apr 2023 03:39:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350aYAf0v49WL6o/QofipBP4L4y6flhFYcYqZzNpajsevFC+xcPnxT0A0hb6dINwVq/YpVvvMSw==
X-Received: by 2002:ac8:7e96:0:b0:3b6:323d:bcac with SMTP id w22-20020ac87e96000000b003b6323dbcacmr4150840qtj.32.1680691150879;
        Wed, 05 Apr 2023 03:39:10 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id r206-20020a3744d7000000b0074a0051fcd4sm4331706qka.88.2023.04.05.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:39:10 -0700 (PDT)
Date: Wed, 5 Apr 2023 12:39:04 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 06/23] fsverity: add drop_page() callout
Message-ID: <20230405103904.2ugfxqmuuqjd7itz@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-7-aalbersh@redhat.com>
 <20230404234019.GM3223426@dread.disaster.area>
MIME-Version: 1.0
In-Reply-To: <20230404234019.GM3223426@dread.disaster.area>
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, hch@infradead.org, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Dave,

On Wed, Apr 05, 2023 at 09:40:19AM +1000, Dave Chinner wrote:
> On Tue, Apr 04, 2023 at 04:53:02PM +0200, Andrey Albershteyn wrote:
> > Allow filesystem to make additional processing on verified pages
> > instead of just dropping a reference. This will be used by XFS for
> > internal buffer cache manipulation in further patches. The btrfs,
> > ext4, and f2fs just drop the reference.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/btrfs/verity.c         | 12 ++++++++++++
> >  fs/ext4/verity.c          |  6 ++++++
> >  fs/f2fs/verity.c          |  6 ++++++
> >  fs/verity/read_metadata.c |  4 ++--
> >  fs/verity/verify.c        |  6 +++---
> >  include/linux/fsverity.h  | 10 ++++++++++
> >  6 files changed, 39 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> > index c5ff16f9e9fa..4c2c09204bb4 100644
> > --- a/fs/btrfs/verity.c
> > +++ b/fs/btrfs/verity.c
> > @@ -804,10 +804,22 @@ static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
> >  			       pos, buf, size);
> >  }
> >  
> > +/*
> > + * fsverity op that releases the reference obtained by ->read_merkle_tree_page()
> > + *
> > + * @page:  reference to the page which can be released
> > + *
> > + */
> > +static void btrfs_drop_page(struct page *page)
> > +{
> > +	put_page(page);
> > +}
> > +
> >  const struct fsverity_operations btrfs_verityops = {
> >  	.begin_enable_verity     = btrfs_begin_enable_verity,
> >  	.end_enable_verity       = btrfs_end_enable_verity,
> >  	.get_verity_descriptor   = btrfs_get_verity_descriptor,
> >  	.read_merkle_tree_page   = btrfs_read_merkle_tree_page,
> >  	.write_merkle_tree_block = btrfs_write_merkle_tree_block,
> > +	.drop_page		 = &btrfs_drop_page,
> >  };
> 
> Ok, that's a generic put_page() call.
> 
> ....
> > diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> > index f50e3b5b52c9..c2fc4c86af34 100644
> > --- a/fs/verity/verify.c
> > +++ b/fs/verity/verify.c
> > @@ -210,7 +210,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
> >  		if (is_hash_block_verified(vi, hpage, hblock_idx)) {
> >  			memcpy_from_page(_want_hash, hpage, hoffset, hsize);
> >  			want_hash = _want_hash;
> > -			put_page(hpage);
> > +			inode->i_sb->s_vop->drop_page(hpage);
> >  			goto descend;
> 
> 			fsverity_drop_page(hpage);
> 
> static inline void
> fsverity_drop_page(struct inode *inode, struct page *page)
> {
> 	if (inode->i_sb->s_vop->drop_page)
> 		inode->i_sb->s_vop->drop_page(page);
> 	else
> 		put_page(page);
> }
> 
> And then you don't need to add the functions to each of the
> filesystems nor make an indirect call just to run put_page().

Sure, this makes more sense, thank you!

-- 
- Andrey

