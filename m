Return-Path: <linux-erofs+bounces-3717-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8OgmMZBXOWpxqwcAu9opvQ
	(envelope-from <linux-erofs+bounces-3717-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 17:41:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812E6B0D06
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 17:41:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C1BeDg+U;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VDmJcvH9;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C1BeDg+U;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VDmJcvH9;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3717-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3717-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=none;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkXV30Cg3z2yVZ;
	Tue, 23 Jun 2026 01:40:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782142858;
	cv=none; b=iDhNQvvuSLGWuM2l+0ffgxV9Qi+JelGtsmNAgztC9chTBCiwdjOMNfx8UsthgOB1bu5/thHxxRX5ubOdHyB6HZBVw/bNvk3odLhEKrXpGyXHTsRKWriskjmBQMw5nQHn5+leLPH01BE66xAIdOyX2Xi/ckcxlmGfvKSWV4XbEFSwf2fTo8i+aW1kWi3kx8SLSg9KAtXQte6xo+A2K59j18I84RqsqghOY8O4CEFY/wpWy8h3jzF5C5UDyvj+lbL4UbiRuOS1DOnLfIDIzLahzVPFsBKXBnvZuJrSVeqaXWgDocx26d7vT3WjgXxUeBnPYgOMxqppqnDoWmGsVA3LZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782142858; c=relaxed/relaxed;
	bh=+HsYs+OFFsLibJr2wyBeZi/5DTfglh26LleEn5Ku9Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnQSMZ2mSIBSUuaM/4i3MaVZ1roDquaU+9eDBEatcNAlcMqFQYdCzTL8wVt7x2cS1bHIaJkfN/fCY4wBpyu51Ootyie7mHb95pk7QNwV7Synejp0gpUlv+iMq8Lf2offfyh1AYRgF+gEyCpCz57WGznhpTiQ9ppkB9sD34OjD6mNnQWztQOiJCkQrwak+Uc86FmYk9jc8XMfFxxa9LX7oPG6kZsiJ2HX+N9yswVphkXj+77HnDODcVoWXNQ+dTPrhQs9IN5bT4q2H3vTxPx5Aox/jo81LfFM74hrH9bcK2c8EDKhYDb59GTGKcZyb9pH1RSCDMi8HUFHkOBI9pYpMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=C1BeDg+U; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VDmJcvH9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=C1BeDg+U; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VDmJcvH9; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkXTy1tWTz2xSN
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 01:40:53 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0309875D27;
	Mon, 22 Jun 2026 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782142851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HsYs+OFFsLibJr2wyBeZi/5DTfglh26LleEn5Ku9Yg=;
	b=C1BeDg+U8YE5XlnJuIhY2W9AhJYHKNCCoj6FM6oDene/t5cpRBHUDBAUS3gRbl9fuEU6eU
	6PxI5mgOb0hOApiuJQQdkYTfXurA7xWfyKPeWdzg8Iu2OWp6B2a+3aj1VFlBWE0AXAFbuV
	RLaiwdm84jFrZgQhighwIQn1U2vzsfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782142851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HsYs+OFFsLibJr2wyBeZi/5DTfglh26LleEn5Ku9Yg=;
	b=VDmJcvH9STidVwkO5zU+z4LgHxXhjoGkAHxuvPGM6WAnC7SYldIyRkChpyXG/okoSyUhO0
	zSN38UHR+fzm5JBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782142851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HsYs+OFFsLibJr2wyBeZi/5DTfglh26LleEn5Ku9Yg=;
	b=C1BeDg+U8YE5XlnJuIhY2W9AhJYHKNCCoj6FM6oDene/t5cpRBHUDBAUS3gRbl9fuEU6eU
	6PxI5mgOb0hOApiuJQQdkYTfXurA7xWfyKPeWdzg8Iu2OWp6B2a+3aj1VFlBWE0AXAFbuV
	RLaiwdm84jFrZgQhighwIQn1U2vzsfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782142851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HsYs+OFFsLibJr2wyBeZi/5DTfglh26LleEn5Ku9Yg=;
	b=VDmJcvH9STidVwkO5zU+z4LgHxXhjoGkAHxuvPGM6WAnC7SYldIyRkChpyXG/okoSyUhO0
	zSN38UHR+fzm5JBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E186D779A8;
	Mon, 22 Jun 2026 15:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iMQKN4JXOWrLJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 15:40:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6DC41A093E; Mon, 22 Jun 2026 17:40:50 +0200 (CEST)
Date: Mon, 22 Jun 2026 17:40:50 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org, 
	syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH RFC v2 00/18] fs: support freeze/thaw/mark_dead/sync with
 shared devices
Message-ID: <efk6qqtrkgqz3k74d6h2z4xmukxsnlidnpypst6hblaxmn7ncb@ogfwkirrzfyc>
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-3717-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1812E6B0D06

Hi!

On Tue 16-06-26 16:08:16, Christian Brauner wrote:
> This is a generalization of the device number to superblock so it works
> for actual block device and anonymous (or even mtd) devices.
> 
> fs_holder_ops recovers the affected superblock from bdev->bd_holder. That
> forces the holder of a block device to be exactly one superblock and makes
> it impossible for several superblocks to share a single device.
> 
> erofs does exactly that. It can mount read-only "blob" devices that are
> shared between many superblocks: a metadata-only erofs that indexes a set
> of per-layer blobs (one filesystem instead of one per OCI layer), or an
> incremental image whose base device is shared by several updates. Because
> the block layer only tracks a single holder, a freeze, thaw, removal or
> sync on such a device is never propagated to all the superblocks using it,
> and the current infrastructure has no way to find them.
> 
> This series replaces the bd_holder-based lookup with a global, dev_t-keyed
> table mapping each block device to the superblock(s) using it. The holder
> argument becomes purely the block layer's exclusivity token -- a superblock,
> or the file_system_type for a device shared within one filesystem type --
> and the fs_holder_ops callbacks look the device up in the table and act on
> every superblock registered for it: 1:1 for most filesystems, 1:many for
> erofs.

So I was thinking about this also in the light of Christoph's complaints. I
agree with you, Chritian, that this translation table maintains the
abstraction of the holder - holder ops define how to transition from bdev
to its holder(s) and how to translate the .sync, .freeze and other
operations for the holders - and that is kept since your changes are
specific to fs_holder_ops.

What I'm wondering about a bit is whether we want this complexity for the
only user which is erofs (i.e., whether this wouldn't be better implemented
in erofs specific holder ops which could arguably be simpler than this
generic solution). On the other hand that will likely have to replicate
the locking dances we do in bdev_super_lock() and I'm not sure whether
spread of this locking complexity into filesystems is better than this
more complex VFS mapping code.

One more thing I was considering is that the need to transition from one
bdev to multiple holders isn't actually unique to erofs. For example device
mapper will need the same thing, arguably partition bdevs could be also
made holders of the complete bdev so events are propagated from the whole
bdev into partition bdevs properly (which currently happens in kind of ad
hoc manner and only in some cases). Currently your translation mechanism is
tied to mapping to superblock but actually rather weakly - we only need the
guarantee that the holder stays alive while the mapping entry exists, the
rest is protected by the mapping entry refcount AFAICS. So with a bit of
effort we could make this a generic bdev -> holders mapping mechanism
usable from whichever holder ops decide to employ it, which would then be
quite attractive IMO.

But I guess let's leave lifting the mapping code from super.c and
converting it into generic mapping mechanism for the moment when we really
get into implementing another user.

All this is a long way of saying that I'm OK with the mapping mechanism
like this :).

								Honza

> Filesystems claim and release their devices through new
> fs_bdev_file_open_by_{dev,path}() and fs_bdev_file_release() helpers; the
> per-fs patches convert xfs, btrfs, ext4, f2fs and erofs over to them and
> fix cramfs and romfs, which released the registered main device with a
> raw bdev_fput().
> 
> Since every superblock is registered under its s_dev the table also
> replaces the last s_dev-keyed walk of the super_blocks list:
> user_get_super() resolves device numbers through it, so ustat() and
> quotactl() now work on any device a filesystem claims and no longer
> take sb_lock.
> 
> The longer-term motivation is to let userspace decide which devices may be
> onlined from one central place, without having to teach every filesystem
> about it individually.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Changes in v2:
> - super: rework the device-to-superblock table reference counting: each
>   (device, superblock) entry carries a single claim count and holds one
>   passive reference on its superblock for the entry's lifetime. New prep
>   patches convert s_count to refcount_t s_passive and make put_super()
>   self-locking.
> - super: preallocate the entry in alloc_super() and register it from the
>   set callbacks through set_anon_super()/set_bdev_super(); an insert
>   failure unwinds exactly like a set callback failure. The superblock
>   stashes the entry in sb->s_super_dev and kill_super_notify() drops the
>   claim through it.
> - super: initialize the table from mnt_init(); the rootfs and shm mounts
>   are created long before any initcall runs.
> - super: fold the v1 "refuse to claim a frozen block device" patch into
>   the registration helper and restore the EBUSY check for the primary
>   device in setup_bdev_super(): additional devices (the xfs log, the ext4
>   journal, erofs blobs) are now refused while frozen as well, answering
>   Jan's question on v1 3/8.
> - Split the core patch into table/helpers/switch-over and move the
>   xfs/btrfs/ext4 conversions before the fs_holder_ops switch so no
>   freeze/mark_dead events are lost mid-series; erofs follows the switch.
> - New prep patches: the ext4 KUnit tests allocate anonymous devices and
>   ocfs2 stops resetting s_dev on dismount.
> - New: convert user_get_super() to the device table, plus a ustat()
>   selftest.
> - New: fix a pre-existing double release of the realtime device file and
>   dangling buftarg pointers in xfs_open_devices()'s error unwind.
> - New: convert f2fs's additional devices to the helpers; fix cramfs and
>   romfs releasing the registered main device with a raw bdev_fput().
> - erofs: drop the .shutdown() and .remove_bdev() implementations and the
>   per-device "dead" flag. Immutable filesystems don't need them: the block
>   layer sets GD_DEAD before fs_bdev_mark_dead() so in-flight bios fail
>   anyway, erofs has no write path or journal to stop, and the read-only
>   loop_change_fd() case must not be forced to -EIO. Patch from Gao Xiang,
>   applied verbatim - thanks!
> - btrfs: fix a general protection fault in close_fs_devices() on a failed
>   mount (reported by syzbot). The release path took the superblock from
>   device->fs_info, which is still NULL if open_ctree() fails before
>   btrfs_init_devices_late(); it now uses bdev_file->private_data.
> - erofs: the v1 conversion was sent with a generic boilerplate changelog;
>   superseded by Gao's patch above.
> - Collect Reviewed-by from Jan Kara and Tested-by from syzbot.
> - Rebase onto v7.1-rc1.
> - Link to v1: https://patch.msgid.link/20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org
> 
> ---
> Christian Brauner (18):
>       xfs: fix the error unwind in xfs_open_devices()
>       super: convert s_count to refcount_t s_passive
>       super: take lock after last reference count
>       fs, block: move blk_mode_t and fop_flags_t into <linux/types.h>
>       ext4: use anonymous devices for KUnit test superblocks
>       ocfs2: don't reset s_dev on dismount
>       fs: maintain a global device-to-superblock table
>       fs: add dedicated block device open helpers for filesystems
>       xfs: port to fs_bdev_file_open_by_path()
>       btrfs: open via dedicated fs bdev helpers
>       ext4: open via dedicated fs bdev helpers
>       fs: look up superblocks via the device table in fs_holder_ops
>       fs: tolerate per-superblock freeze errors on shared devices
>       erofs: open via dedicated fs bdev helpers
>       f2fs: open via dedicated fs bdev helpers
>       super: make fs_holder_ops private
>       fs: look up the superblock via the device table in user_get_super()
>       selftests/filesystems: add ustat() coverage
> 
>  fs/btrfs/volumes.c                               |  31 +-
>  fs/cramfs/inode.c                                |   2 +-
>  fs/erofs/super.c                                 |  35 +-
>  fs/ext4/extents-test.c                           |   9 +-
>  fs/ext4/mballoc-test.c                           |   9 +-
>  fs/ext4/super.c                                  |  12 +-
>  fs/f2fs/super.c                                  |   6 +-
>  fs/internal.h                                    |   1 +
>  fs/namespace.c                                   |   2 +
>  fs/ocfs2/super.c                                 |   1 -
>  fs/romfs/super.c                                 |   2 +-
>  fs/super.c                                       | 620 ++++++++++++++++-------
>  fs/xfs/xfs_buf.c                                 |   2 +-
>  fs/xfs/xfs_super.c                               |  13 +-
>  include/linux/blkdev.h                           |   9 -
>  include/linux/fs.h                               |   2 -
>  include/linux/fs/super.h                         |   8 +
>  include/linux/fs/super_types.h                   |   4 +-
>  include/linux/types.h                            |   2 +
>  tools/testing/selftests/filesystems/.gitignore   |   1 +
>  tools/testing/selftests/filesystems/Makefile     |   2 +-
>  tools/testing/selftests/filesystems/ustat_test.c | 135 +++++
>  22 files changed, 647 insertions(+), 261 deletions(-)
> ---
> base-commit: 0c0d974f62e6603d4514e1a8035658edb353c68f
> change-id: 20260602-work-super-bdev_holder_global-8cba5e52bed5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

