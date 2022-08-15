Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE83592E5A
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 13:46:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M5stJ4kKrz3bc1
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Aug 2022 21:46:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1660563960;
	bh=eTUxYj1OZDkY14aB7vIzWLz6w9dpyMmDNCfmBP+tQss=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dhVt1+0LYiK0nr/BTUApSUojfUomjMotdjOAtOUjXl9crL1rNn4BWyFz9M0EuAh2l
	 yS2W+QHHFI6E5QXA6h40/TZmV+kQ9NnF6WCMr0EN0rdpe57SY4BuskSCpD1hFGydci
	 vkUbsd6k8OlIW2Ka1aKAo4CagOVfc0o5nsiHod7t2CGFZWcQLKXr2oKb5GRso0TQn8
	 CPnl2Hi1q4KIRcz23txvHbz+IN+TO6XBiLelXXFoeTUzjoCrM8egPL8FbuZVIKgPwX
	 TpNS0JkeVaxlF3OzigFFny18hUBERRRsTakaVo5miuU7sAFaIgRXj8MpmKCWza1p2Z
	 7yavHJXwhNXKQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=vYKQQAcO;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M5stB2NMKz2yjC
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Aug 2022 21:45:54 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B808D20866;
	Mon, 15 Aug 2022 11:45:46 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35DCE13A93;
	Mon, 15 Aug 2022 11:45:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uGLIOucx+mLsGAAAMHmgww
	(envelope-from <wqu@suse.com>); Mon, 15 Aug 2022 11:45:43 +0000
To: u-boot@lists.denx.de
Subject: [PATCH v3 2/8] fs: btrfs: fix a bug which no data get read if the length is not 0
Date: Mon, 15 Aug 2022 19:45:13 +0800
Message-Id: <bf56479cb718f70cc595caf5af081f0dbb49e9e7.1660563403.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660563403.git.wqu@suse.com>
References: <cover.1660563403.git.wqu@suse.com>
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
Cc: trini@konsulko.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[BUG]
When testing with unaligned read, if a specific length is passed in,
btrfs driver will read out nothing:

 => load host 0 $kernel_addr_r 5k_file 0x1000 0
 0 bytes read in 0 ms

But if no length is passed in, it works fine, even if we pass a non-zero
length:

 => load host 0 $kernel_addr_r 5k_file 0 0x1000
 1024 bytes read in 0 ms

[CAUSE]
In btrfs_read() if we have a larger size than our file, we will try to
truncate it using the file size.

However the real file size is not initialized if @len is not zero, thus
we always truncate our length to 0, and cause the problem.

[FIX]
Fix it by just always do the file size check.

In fact btrfs_size() always follow soft link, thus it will return the
real file size correctly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 4cdbbbe3d066..309cd595d37d 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -246,16 +246,17 @@ int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
 		return -EINVAL;
 	}
 
-	if (!len) {
-		ret = btrfs_size(file, &real_size);
-		if (ret < 0) {
-			error("Failed to get inode size: %s", file);
-			return ret;
-		}
-		len = real_size;
+	ret = btrfs_size(file, &real_size);
+	if (ret < 0) {
+		error("Failed to get inode size: %s", file);
+		return ret;
 	}
 
-	if (len > real_size - offset)
+	/*
+	 * If the length is 0 (meaning read the whole file) or the range is
+	 * beyond file size, truncate it to the end of the file.
+	 */
+	if (!len || len > real_size - offset)
 		len = real_size - offset;
 
 	ret = btrfs_file_read(root, ino, offset, len, buf);
-- 
2.37.1

