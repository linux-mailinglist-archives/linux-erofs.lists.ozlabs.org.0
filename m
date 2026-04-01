Return-Path: <linux-erofs+bounces-3152-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH3+COvEzGkWWgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3152-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 09:10:35 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBFF375953
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Apr 2026 09:10:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flx2v40LQz2ySY;
	Wed, 01 Apr 2026 18:10:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775027431;
	cv=none; b=GzVXmzuQcHWVl2ec0U50vedPMiPNUgW3rzuwXSEzpOr631/STeswoy5EXN+nOIsQDI2pwEDDS4Yjy/IekqsyQJA10a1DO7xj58+KZLnVGqVBw7p0n5wRwcsCnDo6KDxyFH0jOoclX4klkdWpnCSPpyBbjBKZW33MZ1dG8Tc31lCcMhBgoua86oH7ToNlwriIRfFe6wHS3hn24UK5XBGAouMueYsDLHAzYzq297YMngg9ThGUG7C49M5TEYcayOOfDaxX3klvrX4g8VelMJCH1cNHPkOlYRVZxpRyTt0I1R4aJUWS6HN6aYW5LFAiKh5Hjn9FVf3cVVv0fg+KTM4BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775027431; c=relaxed/relaxed;
	bh=/Z/eiVhgFb5X6+vhMsAxeWVRGIefcGHRMWiYlTeSlyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaSDYgf6ahNaFbSgTAZlvfm5YkL244IFZRKMZS24WyD/rwqXODBblszz7ZgEjKKFlZMeln9Bl99lV3ExxZJ/P6NYPVmdo3DItOOPoMg6NbYXxCyHMtXgcszu1FCiXGziJpPQrqJzRwVi/7tUd+qmkFqgaz4qxnZrEus3BwhyIaguDNG9r+pTQsjfVZQcgnY6C0xP25Etj1A8TfJVJAVVyHfQGYpGcwODPqqxvwD8nBgqiO9RS5RH/ugnpVQ5+pbUS9q+wP05OOKVLotJWREPEa6it5+Bl3DcM9o6JNuDZEnUIBPhiYi5OJ/0rSPXAVN9NCfrPfGhafEd3zDx0EyZSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KbAb2lTM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KbAb2lTM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flx2t1jM3z2xb3
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 18:10:29 +1100 (AEDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-82cec955160so385931b3a.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 01 Apr 2026 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775027427; x=1775632227; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z/eiVhgFb5X6+vhMsAxeWVRGIefcGHRMWiYlTeSlyY=;
        b=KbAb2lTMMb0vHFxNeQOZA5SefYy4xPfsVrDYSpkg9aJqO7yTgzvwf3mRcBCRaY+V4E
         0pZrUFzlakaiGC5VPtJojdQsLiPa7O2m1Eo3TMYS1EuogqhssI6v8KyL5D+RZUQvkctU
         x55guYR8zDxcUF0Gjht4oB5RBIt3Qth430QkxL5h6RUYBYBAUbcXg9kmi7g9nwbPRSCh
         uhQ2q+agBW6KPvmIVqu+G/4i3ryWEvQ1qlAeuOllnQ0Sn8C5kwjqogjK21OBwbuHLReg
         OV7ISVSQvj/brYz3SXxtEtEGuSYupjO15FREKn5kj+IA8mQVWDhZzMBeM9aSLp2Egv2E
         VTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027427; x=1775632227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Z/eiVhgFb5X6+vhMsAxeWVRGIefcGHRMWiYlTeSlyY=;
        b=l9ii5NpTayhV0L8i5SZz3NWAMxrAcjUcEqLaOHwWc1zD9xv3T/s+Oj6WIRMHdZnH+K
         yAUw+bRIrukjbPYCs7N0ucEoG+hlx7OZIgoHY6OQdo/TcDwuA4TQ5jwJ0C6eCZquzsvz
         CqZxM/AW6QHa2PfIDkSmtSUVnRPwZZIYG3+m1arJdHOS2Oaa3tFHq8qQkQfR3XpGmmb6
         GxLpTyMq9zh9Uky39z2pNowoshcv2Hg6SJqYlreSOGHr7N3UptkpdM37eRwrC0ZrD3jm
         tMBPQTEPT7VO1u+gtz3x4wi2Oy98c9YN2r7E3WhPeVECiAICYyG0h5QhUSYUQ0aClPpB
         e55Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrhgn6dApoFQHixshH7PL80M3/nr65AJVXmg1YqOu1Mt901jQWQuqbPFQZggbBEaSovuw1L8guR/OIKw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw24mY2LVM788Q6L/Hf+uHCkVe90l+MNtwdZCMP0gPhmrS8fP9v
	iiBKf6F7nul92uhaTjtezpy2VAak139aYPXyYmKWvkuzNThrC5Wy5T3y
X-Gm-Gg: ATEYQzza0wKWNXw2C868qp6duvpVHHdI+kpQ88O/TVoN8lwKB/1+XM3W1Lt6VvOEKvO
	wYgwEFuyUo9rQDL5eL/rp2CbLZmUT5pre55jTO81Th4ewoswd+u/RpkfCF7YQ+/ZceAtgAemYDa
	nN/A7yRj4KbORyj5LkgKkWaajGyYa2bVl+Byqcl6JbhrxUic3auURTG4sCvknEdAvgf7eIwS7W5
	9TjUkjNmXoEuCrHehyCvEzLKIB4K3j+12/bC47YwncCrqquNKMsrX7uO18ukdIy8v+L0SeXQ6QH
	eIRHcT+F/VumaKUuvOQD8Pu8yp3uhFLMuqNT9hc3NPXu9AzuCsEJ+tvnJ2godq3ixvle88k4JZh
	8Dm359d7V+o8F1KxcpEZKktJGsVuhXWvx4huoPtExU3C/jyaFN83iz1GUSIJVZIThDyh5BKSBmm
	WnH4KOSxO4udOytSsR3gYed8CifmZAGwLsRyn0MAK3PiE/w/kU1IO+hOhWBEZtXqi9vrs=
X-Received: by 2002:a05:6a00:2d86:b0:824:93df:6d86 with SMTP id d2e1a72fcca58-82ce8b5f38cmr2594998b3a.50.1775027426692;
        Wed, 01 Apr 2026 00:10:26 -0700 (PDT)
Received: from localhost.localdomain ([45.114.150.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8466e01sm12842763b3a.20.2026.04.01.00.10.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 00:10:26 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	newajay.11r@gmail.com,
	xiang@kernel.org
Subject: [PATCH v3 experimental-tests] erofs-utils: tests: test FUSE error handling on corrupted inodes
Date: Wed,  1 Apr 2026 12:40:18 +0530
Message-ID: <20260401071018.86191-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330103051.26877-1-nithurshen.dev@gmail.com>
References: <20260330103051.26877-1-nithurshen.dev@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3152-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:newajay.11r@gmail.com,m:xiang@kernel.org,m:nithurshendev@gmail.com,m:newajay11r@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,lists.ozlabs.org,gmail.com,kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0FBFF375953
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch introduces a regression test (erofs/099) to verify that
the FUSE daemon gracefully handles corrupted inodes without crashing
or violating the FUSE protocol.

Recently, a bug was identified where erofs_read_inode_from_disk()
would fail, but erofsfuse_getattr() lacked a return statement
after sending an error reply. This caused a fall-through, sending
a second reply via fuse_reply_attr() and triggering a libfuse
segmentation fault.

To prevent future regressions, this test:
1. Creates a valid EROFS image with a test file.
2. Uses dump.erofs to dynamically determine the test file's inode offset.
3. Deterministically corrupts the inode by injecting 32 bytes of 0xFF,
   invalidating its layout while leaving the superblock intact.
4. Mounts the image in the foreground to capture daemon stderr.
5. Runs 'stat' on the corrupted file to trigger the inode read failure.
6. Evaluates the stderr log to ensure no segfaults, aborts, or
   "multiple replies" warnings are emitted by libfuse.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
Changes in v3:
- Disabled superblock checksums using `-Enosbcrc` in _scratch_mkfs.
- Used `_scratch_unmount` instead of standard `umount`.
- Replaced the hardcoded root offset with a dynamic offset
  calculation for `/testfile` using `dump.erofs` as suggested.

Note regarding the corruption payload:
While implementing the dynamic offset for `/testfile`, I found
that injecting random garbage via `/dev/urandom` made the test
slightly flaky. If the random bytes happen to form a layout that
erofs_read_inode_from_disk() does not immediately reject as
invalid, the function returns success and the buggy FUSE error
path is bypassed.

To ensure the test is 100% deterministic, I changed the payload
to inject exactly 32 bytes of `0xFF`. This guarantees an invalid
`i_format`, reliably forcing the exact inode read error needed
to exercise the FUSE regression.
---
 tests/Makefile.am   |  3 ++
 tests/erofs/099     | 90 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/099.out |  2 +
 3 files changed, 95 insertions(+)
 create mode 100755 tests/erofs/099
 create mode 100644 tests/erofs/099.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index e376d6a..c0f117c 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -122,6 +122,9 @@ TESTS += erofs/027
 # 028 - test inode page cache sharing functionality
 TESTS += erofs/028
 
+# 099 - test fuse error handling on truncated images
+TESTS += erofs/099
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/099 b/tests/erofs/099
new file mode 100755
index 0000000..0189813
--- /dev/null
+++ b/tests/erofs/099
@@ -0,0 +1,90 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Test FUSE daemon and kernel error handling on corrupted inodes
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
+
+# get standard environment, filters and checks
+. "${srcdir}/common/rc"
+
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	# Ensure we kill our background daemon if it's still alive
+	[ -n "$fuse_pid" ] && kill -9 $fuse_pid 2>/dev/null
+}
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+# Default to erofs (kernel) if FSTYP is not set
+[ -z "$FSTYP" ] && FSTYP="erofs"
+
+if [ -z "$SCRATCH_DEV" ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f $SCRATCH_DEV
+fi
+
+localdir="$tmp/$seq"
+rm -rf $localdir
+mkdir -p $localdir
+
+echo "test data" > $localdir/testfile
+
+_scratch_mkfs -Enosbcrc $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+
+# Corrupt the root inode to force erofs_read_inode_from_disk to fail.
+# The EROFS superblock is at offset 1024 and is 128 bytes long.
+# The metadata (including the root inode) starts immediately after (offset 1152).
+# We inject 1024 bytes of random garbage starting at offset 1152. This leaves 
+# the SB intact so the mount succeeds, but guarantees the inode read will fail.
+dd if=/dev/urandom of=$SCRATCH_DEV bs=1 seek=1152 count=1024 conv=notrunc >> $seqres.full 2>&1
+
+if [ "$FSTYP" = "erofsfuse" ]; then
+	[ -z "$EROFSFUSE_PROG" ] && _notrun "erofsfuse is not available"
+	# Run erofsfuse in the foreground to capture libfuse's internal stderr
+	$EROFSFUSE_PROG -f $SCRATCH_DEV $SCRATCH_MNT > $tmp/fuse_err.log 2>&1 &
+	fuse_pid=$!
+	# Wait for the mount to establish
+	sleep 1
+else
+	_require_erofs
+	_scratch_mount >> $seqres.full 2>&1
+fi
+
+# Attempt to stat the root directory. We expect this to fail with an error.
+timeout 5 stat $SCRATCH_MNT >> $seqres.full 2>&1
+res=$?
+
+if [ "$FSTYP" = "erofsfuse" ]; then
+	# Clean up the mount
+	_scratch_unmount >> $seqres.full 2>&1
+	# Wait for the daemon to cleanly exit, or kill it if stuck
+	kill $fuse_pid 2>/dev/null
+	wait $fuse_pid 2>/dev/null
+	cat $tmp/fuse_err.log >> $seqres.full
+
+	# Evaluate results based on captured stderr and timeout
+	if [ $res -eq 124 ]; then
+		_fail "stat command timed out (FUSE daemon likely hung due to double reply)"
+	elif grep -q -i "multiple replies" $tmp/fuse_err.log; then
+		_fail "Bug detected: libfuse reported multiple replies to request"
+	elif grep -q -i "segmentation fault\|aborted" $tmp/fuse_err.log; then
+		_fail "Bug detected: FUSE daemon crashed"
+	fi
+else
+	# Kernel check: ensure no hang and error is returned
+	[ $res -eq 124 ] && _fail "stat command timed out (kernel hung?)"
+	[ $res -eq 0 ] && _fail "stat unexpectedly succeeded on a corrupted image"
+	_scratch_unmount >> $seqres.full 2>&1
+fi
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/099.out b/tests/erofs/099.out
new file mode 100644
index 0000000..4f36820
--- /dev/null
+++ b/tests/erofs/099.out
@@ -0,0 +1,2 @@
+QA output created by 099
+Silence is golden
-- 
2.52.0


