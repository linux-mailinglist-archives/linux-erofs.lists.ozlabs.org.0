Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7B748901
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 18:12:40 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pVxtRSYx;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6GnGLv2M;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qx4SQ0nHBz3bXX
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jul 2023 02:12:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pVxtRSYx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6GnGLv2M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.220.28; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qx4SH0C6gz3bPV
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jul 2023 02:12:30 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB46921E20;
	Wed,  5 Jul 2023 16:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1688573545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laJnl7HhQK/Tv/PqzUYoidR/wXDE+WAIJVPIFf2lcfQ=;
	b=pVxtRSYxDum30xk4c2JQyuaRHFNvjqGI5pa+1l9TjK2H7ROMjo7EdIGdDlzQXwaIwGyi0D
	MYHnvgKqRst/eyFC+Okrc961iU1V/Mr8qyrvjiZzwHXWReUpWSrhSFOpe79t3kyTfJeQAV
	Hf2p1cnNnsYhDEREwuHH1JI7foWXj1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1688573545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=laJnl7HhQK/Tv/PqzUYoidR/wXDE+WAIJVPIFf2lcfQ=;
	b=6GnGLv2MGHnmlspZbI9IPcwZjE0UgNGbJUyuJME/ujhWk8XPp6xGrnnDrvfBxv6bSto5fw
	0j8hz2dNTzGg/WAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8D5D134F3;
	Wed,  5 Jul 2023 16:12:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id p7ssKWmWpWRbQAAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 05 Jul 2023 16:12:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C3A6A0707; Wed,  5 Jul 2023 18:12:25 +0200 (CEST)
Date: Wed, 5 Jul 2023 18:12:25 +0200
From: Jan Kara <jack@suse.cz>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 01/32] block: Provide blkdev_get_handle_* functions
Message-ID: <20230705161225.cwig5a3mo6oz7lew@quack3>
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-1-jack@suse.cz>
 <bb91e76b-0bd8-a949-f8b9-868f919ebcb9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb91e76b-0bd8-a949-f8b9-868f919ebcb9@acm.org>
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
Cc: Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>, linux-nvme@lists.infradead.org, Joseph Qi <joseph.qi@linux.alibaba.com>, dm-devel@redhat.com, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, Jack Wang <jinpu.wang@ionos.com>, Alasdair Kergon <agk@redhat.com>, drbd-dev@lists.linbit.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Christoph Hellwig <hch@infradead.org>, xen-devel@lists.xenproject.org, Christian Borntraeger <borntraeger@linux.ibm.com>, Kent Overstreet <kent.overstreet@gmail.com>, Sven Schnelle <svens@linux.ibm.com>, linux-pm@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>, Joern Engel <joern@lazybastard.org>, reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Trond Myklebust
  <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, linux-mm@kvack.org, Song Liu <song@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Minchan Kim <minchan@kernel.org>, ocfs2-devel@oss.oracle.com, Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue 04-07-23 07:06:26, Bart Van Assche wrote:
> On 7/4/23 05:21, Jan Kara wrote:
> > +struct bdev_handle {
> > +	struct block_device *bdev;
> > +	void *holder;
> > +};
> 
> Please explain in the patch description why a holder pointer is introduced
> in struct bdev_handle and how it relates to the bd_holder pointer in struct
> block_device. Is one of the purposes of this patch series perhaps to add
> support for multiple holders per block device?

No. The reason for adding holder to struct bdev_handle is that it is an
argument blkdev_put() needs. Currently, every user of blkdev_put() has to
remember what it has passed as 'holder' to blkdev_get_by_*() call and pass
that to blkdev_put(). With struct bdev_handle this will happen
automatically. This is already explained in the changelog of this patch:

"Create struct bdev_handle that contains all parameters that need to be
passed to blkdev_put()..."

If it was only about holder, the intrusive patches would not be warranted
but as the description also says:

"This will eventually allow us to pass one more argument to blkdev_put()
without too much hassle."

Because we will additionaly need to propagate the 'mode' argument used at
open to blkdev_put().

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
