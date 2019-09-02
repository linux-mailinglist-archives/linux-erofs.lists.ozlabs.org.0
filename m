Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 78337A56A8
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 14:51:36 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MVMT53xKzDqWH
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 22:51:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+8d7e6b8ef813b711cfc0+5853+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="p1wdTs4X"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MVMN3VzNzDq9B
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 22:51:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2SRLGmzt9ygJ+k1758a7WeMkOp6QVS9SpfevL0fmQfQ=; b=p1wdTs4XDK/LQWfm/yELbp49u
 phV0PdWujXYthfryE4TkwNYPNSjVRtyhrjikDgf3P3SMQVhM4XRwApkyG5tQzhuUZhc9Bz3ebmUh7
 qJ3KM1c0uT+TU9dK8YwGrjAmSVzRQYI1dlCZedOFGQzdvco5MqhqYrS1C6rDLvn7gNyBDqmIo/xKW
 G8ajsycXwdssNAKgMAPBfcubUQjWvXjRoblHim8dRKXzpDUS1z/aSV/OxkTDhuv2tYkihbFEL8+Ig
 Joaenckr004Pz8x2NJ1XiFbwZSkzUEc91fCcuCSy47u20XG+/CKVdTloaqFrnExpE814on13j+pV8
 EmKp8xVSg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i4lnZ-0004LV-VP; Mon, 02 Sep 2019 12:51:09 +0000
Date: Mon, 2 Sep 2019 05:51:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190902125109.GA9826@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
 <20190829101545.GC20598@infradead.org>
 <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901085452.GA4663@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 Miao Xie <miaoxie@huawei.com>, devel@driverdev.osuosl.org,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, linux-erofs@lists.ozlabs.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Sep 01, 2019 at 04:54:55PM +0800, Gao Xiang wrote:
> No modification at this... (some comments already right here...)

>  20 /* 128-byte erofs on-disk super block */
>  21 struct erofs_super_block {
> ...
>  24         __le32 features;        /* (aka. feature_compat) */
> ...
>  38         __le32 requirements;    /* (aka. feature_incompat) */
> ...
>  41 };

This is only cosmetic, why not stick to feature_compat and
feature_incompat?

> > > +	bh = sb_bread(sb, 0);
> > 
> > Is there any good reasons to use buffer heads like this in new code
> > vs directly using bios?
> 
> As you said, I want it in the page cache.
> 
> The reason "why not use read_mapping_page or similar?" is simply
> read_mapping_page -> .readpage -> (for bdev inode) block_read_full_page
>  -> create_page_buffers anyway...
> 
> sb_bread haven't obsoleted... It has similar function though...

With the different that it keeps you isolated from the buffer_head
internals.  This seems to be your only direct use of buffer heads,
which while not deprecated are a bit of an ugly step child.  So if
you can easily avoid creating a buffer_head dependency in a new
filesystem I think you should avoid it.

> > > +	sbi->build_time = le64_to_cpu(layout->build_time);
> > > +	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
> > > +
> > > +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> > > +	memcpy(sbi->volume_name, layout->volume_name,
> > > +	       sizeof(layout->volume_name));
> > 
> > s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
> > if it is le it should be a guid_t).
> 
> For this case, I have no idea how to deal with...
> I have little knowledge about this uuid stuff, so I just copied
> from f2fs... (Could be no urgent of this field...)

Who fills out this field in the on-disk format and how?

> The background is Al's comments in erofs v2....
> (which simplify erofs_fill_super logic)
> https://lore.kernel.org/r/20190720224955.GD17978@ZenIV.linux.org.uk/
> 
> with a specific notation...
> https://lore.kernel.org/r/20190721040547.GF17978@ZenIV.linux.org.uk/
> 
> "
> > OTOH, for the case of NULL ->s_root ->put_super() won't be called
> > at all, so in that case you need it directly in ->kill_sb().
> "

Yes.  Although none of that is relevant for this initial version,
just after more features are added.
