Return-Path: <linux-erofs+bounces-3648-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FqmZIx1ZMWoFhgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3648-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:33 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C1569042F
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LnBkmJyC;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3648-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3648-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfplG5fVhz3c4f;
	Wed, 17 Jun 2026 00:09:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618970;
	cv=none; b=RRtyhMnziZU6lZeI4/3B1VGHkGjZc4NGBe4reetm9ju03F9A43VNcgXiSdy00XVRc6LAzItAaZYGX2YT/SDAGAldTh3WJJsu+EKZu6BuPrNX10f6TDi1kxmrg0jB9ka31R4ejf5aI1PYRjrR2YkSTwkrDyrkZ+WBZyHnQnqbvfZF3/AvKzvikphLSafDY7V7W0462CQwwIlj9zWKxq1KDTtQpsGGZY2j9pXujCfFCvkf0q56pr+XJDXv5a3QanSiZLKZvo0PpaSl12c4EkmqHE9HJosNjkockUypL5QyY1RNga11I9QZaao6SvdN/enW8HBZmxNTtqRAMxpZPSwLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618970; c=relaxed/relaxed;
	bh=G0U6rjaCuzJtGqVL/l9BMHO6/Q/fzl00kgN3Vn3kWUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GApWRx8qrgMCTsplTQz9lYaB3vPkMU82WaA/bfAlIxRlLv1OcplFKpB48Q3/SSlIBsJE49QUWqrkGiiuOacM4J7Oc+QKZMkbmMGEYxlWTSKmRyzNURJsj2lf1QDERBtkqSQ985f9Ys222kPPSsLoY2D0UrfbzTLp/iurwesZ10WdWm63KZkATmKkmLazNd5dBMNTcSvdCuqoGKJKtus09NCThmyABzvnYS7WRXTYL2cGcOSSVg5AVmr/avY25X8cUe5ecZII/RMLTjzAL/oSAqA1VkKB6dVHPjlsH6ys7/qbUy0iHjF9yCg7kxhuCgH9ubneufsT5w0wn7B+0n4s2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnBkmJyC; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfplG0Z4Xz2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:09:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8FF2E42B82;
	Tue, 16 Jun 2026 14:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140C71F000E9;
	Tue, 16 Jun 2026 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618968;
	bh=G0U6rjaCuzJtGqVL/l9BMHO6/Q/fzl00kgN3Vn3kWUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LnBkmJyCuAmHtaaRaT0d15XEfPy13Lg3jk2ijzl0vNeALCtIB489c04dHESaHVijW
	 wI9UeI1OwP+DEWcnKp5ShvoPJNgs++jfkIRf85Cou2hYAKzqqcdqdMFMqJBB0Vvf6A
	 jASziwFdPMWdM+kFqfL5+7hEvTo7dLO9hc23aGmA4gXXwkxZ8MN0ezbrbSn3PgH8NE
	 lCjAiGrRwdU6EbVRsZst/N9MkicuSV3dKKkJy0WFqGxlGNlsskUpPtoCytOlquiq3M
	 hdaVnRpBCd0LQbmbOA4+LjqZFcJWBO6n2zUddC+zCTC6xk3ebZnQdZiyTmtaJGxA4V
	 Ig8FKHri4PEeg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:30 +0200
Subject: [PATCH RFC v2 14/18] erofs: open via dedicated fs bdev helpers
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-work-super-bdev_holder_global-v2-14-7df6b864028e@kernel.org>
References: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
In-Reply-To: <20260616-work-super-bdev_holder_global-v2-0-7df6b864028e@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
 linux-btrfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
 linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, 
 linux-erofs@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Gao Xiang <xiang@kernel.org>
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4587; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Z/efa63dzeSwzrgzZeku7qcS3jdFDHlu9oQwzGdroFs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRtyPLuZZzbDkRlqH0fz3M77PtRG+6s8rGe180ZZj0
 tJ8hRTPjhIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk4lzD8+F664lIrx50bNX9i
 Wae1B3kVSZ3T4/lzSvH3pcKdkhMjGBnOqW1dwvH85Svh61edQvgWflreoSa6oZjP2lT3lsjEf68
 ZAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jack@suse.cz,m:hch@lst.de,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:brauner@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-3648-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1C1569042F

Route opens through fs_bdev_file_open_by_path() so each external device
is registered against the correct superblock, and convert the matching
releases.

Gao Xiang: I think typical immutable filesystems don't need .shutdown()
and .remove_bdev() for the following reasons:

  - blk_mark_disk_dead() sets GD_DEAD in advance of fs_bdev_mark_dead()
    so that the following bios will fail immediately; block_device
    references are still valid so it seems overkill to handle dead
    blockdevs in the deep filesystem I/O submission path.

  - Immutable filesystems like EROFS don't have write paths and journals,
    so they don't need to block writes (i.e., new dirty pages), metadata
    changes, and abort journals.

  - The comment above loop_change_fd() documents a valid read-only use
    case we need to support anyway, but it calls disk_force_media_change()
    which will call fs_bdev_mark_dead() later: we don't want loop_change_fd()
    shutdowns the active filesystems and return -EIO unconditionally.

Currently I think the default behavior (shrink_dcache_sb + evict_inodes)
in fs_bdev_mark_dead() is enough for immutable filesystems, tried to
document in the commit here for later reference.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/erofs/super.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 802add6652fd..def9cbfbc9d8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -153,8 +153,8 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 	} else if (!sbi->devs->flatdev) {
 		file = erofs_is_fileio_mode(sbi) ?
 				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
-				bdev_file_open_by_path(dif->path,
-						BLK_OPEN_READ, sb->s_type, NULL);
+				fs_bdev_file_open_by_path(dif->path,
+						BLK_OPEN_READ, sb->s_type, sb);
 		if (IS_ERR(file)) {
 			if (file == ERR_PTR(-ENOTBLK))
 				return -EINVAL;
@@ -843,11 +843,16 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
 
 static int erofs_release_device_info(int id, void *ptr, void *data)
 {
+	struct super_block *sb = data;
 	struct erofs_device_info *dif = ptr;
 
 	fs_put_dax(dif->dax_dev, NULL);
-	if (dif->file)
-		fput(dif->file);
+	if (dif->file) {
+		if (S_ISBLK(file_inode(dif->file)->i_mode))
+			fs_bdev_file_release(dif->file, sb);
+		else
+			fput(dif->file);
+	}
 	erofs_fscache_unregister_cookie(dif->fscache);
 	dif->fscache = NULL;
 	kfree(dif->path);
@@ -855,18 +860,19 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 	return 0;
 }
 
-static void erofs_free_dev_context(struct erofs_dev_context *devs)
+static void erofs_free_dev_context(struct erofs_dev_context *devs,
+				   struct super_block *sb)
 {
 	if (!devs)
 		return;
-	idr_for_each(&devs->tree, &erofs_release_device_info, NULL);
+	idr_for_each(&devs->tree, &erofs_release_device_info, sb);
 	idr_destroy(&devs->tree);
 	kfree(devs);
 }
 
-static void erofs_sb_free(struct erofs_sb_info *sbi)
+static void erofs_sb_free(struct erofs_sb_info *sbi, struct super_block *sb)
 {
-	erofs_free_dev_context(sbi->devs);
+	erofs_free_dev_context(sbi->devs, sb);
 	kfree(sbi->fsid);
 	kfree_sensitive(sbi->domain_id);
 	if (sbi->dif0.file)
@@ -879,8 +885,13 @@ static void erofs_fc_free(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
 
-	if (sbi) /* free here if an error occurs before transferring to sb */
-		erofs_sb_free(sbi);
+	/*
+	 * Freed here only if an error occurs before the sb is set up; at that
+	 * point no block-backed device has been claimed (that happens in
+	 * fill_super), so the NULL sb never reaches fs_bdev_file_release().
+	 */
+	if (sbi)
+		erofs_sb_free(sbi, NULL);
 }
 
 static const struct fs_context_operations erofs_context_ops = {
@@ -936,7 +947,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	erofs_drop_internal_inodes(sbi);
 	fs_put_dax(sbi->dif0.dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
-	erofs_sb_free(sbi);
+	erofs_sb_free(sbi, sb);
 	sb->s_fs_info = NULL;
 }
 
@@ -948,7 +959,7 @@ static void erofs_put_super(struct super_block *sb)
 	erofs_shrinker_unregister(sb);
 	erofs_xattr_prefixes_cleanup(sb);
 	erofs_drop_internal_inodes(sbi);
-	erofs_free_dev_context(sbi->devs);
+	erofs_free_dev_context(sbi->devs, sb);
 	sbi->devs = NULL;
 	erofs_fscache_unregister_fs(sb);
 }

-- 
2.47.3


