Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A321948C93
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 12:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722938839;
	bh=kwkiJ1lNi4hls3SmDSCczz9y9QcS5IyD1HENBRZAL6k=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=gYngj2Ph+mU1fBDRSOhUCyhfZtl00ThGW7xfCYtBoCHgyPQzQX21qYK8S1Y1q0zzg
	 bOjvJBBMlQTSzaG76oqRJYGFJcAeFgzyBBN7PyUlLqASyCoE1g0MoIkZxL+zP5js/E
	 VRqisWRVBO7/wmsRaHzDsMwg1gf5hpvWU9JRaIq2Hcj+ZIpFTjiUAOE20PmFwDH4Lt
	 nYYhKENmVKyBWnysu9PQJAgNpxSQ+MZ+lTHHWyRHn4r4vN9i+Qf6WA0tkC8PEE0AW9
	 /s18lifzus2XXFWivUwkdsTFXKuoMNlggk8EF34F93avcEytCQtna2qv72eXcAdnrl
	 8QVChySWjtrWQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WdTWC3Mcqz3cXV
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 20:07:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=162.62.57.210; helo=out162-62-57-210.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3392 seconds by postgrey-1.37 at boromir; Tue, 06 Aug 2024 20:07:05 AEST
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WdTVx49PZz30T8
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Aug 2024 20:06:57 +1000 (AEST)
Received: from kyrie-virtual-machine.localdomain ([36.7.196.21])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id CFAE608; Tue, 06 Aug 2024 17:03:15 +0800
X-QQ-mid: xmsmtpt1722934995th3a4owe6
Message-ID: <tencent_0AD6FCF0EDA0644C00A48AEFCC344D0B8306@qq.com>
X-QQ-XMAILINFO: NAuAIaytDrXpXOm3TdgIlMWnN5QYeofBmSr8z+v5NLUl8wfvf60Mh9dCCZvWtw
	 OlEeuSeMDuECRs7ugX8nJ3y9f8zFHMuejtDR3Mp2i7aps8vnP80hdVl54U7D5tDCWe3hU1X2KGjh
	 lJQ2L9UVnd8tt0Y/ZkP7102aWZkG1a28RUtEa7EQdFL5fY3yA6clcUo8xABlr53HR0DzO+QBI/7j
	 JgtJgd0wiQ2EXU1VH7X28AX+2eKL1UxQOKJeTdUIC7AvHP817kcPCsgsuNWnKGKHOpZzEVNX4O0e
	 Y6Bul5oS6YRXbWHhD2iL1vfJaN+IU7E9zFt+ryd7mZnbckk+iUGwYpscYD2K+eDYl5tQNp86a/oE
	 3Ac8j4vPbpWJMeUmOCZCEFE72GfNKkO+TjUcUbcGjOlTWZvulTKm6txa1OBrglwT7XcxRZpXHZpi
	 ek52GyVOuMB6FJDf0WoFcC/mI0CnlCnYtdHQrsy1rxTmfutWlnY0bHVx1uL3BCowfZmLLffnX7oU
	 HFJUOC8BCAWXoLS9f0LN2w4yG4KUQb1vREVqLSGhEIciLV1ln8K8jsdEyZ372moz92MVxsbjx/pS
	 39VzaIMlOSz8BV2uEmE10LNVIBpBr2MdG5nvmQPEkVBy2ggiCfGoA4u9eslR8Y8X2etKCxhBYlct
	 I7i/WGC14zAGfVVRtKCyWH7YHTrWrc8ZN8X0lKjRH8ruSJOkulKOJh7PKYZqfdUNFrGStBr3GJEL
	 +ilkeOtKH12TvE9itN4zLaEXNcMbtWuovcqkdt1Wi7Ggt4i2eVDG6m6uBia8wLkZa8mJefZyrR3t
	 SkRAgTfLwbi+UkT5i2aETgbsWHnAffu+prglw2tl3XeKoPW6WpHsZ4WPZu0ElRZyj4Rvp6ijTWIS
	 8HxQ78l3NR9kz9iQeKUrWglgsI7NecK1E04wMviJqLzK3XYvvFepu1t5cnT7pZOlgWccUCMpvLrE
	 3OrKfamgXJRQ6WVFIVn7g3OHY4RHeoK9yJih+P7cssnGeGZjyNoN7NskAAiwRFA0NZcBAoGmNvmO
	 Q5S1lrxMVbeXpnxoh4
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tests: add compression algorithms check for tests
Date: Tue,  6 Aug 2024 17:02:48 +0800
X-OQ-MSGID: <20240806090247.1633248-1-kyr1ewang@qq.com>
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

