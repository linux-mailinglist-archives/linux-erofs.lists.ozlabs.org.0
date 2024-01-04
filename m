Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6898244C6
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 16:17:09 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mHk6v/mP;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6J4uw5uq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mHk6v/mP;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6J4uw5uq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T5VYs3lJ3z3c5t
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Jan 2024 02:17:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mHk6v/mP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6J4uw5uq;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=mHk6v/mP;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6J4uw5uq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T5VYm1bccz2yV3
	for <linux-erofs@lists.ozlabs.org>; Fri,  5 Jan 2024 02:16:58 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3CFB21D82;
	Thu,  4 Jan 2024 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704381415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMPvsZKYHk+D5kb1N2CM5rR4TjKGNh05qKhD/IuVB8c=;
	b=mHk6v/mPh0nrF36XeRd9n1G+3dVH07YiQx9gWm/SG7NmXFbckEmPHT+psVuS+Q55O5Ewmm
	fzZp736IzVr5FNkauue7PYolsCdGhN9oZfdxiUjjwUo5SvRhYKG4JdOSw0VhUWvKC+wi2H
	9fs2A0RPq42k8lt/8HUXEBH2gHBffpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704381415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMPvsZKYHk+D5kb1N2CM5rR4TjKGNh05qKhD/IuVB8c=;
	b=6J4uw5uqBb70vbWXOXdU9583F4KrmBOAGYenVBa6jTwgLx70IbxaS5CKgObceVLtg+Uuvf
	BlSynn3hFCWD0KCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704381415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMPvsZKYHk+D5kb1N2CM5rR4TjKGNh05qKhD/IuVB8c=;
	b=mHk6v/mPh0nrF36XeRd9n1G+3dVH07YiQx9gWm/SG7NmXFbckEmPHT+psVuS+Q55O5Ewmm
	fzZp736IzVr5FNkauue7PYolsCdGhN9oZfdxiUjjwUo5SvRhYKG4JdOSw0VhUWvKC+wi2H
	9fs2A0RPq42k8lt/8HUXEBH2gHBffpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704381415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMPvsZKYHk+D5kb1N2CM5rR4TjKGNh05qKhD/IuVB8c=;
	b=6J4uw5uqBb70vbWXOXdU9583F4KrmBOAGYenVBa6jTwgLx70IbxaS5CKgObceVLtg+Uuvf
	BlSynn3hFCWD0KCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88C6E13722;
	Thu,  4 Jan 2024 15:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CnlcIefLlmUgTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 15:16:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 21D02A07EF; Thu,  4 Jan 2024 16:16:55 +0100 (CET)
Date: Thu, 4 Jan 2024 16:16:55 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH RFC v3 for-6.8/block 02/17] xen/blkback: use bdev api in
 xen_update_blkif_status()
Message-ID: <20240104151655.oiqtn6onge2etlcn@quack3>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-3-yukuai1@huaweicloud.com>
 <20240104110631.3vspsvxbbvcpdqdu@quack3>
 <29bfcfc7-62b0-3876-78ce-f7ebe3506eb6@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29bfcfc7-62b0-3876-78ce-f7ebe3506eb6@huaweicloud.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 1.90
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email,huawei.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLdan9jouj5dxnqx1npfmn4ucx)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[49];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,kernel.dk,citrix.com,suse.de,gmail.com,lazybastard.org,bootlin.com,nod.at,ti.com,linux.ibm.com,oracle.com,fb.com,toxicpanda.com,suse.com,zeniv.linux.org.uk,kernel.org,fluxnic.net,mit.edu,dilger.ca,infradead.org,linux-foundation.org,samsung.com,vger.kernel.org,lists.xenproject.org,lists.infradead.org,lists.ozlabs.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
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
Cc: hoeppner@linux.ibm.com, Jan Kara <jack@suse.cz>, vigneshr@ti.com, yi.zhang@huawei.com, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, "yukuai \(C\)" <yukuai3@huawei.com>, dsterba@suse.com, konishi.ryusuke@gmail.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, ro
 ger.pau@citrix.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Kuai!

On Thu 04-01-24 20:19:05, Yu Kuai wrote:
> 在 2024/01/04 19:06, Jan Kara 写道:
> > On Thu 21-12-23 16:56:57, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Avoid to access bd_inode directly, prepare to remove bd_inode from
> > > block_devcie.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   drivers/block/xen-blkback/xenbus.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> > > index e34219ea2b05..e645afa4af57 100644
> > > --- a/drivers/block/xen-blkback/xenbus.c
> > > +++ b/drivers/block/xen-blkback/xenbus.c
> > > @@ -104,8 +104,7 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
> > >   		xenbus_dev_error(blkif->be->dev, err, "block flush");
> > >   		return;
> > >   	}
> > > -	invalidate_inode_pages2(
> > > -			blkif->vbd.bdev_handle->bdev->bd_inode->i_mapping);
> > > +	invalidate_bdev(blkif->vbd.bdev_handle->bdev);
> > 
> > This function uses invalidate_inode_pages2() while invalidate_bdev() ends
> > up using mapping_try_invalidate() and there are subtle behavioral
> > differences between these two (for example invalidate_inode_pages2() tries
> > to clean dirty pages using the ->launder_folio method). So I think you'll
> > need helper like invalidate_bdev2() for this.
> 
> Thanks for reviewing this patch, I know the differenct between then,
> what I don't understand is that why using invalidate_inode_pages2()
> here.

Well, then the change in behavior should be at least noted in the
changelog.

> sync_blockdev() is just called and 0 is returned, I think in this
> case it's safe to call invalidate_bdev() directly, or am I missing
> other things?

I still think there's a difference. invalidate_inode_pages2() also unmaps
memory mappings which mapping_try_invalidate() does not do. That being said
in xen_update_blkif_status() we seem to be bringing up a virtual block
device so before this function is called, anybody would have hard time
using anything in it. But this definitely needs a confirmation from Xen
maintainers and a good documentation of the behavioral change in the
changelog.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
