Return-Path: <linux-erofs+bounces-3051-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFJOBXncxmkoPQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3051-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2026 20:37:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA2534A3FA
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2026 20:37:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj9s02hFwz2yS4;
	Sat, 28 Mar 2026 06:37:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774640244;
	cv=pass; b=Gu5DCpOMyEuORbMkNuQFUt2VUH4pJZ3oo42fkE5BjgUI51mFJEMnBC2Immsfah6Knx2B6anUO28uxbZv9ZzSthoiFznkBvVbs128dx9j1O+aMXzqZGBl3vAQqw54iM4IodFhUl+FW0Yni5ohdSE1kYZHb044vrlmnPeP+dX9YmRocC2WVJrCRGoIlLVgPuzEJZtJM6iPxS09U3nx1NSTW2TsJ7Vo5Z44adqpedBnCs5UEvdSFEX7GX8oVqfTou137MvfgPBbZMTTwvIO38NvInpgA27dY99P824os8drYnCeFeVGJRT9lwDwqMvv+PmHD+p2gGz/QSfqIhzGdgNGVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774640244; c=relaxed/relaxed;
	bh=bCUaBLuw6zmtHqTltAWT68I9/2gY8R+qQxebDOFHZXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT2Bj3k54HtRC4INCgAZ/kxsqSVFf8XQYZiEBZS9jGceUYA2iebLE4Qm0ffr9+0CvVPM79uqIkAqIw/DqKnxr3wWrOCnOIqYwz7glG3HPrU6nZppwyXTEJr2Cy2Hg8vzYzepDH2zpswIM+SKQQ6I4j/WJSeicvydERju0pDb+IIaJl+G2hxvb24yQmQ20iqtMv1F7QsUHaPZeNapca5Oeh8nd/BAz4NRSJNQ46RuGVCZ9ERZaNBy7QWvAJmzCzNpGI/uu1ggFjMZ1dxY5rjdbN7lyaKmb60xzh+gDxeIk8EO3dFRi1HFgOu6L31MMXNQEQRf/d8t6AtEwcVHwJ2nOg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=nPfey2Pu; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=nPfey2Pu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj9ry4r7Xz2xR4
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 06:37:22 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774640235; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=BluHSK2Q0Lhl+CK/gTWz0WF8ItIPfxNoJA/vnvAtpMy+A78BJwWIUIftD2eG02A5PKzDa+H7eacDRQyp040trG4QavVPxttngHNOcKMQJ80OpogWFXcnLjMo7eFyd97eO2LlMSm4tDdcuISmCh1H4hMNSPIHAdOpi5MRhv74rpI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774640235; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bCUaBLuw6zmtHqTltAWT68I9/2gY8R+qQxebDOFHZXI=; 
	b=PLJpeQbPHTiIUeP3OT6cThovQDB2SFEB56lcue8cnreNm0S6jUqXOfIFFSE6VilbNsssJ2CuhOvW8HrIHUjdadCMUfZ+hYpQIWMGRPNlSo9vecnTEKQ6NgH3xex05mjy0lAhEPRPSZIb50vLM7I4JEaGtc0kG3UFnDb1bbDG5Xc=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774640235;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bCUaBLuw6zmtHqTltAWT68I9/2gY8R+qQxebDOFHZXI=;
	b=nPfey2PuXrSKIJ9SyHMw2TGiyP0tyy1gGod+Vt1CfhHCo+jFafAY9gWwsLKyoHtT
	NQ6RsErK3cssj+rWzQU7Kj1UBtsFMrI9350WxPYnxyJYfTj07w/pVGgHbQFSvPeQFDu
	BcJDYza1Qac4WlbIlaKrAFsP7DH6dEFcfatRZy94=
Received: by mx.zoho.in with SMTPS id 1774640233216698.9268615350928;
	Sat, 28 Mar 2026 01:07:13 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: tests: add test for malformed tar hardlink targets
Date: Fri, 27 Mar 2026 19:37:12 +0000
Message-ID: <20260327193712.16318-1-ch@vnsh.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <da934dc1-adf0-4961-a43d-e615780c4e38@linux.alibaba.com>
References: <da934dc1-adf0-4961-a43d-e615780c4e38@linux.alibaba.com>
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
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3051-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vnsh.in:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 1EA2534A3FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a regression test for malformed tar hardlink targets.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 tests/Makefile.am     |   3 +
 tests/erofs/029       |  54 ++++++++++++++
 tests/erofs/029.out   |   2 +
 tests/src/Makefile.am |   3 +
 tests/src/badtar.c    | 159 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 221 insertions(+)
 create mode 100755 tests/erofs/029
 create mode 100644 tests/erofs/029.out
 create mode 100644 tests/src/badtar.c

diff --git a/tests/Makefile.am b/tests/Makefile.am
index e376d6a..1e9726f 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -122,6 +122,9 @@ TESTS += erofs/027
 # 028 - test inode page cache sharing functionality
 TESTS += erofs/028
 
+# 029 - regression test for malformed tar hardlink targets
+TESTS += erofs/029
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/029 b/tests/erofs/029
new file mode 100755
index 0000000..cd1a8d3
--- /dev/null
+++ b/tests/erofs/029
@@ -0,0 +1,54 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 029 - check malformed tar hardlink targets
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
+
+# get standard environment, filters and checks
+. "${srcdir}/common/rc"
+
+cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+}
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+if [ -z $SCRATCH_DEV ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f SCRATCH_DEV
+fi
+
+localdir="$tmp/$seq"
+rm -rf $localdir
+mkdir -p $localdir
+
+${PWD}/src/badtar $localdir >> $seqres.full 2>&1 || \
+	_fail "failed to prepare tarballs"
+
+rm -f $SCRATCH_DEV
+$MKFS_EROFS_PROG --tar=f $SCRATCH_DEV $localdir/ok.tar \
+	>> $seqres.full 2>&1 || _fail "valid tar hardlink failed unexpectedly"
+
+for t in empty dot; do
+	rm -f $SCRATCH_DEV
+	$MKFS_EROFS_PROG --tar=f $SCRATCH_DEV $localdir/$t.tar \
+		>> $seqres.full 2>&1
+	ret=$?
+	if [ $ret -eq 0 ]; then
+		_fail "malformed tar with $t hardlink target passed unexpectedly"
+	elif [ $ret -gt 128 ]; then
+		_fail "mkfs crashed on malformed tar with $t hardlink target"
+	fi
+done
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/029.out b/tests/erofs/029.out
new file mode 100644
index 0000000..8ee6db4
--- /dev/null
+++ b/tests/erofs/029.out
@@ -0,0 +1,2 @@
+QA output created by 029
+Silence is golden
diff --git a/tests/src/Makefile.am b/tests/src/Makefile.am
index 16de41a..4a02509 100644
--- a/tests/src/Makefile.am
+++ b/tests/src/Makefile.am
@@ -15,3 +15,6 @@ badlz4_SOURCES = badlz4.c
 badlz4_CFLAGS = ${liblz4_CFLAGS}
 badlz4_LDADD = ${liblz4_LIBS}
 endif
+
+check_PROGRAMS += badtar
+badtar_SOURCES = badtar.c
diff --git a/tests/src/badtar.c b/tests/src/badtar.c
new file mode 100644
index 0000000..77b20af
--- /dev/null
+++ b/tests/src/badtar.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * erofs-utils/tests/src/badtar.c
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+struct tar_header {
+	char name[100];
+	char mode[8];
+	char uid[8];
+	char gid[8];
+	char size[12];
+	char mtime[12];
+	char chksum[8];
+	char typeflag;
+	char linkname[100];
+	char magic[6];
+	char version[2];
+	char uname[32];
+	char gname[32];
+	char devmajor[8];
+	char devminor[8];
+	char prefix[155];
+	char padding[12];
+};
+
+static int writeall(int fd, const void *buf, size_t len)
+{
+	const char *p = buf;
+
+	while (len) {
+		ssize_t ret = write(fd, p, len);
+
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			return -errno;
+		}
+		p += ret;
+		len -= ret;
+	}
+	return 0;
+}
+
+static void tar_octal(char *buf, size_t size, unsigned long long value)
+{
+	snprintf(buf, size, "%0*llo", (int)size - 1, value);
+}
+
+static void tar_checksum(struct tar_header *h)
+{
+	unsigned int i, sum = 0;
+	const unsigned char *p = (const unsigned char *)h;
+
+	memset(h->chksum, ' ', sizeof(h->chksum));
+	for (i = 0; i < sizeof(*h); ++i)
+		sum += p[i];
+	snprintf(h->chksum, sizeof(h->chksum), "%06o", sum);
+	h->chksum[6] = '\0';
+	h->chksum[7] = ' ';
+}
+
+static void tar_fill_header(struct tar_header *h, const char *name,
+			    char typeflag, const char *linkname,
+			    unsigned int mode, unsigned int size)
+{
+	memset(h, 0, sizeof(*h));
+	snprintf(h->name, sizeof(h->name), "%s", name);
+	tar_octal(h->mode, sizeof(h->mode), mode);
+	tar_octal(h->uid, sizeof(h->uid), 0);
+	tar_octal(h->gid, sizeof(h->gid), 0);
+	tar_octal(h->size, sizeof(h->size), size);
+	tar_octal(h->mtime, sizeof(h->mtime), 0);
+	h->typeflag = typeflag;
+	if (linkname)
+		snprintf(h->linkname, sizeof(h->linkname), "%s", linkname);
+	memcpy(h->magic, "ustar", 5);
+	memcpy(h->version, "00", 2);
+	memcpy(h->uname, "root", 4);
+	memcpy(h->gname, "root", 4);
+	tar_checksum(h);
+}
+
+static int write_tar(const char *path, const char *linkname)
+{
+	static const char zeros[512];
+	struct tar_header h;
+	int fd, ret;
+
+	fd = open(path, O_CREAT | O_TRUNC | O_WRONLY, 0644);
+	if (fd < 0)
+		return -errno;
+
+	tar_fill_header(&h, "a", '0', NULL, 0644, 511);
+	ret = writeall(fd, &h, sizeof(h));
+	if (ret)
+		goto out;
+	ret = writeall(fd, zeros, 511);
+	if (ret)
+		goto out;
+	ret = writeall(fd, zeros, 1);
+	if (ret)
+		goto out;
+
+	tar_fill_header(&h, "bad", '1', linkname, 0644, 0);
+	ret = writeall(fd, &h, sizeof(h));
+	if (ret)
+		goto out;
+	ret = writeall(fd, zeros, sizeof(zeros));
+	if (ret)
+		goto out;
+	ret = writeall(fd, zeros, sizeof(zeros));
+out:
+	close(fd);
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	char path[PATH_MAX];
+	int ret;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s <dir>\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	ret = snprintf(path, sizeof(path), "%s/ok.tar", argv[1]);
+	if (ret < 0 || ret >= sizeof(path))
+		return EXIT_FAILURE;
+	ret = write_tar(path, "a");
+	if (ret)
+		goto err;
+
+	ret = snprintf(path, sizeof(path), "%s/empty.tar", argv[1]);
+	if (ret < 0 || ret >= sizeof(path))
+		return EXIT_FAILURE;
+	ret = write_tar(path, "");
+	if (ret)
+		goto err;
+
+	ret = snprintf(path, sizeof(path), "%s/dot.tar", argv[1]);
+	if (ret < 0 || ret >= sizeof(path))
+		return EXIT_FAILURE;
+	ret = write_tar(path, ".");
+	if (ret)
+		goto err;
+	return EXIT_SUCCESS;
+err:
+	fprintf(stderr, "failed to create tarballs: %s\n", strerror(-ret));
+	return EXIT_FAILURE;
+}
-- 
2.43.0


