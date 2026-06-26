Return-Path: <linux-erofs+bounces-3764-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EaGAMDnpPWqo8AgAu9opvQ
	(envelope-from <linux-erofs+bounces-3764-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 04:51:37 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B56C9DEF
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 04:51:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gdYdaqvz;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3764-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3764-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmgDP5gZfz2yYf;
	Fri, 26 Jun 2026 12:51:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782442293;
	cv=none; b=Pxiu89pwsaR/s0cMcbQJR7J+7TJ3vh2Rhuc/Hai7aNuc+QX7n6thcMeTex1gwTzzck60Hjqaur+RX4H3bl+nJD87WibX2GrzAsdghtJ85UqdFkPbAMn3PJ8fXgBdsdEnNEaBxZknSxEe14rVDExFC6wkq1Y7CBQa2BY6MQsobF34e7EfFU+t/PvHKP7ai+aUfTLqWdNn9mA6Jb6N0QJ+JFyblTe4qicKJIMDe9i/h2pyG68J5iSQ4JvjUVcArHOBL+eWdm/phURao58sMtih4xjFIPezncTAnvCOByqchXaQQth+8ja1TDx4S0oI7tzcdZsBDjIGnh/25oujm/XxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782442293; c=relaxed/relaxed;
	bh=EG93Ng9Q+rN0wEMugxc1J36+onoM71B+rz0iIBYZalM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwL/Cc9WkAcnhsrVhcpHWNgeU+8F3x3naCkLIAlNbCGd3i19vRN/GuEa619HbPrUM22JCYh0joMVRW5g9eodpObNo7ZLfGHYGYOhScuQuiDzK5z4vCmtJwyGK8EmI5bigBPaPkFV6X28WIQYT1t1UWGrqZ+Fvp43sDHeHoA3lHdI3Sh0JIC8bFGgFlOOlP8nNOvBYQixqwVWj+iRaJejPWj3Dblk60TXKks9cuzsGB2tj+8vsQA95gyLhb8jpYN+dJFsJ9Z+P1E3DV+T+mwOGF7juPeHN8UMYJMAK4o2JnskjW4n/XvhqTRb9gSPW7SNHJsKKO9U8xUqwpnsvocg4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gdYdaqvz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmgDP0RJ0z2yVv
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 12:51:32 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-37da8b5540bso309093a91.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jun 2026 19:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782442291; x=1783047091; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG93Ng9Q+rN0wEMugxc1J36+onoM71B+rz0iIBYZalM=;
        b=gdYdaqvzbgZTpm76nJzhhW8y2j6h/D71MOx39BNMGCMnvgLbJWG56QnfU9fQDXTRbz
         brAkN9bTVxcqiiAQhW9w1dkvqf/pLs1UBBUMWyeob7aLyPDfvAT8xY+4yEDT7jxTa/ad
         H/SVLaNryHcb5LuaNeWgmzjGgQuS61lc+gnDJeFWEVdlRFh+FrxxpH3ru8Bxd7E8A7q7
         70Ow77yVR21DhTXlLWgITKW1vYGkjE9eTAKOBPz8aDlFIb2kivRP0shMwj+YKiVNtJvL
         Fz03WNJo/ZrHigCHiU+vmPuZfVKGHVPHOUFaSVXCYScrlGiZss2GnApV0rFE7fBUdsb4
         QOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782442291; x=1783047091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EG93Ng9Q+rN0wEMugxc1J36+onoM71B+rz0iIBYZalM=;
        b=MVVx5HnQQ+6yq9nKDMJyzoW0d2GbGOqQYWvyeut8veBIFHIeHkXXsFWs0ID6u5HDk/
         klQegNJ9Rc3Hy35silHKp/AArbKs4PufR06H5XIjr5Bb7hrGNxftEgX9qL3xxbSheygV
         ckjunGCE2NJe9KknG0tuuf/MwZQuCeQwbpRW2hwWoXHNVuB5w0Fll3W4csjmzG3EcuFr
         Gd4y4aLSVxmZ/DCGgV4xWJN8Q/LaEWyGu3t2Et2JP9fwxFvwtdCOTiHbmdANULJQYXyr
         YvG7hyCehZgnDmIK1Tp95s7FSSh8/LqhRmypt3I6IJ+mQmgo1yFxwV3YevHdJWBZ/LHl
         +QgQ==
X-Gm-Message-State: AOJu0YxAgD2uVLIu7xDSZYrebyGv2gsdHXtguC521m9wCAviR6pg8EGC
	ugxSXDl41vJRx9RI5jrw8uSQxjqB09Doq5E3rKoWifEEiK2GR9qLcnJUbXHqt2KvWR0=
X-Gm-Gg: AfdE7ckyacY+Ljyh/IpkO/r4Ec5MelXYwTOk/hcSbmwP8O4003eCrssRBx89UqHodp3
	ISzTCd42HIAUC5TH4we9srjPlniGDOXz1zIjQRn0I92PwxG8Lx4gr3wA7fdCxAtZJheyRPes1CJ
	J1C8inMETUv9czlQrVcNWEruRlep7F4GDOhsEELoxmgvMQJgdRhynaf+nZBfBiTy1d7W/5Za78J
	dAvrQ4cToc/otNIpPnd+NnI1SBEO+8qMpQ9aZ54X6R6pePXMg7a17KInPdyZhwqavnO253rOzDO
	Bm2FDL0vh+6yaFeftgvfNKhsLNByy9HhN+snQFDinilSC8H2jtpHtYhDyCUgBkRvtM0Q0+cIAl/
	9inDaQ1wMUia10VBUeDdSDrBzJLaGjGuA+9iaDi2mKh3rMYTMM9nKvrRW9frVUDnT4lNl9EyIEW
	9YLk+w6IVY7Kpi5dVIoCWf1SSH7WTAQ5ZbUWBFtS95igX9WbFtVg==
X-Received: by 2002:a17:90b:52c4:b0:37d:f331:35d7 with SMTP id 98e67ed59e1d1-37dfa29a0dcmr5181246a91.23.1782442290757;
        Thu, 25 Jun 2026 19:51:30 -0700 (PDT)
Received: from ZYF-PC.localdomain ([124.70.231.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df3b6788csm2876863a91.16.2026.06.25.19.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 19:51:30 -0700 (PDT)
From: Yifan Zhao <stopire@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Yifan Zhao <stopire@gmail.com>
Subject: [PATCH 2/2] erofs-utils: tests: add multi-device chunk read regression test
Date: Fri, 26 Jun 2026 10:50:25 +0800
Message-ID: <20260626025025.805563-2-stopire@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626025025.805563-1-stopire@gmail.com>
References: <20260626025025.805563-1-stopire@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-3764-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[stopire@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D12B56C9DEF

Unfortunately, erofs-utils currently lacks image injection support,
so the test has to hard-code the relevant offsets.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <stopire@gmail.com>
---
 tests/Makefile.am   |   3 +
 tests/erofs/032     | 135 ++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/032.out |   2 +
 3 files changed, 140 insertions(+)
 create mode 100755 tests/erofs/032
 create mode 100644 tests/erofs/032.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index a1e31fb..3c41eb3 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -132,6 +132,9 @@ TESTS += erofs/030
 # 031 - test chunk-based inodes
 TESTS += erofs/031
 
+# 032 - regression test for buffered reads across device chunks
+TESTS += erofs/032
+
 # NEW TEST CASE HERE
 # TESTS += erofs/999
 
diff --git a/tests/erofs/032 b/tests/erofs/032
new file mode 100755
index 0000000..416ff5e
--- /dev/null
+++ b/tests/erofs/032
@@ -0,0 +1,135 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+#
+# Regression test for buffered reads crossing EROFS device chunks.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
+
+# get standard environment, filters and checks
+. "${srcdir}/common/rc"
+
+cleanup()
+{
+	[ -n "$mnt" ] && $UMOUNT_PROG "$mnt" 2>/dev/null
+
+	for dev in "$meta_loop" "$dev1_loop" "$dev2_loop" "$dev3_loop"; do
+		[ -n "$dev" ] && losetup -d "$dev" 2>/dev/null
+	done
+
+	rm -rf $tmp.*
+}
+
+_require_root
+[ "$FSTYP" = "erofsfuse" ] && _notrun "kernel EROFS is required"
+_require_erofs
+which losetup >/dev/null 2>&1 || _notrun "losetup is not found"
+which blockdev >/dev/null 2>&1 || _notrun "blockdev is not found"
+[ -w /proc/sys/vm/drop_caches ] || _notrun "drop_caches is not writable"
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+chunk=4096
+localdir="$tmp/$seq"
+src="$localdir/src"
+mnt="$localdir/mnt"
+img="$localdir/merged.erofs"
+blob="$localdir/blob.bin"
+dev1="$localdir/device1.bin"
+dev2="$localdir/device2.bin"
+dev3="$localdir/device3.bin"
+expected="$localdir/expected.bin"
+affected="$localdir/affected.bin"
+actual="$localdir/actual.bin"
+
+mkdir -p "$src" "$mnt" || _fail "failed to create test directories"
+
+emit_byte()
+{
+	dd if=/dev/zero bs="$1" count=1 2>/dev/null | tr '\000' "$2"
+}
+
+write_at()
+{
+	printf '%b' "$1" | dd of="$2" bs=1 seek="$3" conv=notrunc \
+		>>$seqres.full 2>&1 || _fail "failed to patch image"
+}
+
+setup_loop()
+{
+	loopdev=`losetup -f 2>/dev/null` || _notrun "no free loop device"
+	losetup "$loopdev" "$1" >>$seqres.full 2>&1 || \
+		_fail "failed to setup loop device"
+}
+
+emit_byte $chunk X > "$src/mem.bin" || _fail "failed to create source file"
+emit_byte $chunk Y >> "$src/mem.bin" || _fail "failed to create source file"
+emit_byte $chunk Z >> "$src/mem.bin" || _fail "failed to create source file"
+
+emit_byte $((chunk * 3)) A > "$dev1" || _fail "failed to create device 1"
+emit_byte $chunk P > "$dev2" || _fail "failed to create device 2"
+emit_byte $((chunk * 2)) B >> "$dev2" || _fail "failed to create device 2"
+emit_byte $((chunk * 2)) P > "$dev3" || _fail "failed to create device 3"
+emit_byte $chunk C >> "$dev3" || _fail "failed to create device 3"
+
+emit_byte $chunk A > "$expected" || _fail "failed to create expected output"
+emit_byte $chunk B >> "$expected" || _fail "failed to create expected output"
+emit_byte $chunk C >> "$expected" || _fail "failed to create expected output"
+
+emit_byte $((chunk * 3)) A > "$affected" || _fail "failed to create affected output"
+
+"$MKFS_EROFS_PROG" -T0 -Eforce-inode-compact,nosbcrc --chunksize=$chunk \
+	--blobdev="$blob" "$img" "$src" >>$seqres.full 2>&1 || \
+	_fail "failed to create chunk-based image"
+
+# Convert mkfs' single blob-device image into three blob devices whose chunk
+# block addresses are contiguous.  A buggy kernel can merge the buffered read
+# bios across those iomap/device boundaries and read A/A/A instead of A/B/C.
+write_at '\003\000' "$img" $((1024 + 86))
+write_at '\030\000' "$img" $((1024 + 88))
+write_at '\000\000\001\000\000\000\000\000' "$img" 1408
+write_at '\000\000\002\000\001\000\000\000' "$img" 1416
+write_at '\000\000\003\000\002\000\000\000' "$img" 1424
+dd if=/dev/zero of="$img" bs=128 count=3 seek=24 conv=notrunc \
+	>>$seqres.full 2>&1 || _fail "failed to patch device table"
+write_at '\003\000\000\000' "$img" $((3072 + 64))
+write_at '\003\000\000\000' "$img" $((3072 + 128 + 64))
+write_at '\003\000\000\000' "$img" $((3072 + 256 + 64))
+
+setup_loop "$img"
+meta_loop="$loopdev"
+setup_loop "$dev1"
+dev1_loop="$loopdev"
+setup_loop "$dev2"
+dev2_loop="$loopdev"
+setup_loop "$dev3"
+dev3_loop="$loopdev"
+
+$MOUNT_PROG -t erofs \
+	-o device=$dev1_loop,device=$dev2_loop,device=$dev3_loop \
+	"$meta_loop" "$mnt" >>$seqres.full 2>&1 || \
+	_notrun "this test requires EROFS multiple device support"
+
+for dev in "$meta_loop" "$dev1_loop" "$dev2_loop" "$dev3_loop"; do
+	blockdev --setra 5120 "$dev" >>$seqres.full 2>&1 || \
+		_fail "failed to set readahead"
+done
+
+sync
+echo 3 > /proc/sys/vm/drop_caches || _notrun "failed to drop page cache"
+
+cat "$mnt/mem.bin" > "$actual" || _fail "failed to read mem.bin"
+
+if cmp -s "$actual" "$affected"; then
+	_fail "buffered read merged across device chunks"
+fi
+
+cmp -s "$actual" "$expected" || _fail "unexpected data from device chunks"
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/032.out b/tests/erofs/032.out
new file mode 100644
index 0000000..34e059f
--- /dev/null
+++ b/tests/erofs/032.out
@@ -0,0 +1,2 @@
+QA output created by 032
+Silence is golden
-- 
2.54.0


