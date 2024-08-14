Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7E951B54
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 15:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723640610;
	bh=kwkiJ1lNi4hls3SmDSCczz9y9QcS5IyD1HENBRZAL6k=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=R74VtzpEK3K8jzHtxf5kcOZn/C7yWv9gkWzobt8WOrD89EzXLrQatxqMG7gocEUdw
	 teOmsGbEqi3y+PdztAdjLfQMoi0IM/VfVT2lzw57pd4xZCwKJeBK3aSiPfqsByN+pJ
	 21L3+QW/k6Ee/FH9Gqx5KcQmlp7jKDQHn6hZ/ryY2VByDZaNYjykziJNTjZLs3+yjV
	 GvoXWgR7cUW6Nv0nw0Z6QCmZe+9WMriBg03VU1hcIdcWaiUChAj2o2mZZLvrPzyKSk
	 EYUdWgxOYnebu4kLKLvLTSSMa1lWNIQ6ugI5/PKL06u1KssZtk49r4sc2zzVR/oMiN
	 /ZWHE+mcXpSVw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WkT2p5MWjz2yWy
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2024 23:03:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=43.163.128.53; helo=xmbghk7.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1497 seconds by postgrey-1.37 at boromir; Wed, 14 Aug 2024 23:03:18 AEST
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WkT2Z61Cwz2yJL
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2024 23:03:02 +1000 (AEST)
Received: from kyrie-virtual-machine.localdomain ([36.7.197.226])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 73A6AA3; Wed, 14 Aug 2024 21:01:51 +0800
X-QQ-mid: xmsmtpt1723640511tu9kxddh9
Message-ID: <tencent_8101E12AB933BB347A0CF8F326B773927C08@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCl//BRDov21e8EwA8Rf+vx2NyHGrA9bdpVM3ZKUCICHB4LVCndQ
	 YfmYRq/0OcO3xfpFanJNEbhQvCyEliZopo4chmDox9yUFf7C2luvGNyPtsD3c2KtpWL/0/zinz34
	 7rYxFAuPBaT+LJHn12FQz3p96esh/47KSoorTFLM5OHH4zPZLZG8gtk6SXwM9oBWs3el3r4CLg40
	 Hl6tizySpeYCiUC81gTZNZ5Gl7CCfXwwylZ7eT0ZN8y+WMUnlYXMVEFuIZb7P1rRNe1dCL+6OB5R
	 xmNovY+286ikWMDIcOhh/VuEGkfaFHj7K9K+gX4A568S+sEB+UwfXFU7IvCa3X4eI2RUlDAAgcrE
	 XKaK4jAifbhPAdFhtRHjQs7PbJG35iyGNJ9kO82cJXBxpYVYRmkNrKem6ptV3fUy6v6h9yLQKtqq
	 yPcFC9+tKIONn8YUbMm/n/tS/KfScv7f0fxZiggkWdUxPZYrsjKEbBR9awvjxe2+HiE4q3Om1iLy
	 +m5D9kGUHXS4gYfbEs7i4RNxRnBd0jLQbNY/oWCPFfDQkhPv28E5vT8OkAYcj8f+U0GaA73BF1N/
	 Dfaz/5IzT78euEzxCT8LWHaTB2zl7/7fU6Z37IUMoge1rFaJ6V+JYSn+C1Tqy53C1SqaapFWFRi3
	 mOHTT0GBCSHcJrmdY2nd7mmLC5xvmZ+IeI+9tDvKKrHL8D2Y5nbbfIfY/LcaqICpbpcFwaP8AtAK
	 y590NWlc7wLFE8NsUcKNdhQWe11FDMW3hw6/F56CJfA/BS5IOxtGu/Bw6GmnZ8SLpYgNjojvGoBK
	 6Ry9xIqKhl2vw5Xbwl5jsSB5vw6/iXIyhskaxBjKvwvPguAMcEug0mmItlkhN2fB2EMWzNT/k/jO
	 IwEoK+Vi+BYy/KksIhUXb3PZeBqpy7MwEq71WTikQ/sV6lgsHjb6+7Wz91xMuMHY2rYlSlKx23mF
	 wl7yXYqlzwEoGtQIu4PbSnaG5PNKHecL1oM/EoQRZhqsmjGeh/yRKVDEbbjBmgaLg7AT13wdFFzC
	 jNWG1d9BPIYbFkerOfKlkuimH2UUtDZiPpxsuYqpx/vm7v10pU
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tests: add compression algorithms check for tests
Date: Wed, 14 Aug 2024 21:01:10 +0800
X-OQ-MSGID: <20240814130110.2016351-1-kyr1ewang@qq.com>
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

