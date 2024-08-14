Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 86222951BCF
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 15:27:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723642018;
	bh=kwkiJ1lNi4hls3SmDSCczz9y9QcS5IyD1HENBRZAL6k=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=HBsGi/x5xJGjW6LXXG3jqczMVa2xFzpEYHG0rOfF9GGv0lzS5wICEXbxuAa5Fsg0w
	 s/1hov7bV/ARQOA5SaRcA0+A+lu0/d7/tUQ0NwkCEGsXkmmZBwmNGRXZS/xzCSRzj/
	 0aXdpB/sLqjY11eCt5wiEU2kUjqqtxfdAsNlEP/AyAu3LsqWFyKa6rv5rCWvjppD/M
	 OhKKJ0tuvGFkBSVRuh0ko/WL5pog3EAnqFd2EyHDnsahk2smEaVwIPz+tFMMpHD0e3
	 xqM9mz8vJRSYutW4Ge/vQC6RCtd4yf6CAqy0D27V8lmsPwcpEdux8Y2A/KfXpk2hVI
	 XYF/lZn8BAf8w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkTYt1RShz2yWK
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 23:26:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ftkSKIrm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.231; helo=out203-205-221-231.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3768 seconds by postgrey-1.37 at boromir; Wed, 14 Aug 2024 23:26:47 AEST
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WkTYg6wQhz2yDk
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2024 23:26:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723641984; bh=kwkiJ1lNi4hls3SmDSCczz9y9QcS5IyD1HENBRZAL6k=;
	h=From:To:Cc:Subject:Date;
	b=ftkSKIrmrghpyq59tPPQMYgcz33lbYdBplOJ5SimTZ+7xDpx5VCWSVuCOb0d0DhGP
	 Fpx0ZiQ28G3JCqKsEJZJUk6McGvfCgZDI1K2No/pQE/9Y+aahykxtMfaJxu4aSocq/
	 sdaLe7m2uq59clYVd22/yrYAx2A+nGChLHTL8ieU=
Received: from kyrie-virtual-machine.localdomain ([36.7.197.226])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 5A486A99; Wed, 14 Aug 2024 20:22:36 +0800
X-QQ-mid: xmsmtpt1723638156t30kvx9vc
Message-ID: <tencent_4CCC2DAF246C00A80AC80C31CD2603EAFC06@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0ag/paPV7i3d/r1654CtPmbDdm/pMN/hPUczB1oDWfQDT0YfR0nd
	 Zb22cRnV7TvIecCUSJZBhA2T66FpQj/KQSvyDx6gZArn+wz4uIyLtkjFoT5unsNmobf8nVIMKFRl
	 /Jt2WUpPPbB4DvHDXjN/8v17HlVVbm7w8Irw6qOi/S+56I7vBRpqw1/xBUh5ukMK93m030Eo4noQ
	 HX5WqFLD4LdPXgU+SzpoXktVSwbAWtn3rNaj5TrTSDWuDfQL8okl2ovGkPVpCdJ3X51GPa/lvlwQ
	 DyqwsY484cBYi1THk5K5aspOMOpJXKDk8aUiOfz+k8WDMU0qnCu7HbfkX/BBrQXwhUvSCm3WQO3n
	 t34j0Qj7vSinWZGw19oJO3hwtp8vBcL1HTAKRMf/pq049tNour4kvoMRgk6GO9yX52rpz+Z4NmEG
	 5/lJxWeNWkWYlzGMvmhlUx/qjysGO539g8B1uMWvzfjwPl4d0FBhKAoqvtyvxZKcKA0eW5bswLO+
	 UmFektp/O+UZZRyb0yqJiLNrCinxBOuEhgawYg1OeQRQFzoBXqanvEDDpaJESuZD/iFLr86scv5E
	 6hK+Iabmcd4UJBItkwFslz8Fm9Hxxwk2QhPq8Q+TPNKAPS+ssmECUfKwBZYlYFpjBMxkCXpG3xUO
	 hGD/rRiSfcCSKfFQ3v4LhZj+QaONvekFl6BhvB4dPNMvALmDyrA/9bLEBnPbYqXbxbR9WKobVdIu
	 0orlEXzAuXVcg7EGK66aMA7t1XbT+Af9c3W/47FX1+2QZF5LtVpL/Vm0S8rKmsCtFWNPwedG9ZyR
	 UvA6FDliyLmWWsGthOg5MUvLG17Ju4qC7f0XJr/+6l03PnvXfToFAne/x1IwOZV9H5tMxLkrqwwW
	 Xwz0zeLj2cy355fwaUSfSmDXqvnuJP/hVg+K86xoIPBgf6chRTxsDPvazOEjcAvTboE1hOAztVUo
	 uMwYTMBO3dZjbdiMnluzjB76mCtPliygDIdENGIRNomgQV+Ce0MA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tests: add compression algorithms check for tests
Date: Wed, 14 Aug 2024 20:22:32 +0800
X-OQ-MSGID: <20240814122232.1982499-1-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
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
From: Jiawei Wang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jiawei Wang <kyr1ewang@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

_require_erofs_compression is added to check whether the compression
algorithms are supported in the test environment before starting tests.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 tests/common/rc | 16 ++++++++++++++++
 tests/erofs/008 |  2 ++
 tests/erofs/009 |  2 ++
 tests/erofs/010 |  2 ++
 tests/erofs/011 |  2 ++
 tests/erofs/017 |  2 ++
 tests/erofs/018 |  2 ++
 tests/erofs/024 |  2 ++
 8 files changed, 30 insertions(+)

diff --git a/tests/common/rc b/tests/common/rc
index 0ace9d0..1c3f1d6 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -148,6 +148,22 @@ _require_fscache()
 	[ -x $CACHEFILESD_PROG ] || _notrun "cachefilesd not built"
 }
 
+_require_erofs_compression()
+{
+	local opt="$*"
+	local random_dir="$tmp/$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)"
+	
+	mkdir -p $random_dir/test $random_dir/mnt > /dev/null 2>&1
+	truncate -s 1m $random_dir/test/file > /dev/null 2>&1
+	
+	eval "$MKFS_EROFS_PROG $opt $random_dir/tmp.erofs $random_dir/test" >> /dev/null 2>&1
+	_try_mount $random_dir/tmp.erofs $random_dir/mnt || \
+		_notrun "fail to mount filesystem in _require_erofs_compression"
+	_do_unmount $random_dir/mnt
+    
+	rm -rf $random_dir
+}
+
 # Do the actual mkfs work.
 _do_mkfs()
 {
diff --git a/tests/erofs/008 b/tests/erofs/008
index aa8ba1d..cd3929c 100755
--- a/tests/erofs/008
+++ b/tests/erofs/008
@@ -27,6 +27,8 @@ echo "QA output created by $seq"
 [ -z "$lz4_on" ] && \
 	_notrun "lz4 compression is disabled, skipped."
 
+_require_erofs_compression "-zlz4"
+
 if [ -z $SCRATCH_DEV ]; then
 	SCRATCH_DEV=$tmp/erofs_$seq.img
 	rm -f SCRATCH_DEV
diff --git a/tests/erofs/009 b/tests/erofs/009
index 2ce0e0a..b3ad210 100755
--- a/tests/erofs/009
+++ b/tests/erofs/009
@@ -27,6 +27,8 @@ echo "QA output created by $seq"
 [ -z "$lz4hc_on" ] && \
 	_notrun "lz4hc compression is disabled, skipped."
 
+_require_erofs_compression "-zlz4hc"
+
 if [ -z $SCRATCH_DEV ]; then
 	SCRATCH_DEV=$tmp/erofs_$seq.img
 	rm -f SCRATCH_DEV
diff --git a/tests/erofs/010 b/tests/erofs/010
index a4f4180..2782fb6 100755
--- a/tests/erofs/010
+++ b/tests/erofs/010
@@ -27,6 +27,8 @@ echo "QA output created by $seq"
 [ -z "$lz4_on" ] && \
 	_notrun "lz4 compression is disabled, skipped."
 
+_require_erofs_compression "-zlz4"
+
 if [ -z $SCRATCH_DEV ]; then
 	SCRATCH_DEV=$tmp/erofs_$seq.img
 	rm -f SCRATCH_DEV
diff --git a/tests/erofs/011 b/tests/erofs/011
index 945998b..bd5d933 100755
--- a/tests/erofs/011
+++ b/tests/erofs/011
@@ -27,6 +27,8 @@ echo "QA output created by $seq"
 [ -z "$lz4hc_on" ] && \
 	_notrun "lz4hc compression is disabled, skipped."
 
+_require_erofs_compression "-zlz4hc"
+
 if [ -z $SCRATCH_DEV ]; then
 	SCRATCH_DEV=$tmp/erofs_$seq.img
 	rm -f SCRATCH_DEV
diff --git a/tests/erofs/017 b/tests/erofs/017
index 0ba391f..9e7553c 100755
--- a/tests/erofs/017
+++ b/tests/erofs/017
@@ -27,6 +27,8 @@ echo "QA output created by $seq"
 [ -z "$lz4_on" ] && \
 	_notrun "lz4 compression is disabled, skipped."
 
+_require_erofs_compression "-zlz4"
+
 if [ -z $SCRATCH_DEV ]; then
 	SCRATCH_DEV=$tmp/erofs_$seq.img
 	rm -f SCRATCH_DEV
diff --git a/tests/erofs/018 b/tests/erofs/018
index b6de58d..47b8d52 100755
--- a/tests/erofs/018
+++ b/tests/erofs/018
@@ -27,6 +27,8 @@ echo "QA output created by $seq"
 [ -z "$lzma_on" ] && \
 	_notrun "lzma compression is disabled, skipped."
 
+_require_erofs_compression "-zlzma"
+
 if [ -z $SCRATCH_DEV ]; then
 	SCRATCH_DEV=$tmp/erofs_$seq.img
 	rm -f SCRATCH_DEV
diff --git a/tests/erofs/024 b/tests/erofs/024
index e2cbeba..f477c04 100755
--- a/tests/erofs/024
+++ b/tests/erofs/024
@@ -27,6 +27,8 @@ echo "QA output created by $seq"
 [ -z "$deflate_on" ] && \
 	_notrun "deflate compression is disabled, skipped."
 
+_require_erofs_compression "-zdeflate,9"
+
 if [ -z $SCRATCH_DEV ]; then
 	SCRATCH_DEV=$tmp/erofs_$seq.img
 	rm -f SCRATCH_DEV
-- 
2.34.1

