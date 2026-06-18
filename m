Return-Path: <linux-erofs+bounces-3675-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3FXxKE0ZNGr0OQYAu9opvQ
	(envelope-from <linux-erofs+bounces-3675-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 18:14:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFB6A1863
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 18:14:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=RxR9rWiB;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3675-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3675-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gh5Pw1TXgz2ytj;
	Fri, 19 Jun 2026 02:13:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781799236;
	cv=none; b=T3IGahm4etP+d37msgFalP0DfT3jCB4oyIyN9ToXTWnA4u5eYE9hCCBNNtK1PS7egHp35ZrMlBeG8qdHe88xB85fPEaMTJuVA9yTyvZ7h01rilYMPrn4pxGKr3nAXR3wlBrZk8auCWEcPoXKQ+kYGZeD6nT4WijXh8jMD5NhodGOM9TrN0zulRmzkhBZeAnMecRX6XMftzayEFxu5HkYTRbbE6OxBfy6A7jhn8otFOFPtr3cCPf44oeCRG7DmwoSFw99MUqfOQ0GYcjCQ5lfRuIP4554PUirjiYNL0KK5PYKsKbASmx0Q1vcDEndWwJaMxiFMPTFPXMvzpPYqUS9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781799236; c=relaxed/relaxed;
	bh=yIFvXLcBExm9V2ghigl9PhDQEh1Tujlxv5Eg+Rt+6F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7/Ut/aUnloAQcLwFlqaEBS9FU79613Bn53p+3oHxPP7PgXiiSNe9EYgxzrOK1DZ0IybXSdYxrdO+vMhJk90tqY1Bp9rmHzODI1DCGD/5vwQPudpVW64J8rwrdxtHWzaGxvz+AR1dxZLlJ15CoggL4SnRoXHvj+WUE8bEcYie8QfPm8Wha3Sl1DOoLEt2H7qAshYfu9ndLMyEWbhx6MAE4e7Qym9dAg4WB8wOjj9/X4zuwxI+W8wZyil9xm5gUzWNncDNzyXMCmleukdft01MIUB2zFR34+i7zW5nkBYbvKSR+RENGo9MZgtqlcpHGd8Di65psl8izT32gs4T54Yxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RxR9rWiB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+aruiz.redhat.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gh5Pt6Q3dz2yRM
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 02:13:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D1FB44357;
	Thu, 18 Jun 2026 16:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79289C2BCF4;
	Thu, 18 Jun 2026 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781799231;
	bh=7NYTBhkmj2Rr8b8068lxoBsflcbEvf21KYt+cWMGNtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RxR9rWiBOWNdEBiRXl1JHjXLCWfNJG+LZjuzYi+cksaUuQNUO61Ok3BssAwSx7cOx
	 UAh4RrmeODOv7CxG7oPIRZ4uTj4+NNiKZvKuM4sVSxu7nx064x71omLg88onwk9yNv
	 JWkiSi8cvdYT8L9iXnr8rnznCoqnLy2Y84+gCrT8FN25NmdGJTOT3NwWfpoSJT/NQZ
	 1SRP3iRmFPdvLy+4aHrbMR/ZlVMYVhdi/b2r1Yt/vrUvXejA32DNabCHn+fr/Iqj5A
	 xaEmLSE0r6NCrOIOcG36Wa+Lp4OQj2nVv6Q4DxQKBJZgSGqAJFl1EpdOR45AbII+2J
	 KuHAA+oCJBgiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB0DCD98F8;
	Thu, 18 Jun 2026 16:13:51 +0000 (UTC)
From: Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org>
Date: Thu, 18 Jun 2026 17:13:45 +0100
Subject: [PATCH RFC 2/2] erofs: add KUnit test for memory-backed compressed
 mount
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
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-erofs-memback-v1-2-5aa7006a241a@redhat.com>
References: <20260618-erofs-memback-v1-0-5aa7006a241a@redhat.com>
In-Reply-To: <20260618-erofs-memback-v1-0-5aa7006a241a@redhat.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Brian Masney <bmasney@redhat.com>, Eric Curtin <ericcurtin17@gmail.com>, 
 Alberto Ruiz <aruiz@redhat.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781799229; l=8348;
 i=aruiz@redhat.com; s=20260612; h=from:subject:message-id;
 bh=b9t0SkET5XJY4KK4sxjXiSKjgiQdXm9lWMdLqHk7s2k=;
 b=tbONYBa2EzQSjsUjfTnKYiQ6NLw3Y1EmK9ph1Pt6looSCrto6gVgu7pG38FrLeu/YehLWJG86
 M0S710t0tL9CWy3m1en95zZgJq1Spdp6T/WvwEc4bAkU6HSRztDrp9u
X-Developer-Key: i=aruiz@redhat.com; a=ed25519;
 pk=d1doFQwve1B/jU9nG5oPl1W5d+t+iFrjkkwk/hD97Ow=
X-Endpoint-Received: by B4 Relay for aruiz@redhat.com/20260612 with
 auth_id=818
X-Original-From: Alberto Ruiz <aruiz@redhat.com>
Reply-To: aruiz@redhat.com
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:linux-kernel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:javierm@redhat.com,m:bmasney@redhat.com,m:ericcurtin17@gmail.com,m:aruiz@redhat.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-3675-lists,linux-erofs=lfdr.de,aruiz.redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,redhat.com,gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[aruiz@redhat.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-erofs@lists.ozlabs.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FAFB6A1863

From: Alberto Ruiz <aruiz@redhat.com>

Add a KUnit test that exercises the EROFS memback mount path with a
compressed (LZ4) image. The test embeds a minimal 8 KiB EROFS image
containing a single file with known content ("The quick brown fox. "
repeated 250 times), mounts it via erofs_memback_set_pending(), reads
back the decompressed file data, and verifies it byte-for-byte.

Since erofs_memback_set_pending() is __init, the test uses
kunit_test_init_section_suites() so it runs during kernel init.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Alberto Ruiz <aruiz@redhat.com>
---
 fs/erofs/Kconfig        |  11 ++++
 fs/erofs/Makefile       |   1 +
 fs/erofs/memback_test.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 97c48ebe8458..adf26e67924c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -213,3 +213,14 @@ config EROFS_FS_PAGE_CACHE_SHARE
 	  content fingerprints on the same machine.
 
 	  If unsure, say N.
+
+config EROFS_FS_MEMBACK_KUNIT_TEST
+	bool "Test EROFS memory-backed mount" if !KUNIT_ALL_TESTS
+	depends on EROFS_FS=y && EROFS_FS_ZIP && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit test for the EROFS memory-backed mount path. Embeds a small
+	  LZ4-compressed EROFS image and verifies that it can be mounted and
+	  read via the memback interface during kernel init.
+
+	  Say N unless you are running KUnit tests.
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 8f3b73835328..b98c95e96e85 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -12,3 +12,4 @@ erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
 erofs-y += memback.o
 erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
+obj-$(CONFIG_EROFS_FS_MEMBACK_KUNIT_TEST) += memback_test.o
diff --git a/fs/erofs/memback_test.c b/fs/erofs/memback_test.c
new file mode 100644
index 000000000000..9661b76cfa0f
--- /dev/null
+++ b/fs/erofs/memback_test.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for EROFS memory-backed mount (memback).
+ *
+ * Embeds a minimal LZ4-compressed EROFS image and verifies that the memback
+ * path can mount it and serve decompressed file data correctly.
+ */
+#include <kunit/test.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/init_syscalls.h>
+#include <linux/namei.h>
+#include <linux/slab.h>
+#include <uapi/linux/mount.h>
+#include "internal.h"
+
+#define EROFS_MEMBACK_TEST_DIR "/erofs_memback_test"
+#define EROFS_MEMBACK_TEST_FILE EROFS_MEMBACK_TEST_DIR "/testfile"
+
+/*
+ * "The quick brown fox. " repeated 250 times = 5250 bytes, LZ4-compressed
+ * into a 2-block (4096 x 2) EROFS image by:
+ *   mkfs.erofs -zlz4 -b4096 -x-1 image.img testdir/
+ *
+ * The full image is 8192 bytes but only 384 bytes are non-zero.  We store
+ * just the two non-zero regions (superblock+metadata at offset 1024 and
+ * compressed data at offset 8140) and reconstruct the image at runtime.
+ *
+ * The image is placed at a non-page-aligned offset (3 × 512 = 1536 bytes)
+ * within the allocation to exercise the non-page-aligned memback path.
+ */
+#define EROFS_TEST_IMAGE_SIZE 8192
+#define EROFS_TEST_IMAGE_OFFSET 1536
+
+static const unsigned char erofs_test_metadata[] __initconst = {
+	0xe2, 0xe1, 0xf5, 0xe0, 0xee, 0x93, 0xd1, 0x4a, 0x03, 0x00, 0x00, 0x00,
+	0x0c, 0x00, 0x24, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x5d, 0x77, 0x31, 0x6a, 0x00, 0x00, 0x00, 0x00, 0xac, 0xb1, 0x04, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x2c, 0x51, 0x16, 0x54, 0xcc, 0x6a, 0x43, 0xdd, 0x96, 0xc4, 0x3e, 0x45,
+	0x16, 0x53, 0x0e, 0x9b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x05, 0x00, 0x00, 0x00,
+	0xed, 0x41, 0x00, 0x00, 0x2f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00, 0xe8, 0x03, 0x00, 0x00,
+	0xe8, 0x03, 0x00, 0x00, 0x50, 0x77, 0x31, 0x6a, 0x00, 0x00, 0x00, 0x00,
+	0x7c, 0x8d, 0x20, 0x14, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x24, 0x00, 0x02, 0x00,
+	0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x25, 0x00, 0x02, 0x00,
+	0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x27, 0x00, 0x01, 0x00,
+	0x2e, 0x2e, 0x2e, 0x74, 0x65, 0x73, 0x74, 0x66, 0x69, 0x6c, 0x65, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x07, 0x00, 0x00, 0x00, 0xa4, 0x81, 0x00, 0x00,
+	0x82, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+	0x02, 0x00, 0x00, 0x00, 0xe8, 0x03, 0x00, 0x00, 0xe8, 0x03, 0x00, 0x00,
+	0x50, 0x77, 0x31, 0x6a, 0x00, 0x00, 0x00, 0x00, 0x2d, 0x3a, 0x37, 0x14,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x10, 0x82, 0x04,
+};
+
+static const unsigned char erofs_test_cdata[] __initconst = {
+	0xff, 0x06, 0x54, 0x68, 0x65, 0x20, 0x71, 0x75, 0x69, 0x63, 0x6b,
+	0x20, 0x62, 0x72, 0x6f, 0x77, 0x6e, 0x20, 0x66, 0x6f, 0x78, 0x2e,
+	0x20, 0x15, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0x69, 0x50, 0x66, 0x6f, 0x78, 0x2e, 0x20,
+};
+
+#define EXPECTED_PATTERN "The quick brown fox. "
+#define EXPECTED_PATTERN_LEN 21
+#define EXPECTED_REPEATS 250
+#define EXPECTED_FILE_SIZE (EXPECTED_PATTERN_LEN * EXPECTED_REPEATS)
+
+static void __init erofs_memback_test_mount_compressed(struct kunit *test)
+{
+	void *buf;
+	struct file *file;
+	char *readbuf;
+	ssize_t nread;
+	int ret, i;
+
+	buf = kzalloc(EROFS_TEST_IMAGE_OFFSET + EROFS_TEST_IMAGE_SIZE,
+		      GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	memcpy(buf + EROFS_TEST_IMAGE_OFFSET + 1024, erofs_test_metadata,
+	       sizeof(erofs_test_metadata));
+	memcpy(buf + EROFS_TEST_IMAGE_OFFSET + 8140, erofs_test_cdata,
+	       sizeof(erofs_test_cdata));
+
+	erofs_memback_set_pending(buf + EROFS_TEST_IMAGE_OFFSET,
+				  EROFS_TEST_IMAGE_SIZE);
+
+	ret = init_mkdir(EROFS_MEMBACK_TEST_DIR, 0700);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = init_mount("none", EROFS_MEMBACK_TEST_DIR, "erofs", MS_RDONLY,
+			 NULL);
+	if (ret) {
+		init_rmdir(EROFS_MEMBACK_TEST_DIR);
+		kfree(buf);
+		KUNIT_FAIL(test, "init_mount failed: %d", ret);
+		return;
+	}
+
+	file = filp_open(EROFS_MEMBACK_TEST_FILE, O_RDONLY, 0);
+	if (IS_ERR(file)) {
+		init_umount(EROFS_MEMBACK_TEST_DIR, 0);
+		init_rmdir(EROFS_MEMBACK_TEST_DIR);
+		kfree(buf);
+		KUNIT_FAIL(test, "filp_open failed: %ld", PTR_ERR(file));
+		return;
+	}
+
+	KUNIT_EXPECT_EQ(test, (int)i_size_read(file_inode(file)),
+			EXPECTED_FILE_SIZE);
+
+	readbuf = kzalloc(EXPECTED_FILE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, readbuf);
+
+	nread = kernel_read(file, readbuf, EXPECTED_FILE_SIZE, &file->f_pos);
+	KUNIT_EXPECT_EQ(test, (int)nread, EXPECTED_FILE_SIZE);
+
+	for (i = 0; i < EXPECTED_REPEATS && nread == EXPECTED_FILE_SIZE; i++)
+		KUNIT_EXPECT_MEMEQ(test, readbuf + i * EXPECTED_PATTERN_LEN,
+				   EXPECTED_PATTERN, EXPECTED_PATTERN_LEN);
+
+	kfree(readbuf);
+	fput(file);
+	init_umount(EROFS_MEMBACK_TEST_DIR, 0);
+	init_rmdir(EROFS_MEMBACK_TEST_DIR);
+	kfree(buf);
+}
+
+static struct kunit_case erofs_memback_test_cases[] __initdata = {
+	KUNIT_CASE(erofs_memback_test_mount_compressed),
+	{},
+};
+
+static struct kunit_suite __refdata erofs_memback_test_suite = {
+	.name = "erofs_memback",
+	.test_cases = erofs_memback_test_cases,
+};
+kunit_test_init_section_suites(&erofs_memback_test_suite);
+
+MODULE_DESCRIPTION("EROFS memback KUnit test suite");
+MODULE_LICENSE("GPL");

-- 
2.53.0



