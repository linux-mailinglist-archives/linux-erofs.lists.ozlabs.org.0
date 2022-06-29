Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD655FEC5
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 13:39:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXzxx52qJz3c9Z
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jun 2022 21:39:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656502741;
	bh=mr46B25ZUmI7GGQ5t6X0E3WzxzV6Pf3dl/rRvmfxgMo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=LSfr0CijkeVEhkNb4GGsWWVSy3ZWvBDfeDmFUiYda43PzS0a7eNYD4CxfH4Mth21R
	 vQSiVXmAV5hkeEGHinFsljDF6b9fzu9o2vLiCtbtcYdj7dsegFu0JTvSI+t/4HfnDE
	 3az7QwL0MKXmMZpXKxYXOH5hXKorxtjBYZ6nU9OZA1LnLAg2Ep2Qij74b8U/atOoOY
	 S9xAV1LT/8mpZd+wAivqUC50tHv36aWeT6FCLREh74C0Nv/rrnVxPJ0VsBN0Dd5T9p
	 l9BEEG7EwTb2J1ybEZTZlzp+JcziciM27nR+IeeyS2uI104E8KhZB+oIsfU03ZYxlS
	 ojHSByI6qIJCA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=tL3h0ntz;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXzxq1l7Tz3c9Z
	for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jun 2022 21:38:54 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC9501F915;
	Wed, 29 Jun 2022 11:38:51 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAF30133D1;
	Wed, 29 Jun 2022 11:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0M6THck5vGLFPwAAMHmgww
	(envelope-from <wqu@suse.com>); Wed, 29 Jun 2022 11:38:49 +0000
To: u-boot@lists.denx.de
Subject: [PATCH 1/8] fs: fat: unexport file_fat_read_at()
Date: Wed, 29 Jun 2022 19:38:22 +0800
Message-Id: <b28b8d554dd3d1fc6bed8fc7f5b9cb71e1880e38.1656502685.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656502685.git.wqu@suse.com>
References: <cover.1656502685.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Qu Wenruo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Qu Wenruo <wqu@suse.com>
Cc: trini@konsulko.com, jnhuang95@gmail.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

That function is only utilized inside fat driver, unexport it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/fat/fat.c  | 4 ++--
 include/fat.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index df9ea2c028fc..dcceccbcee0a 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -1243,8 +1243,8 @@ out_free_itr:
 	return ret;
 }
 
-int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
-		     loff_t maxsize, loff_t *actread)
+static int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
+			    loff_t maxsize, loff_t *actread)
 {
 	fsdata fsdata;
 	fat_itr *itr;
diff --git a/include/fat.h b/include/fat.h
index bd8e450b33a3..a9756fb4cd1b 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -200,8 +200,6 @@ static inline u32 sect_to_clust(fsdata *fsdata, int sect)
 int file_fat_detectfs(void);
 int fat_exists(const char *filename);
 int fat_size(const char *filename, loff_t *size);
-int file_fat_read_at(const char *filename, loff_t pos, void *buffer,
-		     loff_t maxsize, loff_t *actread);
 int file_fat_read(const char *filename, void *buffer, int maxsize);
 int fat_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info);
 int fat_register_device(struct blk_desc *dev_desc, int part_no);
-- 
2.36.1

