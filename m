Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE496D7A91
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 13:01:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ps1sV3Z7yz3cLB
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 21:01:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V0YFHs3q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V0YFHs3q;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V0YFHs3q;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V0YFHs3q;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ps1sQ1FgQz3bZj
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 21:01:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680692486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BoHgQZFE6GmfSeys+DR2W7oxw4hgWtoFTpySQ2VkKFk=;
	b=V0YFHs3q1dLyZp4PMwJNCCZ33lAFL3XbzLK2np25QTW7So8YIDuXIa+RO/8Dnu2ClfuhnK
	ZPRWi7QRhYts68A5SRVeptxYKJ77Lv9cKPElSU901ixPibk7i2+Ak241hDyVxHeAUytT9c
	dncUlvYXYDjomzIs6g84eq76rx7baj8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680692486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BoHgQZFE6GmfSeys+DR2W7oxw4hgWtoFTpySQ2VkKFk=;
	b=V0YFHs3q1dLyZp4PMwJNCCZ33lAFL3XbzLK2np25QTW7So8YIDuXIa+RO/8Dnu2ClfuhnK
	ZPRWi7QRhYts68A5SRVeptxYKJ77Lv9cKPElSU901ixPibk7i2+Ak241hDyVxHeAUytT9c
	dncUlvYXYDjomzIs6g84eq76rx7baj8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-I7b6f8XwPYqUi0dcBArpWg-1; Wed, 05 Apr 2023 07:01:23 -0400
X-MC-Unique: I7b6f8XwPYqUi0dcBArpWg-1
Received: by mail-qk1-f200.google.com with SMTP id q143-20020a374395000000b0074690a17414so16136353qka.7
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Apr 2023 04:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680692482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoHgQZFE6GmfSeys+DR2W7oxw4hgWtoFTpySQ2VkKFk=;
        b=W8g8bT8ouimKUfS2cs+dQ/fAaYL79mxuXmVDKj3CkWdIYTKKaAmMDpJzldkINKHKQ2
         paoWH3PF2SHoejruhmn26Kf0Ih2ViC5RAigIT2xXTGFeFWla7L97/KWRiHZKErrO4kHE
         vJx4q9veEUNb87F38YzqNCi318N5QHt2P4/zai+AWcKUjSkTu+wWY3Ip4HXCu74oaaqB
         oywuIDJ2Nm5ozs1SUMI/zuRbUSszZYpQT0B7i6WKpto8ZAhPuYIdATXQNfwoMt7aiutY
         jrAAM9mjp6kdWPPQBe2tcKlxmLB7mCrJcGEDRN/3fdZq5s2OOnAht9Ok1u6qXPTt4+Jp
         BRtA==
X-Gm-Message-State: AAQBX9c8/BB8+vTLn+7cWzGHe7cGp13tR+R1+d60Xsku3FN23gqoCiuy
	OU5dKpypcomjP4Rzf/JoefwgPCKfKks+Q//AyaGP9m/TmSLWJztTziNuPEi3E0fmKycyl6CwuSg
	gzum9pEoKu/XG1Y3Brt1uV8c=
X-Received: by 2002:a05:6214:4001:b0:5ca:f6dd:f3b6 with SMTP id kd1-20020a056214400100b005caf6ddf3b6mr8310661qvb.16.1680692482365;
        Wed, 05 Apr 2023 04:01:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZN5rxyt4g78lpjs6te5NjsBmYN83L29u8HXb3VRNmLRZGiyzEv7hgqJmGPE20fJY6cuY/SPQ==
X-Received: by 2002:a05:6214:4001:b0:5ca:f6dd:f3b6 with SMTP id kd1-20020a056214400100b005caf6ddf3b6mr8310617qvb.16.1680692482068;
        Wed, 05 Apr 2023 04:01:22 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id om30-20020a0562143d9e00b005dd8b934576sm4136208qvb.14.2023.04.05.04.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:01:21 -0700 (PDT)
Date: Wed, 5 Apr 2023 13:01:16 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 09/23] iomap: allow filesystem to implement read path
 verification
Message-ID: <20230405110116.ia5wv3qxbnpdciui@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-10-aalbersh@redhat.com>
 <ZCxEHkWayQyGqnxL@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZCxEHkWayQyGqnxL@infradead.org>
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, agruenba@redhat.com, djwong@kernel.org, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Tue, Apr 04, 2023 at 08:37:02AM -0700, Christoph Hellwig wrote:
> >  	if (iomap_block_needs_zeroing(iter, pos)) {
> >  		folio_zero_range(folio, poff, plen);
> > +		if (iomap->flags & IOMAP_F_READ_VERITY) {
> 
> Wju do we need the new flag vs just testing that folio_ops and
> folio_ops->verify_folio is non-NULL?

Yes, it can be just test, haven't noticed that it's used only here,
initially I used it in several places.

> 
> > -		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> > -				     REQ_OP_READ, gfp);
> > +		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
> > +				REQ_OP_READ, GFP_NOFS, &iomap_read_ioend_bioset);
> 
> All other callers don't really need the larger bioset, so I'd avoid
> the unconditional allocation here, but more on that later.

Ok, make sense.

> 
> > +		ioend = container_of(ctx->bio, struct iomap_read_ioend,
> > +				read_inline_bio);
> > +		ioend->io_inode = iter->inode;
> > +		if (ctx->ops && ctx->ops->prepare_ioend)
> > +			ctx->ops->prepare_ioend(ioend);
> > +
> 
> So what we're doing in writeback and direct I/O, is to:
> 
>  a) have a submit_bio hook
>  b) allow the file system to then hook the bi_end_io caller
>  c) (only in direct O/O for now) allow the file system to provide
>     a bio_set to allocate from

I see.

> 
> I wonder if that also makes sense and keep all the deferral in the
> file system.  We'll need that for the btrfs iomap conversion anyway,
> and it seems more flexible.  The ioend processing would then move into
> XFS.
> 

Not sure what you mean here.

> > @@ -156,6 +160,11 @@ struct iomap_folio_ops {
> >  	 * locked by the iomap code.
> >  	 */
> >  	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
> > +
> > +	/*
> > +	 * Verify folio when successfully read
> > +	 */
> > +	bool (*verify_folio)(struct folio *folio, loff_t pos, unsigned int len);
> 
> Why isn't this in iomap_readpage_ops?
> 

Yes, it can be. But it appears to me to be more relevant to
_folio_ops, any particular reason to move it there? Don't mind
moving it to iomap_readpage_ops.

-- 
- Andrey

