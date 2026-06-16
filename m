Return-Path: <linux-erofs+bounces-3639-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lma8CPxYMWrphQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3639-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:00 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368026903FE
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:08:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YErVXEEI;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3639-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3639-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfpkd16Kgz3c4f;
	Wed, 17 Jun 2026 00:08:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618937;
	cv=none; b=HRqwmif1JkrJ9S0L4fn+EtqzN2waPBCzP4l7b5VZiDX5oRRGVw6zHG1971oIY7OUO0xQbgjeXP0RczoMqSkfJel3OvfpDGF1bolpg81eXTGex705bHVx+rrMj/pNpheTa281aEiYKS6SvLKbFD81xJPIATNUAw+Hr9amLb0ldSPQj8pxa/KTmAk3bjYwMimhb8ju2KBxMV9q6RnhWKqmjBfcBpGGBSaqIShRPWyDvgOE08vhBiIrsaT0OMlB7AcegHdKaXs+nO+a3+cGdgDHRMsVUZkR5mmJyE8T4Dovg0pSUUtOGK9heKNIe6gy0lJZ+jcLH852sqDsVofNnI8B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618937; c=relaxed/relaxed;
	bh=YhQnc85bhNppX3ZWtjMTIiQZA5BWEXOerB7NxvXiEsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLVgBSyI89chR8JA6ReWdPb2lF+KEAAPRtChgCYYLq4NZEjK4W5QHGsaFjKh4UTRs7DVRY9/DrKDNDoIRsKl+v+OC1kkzw7wlxm2g50b2fG5nkG+0a/yn2uKgBljRaDVw8LwzKI2Ubx3LQ6I0ld74cmcV3oZTALowcDIiJONue8ia9ZN+v+d0yVTzXZsbZTR4OPKQYiaWSW1T9ArSdOYjLtEWg3P+I7uSfxdmVXXvrOpXjWNKjlEs4Krj7yashmTLQwGy6e0KAKWRlxQVRIUjFl5CnaZSGM5DziBmpEPmyUJ/chTW+y3ClFoUfpkiLWELxvchbtZ8gfQ0i8dGwqlTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YErVXEEI; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfpkc2mnRz2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:08:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 526B243FE8;
	Tue, 16 Jun 2026 14:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E595E1F00A3A;
	Tue, 16 Jun 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618934;
	bh=YhQnc85bhNppX3ZWtjMTIiQZA5BWEXOerB7NxvXiEsY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YErVXEEI97QukE5WwtZDkNCrh8zvAAbO493SZHRJP0UY6wJSXsDkm6g0fuf9t9afl
	 2C8tMUrhnBFGhPb0rvQCfBuWiiSn2SxN70646xDlZO8j0aCkHdO048moY9huSDpywc
	 mt9bIk16S6sk2fia2i+A0gWOOr+95pS+2uIZlWwps3NzBdFi+ilPqtOH87ie53KdiH
	 cQxZTYhOSI5AFxACkQQXT9FrQOpFFFnBEwcerrLpfxZUzp4VNmLC9j1Q4Bd79BWX0a
	 dPB0ZLfCwPlm6YNJTVxB81iH3rUTNjG1cbFd5nTAm2uyFcAbt07aD7aIC22I9yTKQx
	 OjcvPNxqXfZYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:21 +0200
Subject: [PATCH RFC v2 05/18] ext4: use anonymous devices for KUnit test
 superblocks
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
Message-Id: <20260616-work-super-bdev_holder_global-v2-5-7df6b864028e@kernel.org>
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
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-4090c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8k1zf1Xhv1DGOeFMfDC/l7TAYeTE4+X4pRdFgzN3Qrk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRty7rJkuyThlafyx1mIfjotdVpZ67EFinW+lVrsm6
 M7QlP3UUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFjvxkZNh5cy6Npvn9z+LWY
 x3cOHzqavPJzxZ1Uvcs2TCKPvDzWaDMyzIoU7rjsZfN8+0tGuzPhUV/+TPWL69tZnSwxqedB5X8
 nLgA=
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
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-3639-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 368026903FE

The mballoc and extents KUnit tests create superblocks through
sget_fc() with a set callback that never assigns s_dev and a kill_sb
that only calls generic_shutdown_super().

The upcoming global device-to-superblock table registers every
superblock under its s_dev, so each superblock needs a unique device
number. Allocate a proper anonymous device via set_anon_super_fc() and
release it through kill_anon_super().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/ext4/extents-test.c | 9 ++-------
 fs/ext4/mballoc-test.c | 9 ++-------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index bd7795a82607..c3836ecb89f9 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -126,11 +126,6 @@ struct kunit_ext_test_param {
 	struct kunit_ext_data_state exp_data_state[3];
 };
 
-static void ext_kill_sb(struct super_block *sb)
-{
-	generic_shutdown_super(sb);
-}
-
 static int ext_init_fs_context(struct fs_context *fc)
 {
 	return 0;
@@ -138,13 +133,13 @@ static int ext_init_fs_context(struct fs_context *fc)
 
 static int ext_set(struct super_block *sb, struct fs_context *fc)
 {
-	return 0;
+	return set_anon_super_fc(sb, fc);
 }
 
 static struct file_system_type ext_fs_type = {
 	.name		 = "extents test",
 	.init_fs_context = ext_init_fs_context,
-	.kill_sb	 = ext_kill_sb,
+	.kill_sb	 = kill_anon_super,
 };
 
 static void extents_kunit_exit(struct kunit *test)
diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index d90da44aadbd..a3b33ed2c172 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -59,11 +59,6 @@ static const struct super_operations mbt_sops = {
 	.free_inode	= mbt_free_inode,
 };
 
-static void mbt_kill_sb(struct super_block *sb)
-{
-	generic_shutdown_super(sb);
-}
-
 static int mbt_init_fs_context(struct fs_context *fc)
 {
 	return 0;
@@ -72,7 +67,7 @@ static int mbt_init_fs_context(struct fs_context *fc)
 static struct file_system_type mbt_fs_type = {
 	.name			= "mballoc test",
 	.init_fs_context	= mbt_init_fs_context,
-	.kill_sb		= mbt_kill_sb,
+	.kill_sb		= kill_anon_super,
 };
 
 static int mbt_mb_init(struct super_block *sb)
@@ -136,7 +131,7 @@ static void mbt_mb_release(struct super_block *sb)
 
 static int mbt_set(struct super_block *sb, struct fs_context *fc)
 {
-	return 0;
+	return set_anon_super_fc(sb, fc);
 }
 
 static struct super_block *mbt_ext4_alloc_super_block(void)

-- 
2.47.3


