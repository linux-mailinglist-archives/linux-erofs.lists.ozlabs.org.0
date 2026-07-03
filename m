Return-Path: <linux-erofs+bounces-3812-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fCXoGqoTR2oVTAAAu9opvQ
	(envelope-from <linux-erofs+bounces-3812-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Jul 2026 03:43:06 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808146FDC39
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Jul 2026 03:43:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="dJtuR/82";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3812-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3812-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grxN440qcz2yMm;
	Fri, 03 Jul 2026 11:43:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783042980;
	cv=none; b=gqg8WnrMX0VMpLq8CHt4SoDf8ySBJAQ8Xelw19rHPCrIeXwGR9uAwniTu74MIEInpmXXniiYPvhruo9sYPgCtWKJDy4huln5/26JJ4hW7I+kaacpKF3HbnWzQO1eL6BSGW5TF3lVBt/T29DNGOPsXzaimW6h0MoO2YcFpzVSG/JbMwxV5v+lZ1sTw1/pSDCpozKiUER4sU7INHz4uexu0xVA/hUmzBuWjZxIIT6XtS3DLQC5lyl5OMKzKOREHIwusay5uIEW4rN2gJ69HpWrROk1eMcu+pr4gwkCGcXGWG33OM23aO0IH93UN41+8T3xazBbV8HaDLqMvWXeVt+0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783042980; c=relaxed/relaxed;
	bh=AX4qRITMVBxo2syOiuIn5nihRYToP/HhChwFyF/gFaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYyM3yl9UiNQfqiOJUL0QuTzyucNppX75uvpZBU3TRtBVVme+vU5Vl7XZAQtXcWIYtaqx2iK+ceH3S6r0AW7x/cjQ2K57hgbr8g/CEhH3+Cq7i+TYtX1k2eoSH3IKXlsrLF37K9UIpVjDq+WxpMKzUxXwoJvScmEHcChs2gRE2OZJnkBFLQ5imE7v+YukP5aysalJ8MxJemfczg/OVNlM0Ef+XkN0L2t+x88P9XqC0J7zequv26Fc9RLerwYZPewemZTLXZtuHM09PLciYsBJ4ONAtDIr3gcv7qkT7qW2lUnZloATxGa5ZizlL5qiv16t6RazHkm9eAfWzNk+Dnx7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJtuR/82; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4grxN32C37z2yDs
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Jul 2026 11:42:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 31877417C3;
	Fri,  3 Jul 2026 01:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EFEF41F00A3A;
	Fri,  3 Jul 2026 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783042976;
	bh=AX4qRITMVBxo2syOiuIn5nihRYToP/HhChwFyF/gFaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dJtuR/82aT9h1ImO0a7pYJQJ+soh57RpaSsmH5o5j8IK42iv/kQcFlPB7G3vFH4zD
	 1cI/SGmmNm3EEL6hcAAYkT4Cd9gRd1KbwZAx1RrmLI0EXdSf/I7vlhkKUPloFFQFee
	 mo7Sy4AoM5ffBWElmdGzSCFl7tzmoFL2T8PkfPcgWfWsmksc77beqcX/v8FPel49/a
	 WL/a6F6omLU837kQyj/YQ2Bnb8p5c5Jge2S29NN/YRr4I65yaPrg3fle9EEwK5trBb
	 rNXtXGBsg5Zx8ICE/FevfeOhXvdgaCFoi43mChEiMQwqoq9IOuC8mhW4d404Wyok50
	 oL2V6nXFK4a4g==
Date: Thu, 2 Jul 2026 18:42:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@lst.de, willy@infradead.org,
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>,
	"open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>,
	"open list:EXT2 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
	"open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
	"open list:FUSE FILESYSTEM [CORE]" <fuse-devel@lists.linux.dev>,
	"open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>,
	"open list:NTFS3 FILESYSTEM" <ntfs3@lists.linux.dev>
Subject: Re: [PATCH v2 17/18] iomap: pass iomap_next_fn directly instead of
 struct iomap_ops
Message-ID: <20260703014255.GR9392@frogsfrogsfrogs>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-18-joannelkoong@gmail.com>
 <20260702165841.GM9392@frogsfrogsfrogs>
 <CAJnrk1YW0gKRVvHRC+WeKoV2vrquzaC6UkipZkQ34Z0RAQDjtg@mail.gmail.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YW0gKRVvHRC+WeKoV2vrquzaC6UkipZkQ34Z0RAQDjtg@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3812-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:brauner@kernel.org,m:hch@lst.de,m:willy@infradead.org,m:hsiangkao@linux.alibaba.com,m:linux-fsdevel@vger.kernel.org,m:linux-xfs@vger.kernel.org,m:axboe@kernel.dk,m:clm@fb.com,m:dsterba@suse.com,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:djbw@kernel.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:yuezhang.mo@sony.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:libaokun@linux.alibaba.com,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:yi.zhang@huawei.com,m:jaegeuk@kernel.org,m:miklos@szeredi.hu,m:agruenba@redhat.com,m:mikulas@artax.karlin.mff.cuni.cz,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:cem@kernel.org,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-btrfs@vger.kernel
 .org,m:nvdimm@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-f2fs-devel@lists.sourceforge.net,m:fuse-devel@lists.linux.dev,m:gfs2@lists.linux.dev,m:ntfs3@lists.linux.dev,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,infradead.org,linux.alibaba.com,vger.kernel.org,kernel.dk,fb.com,suse.com,zeniv.linux.org.uk,suse.cz,gmail.com,google.com,huawei.com,vivo.com,samsung.com,sony.com,mit.edu,dilger.ca,linux.ibm.com,szeredi.hu,redhat.com,artax.karlin.mff.cuni.cz,paragon-software.com,wdc.com,lists.linux.dev,lists.ozlabs.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 808146FDC39

On Thu, Jul 02, 2026 at 05:17:02PM -0700, Joanne Koong wrote:
> On Thu, Jul 2, 2026 at 9:58 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 3f0932e46fd6..0aa8abc438c1 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -626,7 +626,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
> > >       return 0;
> > >  }
> > >
> > > -void iomap_read_folio(const struct iomap_ops *ops,
> > > +void iomap_read_folio(iomap_next_fn iomap_next,
> >
> > If you took my earlier suggestion to rename the typedef to
> > iomap_iter_fn, then this parameter ought to be named iter_fn.
> 
> Hmm... maybe at that point, it's self-explanatory enough that the arg
> could just be called "iter" instead of "iter_fn"?

Dunno.  Seeing as we already have variables named "iter" that are the
actual iteration state object, I think it's clearer to leave the
iteration function as "iter_fn".

> >
> > >               struct iomap_read_folio_ctx *ctx, void *private)
> > >  {
> > >       struct folio *folio = ctx->cur_folio;
> > > @@ -650,7 +650,7 @@ void iomap_read_folio(const struct iomap_ops *ops,
> > >               fsverity_readahead(ctx->vi, folio->index,
> > >                                  folio_nr_pages(folio));
> > >
> > > -     while ((ret = iomap_iter(&iter, ops)) > 0) {
> > > +     while ((ret = iomap_iter(&iter, iomap_next)) > 0) {
> > >               iter.status = iomap_read_folio_iter(&iter, ctx,
> > >                               &bytes_submitted);
> > >               iomap_read_submit(&iter, ctx);
> > > @@ -688,22 +688,22 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
> > >
> > >  /**
> > >   * iomap_readahead - Attempt to read pages from a file.
> > > - * @ops: The operations vector for the filesystem.
> > > + * @iomap_next: The iomap_next callback for the filesystem.
> >
> > "The iomap iteration function for the filesystem" ?
> >
> > Using the term "iomap_next" in the definition for iomap_next isn't that
> > helpful.
> 
> Agreed, I'll replace this with your suggestion.

<nod>

> >
> > >       return ret;
> > > @@ -824,16 +824,16 @@ xfs_file_dio_write_atomic(
> > >       unsigned int            iolock = XFS_IOLOCK_SHARED;
> > >       ssize_t                 ret, ocount = iov_iter_count(from);
> > >       unsigned int            dio_flags = 0;
> > > -     const struct iomap_ops  *dops;
> > > +     iomap_next_fn           dops;
> > >
> > >       /*
> > >        * HW offload should be faster, so try that first if it is already
> > >        * known that the write length is not too large.
> > >        */
> > >       if (ocount > xfs_inode_buftarg(ip)->bt_awu_max)
> > > -             dops = &xfs_atomic_write_cow_iomap_ops;
> > > +             dops = xfs_atomic_write_cow_iomap_next;
> > >       else
> > > -             dops = &xfs_direct_write_iomap_ops;
> > > +             dops = xfs_direct_write_iomap_next;
> >
> > Probably ought to be called iter_fn, or at least something that isn't
> > "dops".
> 
> Nice spotting, I'll rename this in the next version.

<nod>

--D

> Thanks,
> Joanne
> 

