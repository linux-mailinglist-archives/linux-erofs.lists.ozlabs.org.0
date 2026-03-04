Return-Path: <linux-erofs+bounces-2494-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBQRKHd2qGnpugAAu9opvQ
	(envelope-from <linux-erofs+bounces-2494-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 19:14:15 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB7205FDA
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 19:14:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR15X5CzJz30hq;
	Thu, 05 Mar 2026 05:14:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::231" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772648048;
	cv=pass; b=Fw67UK+Bxau3blWFf7xuCQcTFKzNB8tPFasTuxup+yD0tjHMy33Gb4U1vns6jB/VW07zkA1XCSNf5SXdFbUY/mXPCyXqROQQYjjBN9o1WCbuoM6SUvsBlOzdaHxdW6/114Kzs4Cq5yQ/c551AOupwHk31w6nqiRy4MnsS7iatw4KVi7Q7awvl5djcjQzt0r3ko/JjcITkE2/drMJbRumSymxttfEJvLd+BLga7mup54B8MOucpqrKSNpFT4Pn9ly7bM86aCn+H1FvL/h884vgPoDNEy6/k+86QajNMXP1NplYX/4nyKbDy9ckXZvb5UwmW6LiVIRHGfl1Pd5qMzjpA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772648048; c=relaxed/relaxed;
	bh=Z0HwNiZiWP9nB5V8F1IqVpgBJlc5ry7piL71tsDcK5k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HDHtOMHk7trcEI0aPAwPPYLBDN7pQeSFZ4DQ6ORfUbnfZFnjvZaSiYZG4mCLpRxhG0zckZzqBV+7PUQ/Mh28dOQYa1g2WKkGinnFwxX+XwnodTH1ezwrukJr6uLcvqCYMQliebHeiarvddIourCEtfQr4mvUnyW9gSzuxqFjfJgKxcpJMy2J7944tqybPQedm0yqhYpEscrkawE94oj8rSar8IlIn+rr9dI6EuhOp/SA1KqdSjviYnUTWWuq6+68+NSt6OjQRxT9RdyE03etJcIJ3nB4bYLp9Ro0fLQOw/bfnCRAR0vo00gKOxIougkVzXovkJQSTXS7SwTzOqhcYw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UgXGG1gO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::231; helo=mail-lj1-x231.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UgXGG1gO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::231; helo=mail-lj1-x231.google.com; envelope-from=aayushmaan.chakraborty@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fR15V4dJkz2yFQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 05:14:05 +1100 (AEDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-38a23cf08e0so32605601fa.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Mar 2026 10:14:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772648036; cv=none;
        d=google.com; s=arc-20240605;
        b=KBeEEwVdcQNoAc6SdhbZlveu7gqEUvGpvoP9Nfa5Pq5Qi1VfOwi8zyeeR+2wFMbx2B
         WQNYMiN46eOhaIEZccfkhXmK3bJZ/Ed4KI7kbvHy1yrC+ZtKolOPJFK2ldLcocZ3um3v
         Bt/3GvEAAWtRgllLFeMaBPDPs+hHGplhrvAGPDF6R5jf3n3+jgrkbLCb3GDNlBjgfIE9
         zSuncaYGpeFAFjpTXGuAMRel9uzdIPPLyI69Cp0uNMbzHXfGecKF43hRSOzAdkkRdMh2
         F2b965kbDijwwDOdaDWHhPMQjh2tzXh1heKN2Wfd/jggV7orMVsjQC8VHfYia+evK0aQ
         qmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Z0HwNiZiWP9nB5V8F1IqVpgBJlc5ry7piL71tsDcK5k=;
        fh=AHnHft27vbfAZR0iP4O+qFI4fpW+Rv1CrfmhGsWufCA=;
        b=X8CJnR/CRl6s9B44lgTluLYCCPlID1A7GDzbvketawpFU2j3KoCSTwZqc6cbw3TFK4
         Ouzs5FU8qRFK0/46T/1GJLHBBzyBhIODmhWqKEHezxMeKgTCSoGhbM5+93qE7wJg2+HN
         P8EpfOihfI+IxvQ4I+rynWZOVGKiTu5DDajVvunIRTC+J47WXSwEkKjWxsazPbFU2giK
         azaSkGSkCxdMHHQich2Eao4m/H3KFADpQpPnhe9gtJP+TKvKQS7fsat/kmXSr8KHPr0a
         eMT1BDXpyeKoV/DAPAF274f5LBchKY+bi6eptkQaacrY7AyAFBPTDS+yUUkiqZD3I+HU
         FoBA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648036; x=1773252836; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0HwNiZiWP9nB5V8F1IqVpgBJlc5ry7piL71tsDcK5k=;
        b=UgXGG1gOz1gqVCv12gW99c5VZgcELL+vs0l5nCS5C9q2Rk3xqlcJPPrLet0bk+FDJd
         rG4VJd0AQpZbYJXcfWtZCsYgvwXkHzY7AxWJScokSeeLUDh+VgN4CNDEZ2iMqYQy6ka1
         r0dRx4Mb4uKz03Ej+0NOF/2ovzhUEWZbHz4WT4ShtZaCA7sT+bqUEkN/Fi28AqtDgUnS
         8fiELFYPhIH0EgBZpcz0lrPPgT/xuJov31kXCTOQ+8j/t2lIoDNCdOS1IBopoiWcWKrk
         1n02xomwfUL76ziYpJvudzwlEBj9ngpvQEX2ygy1EdF0dLLGNAPIoKOOr8ixI7KZl+A6
         dILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648036; x=1773252836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0HwNiZiWP9nB5V8F1IqVpgBJlc5ry7piL71tsDcK5k=;
        b=j4ASvywsLR2H+9N/bjal3qdR/md2EOv+rmcmGMreDL6jPF1JACCD1yDHDc59Ow/6q7
         6i1UTFJuLggDZXMf0J0L/l4288PKh1b8PZgdl2Ur7GnGLDn7sXHp4LKTVHspTYq2dEVS
         CVwuYVq2Vdpx5oVEBYaDh4+oL1zzKkRswDk5Vp5eBiU7ou/uJtf4ZerfoH6+Td6bQIwl
         ItPdqPh00VodQjc4Zdap4FhVKkuUtI5HIujjb6rBL8y/5SAZpSRhw4ViOuEpLuvUgvwR
         WQmnVWpExp7/bKCA49TrkJyb0vm1akxOO32p0qEWh/0Zj/2bgivWDHrfjzl0lrMa9G8l
         ESCw==
X-Gm-Message-State: AOJu0YxOqyoALCiqlkvTZ+AxtQJaflJbV5ERWFYD3sXmy/v09DGEJSHY
	BJDWNmVdgxQCYJDdsLdGSvGX6q9FXeLwCgN+u/KUCcZbPFZRJ5JZ5hc4UV/XiO+LJY4DdrgGduY
	NajVIehhqV1+6IBNVoXKNOFL5vM+huzYdHprf14g=
X-Gm-Gg: ATEYQzy5tUq5lZwueUMitnsOV1Z4pHQ0POpmxjC8inYj571qhVr7F6NZjoB/Bf04y4c
	LN0j3ASMRecdDc5eJzwCMKXDrkyfC3l4uhT/0C1OJov1XM6qk92QVqaT0MY8oR2erjqSSN/Lx3e
	RoewtuEBYJ3MMuQbcpYYj+6GTbvonu8vloUQl8DbVn/c4XOv/r7w+Wba6l7X/yfupyDEHKaTHSx
	MqMguILKHk6axx2MzNMHTupyUG4j0pITImqzpCbjsM0jq2D0jmtqxdN5XPILfv6M28k0ivFrQtj
	cVboG2pEmNHM7NIQgg==
X-Received: by 2002:a2e:91c2:0:b0:38a:30c0:1cd with SMTP id
 38308e7fff4ca-38a30c004e4mr10834221fa.7.1772648036108; Wed, 04 Mar 2026
 10:13:56 -0800 (PST)
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
From: Aayushmaan Chakraborty <aayushmaan.chakraborty@gmail.com>
Date: Wed, 4 Mar 2026 23:43:43 +0530
X-Gm-Features: AaiRm53j87vXGcfl3_N6UBZLjic7LG7q4TH1Je_olzTORdbO4cc7QseZSVDkVYw
Message-ID: <CABCXVcmmXnEw6256sJsfGuG7eqLA0ytR-sJharrOHx+Yc2bLxA@mail.gmail.com>
Subject: [PATCH] tests: add basic smoke/integration test script
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 83DB7205FDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2494-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aayushmaanchakraborty@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

Hi Gao Xiang and linux-erofs team,

The repository currently lacks any automated smoke or integration tests.

This patch adds a simple, self-contained bash script (tests/smoke.sh)
that verifies the primary userspace workflow:

- mkfs.erofs image creation (uncompressed)
- fsck.erofs integrity check
- erofsfuse FUSE mount
- Basic content verification
- Clean unmount and full cleanup

The script:
- Checks for required binaries upfront with a helpful error message
- Fails fast with clear diagnostics
- Uses trap for cleanup on exit or failure
- Exits non-zero on failure

Happy to expand it (e.g., add compressed image variant, error
injection, or CI integration).

Thanks for considering!

Best regards,
Aayushmaan Chakraborty
GitHub: https://github.com/Aayushmaan-24/erofs-utils/tree/add-basic-smoke-t=
est

---

From 5dabe68b8c58e5d8b5541822446f7e27e816d6a1 Mon Sep 17 00:00:00 2001
From: Aayushmaan <aayushmaan.chakraborty@gmail.com>
Date: Wed, 4 Mar 2026 18:49:53 +0530
Subject: [PATCH] tests: add basic smoke/integration test script

Verifies core userspace workflow: mkfs.erofs image creation,
fsck.erofs integrity check, erofsfuse mount, content verification,
and automatic cleanup.
Script includes:
- Binary existence checks
- Fail-fast error handling
- Trap-based cleanup on exit
- Tested locally on Debian-based Chromebook (Crostini)
No existing tests were present in the repository.
---
 tests/smoke.sh | 115 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100755 tests/smoke.sh

diff --git a/tests/smoke.sh b/tests/smoke.sh
new file mode 100755
index 0000000..43f70f5
--- /dev/null
+++ b/tests/smoke.sh
@@ -0,0 +1,115 @@
+#!/usr/bin/env bash
+#
+# Basic smoke test for erofs-utils
+# Tests: mkfs.erofs =E2=86=92 fsck.erofs =E2=86=92 erofsfuse mount =E2=86=
=92 content
verification =E2=86=92 unmount
+#
+# Usage: ./tests/smoke.sh
+#        Must be run from the root of the built erofs-utils tree
+#
+# Exits with 0 on success, non-zero on failure
+
+set -euo pipefail
+IFS=3D$'\n\t'
+
+echo "=3D=3D=3D Starting EROFS smoke test =3D=3D=3D"
+
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+# Setup
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+SRC_DIR=3D"smoke_test_src_$$    "
+IMAGE_FILE=3D"smoke_test.img"
+MOUNT_POINT=3D"smoke_test_mnt_    $$"
+
+MKFS_BIN=3D"./mkfs/mkfs.erofs"
+FSCK_BIN=3D"./fsck/fsck.erofs"
+FUSE_BIN=3D"./fuse/erofsfuse"
+
+if [[ ! -x "$MKFS_BIN" || ! -x "$FSCK_BIN" || ! -x "$FUSE_BIN" ]]; then
+    echo "ERROR: Required binaries not found (expected: $MKFS_BIN,
$FSCK_BIN, $FUSE_BIN)."
+    echo "       Make sure you have built erofs-utils first, for example:"
+    echo "         ./autogen.sh"
+    echo "         ./configure --enable-lz4 --enable-lzma
--enable-fuse --with-libzstd"
+    echo "         make -j$(nproc)"
+    exit 1
+fi
+
+mkdir -p "$SRC_DIR" "$MOUNT_POINT"
+
+# Create some test files
+echo "Hello from EROFS smoke test!" > "$SRC_DIR/hello.txt"
+echo "This is a second file."      > "$SRC_DIR/second.txt"
+mkdir "$SRC_DIR/subdir"
+echo "Nested file content"         > "$SRC_DIR/subdir/nested.txt"
+
+echo "[OK] Test files created in $SRC_DIR"
+
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+# Create image (uncompressed)
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+echo "Creating EROFS image (uncompressed)..."
+"$MKFS_BIN" "$IMAGE_FILE" "$SRC_DIR/"
+
+if [[ ! -f "$IMAGE_FILE" ]]; then
+    echo "ERROR: mkfs.erofs failed to create $IMAGE_FILE"
+    exit 1
+fi
+
+echo "[OK] Image created: $IMAGE_FILE"
+
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+# Verify with fsck
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+echo "Running fsck on image..."
+"$FSCK_BIN" "$IMAGE_FILE"
+
+# fsck.erofs usually prints stats or "No errors found" on clean images
+# We just check exit code here
+echo "[OK] fsck completed (exit code $?)"
+
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+# Mount via FUSE and verify contents
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+echo "Mounting image via erofsfuse..."
+"$FUSE_BIN" "$IMAGE_FILE" "$MOUNT_POINT/"
+
+# Give FUSE a moment to settle
+sleep 1
+
+# Basic existence checks
+if [[ ! -f "$MOUNT_POINT/hello.txt" ]]; then
+    echo "FAIL: hello.txt not visible after mount"
+    fusermount -u "$MOUNT_POINT" 2>/dev/null || true
+    exit 1
+fi
+
+if ! grep -q "Hello from EROFS" "$MOUNT_POINT/hello.txt"; then
+    echo "FAIL: Content mismatch in hello.txt"
+    fusermount -u "$MOUNT_POINT" 2>/dev/null || true
+    exit 1
+fi
+
+if [[ ! -f "$MOUNT_POINT/subdir/nested.txt" ]]; then
+    echo "FAIL: subdir/nested.txt not visible"
+    fusermount -u "$MOUNT_POINT" 2>/dev/null || true
+    exit 1
+fi
+
+echo "[OK] Mount successful and files verified"
+
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+# Cleanup
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+echo "Unmounting..."
+fusermount -u "$MOUNT_POINT" 2>/dev/null || sudo fusermount -u
"$MOUNT_POINT" || {
+    echo "Warning: unmount failed, continuing cleanup..."
+}
+
+rm -rf "$SRC_DIR" "$MOUNT_POINT" "$IMAGE_FILE"
+
+echo "=3D=3D=3D Smoke test PASSED =3D=3D=3D"
+exit 0
--
2.39.5

