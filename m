Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB91979C0F
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 09:33:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726471978;
	bh=tAWkBo/bN8advUaT2WI+B+lZtmn2EzEsGvCaS2uua7A=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=LG8DvyJGWPtGHMohuPBp73N06IlBMfL8+3eMiBK6A8RDu2d261f24r8ylRicNW6Zv
	 0QUxKQepOozzIZ7PY0f0tE3h6PstpNljWME9h/XQVpgzCR5ym6wRvBjqywLzzZJSlw
	 njpqm4CWJdbhX8oEHNoQXbtXFOaz3Xoieid7mV6n+1X3HniFl2o0qN4V6ZQJghvZrE
	 Ys8+q8TpVXlk99Qz0PePhzSqHcpoLMgbBeY/wXKa6a2RBpzzSwePYOCZL9/lIZYOvU
	 Rb9H5u9Ni2HR3cO8Q7Jtz25twtl3pp+vlo//otluKZ8fTQAYlX1dPPNLwGepoXnNc1
	 aill9da8w7ReQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6c8B6dHSz2yYK
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 17:32:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.202
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726471975;
	cv=none; b=HH0rm1Q/IZEm4GOkP8Kf9PQHGZ/6P2ucfgQzAToi9cRwP/aayJlMXBybS/Ku5lLaIQLjF/c5Po2B9H8Gl9ZkrIx8gX8aLCVmZUpt4s87OplRyzJGKFp04iXnsjwY8VkmXfA5QMCXeu/L/XRUzJWLCmrEqGxHG+MONxd4olhJO8XZgi+kxc1y10bMqAs75IJOg6iF3ZIMb/hBWCNXtPbnxZD1q7IS6E1QKm4dQ9Mg3/2OOiQ9VAKKy2DGvWwkzvnkGJK4Wd8CDzw0/KVVpF68RsYb3sQGL+9TX2IS4pVgUO8oXQp6VeMExJnEaaxq4ewxHkHd2CskzFMrfrgrwmKjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726471975; c=relaxed/relaxed;
	bh=tAWkBo/bN8advUaT2WI+B+lZtmn2EzEsGvCaS2uua7A=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=mSl6woWXAGF579JCb2qhecU5xyRdFMNrELyqqWA/6TfRGrQbL3h0MLdpPqwUjw4tsKnqzmrZjaTS2Fy9QewHLqIn27WggwDR31uW5RPyPzbhXRD8jwT+1YuYS6RW7aYwV2ntBA/TxqzWhPxs6rMbk9C/UkhcLI/zS4owHiFIDHTvgwcPwqiKGdNd5nDv13T0BPSYN82prlTa6cShtWOxIQ1l598nZrj7dUugLD1X4DesCXBEvWq9ODV6gjizMmHd9xbpRRGyd/sLfrAFejSDkbwGkU6aa8rDAQdhIeC1qPyz+2e+lEyeysJ8hFKprc4nmKPPhHNE30TEvoBuTGF4Mw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=WnGBIjJo; dkim-atps=neutral; spf=pass (client-ip=203.205.221.202; helo=out203-205-221-202.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=WnGBIjJo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.202; helo=out203-205-221-202.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4X6c845qbgz2xnH
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 17:32:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1726471966; bh=tAWkBo/bN8advUaT2WI+B+lZtmn2EzEsGvCaS2uua7A=;
	h=From:To:Cc:Subject:Date;
	b=WnGBIjJomuxcAS3WNIFHZh5bHc4xWs5Hk2hBYO0GtcOxGWWi74b0Xi+5MU+gauIO1
	 TRXpqBf6qbFEfPg+4oUR14L2ybgCjsaMVjbI9K6fGPBvyAPWr3vb+7zNQHRkBVa+/J
	 DrDORujhpvvKWsL+niyxH415U204WfnB+6YmvFdA=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 657A1E59; Mon, 16 Sep 2024 15:25:23 +0800
X-QQ-mid: xmsmtpt1726471523taubk53v6
Message-ID: <tencent_EE0449D70019158119071A5706D1F9C05B07@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCMbtY5uOAvJ8H6q3V1eHQ6BTzuIIi+WCTZe45ZJor+30qg05bsV
	 fCl72YnU1qPy5UUkF9mshiV19E0SRmCsu7Ym/nEt5+jgJR0VeMIJPoizFLpBPRmJneYXLY4mGs92
	 pD7wryzaeqPSgezloigzCENTQ1I75ZW1ABD/eYoZypQiFC91KC9UXGvPsYIOYVU031cz5+U1WLEa
	 kXkwe7MNjGnF1LXB9uZ0Uk5FlSrG/YZrteCCAR20yM+wBvaIg++4zUcZBQ7haA+6f09CkcHjOD/d
	 xq0IviYvkGgXEhF7utBlPzQNzr9nq23ZjpkAoXiBaoz8vuQV/5leGb8ornz7rbQL/E5UpNXtES73
	 Nrck7hyY1xXZytpA0w9y6d5Hvh8JbyCLQZONlZK2gyU7l0q6utuHX+qMxXH7M3Vy/Cj8ctu8No+K
	 EaEOK3se7dJDekh21F5t+6Vhlca7A454PFFBFamA/S8qQd7rARlpoC39zRfknhyy654c98BOVdNp
	 G2bGuupQ0Y2vJaOAHKZjnqAe6a+B5f87NUyX5uOzHe9Pac+Rhaf4aQ+3iFvwswXf9ONSqfa9BPJ7
	 syO6wNGFxgKF1PMnPfeYVdFLwHeK6+EU4Qrtwzuwti4Ij4hIO6enqIIvK4yuvVU15VR6/yEeQUMx
	 tOWeJSQgYoMHH20Ouf8HVIZWMj2gFm2moGFUQuw8XI4GIDtb1dXVoB4Nzlz7PlLqfnbZG3fO9ZI5
	 /2so99pewrmUhAIKjf1nhiYOYkmgAVgn/4zaMpSuwqbTS8zWmml9AzC0d0pfnylEFaiTNC+JDeLR
	 8lexV8MUi/5Z3a17S7a46Homedat7S0yTMnnHbGQPV3C4cVVkdul58pNhkh6gvz3AQdDduhXecz5
	 AuDMxeWcUdRGPUGBKXz2LQQRI5upiDADPDrw2BtT6+ySlCrIfHQrYOjocUvzRAIQGR9vM9l/ByMQ
	 LXggAU1rUdng1syJBxZ7Py1e+6HgK+JKkAZ0g+flvQW8mWzh6RBg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tests: add compression algorithms check for tests
Date: Mon, 16 Sep 2024 15:25:20 +0800
X-OQ-MSGID: <20240916072520.2447444-1-kyr1ewang@qq.com>
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
+	local random_dir="$tmp/$RANDOM"
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

