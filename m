Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4582B4414
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Nov 2020 13:57:10 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZTcM0xKdzDqN8
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Nov 2020 23:57:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605531427;
	bh=yUStCYn2L0K8f5ZtWWqiCw4BZdzFGmzkMbiGfBO2jGk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=HxZ//MVqI4sTzYx99QbetMMX4W/RsleFVUs4PYwbmGGCWxPBVLRbJBRf7amdyzIEg
	 yHHEF1oRjgc4emvN9Z5D4NPFw3SqtG1YB8O/RuBMGVpPQOgpcnR4F7N3gPLcggS2Et
	 w7OUhHz0VC3ayqpgztxuc1R1SxAFaxyVMZGvPGlM40lbubQVpaUkjFiM7gr6GIH9WJ
	 GCpBdO8VnAlF1ZPxk4KabaywwBlxwFxgVx6EJ1h24kFWjBTcFC/t0jlAfdOuh+9qrz
	 o7QsbPPXePWcDnhG10stRl6Damovu3ZUxoFBbtdTxC2O8gBHwPAmF5rzic7qeuWyhc
	 V7Z9KVqEAIA1w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.147; helo=sonic302-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=MxFE0seC; dkim-atps=neutral
Received: from sonic302-21.consmr.mail.gq1.yahoo.com
 (sonic302-21.consmr.mail.gq1.yahoo.com [98.137.68.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZTbK0wqbzDqJf
 for <linux-erofs@lists.ozlabs.org>; Mon, 16 Nov 2020 23:56:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605531366; bh=ZeoZCF+02kPYmjEhe9V6qYWXprtZRQtGQaUeMd+b+7I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=MxFE0seCQgNEbfs3MuF1DOTbK+CoImEjNQz1xv93vZwnYeLuogOuNYVtYMrNc75rDtXAlf5VbgYCUhA2uaNHB9dW2ydM509IO4PSvyiHYVz6aQ5bmOCE/FmwnN1l20mIpY2E5xBQCwzZ9Z7sayBbO8Wn+/9YJuMbg99lfLxpptZ88P1be1ZGe0ePHLXfl7gCNAlKVXjKbc7yPAF2MxMkZjFcd4tdmd6CZ6srNGMoy+EVYI3o5qPgTwH/zDcWn2djV19TGcMNGxdtSFwosnaEVany6CG/wk1/rJftJRBaDUCkIHow32eLvEy0JriD1+D5LJGa+FrPw8e2jlQJC2IbOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605531366; bh=MtWtlqV940WD0EjTZ72p4DWdjrLU+XqaIAWuD/DXo0+=;
 h=From:To:Subject:Date:From:Subject;
 b=nRHxAcNNyBv8KcxdiLVv2CNyI0JUVBmGBSpJNHFcvoeg/W73M2HRXEWnFLKfa1t8QViuGCQ/0hpxTbKc5NfIrgJfpR8Q4qUi89tFIWGUVQNkXJ2d0Jr3suTZpWgO7uxU4erCe/tUrW7zJXpxxjHAq+Tbik2cDde5vxmgYJvvf3mxCMPbJ6tBImIA1H+kDoseW1jlisJSAOFPlwKXSkTxkTgR2BiYkgaexkAesxRTu9nHY9MlEvt9rYh/lnD25dQoLnO+mEEFW6AFQJLlgUlG5qgSR80sa2u9lKhzmDGn+z6toEbbS+SUW13v9N5al/ETzxn4PgYxv8WRDccPK14rtQ==
X-YMail-OSG: QmlYFd0VM1n8YtIldMC7f46aXArjb3Ovv4RKyaQhDNUgyM23vIiznzDagcOjE7F
 X0LRchASstTnMIrRVt2DS9yOlV5Kx8bFgY4Ir_6P2w5RecLzer1F4F725TXouy0GKOVqHVBaNPPC
 CQiOsG27JU.7mD4_ovhdMFJS3wm_hGOT1O55bMiGOQeMk.RRn6bJiK.aIkgmems6Umt9HqD6yYMv
 yVAJBpw55qR1RVOkEJ.57UdwiHKDTA9fOJ9rXF.NdNS8VGSIPKNPNKgG9JmBye6wyHDKKvC0BekJ
 Y99.GBn6xWHGMKomZuZQf.3ZaVlUErglZpwPc7UAw5d39TUdWDpXzypu1JrYzupGIEAg9Rn00qMY
 FHMY2XxrQ_8Qr.iW6wALZYtnMiY3_tmAXZCQwx6ns1C2qFwc0_6wvmWcEdK5qQ.PB6TsRKZTF_tI
 fBglyPTMiuCf2fzghFsICC8lWYFdujUt6P0iYaBs7tjhhciQjkxBunoSQ9Kw6WAVZ4S4bcVgdMhW
 ojEsW0Y.G3qgWgCBXR_nZNBgizAJYlc4PHDril3OMkwWnlp1cxrhXekTL64JhZ.wQ_cqJaS.IAwK
 Y6aB28XRZOdzxPUVq9FztLQR7yMPM2sLgT8OAOJc6IROuOAv08o7HXnVZQ.q4oblJwAWt.Dmn_0E
 vN1tOLz8WUWI4Z9LPA_qeIdOnRrG4Ixi.rq3M8CrAO6kQTlJgXx3XyhrCnT6uILXRpLvfRY5QP.6
 uHNdnBhFp8wIl3N.DDok1I67uG4CBORIzn.00dQkEVAkP6YOlINLDzxzj360feeu9MpDM1VpWaF7
 XqVn01p99z6XpxR_dRGFm1_aE5ZwsCFIGCzcwPThNyaCZy1oljwUzqzUJK1nHA5JeJr1SEIY6hPT
 W4Lsro0I96VLlDGDQJnUeLZDBozldyW98wlf0otLxvn2BKfMk5ypRxhCQud161C1NzW2A8nQi78n
 6k1O3jbVOEckAfvmkXmmMPgArx7VsLxD4Nr0.rDAGDmnCWLrrrW551gcaqJr4Dz3f82zAlOjwKgs
 3m7aBpniTk.1L9XHZIB0GywK.GBjzBLnl12aW1QRahuOnqrrU5AsiLSgFMDIl1aT0YeMNWckUi9b
 KWj.0JDeXRQ7x4NIvqQoKifNRO2cUV7n_b7nuBqWLtP6q5B_A2YB20zuZsmGEe9aGhQsYA3Vd3R3
 6tcgdGXpbqjg0B76hIX6cDEzV_Lcoqagc.KWawR1frZ_NfAXh34PA48vh59MNLttYQLOgbzgWixH
 s2AtIxTusPkAJUT97T0.CsDXTg4Z6Nu9Xcxx2eFfA6R0CNFhPkPBXbzb8MOb_ZPJ3ZcttHdwEGMY
 fPz_b7PN4d0cHXk_W8iITQfcRu5xXQWbXtEPJ0YxYVuviSyb.qohx0aVZPGxFfGjqh1DQgBQCwao
 WcqB7w2xk6iHGLLLcaQkhhHPO3Fm7BGSelMtbAGjFExB8jPPYutC1dyPZRQS0Auq_U6fUTijSsJW
 HO_ObG_Z8w6ayqzTFrLjrEBU05yvsig7Me627HKE7APJ6leBIv7xQ8SqYYDVlxXv6tzJAcGB6Cqd
 aJ5fYarHq.xpLN5Sl0WKA5x4i2o7Tv5CjpSZ2P1qcwNP5fduOc3Y0gp77G9BLiTRgoaq_kU4uYxy
 OwRj5ffTvVka.y1TnyOFMijqKnsAY4EAyXTI3tt4N9zOVtk4PaJqYal2GnMmaD2.uh1xudbsS8n8
 8t797egCwtzys.WIFh1tmozDU.c46pB9J5h1asB7pACuKeFKddY3S5e1PlzA0xmGGdggjbKWFPVC
 rrLxuAs8ezr8Etsx.mRKkqLuWLsSizEBXeu.Ef5HUyLZIzaUjjAmXwQkhzdda0VjfOHF9R7tHieO
 1KiA.aZQSf1j20RLl82qRzZzVdA3qYY.Y0W2JtbO_0QB7nC3l3MRAQUMEPc4YM_nA5NNCSa1t1YN
 UUV7WiJv9WoPOirkFCM87DUwJuhURkRo5TQL3mvkE4Phdgj8uhhkzFL7HFI5W0PnmQDA8M26H.Fg
 GpjP79vojWg56W6cfZiHvJNGLo1v8B3nfGIJXWCEwmJhwVCbarOKlmieJhjba0WHAK4LGNxl.O2S
 P9zE_VQy9vOtlfRXulHwjEYORYWSY4xJ690V0kIGWmrqNyMJc93v8mAkDmdJTvj3Igli_LigUHEr
 TXM7.XUtmtiDiCCtYw4MwQ4kRBL3T3psWimpWwE6K3yy5zwf5TXusWLeqK_FVc.E3HX2Mj4ipgp1
 tEXRrV2FeZE0X2v8WTcsG0ofLDZZfK1u2XX6cFs.l2pKolNoiU.2Zv_GmKUWTHjel0tblQVWhVxz
 WDr4CAIBWb3Njy2ueqacf2R22BoOZpMZoa5bFshm6KlIv2QM6u0z_v93uoVlnm5rT9i3LX4rj5a5
 V9sSp.JQlyRDY0J2K3OPfsz8ThfqevS3zHIfTXN9f.eR9OHUAPWm6k.XYmw9DTsEYlZgrKEMl9tP
 jIZz9mCcSKJ7tc8oJhzkIm9jRFcdaDOL_7tC11PivZJjbEjYUJH4sI6oHt4Dz2oVj10o2altaKfH
 zjKmTBeq58Q03pOZw4Z7LL5cC3wl45d1pVc029iUSdVL7BYXzuAu_to_9ifJvyyIvfXWAxNDhQRA
 dBIlF1Q_p86IdWoTQGpKaCGeOmWiNMgxvB8uoRUQaeDqPt88qj0uBhZcQx4b87JgmrgmZTrMii38
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Nov 2020 12:56:06 +0000
Received: by smtp414.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID ffa261d8c171b0beb5d1b98e92e0ae62; 
 Mon, 16 Nov 2020 12:56:02 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: update README
Date: Mon, 16 Nov 2020 20:55:27 +0800
Message-Id: <20201116125527.3644-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201116125527.3644-1-hsiangkao@aol.com>
References: <20201116125527.3644-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

Make it easier to understand...

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 README | 63 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/README b/README
index 7a7ac5d5cb6f..a69607a32e57 100644
--- a/README
+++ b/README
@@ -1,30 +1,32 @@
 erofs-utils
 ===========
 
-erofs-utils includes user-space tools for erofs filesystem images.
+erofs-utils includes user-space tools for erofs filesystem.
 Currently only mkfs.erofs is available.
 
 mkfs.erofs
 ----------
 
-It can create 2 primary kinds of erofs images: (un)compressed.
+It can generate 2 primary kinds of erofs images: (un)compressed.
 
- - For compressed images, it's able to use several compression
-   algorithms, but lz4(hc) are only supported due to the current
-   linux kernel implementation.
+ - For uncompressed images, there will be none of compression
+   files in these images. However, it can decide whether the tail
+   block of a file should be inlined or not properly [1].
 
- - For uncompressed images, it can decide whether the last page of
-   a file should be inlined or not properly [1].
+ - For compressed images, it will try to use lz4(hc) algorithm
+   first for each regular file and see if storage space can be
+   saved with compression. If not, fallback to an uncompressed
+   file.
 
 Dependencies
 ~~~~~~~~~~~~
 
- lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.3+ recommended [4].
+ lz4-1.8.0+ for lz4 enabled [2], lz4-1.9.3+ highly recommended [4].
 
 How to build for lz4-1.9.0 or above
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-To build you can run the following commands in order:
+To build, you can run the following commands in order:
 
 ::
 
@@ -32,23 +34,25 @@ To build you can run the following commands in order:
 	$ ./configure
 	$ make
 
-mkfs.erofs binary will be generated under mkfs folder. There are still
-some issues which affect the stability of LZ4_compress_destSize()
-* they have impacts on lz4 only rather than lz4HC * [3].
+mkfs.erofs binary will be generated under mkfs folder.
+
+* For lz4 < 1.9.2, there were some stability issues about
+  LZ4_compress_destSize(). (lz4hc aren't impacted) [3].
 
 How to build for lz4-1.8.0~1.8.3
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-For these old lz4 versions, lz4hc algorithm cannot be supported without
-lz4 static libary due to LZ4_compress_HC_destSize unstable api usage,
-which means only lz4 algrithm is available if lz4 static library isn't found.
+For these old lz4 versions, lz4hc algorithm cannot be supported
+without lz4-static due to LZ4_compress_HC_destSize() unstable
+api usage, which means only lz4 algrithm is available if lz4-static
+isn't found.
 
-On Fedora, static lz4 can be installed using:
+On Fedora, lz4-static can be installed by using:
 
 	yum install lz4-static.x86_64
 
-However, it's not recommended to use those versions since there were bugs
-in these compressors, see [2] [3] [4] as well.
+However, it's not recommended to use those versions directly since
+there were serious bugs in these compressors, see [2] [3] [4] as well.
 
 How to generate erofs images
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -78,14 +82,12 @@ which was replaced by the new erofs-utils implementation.
 
 git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b obsoleted_mkfs
 
-It may still be useful since new erofs-utils has not been widely used in
-commercial products. However, if that happens, please report bug to us
-as well.
+PLEASE NOTE: This version is highly _not recommended_ now.
 
 Contribution
 ------------
 
-erofs-utils is a GPLv2+ project as a part of erofs file system,
+erofs-utils is under GPLv2+ as a part of erofs project,
 feel free to send patches or feedback to us.
 
 To:
@@ -101,19 +103,20 @@ Cc:
 Comments
 --------
 
-[1] According to the erofs on-disk format, the last page of files could
-    be inlined aggressively with its metadata in order to reduce the I/O
-    overhead and save the storage space.
+[1] According to the erofs on-disk format, the tail block of files
+    could be inlined aggressively with its metadata in order to reduce
+    the I/O overhead and save the storage space (called tail-packing).
 
-[2] There was a bug until lz4-1.8.3, which can crash erofs-utils randomly.
-    Fortunately bugfix by our colleague Qiuyang Sun was merged in lz4-1.9.0.
+[2] There was a bug until lz4-1.8.3, which can crash erofs-utils
+    randomly. Fortunately bugfix by our colleague Qiuyang Sun was
+    merged in lz4-1.9.0.
 
     For more details, please refer to
     https://github.com/lz4/lz4/commit/660d21272e4c8a0f49db5fc1e6853f08713dff82
 
-[3] There are many crash fixes merged to lz4 1.9.2 for LZ4_compress_destSize(),
-    and I once ran into some crashs due to those issues.
-    * Again lz4HC is not effected for this section. *
+[3] There were many bugfixes merged into lz4-1.9.2 for
+    LZ4_compress_destSize(), and I once ran into some crashs due to
+    those issues. * Again lz4hc is not affected. *
 
     [LZ4_compress_destSize] Allow 2 more bytes of match length
     https://github.com/lz4/lz4/commit/690009e2c2f9e5dcb0d40e7c0c40610ce6006eda
-- 
2.24.0

