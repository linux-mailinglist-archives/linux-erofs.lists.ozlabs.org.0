Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832E97C312
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 05:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726715533;
	bh=HW8fxmTF9tFjRSd2BJSF1bFunrYTDD4tstRDNoCNXvg=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=HFNk4F0yxCdJEk90DOCTqvuH0Qd9u5ey6zLVsG5x/1zI2Pxb44PvjeTuWNGtMImmX
	 UqJpFHeWolDalC/U0RynfJy+mVaI8dYxad8J4CupVwDSrFh1gdHZJxPK1HXNiodPTz
	 YBIz/jmNcliGPpcDlw6+LvKKlCp+UjUgAiDvRcsFwek/CmNZBZ9uqwLvAGsjTQmL3I
	 Ikt/sy0JI6GaG9fQxiYx4539T2319/HAXJI8OkZ1T+tPtKAQvkjLqChxl+2/coPG7r
	 7PjOvjrZeOh+6091wOsSQ6G8yrA02s7z6iLpsHAduv/xErwPFVuydgv72qprnfiEJL
	 cNFY98ODGo+Zw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X8LCx4qTsz2yGC
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 13:12:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.202
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726715531;
	cv=none; b=H4b7cLu1MW9zLptML3OF/Qt/ZBoRP7IEZWzAf6/XSBC0jMKOlJUVZqtyZLKOSQUxzHWE87SOOue0IkhRPYss3C38DCFF2DCp0q/08y5lavWaaiJyzEqr3w3N1ABL3lHLdsfvgecgvBcjXR7kzctNtVelvxBWqXdQPIOL+nNpoP3N7XaHTbdhc6+o/QxtJqiPKfWNBgZgJD/4tyuxpAKkyfIMPb48yv0RUUU3BBkbh0nNwv5NkkjS5YhyLtf+V19TREBT4kLq2CMZPhAHq2pPF48ff9D7k6FplYrGwhJVUyvsIDuXfKaHE6NvFA0mwYINHpb1spwP4cEzbSnaJYWmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726715531; c=relaxed/relaxed;
	bh=HW8fxmTF9tFjRSd2BJSF1bFunrYTDD4tstRDNoCNXvg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aJfUhWzvkcgnYnvaSRfKOSfKILkuUFgnn7qXYYVagJ/kjgvtnG7SsYPSU6Uog7VWHKChqmRJhhT6tAcazqZ8HgF4JVV2CiByNFhwXqiGzyHvX+5aeYTv49Di4/BJHh2TyHZ814Dl7GaRh9BDApNPMCxmyctVYj0oFOHG2ELpHlU+rN/5fThhsF7nkQJrIot97sxq3u0KKoy/MQoFSqP67vOt0EJsqVaQwbOcEdM/W8gxYdrOLvgR7kXc2/TOHzRsSvtFqVp4PhK0xVtYQWoAZLBW97efSioD29UW3E1pR5xnd27iaEshXETfEDdJUTq0aiUI/niVhaI2IPRM2raBWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=I8B4pkj+; dkim-atps=neutral; spf=pass (client-ip=203.205.221.202; helo=out203-205-221-202.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=I8B4pkj+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.202; helo=out203-205-221-202.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4X8LCq6QS7z2yD8
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Sep 2024 13:12:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726715520; bh=HW8fxmTF9tFjRSd2BJSF1bFunrYTDD4tstRDNoCNXvg=;
	h=From:To:Cc:Subject:Date;
	b=I8B4pkj+4ufkh2gpYOppOaolu77tUHqUKpQ25BiplJMFC5VQJAGQt1pzZ8WM7Frkh
	 C8yNTyAuP5Knbi1aqbX/3WMd5vxgtDQJAAjnvre+1yI9f2YxzwvMUion9Kgxkf8h8n
	 dy9iJKhpXy0i+dN2dvjlSB447w6WKOkoXLsD++Ik=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 12E2283F; Thu, 19 Sep 2024 11:04:46 +0800
X-QQ-mid: xmsmtpt1726715086tp1wvibmw
Message-ID: <tencent_322A10338334270CD6F322B7629240016C08@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeienuUoW6dNDDf8im3myjRgwCPY+zzdR3z/Na5mWDvkgtvseovUYD
	 1FuvX7kDgpDG4ltcRIeGR0xAzCh/uZF5kJPzkrlVPXtHjxy8LRaTifB3KsZTfPLrIvLwfoXRq9SC
	 U3zFXyp/wpe0eFs50wWwSoGoS/miGZKdygk1bF5M3wttuxAfD3mKba1R6ybMdOPqE4ia+yJAMhoL
	 TlG8dss36YP+JI9IdMwZIl9VJMr+CkOeFtDIcKxRSPTi6ozmxESTKyJ9AlyMpqRYX5TMMBM1vnJv
	 ZRFWc6nRtoxCvnQogiIW/rKajSGPOSKWGkdw7dgLmOJsrQHudxCuaJzSIWKWt09AWQQy3nL8CgGu
	 KDl5iDpH5n+U4gF3vPRs1iQ2CpnU4vJ3Xs6VSJMv0voFRRhDYRMM2LmR8aQdumX+mZNKpxigZIIE
	 MRNj1xbqBDIVdgt0r7vg1e3CWsP/ftvnqDY8Ply+QeTGddv+R5Idnh2hpGRxopnvtizcT62kQiUw
	 QBhH6Mo6KyaDIrOLJuQEBfE1nJU429fDOf1gAKMFoMqIkfUOATGG8xWb7exB8iOI/oQoFy2cFUXp
	 O327FKvBpq6pHcE2u/7Lj2MVID7tRbZja+DHltroTUyG5biHu7Zj2p2GaDKcweBt+oWrvnYm7www
	 klCobm8qrvV85u4SR2x5QVGfhiTDC8XFzpSIROkQOeZaMq7li7ugkkVskhOEKdVLg80z1fXibndx
	 Hs5ztiRZdqOQRN+zJgGGJc/GzqLXJM6OnMI2BUNeHN7x+geJRaaL3fhcTv16mPAoMejUQCSIO+9W
	 czvJsg/efnOjdzeVKWCZ9UfunbnwvBgrNM+verzYSkB26yyYa0nDFu85xpTD+jN46NSFsQ4k3ysU
	 ZTLsYjke2CGUC0B1BPUmk3o50Bjvx5LPCSkqhLI479lY1LHhjPL8XamDdjFpAt87FkD8Qwbx+9S5
	 lGEIWa+cJMI9qJbZzq5eVuIhhOaf4abTaVle1YQ585jTNvLfVUfw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tests: add compression algorithms check for tests
Date: Thu, 19 Sep 2024 11:04:43 +0800
X-OQ-MSGID: <20240919030443.2796757-1-kyr1ewang@qq.com>
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
+	local random_dir="$tmp/$(date +%Y%m%d)_$RANDOM"
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

