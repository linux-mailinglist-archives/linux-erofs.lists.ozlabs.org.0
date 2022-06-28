Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388BE55BF20
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 09:28:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LXGRr0QqMz3bsW
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Jun 2022 17:28:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656401336;
	bh=hloSUbimKPIEYh1/9v8Sy8+7YBlPPiZ44GRZGeoZWho=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Cp8C714psUEE1RtPCBQMl7s5uxSJXGOSchXFcfkbWcEmcIMZ0MxYX1/8ArwkX7VQD
	 YlQVZ94ILh4GLxp+ErDNH14uQIyiH+F/l+gVhk7yV19iuKDJ/9tyc/zbpAkUN0nANz
	 mzCMOzMJeSMz0890JNgU3UeguhPT1hH9nCaPospTJUzeVv2AEBCOBRaBC+UGD4oKEb
	 aSPZFmg73xNVb3KFLWltEsbebra0i9ScMkIQFXnEWzPgWiZWRP0U+Do/R65FgxGfI/
	 BDJqOZdID02c6dcSh1maBApBLqussV2EGRz5E5X8gocc4KFZQHtQNG8Ijv5fS8ku2Y
	 qQ4zvfD7Xvzow==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=195.135.220.29; helo=smtp-out2.suse.de; envelope-from=wqu@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=ihZIXOHg;
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LXGRk4ZhJz3bsW
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Jun 2022 17:28:50 +1000 (AEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CFA81FB3C;
	Tue, 28 Jun 2022 07:28:47 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DC47139E9;
	Tue, 28 Jun 2022 07:28:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wIevNautumJzFQAAMHmgww
	(envelope-from <wqu@suse.com>); Tue, 28 Jun 2022 07:28:43 +0000
To: u-boot@lists.denx.de
Subject: [PATCH RFC 6/8] fs: sandboxfs: add sandbox_fs_get_blocksize()
Date: Tue, 28 Jun 2022 15:28:06 +0800
Message-Id: <9f4b43b84a688b0367a87da2d4e0eb303a36bf32.1656401086.git.wqu@suse.com>
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
Cc: trini@konsulko.com, Simon Glass <sjg@chromium.org>, jnhuang95@gmail.com, joaomarcos.costa@bootlin.com, marek.behun@nic.cz, thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is to make sandboxfs to report blocksize it supports for
_fs_read() to handle unaligned read.

Unlike all other fses, sandboxfs can handle unaligned read/write without
any problem since it's calling read()/write(), which doesn't bother the
blocksize at all.

This change is mostly to make testing of _fs_read() much easier.

Cc: Simon Glass <sjg@chromium.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 arch/sandbox/cpu/os.c  | 11 +++++++++++
 fs/fs.c                |  2 +-
 fs/sandbox/sandboxfs.c | 14 ++++++++++++++
 include/os.h           |  8 ++++++++
 include/sandboxfs.h    |  1 +
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index 5ea54179176c..6c29f29bdd9b 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -46,6 +46,17 @@ ssize_t os_read(int fd, void *buf, size_t count)
 	return read(fd, buf, count);
 }
 
+ssize_t os_get_blocksize(int fd)
+{
+	struct stat stat = {0};
+	int ret;
+
+	ret = fstat(fd, &stat);
+	if (ret < 0)
+		return -errno;
+	return stat.st_blksize;
+}
+
 ssize_t os_write(int fd, const void *buf, size_t count)
 {
 	return write(fd, buf, count);
diff --git a/fs/fs.c b/fs/fs.c
index 7e4ead9b790b..337d5711c28c 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -261,7 +261,7 @@ static struct fstype_info fstypes[] = {
 		.exists = sandbox_fs_exists,
 		.size = sandbox_fs_size,
 		.read = fs_read_sandbox,
-		.get_blocksize = fs_get_blocksize_unsupported,
+		.get_blocksize = sandbox_fs_get_blocksize,
 		.write = fs_write_sandbox,
 		.uuid = fs_uuid_unsupported,
 		.opendir = fs_opendir_unsupported,
diff --git a/fs/sandbox/sandboxfs.c b/fs/sandbox/sandboxfs.c
index 4ae41d5b4db1..130fee088621 100644
--- a/fs/sandbox/sandboxfs.c
+++ b/fs/sandbox/sandboxfs.c
@@ -55,6 +55,20 @@ int sandbox_fs_read_at(const char *filename, loff_t pos, void *buffer,
 	return ret;
 }
 
+int sandbox_fs_get_blocksize(const char *filename)
+{
+	int fd;
+	int ret;
+
+	fd = os_open(filename, OS_O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	ret = os_get_blocksize(fd);
+	os_close(fd);
+	return ret;
+}
+
 int sandbox_fs_write_at(const char *filename, loff_t pos, void *buffer,
 			loff_t towrite, loff_t *actwrite)
 {
diff --git a/include/os.h b/include/os.h
index 10e198cf503e..a864d9ca39b2 100644
--- a/include/os.h
+++ b/include/os.h
@@ -26,6 +26,14 @@ struct sandbox_state;
  */
 ssize_t os_read(int fd, void *buf, size_t count);
 
+/**
+ * Get the optimial blocksize through stat() call.
+ *
+ * @fd:		File descriptor as returned by os_open()
+ * Return:	>=0 for the blocksize. <0 for error.
+ */
+ssize_t os_get_blocksize(int fd);
+
 /**
  * Access to the OS write() system call
  *
diff --git a/include/sandboxfs.h b/include/sandboxfs.h
index 783dd5c88a73..6937068f7b82 100644
--- a/include/sandboxfs.h
+++ b/include/sandboxfs.h
@@ -32,6 +32,7 @@ void sandbox_fs_close(void);
 int sandbox_fs_ls(const char *dirname);
 int sandbox_fs_exists(const char *filename);
 int sandbox_fs_size(const char *filename, loff_t *size);
+int sandbox_fs_get_blocksize(const char *filename);
 int fs_read_sandbox(const char *filename, void *buf, loff_t offset, loff_t len,
 		    loff_t *actread);
 int fs_write_sandbox(const char *filename, void *buf, loff_t offset,
-- 
2.36.1

