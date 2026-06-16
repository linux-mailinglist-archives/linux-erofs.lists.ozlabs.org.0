Return-Path: <linux-erofs+bounces-3652-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kXzeKy1ZMWoWhgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3652-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:49 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FDB690449
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 16:09:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R21HKyqx;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3652-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3652-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfplb0lp1z3c53;
	Wed, 17 Jun 2026 00:09:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781618987;
	cv=none; b=ogyKakdjU66KPtZME9m/7vhAanM2ZT0WhLsonXQunlg7nHWJjvChqjXRg91tnVSLpJw7GwKmhmpwgg6fEaQdDnhysSZ3FA2u/0yDoFlG0U+yCja139xyOx3yonu3vjgchaRc4X2YmlZ5yakxgTxo4UFfkDlGjgAfgqrnhLjJvdmrd2pR6q6g89RzukDV4iM1t2Na0pgbaO1HdwP+vQQ0MNKtmC2ipyX05Yh4cqElglSIk73/vRxlG0UMx9jPsS0QqSz7Ya/C4luDc3GUpi3UkesjiyMbtgbKDDE1vpFazN5VVT+tzWY+fFMxidsOX/50+vZ0LsEIFcEr4xhh1YME0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781618987; c=relaxed/relaxed;
	bh=Hnq/c353kAl87K4UdosPy5fyXTR7Sb7grea3tPyWRUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoPf9tSUCKSs3i0xUrYtb8xhd5DX66wyQ6RI61PcsaFiPDay0G4C0fdBUeWZ6kBlTJ6p7TfkAr2qPANuONcp80MVbUI0c5HndcF3S5xnhqodPCGEM8dggMLxFsDWjEMGc/1ZhI8ivZ6V7wqg/2iBWzXN21a2twm5AX0vqr3MwxV7GUMbtypHLHlX9bkl5Z8++MpBoE4tiLesbsWIygFXPceb9R/tdtxAzmqX2c7XPcxOCFTUHMwiPQFQvtEd5rvecKpr3A5FfzAd195Ib2Y5tiqp06rjJlkTqVKJ102yHiVUzd8rWDn9Ertf+eDX/ZVcpu93j/1ck63QxI2AaTs3+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R21HKyqx; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfplY4q3lz2yv0
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 00:09:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A35734177A;
	Tue, 16 Jun 2026 14:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9211F00A3A;
	Tue, 16 Jun 2026 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618983;
	bh=Hnq/c353kAl87K4UdosPy5fyXTR7Sb7grea3tPyWRUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R21HKyqxQoOZhA2o4e8Ui3qqOoyIvR6UeBMnGed1KoIxsSk9kuVanj/nlHQdx8b1R
	 d9hC2PNyq23gQ7m1OET2m+OP1czV0VcrLqbTsBU2dU3lB58F7gAijoS+VM/OPn1+Y7
	 L61fiOEF2HAX1Mf/zO+YiV6T0CGZCaAPb1bMwa1AnyKgy12PndI/3ArwKBnOMwJX+J
	 +sKr47XJPwiCPHNdU6aKrjIkmtS6d59LtZwlHObyGlkltD/QSGakUXWJLJgu3ZFfdR
	 LUvJsypOhZJO2mVBbrVXxYYUfAV1Xa+mugkFBTisvbFA/jBr4aqfHiaLeeEsoFqyA0
	 7fmERGvfrVh9A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 16 Jun 2026 16:08:34 +0200
Subject: [PATCH RFC v2 18/18] selftests/filesystems: add ustat() coverage
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
Message-Id: <20260616-work-super-bdev_holder_global-v2-18-7df6b864028e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5547; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bUlyKlQEIDC+ooT/76BgARuSUwExW7lF9qoA1/7mnKE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQZRtzfK1ZzQHF6Ea/OxbsPdnn99+/5bZNZsqgyzufif
 //F2otMO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSOJ/hn8qOO9xX9T/82FOR
 3X/k0iGbc+cunZHN8vV7YfA6Imii9j+G/16KaryOfFZzjERaNKvfPX8csFno4Y3nAcebtCq//Nr
 wnwsA
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
	TAGGED_FROM(0.00)[bounces-3652-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 26FDB690449

user_get_super() is now backed by the global device-to-superblock table
instead of a walk of the super_blocks list. ustat(2) is its most direct
user-visible consumer but nothing in the tree exercises it.

Add a small regression test: the device number of a mounted tmpfs (an
anonymous device, registered in the table by sget_fc()) must resolve,
it must stop resolving after the unmount (the entry is dropped again in
kill_super_notify()), and bogus device numbers keep reporting EINVAL.

The test passes on kernels before the conversion: it pins down the
semantics the table-backed lookup must preserve.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/filesystems/.gitignore   |   1 +
 tools/testing/selftests/filesystems/Makefile     |   2 +-
 tools/testing/selftests/filesystems/ustat_test.c | 135 +++++++++++++++++++++++
 3 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 64ac0dfa46b7..1bd53d54553c 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -5,3 +5,4 @@ fclog
 file_stressor
 anon_inode_test
 kernfs_test
+ustat_test
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 85427d7f19b9..bbdd40b167fa 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog
+TEST_GEN_PROGS := devpts_pts file_stressor anon_inode_test kernfs_test fclog ustat_test
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/ustat_test.c b/tools/testing/selftests/filesystems/ustat_test.c
new file mode 100644
index 000000000000..d429fd18d779
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ustat_test.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test ustat(2): looking up superblocks by device number.
+ *
+ * ustat() resolves a device number to a mounted superblock via
+ * user_get_super(). Check that the device number of a mounted tmpfs (an
+ * anonymous device) resolves, that it stops resolving once the filesystem
+ * is unmounted and that bogus device numbers report EINVAL.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+/* struct ustat is not exported through UAPI, mirror include/linux/types.h. */
+struct ustat_buf {
+	int		f_tfree;
+	unsigned long	f_tinode;
+	char		f_fname[6];
+	char		f_fpack[6];
+	/* slack in case an architecture lays the struct out differently */
+	char		pad[64];
+};
+
+#ifdef __NR_ustat
+
+/*
+ * The kernel decodes @dev with new_decode_dev(), which matches the low 32
+ * bits of the st_dev encoding stat(2) returns for any major below 4096.
+ */
+static int sys_ustat(unsigned int dev, struct ustat_buf *buf)
+{
+	return syscall(__NR_ustat, dev, buf);
+}
+
+static int write_string(const char *path, const char *string)
+{
+	ssize_t len = strlen(string);
+	int fd;
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -1;
+	if (write(fd, string, len) != len) {
+		close(fd);
+		return -1;
+	}
+	return close(fd);
+}
+
+/* Enter namespaces in which mounting a tmpfs instance is allowed. */
+static int setup_namespaces(void)
+{
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+	char map[64];
+
+	if (unshare(CLONE_NEWNS | (uid ? CLONE_NEWUSER : 0)))
+		return -1;
+
+	if (uid) {
+		if (write_string("/proc/self/setgroups", "deny"))
+			return -1;
+		snprintf(map, sizeof(map), "0 %d 1", uid);
+		if (write_string("/proc/self/uid_map", map))
+			return -1;
+		snprintf(map, sizeof(map), "0 %d 1", gid);
+		if (write_string("/proc/self/gid_map", map))
+			return -1;
+	}
+
+	return mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL);
+}
+
+TEST(resolves_mounted_superblock)
+{
+	char dir[] = "/tmp/ustat_test.XXXXXX";
+	struct ustat_buf ub;
+	struct stat st;
+
+	ASSERT_NE(NULL, mkdtemp(dir));
+
+	if (setup_namespaces()) {
+		rmdir(dir);
+		SKIP(return, "cannot set up namespaces: %s", strerror(errno));
+	}
+
+	ASSERT_EQ(0, mount("ustat_test", dir, "tmpfs", 0, NULL));
+	ASSERT_EQ(0, stat(dir, &st));
+
+	memset(&ub, 0xff, sizeof(ub));
+	ASSERT_EQ(0, sys_ustat(st.st_dev, &ub))
+		TH_LOG("ustat(%u): %s", (unsigned int)st.st_dev,
+		       strerror(errno));
+
+	ASSERT_EQ(0, umount(dir));
+
+	/* The unmount removed the superblock, the device is gone. */
+	ASSERT_EQ(-1, sys_ustat(st.st_dev, &ub));
+	ASSERT_EQ(EINVAL, errno);
+
+	rmdir(dir);
+}
+
+TEST(bogus_device_numbers)
+{
+	struct ustat_buf ub;
+
+	ASSERT_EQ(-1, sys_ustat(0, &ub));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* major 4095, minor 1048575: nothing plausible lives there */
+	ASSERT_EQ(-1, sys_ustat((0xfffu << 8) | 0xffu | (0xfff00u << 12), &ub));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+#else /* !__NR_ustat */
+
+TEST(unsupported)
+{
+	SKIP(return, "ustat(2) is not available on this architecture");
+}
+
+#endif /* __NR_ustat */
+
+TEST_HARNESS_MAIN

-- 
2.47.3


