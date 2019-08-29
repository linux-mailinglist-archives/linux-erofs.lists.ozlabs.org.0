Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B807EA159E
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 12:16:09 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Jz5z1LKBzDrWN
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Aug 2019 20:16:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+c7f673d4bdabd04d2ac5+5849+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="A8ByRWni"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Jz5v5z4pzDrVX
 for <linux-erofs@lists.ozlabs.org>; Thu, 29 Aug 2019 20:16:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+tvFhqmaMhEec6GVANstlSqfji2crmXW2QTn7NNJoKM=; b=A8ByRWni1NBWV0UmmUIN/6rpi
 X3+y753F9ZqsThDJt7o7aQDx8POSMk6vACgG+5/80a1/+RSMhyYSRrmPLRpcTkxdB4r9jhP39z00m
 SNB0dmwp7a4mnINr37mvl1dEDK1Kpg50ghRaa+oGg1UZDZiYC/NOIUUu0XDWQCgHzf/0eIckqUF/1
 9a6jhptLbC3I1vcXNZkpwv9AOY3c3Cp/r9EJxRPf72G+6RzZ1mF7BuKGpEZuA321ML2zD8nGEkrax
 VLgAfbmTT85kCCq9Gz0D6elE0GxuabOBX7ZlxpsnO0v9ywXu50/taO3Jf5w3NjCzs7tXNKdGet3j8
 t6Mc6EgUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1i3HSz-0004ua-L6; Thu, 29 Aug 2019 10:15:45 +0000
Date: Thu, 29 Aug 2019 03:15:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190829101545.GC20598@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802125347.166018-4-gaoxiang25@huawei.com>
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
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Christoph Hellwig <hch@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 02, 2019 at 08:53:26PM +0800, Gao Xiang wrote:
> +static int __init erofs_init_inode_cache(void)
> +{
> +	erofs_inode_cachep = kmem_cache_create("erofs_inode",
> +					       sizeof(struct erofs_vnode), 0,
> +					       SLAB_RECLAIM_ACCOUNT,
> +					       init_once);
> +
> +	return erofs_inode_cachep ? 0 : -ENOMEM;

Please just use normal if/else.  Also having this function seems
entirely pointless.

> +static void erofs_exit_inode_cache(void)
> +{
> +	kmem_cache_destroy(erofs_inode_cachep);
> +}

Same for this one.

> +static void free_inode(struct inode *inode)

Please use an erofs_ prefix for all your functions.

> +{
> +	struct erofs_vnode *vi = EROFS_V(inode);

Why is this called vnode instead of inode?  That seems like a rather
odd naming for a Linux file system.

> +
> +	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
> +	if (is_inode_fast_symlink(inode))
> +		kfree(inode->i_link);

is_inode_fast_symlink only shows up in a later patch.  And really
obsfucates the check here in the only caller as you can just do an
unconditional kfree here - i_link will be NULL except for the case
where you explicitly set it.

Also this code is nothing like ext4, so the code seems a little confusing.

> +static bool check_layout_compatibility(struct super_block *sb,
> +				       struct erofs_super_block *layout)
> +{
> +	const unsigned int requirements = le32_to_cpu(layout->requirements);

Why is the variable name for the on-disk subperblock layout?  We usually
still calls this something with sb in the name, e.g. dsb. for disk
super block.

> +	EROFS_SB(sb)->requirements = requirements;
> +
> +	/* check if current kernel meets all mandatory requirements */
> +	if (requirements & (~EROFS_ALL_REQUIREMENTS)) {
> +		errln("unidentified requirements %x, please upgrade kernel version",
> +		      requirements & ~EROFS_ALL_REQUIREMENTS);
> +		return false;
> +	}
> +	return true;

Note that normally we call this features, but that doesn't really
matter too much.

> +static int superblock_read(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi;
> +	struct buffer_head *bh;
> +	struct erofs_super_block *layout;
> +	unsigned int blkszbits;
> +	int ret;
> +
> +	bh = sb_bread(sb, 0);

Is there any good reasons to use buffer heads like this in new code
vs directly using bios?

> +
> +	sbi->blocks = le32_to_cpu(layout->blocks);
> +	sbi->meta_blkaddr = le32_to_cpu(layout->meta_blkaddr);
> +	sbi->islotbits = ffs(sizeof(struct erofs_inode_v1)) - 1;
> +	sbi->root_nid = le16_to_cpu(layout->root_nid);
> +	sbi->inos = le64_to_cpu(layout->inos);
> +
> +	sbi->build_time = le64_to_cpu(layout->build_time);
> +	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
> +
> +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> +	memcpy(sbi->volume_name, layout->volume_name,
> +	       sizeof(layout->volume_name));

s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
if it is le it should be a guid_t).

> +/* set up default EROFS parameters */
> +static void default_options(struct erofs_sb_info *sbi)
> +{
> +}

No need to add an empty function.

> +static int erofs_fill_super(struct super_block *sb, void *data, int silent)
> +{
> +	struct inode *inode;
> +	struct erofs_sb_info *sbi;
> +	int err;
> +
> +	infoln("fill_super, device -> %s", sb->s_id);
> +	infoln("options -> %s", (char *)data);

That is some very verbose debug info.  We usually don't add that and
let people trace the function instead.  Also you should probably
implement the new mount API.
new mount API.

> +static void erofs_kill_sb(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi;
> +
> +	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
> +	infoln("unmounting for %s", sb->s_id);
> +
> +	kill_block_super(sb);
> +
> +	sbi = EROFS_SB(sb);
> +	if (!sbi)
> +		return;
> +	kfree(sbi);
> +	sb->s_fs_info = NULL;
> +}

Why is this needed?  You can just free your sb privatte information in
->put_super and wire up kill_block_super as the ->kill_sb method
directly.
