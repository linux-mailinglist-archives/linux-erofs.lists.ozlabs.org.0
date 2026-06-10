Return-Path: <linux-erofs+bounces-3564-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MZQgAIwKKWrnPAMAu9opvQ
	(envelope-from <linux-erofs+bounces-3564-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jun 2026 08:56:12 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 647BF6666AA
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Jun 2026 08:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=K4qw8D70;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3564-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3564-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZxPz20mGz2xl6;
	Wed, 10 Jun 2026 16:56:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781074567;
	cv=none; b=IVj2v3ltimfFQWar/fchYnDpPh115Ep70LX99ElnJjigyUA7Hf8MxeqWscxVZ7DAIQPDVoNlyfk4b3NLyR//+OYWSKDXRHEHqfheSplcX+vU08MKtUOh4S9d1SUizT2DhGZq/Lq1YgkfmWRxVJ1vphE7GSc0busAH55RMDND29HAEXZ2B0LO0SyZlazvjHJTAsjhZaWZ/U9j12n71/mLFmT6VF6j8Pn/rz3YXMPRdjSHNbOa8v6weStzssePjH2e9UPQy4RLEln5nJW0YG/3NvVGuvfv48OVgoZMcrnG8h7XNfONVti6OrA/dHk9IJw+EIgZHpDFg4qnqTzMJvlh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781074567; c=relaxed/relaxed;
	bh=tHKZXlYHzQiuz4CuXIVUBayRBgQEvDJmST6DE9mf+8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDaugbyxgmARhKotIY0XDbFcM3LVQkS+RufzPPpvz47B+O5CEiZl+crFKJym1DEK6JBomfhpc1thxPsjtkjPEr0sBRrAeXNmmTiC+JC1UB3sZy5ONicqUQAvYCmaBHb9Oe6e9Kqga8xmORPWiGD+6PEjZ8zuayVvSJ/XLNUOcEX3zF13bolZvN+M7vKt8unghoXP5Ym2XqrSayx4mZ6pry68XC6NrwV0Ak8Ecpdzng1WY4/mjRYNsAIq04flvD93V6+XEfEX2piwoR9LVhD/a6g/QAvW9WtEaL8VeAh6RsefMbSSaGN/RlBmPF65iDQaryNP559HxBdzaH8dlxLUXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=K4qw8D70; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZxPw5gbfz2xjN
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Jun 2026 16:56:02 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781074557; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tHKZXlYHzQiuz4CuXIVUBayRBgQEvDJmST6DE9mf+8g=;
	b=K4qw8D70R38P6bAf0K80YJCV5rU/2Y+4objpKvfsrTzh8x7wIwXWWx1VkfhjN2YtVCzW18RwNuMMbdzGfqIgqtWHSup79ELxKrJoTZizqkPgu+Jeeu4KseHsDgUqQ5TUr877AlTIXafgCkXJO0ozvNTSQeQmNUBZqROhe3WCq9g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X4ZbVxy_1781074555;
Received: from 30.221.130.225(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4ZbVxy_1781074555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 14:55:56 +0800
Message-ID: <e4aa171b-ac0f-4cd1-8605-91a3f82a4faf@linux.alibaba.com>
Date: Wed, 10 Jun 2026 14:55:54 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 7/8] erofs: open via dedicated fs bdev helpers
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
 linux-xfs@vger.kernel.org, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-7-bb0fd82f3861@kernel.org>
 <7c5bfcf0-36a3-4cc6-bf31-6af4fc901c37@linux.alibaba.com>
 <20260603-nieder-ausdehnen-siebdruck-aa96f40ebec6@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260603-nieder-ausdehnen-siebdruck-aa96f40ebec6@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3564-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:hch@lst.de,m:jack@suse.cz,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 647BF6666AA

Hi Christian,

On 2026/6/3 21:42, Christian Brauner wrote:
>> May I ask if it's an urgent 7.2 work? If not, I could
> 
> No no, it's way too late for that this cycle.
> 
>> make a preparation patch for the upcoming 7.2 cycle
>> to handle erofs_map_dev() failure here so you don't
>> need to bother with this in this patchset.
> 
> Sounds good. I take it you can just do this yourself without me.
> 
>> I will seek more time to resolve the recent todos
> 
> Thanks!
> 
>> yet always intercepted by other unrelated stuffs.
> 
> :)

I removed .shutdown() and .remove_bdev() implementations since I
think it doesn't quite seem necessary for immutable fses, but
would like to know your thoughts too, my overall own comments are
documented in the commit message below:


 From 933f6c6f2e704116d9a15815c880196bec7b9ee3 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 2 Jun 2026 12:10:13 +0200
Subject: [PATCH] erofs: open via dedicated fs bdev helpers

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

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
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
2.43.5



