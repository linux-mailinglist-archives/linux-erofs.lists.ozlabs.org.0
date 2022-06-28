Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36CF55BF1C
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 09:28:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXGRb5N65z3bY6
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 17:28:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656401323;
	bh=EJDsnfm5CD6flKl27ug0ll/8C9SQYioiQTVCJ40ytaU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cJFyF+VkNjZ5na7El7HQr1INBWZ0/S9tOBwnaM0AfeXc53ziFBToCv1s7/EJW0Acr
	 QfBx1SY/242rWu2wTYtcCqpXGuRRlK16xEs2nudPSjoYCCMVPejSFmXabxmcPaCjd2
	 K++PISZkbPUyLz4Q5DQaGPgiEbJkMDZtuFyJaFlPRFrDGCcPPSnjRCc7xXYIAKpZHe
	 PTsfs24gaBL/uLgxMbEWZFh813a4cHxnQaQ9JwJ0xcCkKrh92g+6JkYgtHSJPBgl8B
	 NL7b0JHi/1+bkMZBGwmrtBgylzSzE4uNmVCmZCK/hFCWXO3o4WrdlXNclKbZg05L1O
	 hOFmzGAiekrfQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=SsQf2kEY;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXGRT5fLxz3bsW
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 17:28:37 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1879D1FB3C;
	Tue, 28 Jun 2022 07:28:35 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DB70139E9;
	Tue, 28 Jun 2022 07:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MCnEGaCtumJzFQAAMHmgww
	(envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:32 +0000
To: u-boot@lists.denx.de
Subject: [PATCH RFC 2/8] fs: always get the file size in _fs_read()
Date: Tue, 28 Jun 2022 15:28:02 +0800
Message-Id: <cd417bc9dc4b44c4ac8d98f146e47c98cf4aac5a.1656401086.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656401086.git.wqu@suse.com>
References: <cover.1656401086.git.wqu@suse.com>
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

For _fs_read(), @len == 0 means we read the whole file.
And we just pass @len == 0 to make each filesystem to handle it.

In fact we have info->size() call to properly get the filesize.

So we can not only call info->size() to grab the file_size for len == 0
case, but also detect invalid @len (e.g. @len > file_size) in advance or
truncate @len.

This behavior also allows us to handle unaligned better in the incoming
patches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/fs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 6de1a3eb6d5d..d992cdd6d650 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -579,6 +579,7 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 {
 	struct fstype_info *info = fs_get_info(fs_type);
 	void *buf;
+	loff_t file_size;
 	int ret;
 
 #ifdef CONFIG_LMB
@@ -589,10 +590,26 @@ static int _fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 	}
 #endif
 
-	/*
-	 * We don't actually know how many bytes are being read, since len==0
-	 * means read the whole file.
-	 */
+	ret = info->size(filename, &file_size);
+	if (ret < 0) {
+		log_err("** Unable to get file size for %s, %d **\n",
+				filename, ret);
+		return ret;
+	}
+	if (offset >= file_size) {
+		log_err(
+		"** Invalid offset, offset (%llu) >= file size (%llu)\n",
+			offset, file_size);
+		return -EINVAL;
+
+	}
+	if (len == 0 || offset + len > file_size) {
+		if (len > file_size)
+			log_info(
+	"** Truncate read length from %llu to %llu, as file size is %llu **\n",
+				 len, file_size, file_size);
+		len = file_size - offset;
+	}
 	buf = map_sysmem(addr, len);
 	ret = info->read(filename, buf, offset, len, actread);
 	unmap_sysmem(buf);
-- 
2.36.1

