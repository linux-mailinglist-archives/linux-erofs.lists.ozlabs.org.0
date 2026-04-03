Return-Path: <linux-erofs+bounces-3183-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI0KJz8Lz2kNsgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3183-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 02:35:11 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5E238F84B
	for <lists+linux-erofs@lfdr.de>; Fri, 03 Apr 2026 02:35:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn09l1rz5z2xQD;
	Fri, 03 Apr 2026 11:35:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775176507;
	cv=none; b=AgGARxTzfSZaT25ojRsE5ycZVAMhtoFxhCNdkmEGjnz359Y4LlKrjNPYaLBK3/GU21n8CbzFpoT9OU60VAyyHSASxNFKilESgv3W2u1W7PiqykzZlXI6DVVCXcczmw1Jm1h9ANoFe6J9+MHAE2vt8z/c2WmSVdDlfrBvHWZrBuSXQrB4BcvzU/kpEJd0/VmNrLReFsnDKEIZdtvQRSqigddQhvxJEBVl9T9PE+eHMM75rllB6sWuuy+mZ+j0ZLiyWK6Hnhg5G/8Ga+kLMSxtHOECz/1TfhayLZMcVznqsydn1TgtkoMJ6Cpm3fI8jJOdovvDnp3u3+8IsKOLEugdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775176507; c=relaxed/relaxed;
	bh=iHFhKPKNiUir/OmVbi3o3NODzNBUKZvXi/EjL0vUiZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwTA2gxuV2i0p73gULX+j19QM15AM+nOmUawHeXpRq+rwgKrKxbTLE3wcKxcxb5wRprVZmre2/0siqUwludHwoxL35RITXjju69NcdycGUrmtkyTytBcsxJkKibQUhIUO1CHUC26nvZfdxvxi5Mnl9R751DGXQ41NGLRaMrmEooJ4r5OuvGU1hebPw7WGcyWnT5Gb+NXaCM/dQgriWz3hXJNq/Wqqwmvb4pORT8EPX5B6jNFGxXVU3KeolBUAaX2iObgvj/+pa5w/EyEGOqZ3Ia/VmHkVATaGNgScRz8UQgkiGHky9S3FU0Opsj45icpNaT0hRkqR78koiwrrLF/dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VtDT+rw/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VtDT+rw/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn09j2Zw2z2xN8
	for <linux-erofs@lists.ozlabs.org>; Fri, 03 Apr 2026 11:35:04 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-824c9da9928so751277b3a.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775176502; x=1775781302; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHFhKPKNiUir/OmVbi3o3NODzNBUKZvXi/EjL0vUiZA=;
        b=VtDT+rw/6FgdzyuSDpdpHaHmBwtL/buY9yDWrNrAyyz7BuTDVPGsIldCwjWKTrIPRn
         eeTKNVGDtjsw+yxVSNI2G8S7sjZh889H3ENMo5OzrwKDh6vQBXMSsPbWTLJf4lpyAvTg
         s6hTvR8/HRSVVs7gnK0v8nFG9wU075kcjSameYQi9/MykByHqBwwy6/xIYrUjrWxP2tV
         Db3mim+K2buENe8x/aueqb4+qH1T27f1Clrc82OdMw7lxf0hq53ZfnCeUmiO0gMyOowI
         QOvSwP8YAKWJHM13ht/ScMQQU/wd0MSKXA3dqYKhZl2vWY9m4l2f/YSEM8SkoCBCsf1P
         pssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176502; x=1775781302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iHFhKPKNiUir/OmVbi3o3NODzNBUKZvXi/EjL0vUiZA=;
        b=AbAQGG62ASXF8Aee9g28NFpHcb5hrhYWWnq8Mgcksf8zfXvO+mfpM0gl73s63KwkK4
         DMR8e212X35Lmfz/UlHSwGwYfeVH7w9jq89TS8N1j9VSZqxT7V4UpDSFjxBVtZWZu3Lm
         s4d7ZhLjP2xZvtPhs1mtuLqjNgtIN5YlhxHAtPnQtdXluime6c6geR/l86A2FzN3wiwt
         T8w4AcJ1yZODNL9RKGoe2caUAfEocgAfPNhx5o3rXFvA0Eh6a5lKfWwsjSXTQFtysbLk
         x7W0MvUjFO9OOrPw8hl1+e88pynmWJVjJpyJ8jgp+PS5mrcwWnKQFID+IKbIhmf4dgKt
         Iz4g==
X-Forwarded-Encrypted: i=1; AJvYcCUqiu9MMlwqfktSqaLL6jfe0pvsBX65HR1aTmMnW6J4neOIRP30D0JxnUS5LYzXXNghbB19Q9Dv+xgNVQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJaGlwNt9Wb46wMIUWsg1CY4XqY4BkdFEF/Hf9mWLI6Kgjzc/g
	DElRpdhVrIQIo2VAiqSfNWrFsvm39jYPypHjQnPz4xXL2d8tdAVati8o
X-Gm-Gg: ATEYQzyjT/P0hLpjQRuNxH8WuDrvbrSjPhJDSIi2zrlP9yDqprTQ1mie5wEz8UqyrDI
	5czaA9KATP2Rcfq00QVuRAs0fvq+40v2q9ekUv1u1tgxgAlG8AdY65ZG6LX12xKzDlapUnDUBWn
	g0IGPLQzC3QWbzCN9e5USvKIYdzXi3pq5pz+bw5JgZhmWU7x6hmXjPnYrMkhrBUqP+ITPtel4pG
	1YzkcT6+km9p7CRiKJm3JVC8iih4PpnDYOm8IonnvY3nVInMWk2A6GHSIw+7TM09vEgsZJ5lY79
	YhEWDZC2Pv+s0p2yCCRubMkvdv0x3l5p58B6Uga9Qam1zxIg9mWPrGvHM9M7QV0fmZqMtri739G
	jL+twBWRApqa+oMUb1JK6P/ePDNVE0LfUInKH/n8t8chfNpGrQwXnir0kVvcuknUCtiz61MxnXO
	8OQlDCVm2x+ODW/I0Pb12kRcQR1ytn73BtqgEEY9AfOvftPpxx44iQPARcVH9A3i0/9VQ=
X-Received: by 2002:a05:6a00:414b:b0:829:7a15:9b96 with SMTP id d2e1a72fcca58-82d0dbd3ad4mr1167756b3a.54.1775176501888;
        Thu, 02 Apr 2026 17:35:01 -0700 (PDT)
Received: from localhost.localdomain ([45.114.151.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca14b3sm4990500b3a.54.2026.04.02.17.34.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 17:35:01 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	newajay.11r@gmail.com,
	xiang@kernel.org
Subject: [PATCH v5 experimental-tests] erofs-utils: tests: test FUSE error handling on corrupted inodes
Date: Fri,  3 Apr 2026 06:04:52 +0530
Message-ID: <20260403003452.4626-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401075504.88389-1-nithurshen.dev@gmail.com>
References: <20260401075504.88389-1-nithurshen.dev@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-3183-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 3C5E238F84B
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
1. Creates a valid EROFS image.
2. Uses dump.erofs to dynamically determine the root directory's
   inode NID and metadata block address.
3. Deterministically corrupts the root inode by injecting 32 bytes
   of 0xFF, invalidating its layout while leaving the superblock intact.
4. Mounts the image in the foreground to capture daemon stderr.
5. Runs 'stat' on the root directory to trigger the inode read failure.
6. Evaluates the stderr log to ensure no segfaults, aborts, or
   "multiple replies" warnings are emitted by libfuse.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
Changes in v5:
- Removed hardcoded offset 1152 and /dev/urandom logic.
- Implemented robust dump.erofs parsing to dynamically calculate 
  the exact root inode offset.
- Replaced the corruption payload with a deterministic 32-byte 
  0xFF sequence to guarantee i_format invalidation across all shells.

---
 tests/Makefile.am   |   3 ++
 tests/erofs/099     | 106 ++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/099.out |   2 +
 3 files changed, 111 insertions(+)
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
index 0000000..f34403d
--- /dev/null
+++ b/tests/erofs/099
@@ -0,0 +1,106 @@
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
+[ -z "$EROFSDUMP_PROG" ] && EROFSDUMP_PROG="../dump/dump.erofs"
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
+# Dynamically determine the inode offset of the ROOT directory (/) using dump.erofs.
+META_BLKADDR=0
+BLOCK_SIZE=4096
+
+META_STR=$($EROFSDUMP_PROG $SCRATCH_DEV | grep -i "meta_blkaddr" | grep -oE '[0-9]+' | head -n 1)
+[ -n "$META_STR" ] && META_BLKADDR=$META_STR
+
+BLK_STR=$($EROFSDUMP_PROG $SCRATCH_DEV | grep -i "block size" | grep -oE '[0-9]+' | head -n 1)
+[ -n "$BLK_STR" ] && BLOCK_SIZE=$BLK_STR
+
+# Extract the NID of the root directory
+NID=$($EROFSDUMP_PROG --path=/ $SCRATCH_DEV | grep -iE 'nid\s*[:=]?\s*[0-9]+' -o | grep -oE '[0-9]+' | head -n 1)
+
+if [ -z "$NID" ]; then
+	_fail "Could not parse NID from dump.erofs output"
+fi
+
+OFFSET=$(( META_BLKADDR * BLOCK_SIZE + NID * 32 ))
+
+# Deterministically corrupt the root inode's layout by writing 32 bytes of 0xFF.
+awk 'BEGIN { for(i=0;i<32;i++) printf "\377" }' | dd of=$SCRATCH_DEV bs=1 seek=$OFFSET count=32 conv=notrunc >> $seqres.full 2>&1
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
+# Attempt to stat the root directory to directly trigger getattr without a lookup.
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


