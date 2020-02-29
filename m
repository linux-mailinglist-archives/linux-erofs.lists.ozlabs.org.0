Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB51744FB
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:52:31 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvCc6Hh3zDrMy
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:52:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951948;
	bh=D2lnWp7sUXmwdirqVMbqOIOpG08IiOKuqe2ychro5Jw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=g45dfkuPlFBVnjKgjLzhEahWPUpzvF2NINqI32E3gGpI/PEbe2ML59EqDep6E65jT
	 itSqSzkAc6B5+r3i9upLGmmJA+d061lnxCfseIqQhQgK9M/6RbkiEzjjcToFWOs/dU
	 OMGwt/Eid73jUQe7xCETT4Lhot1sFkDPD63I0u32ahJLJxCrF8lXy15tIIWlVsIVaL
	 CVZF7UcKEWw79mFgYzcjN6RQqCq9mj7SdF9jz9lSwgBifn7DWlJDWYrsBS71wIVh7F
	 B/zdWUWDckFJM1PYvdk6NWgoZfMGzqcxiFQfaY6pl27M/heOKG7AhcQmpA9ZCpGQgS
	 MewjamgA/RGsQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.148; helo=sonic309-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=RrxS6BHb; dkim-atps=neutral
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvCW4NVHzDr6P
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:52:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951939; bh=egLJOE2u4hMpJ5Sm7+eVqAHr/prdhHzg6ofLJ0CvBOM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=RrxS6BHb78SzqBKSytwtj4B5Gg5JrfG6e9EHUfcBf7VIkHo+qCzCd6rQvC+rN12LCiaYm8d5eM3yDfZmgwLuvK5z+JS1cQNKs4/izpuFH+kjCXiDTx4QC09d3kjIILQavBJqvCGqBPKogpv3yYPTQBChjtdipsrcy4wB3KMcBhH+ba9lugyomk+mQ7MZLBrKlS4XswFwwrmPcI4eh+rgv456HeJQfQQe2BkcGyYb2f5MNOzRZSbVfpLx2US9Tc7w5sp4RjvBSHMhQLFJ68L4L+OB/xSer9tAw9M46rtVZDdKD6TQpgk7O7Hpuoy+fciLC1Jeg52nXYP2aXM4NaHE5Q==
X-YMail-OSG: 71yqp9gVM1lj7bVawgBzx5I7V_lM8xC4fUU5nS.mVJu2ryD6NLkdZHElKu36Al1
 FXxUycJ.1YR22RqKFvIuKFHPzxd9v7Zw4RWICG.Zn5UAVsa.uH4jCJC_Yk8sCdMSKSO3IwJmcCoB
 CTKT0duBoISkw94.sRqU.a.2YQ.VQbl9E5Ep__6I5GdZFE8F84__V88aPlj.Ktj1yZjyJ57zpETQ
 xp3Q0u9LtrlafglJYtfOc4GYcQr5aLbrHggQbUZEbbsy5O54LJ0paTOARnX7KL63L3QUTdR13h2b
 YA2nHbS_8dgqGUhdbJfnQw2b9w1jLDT6R4bTRWORKsXyLkAjc3lL2H0wdEVLH0j6OZq6YJbmPT4k
 prfRUJ0O7Cx_VM8IB7dWv3gkxChutJjeyyeFDfit9Ooman0KodYUNLEc2jFGZtP0c9h.QW04MtlN
 telLEg8pQYuM6J8wN3fYCVT4F.JFqKEhropTcDwRMYb30tOPthuAGVoR3qufLioO3qk8jA3tGqLt
 eYvdsdRs5okzdj.s_NaaTvgJQ.2bbb150MiwIk2g310rHYNVrBNqkgKfONRkGa0E8lcl5hMeg.Cv
 kS.tmRFQN3Z9O4nPet8pTbEouaaPMUJV0WpcRpmxkCPz8goBPFmTvzeawI8MeDE3s0enBT1TjUQ1
 H.vxOXA1BrAsc.SRyZTNXWn7HpPQCh__MDhU34VUy2MxqPR1U5BIgQDMbxURaj37en3hWK1.i_5d
 dnjHkRj1YSL5g2dIz8NwegU5SjGCtusyRNFUviATLE1AVWlMzFKDRx1yNarBoxsor7udvw_oJAF3
 zRe5XvX_at3Z54WybXRVRgHnQX0j7o8WNsf9rs8AkXyB7VunQzFWobuZ5yYMbNnW7qqsHNdYiHKV
 t9wLRSjWnFDsOB6_Vnp4JYwZVOc6k2gr46ZA3xvr.Y0rRw67fxZ4CAag_8GbhCrQjkg_0A_k5Klb
 2TWiP8oVyHhHU7Vw3zrk71VROLhTBTAl.O44s2FPsSbeRxr7RpN_Ku.A2BugM9eyDpeLCrKRMNGI
 7FAQwxrmGLgUtlcyPUlNak58FqUIwg3G6zvYcQ1GOBXgdKIJbhtuKdCPU7VNMBntEApua3hFIsbd
 d5VN2lmjUMw5UEQeAWXHM6S.sRiEdK9k.tOsZh9sJlhUV9K9X.8muUyGheOWBDIGbU_d4Sw9Q2.n
 IPG1bxX673NXlA.YoGmSdWfSHiOJCzdtw3MKvCXSym3DtSR.slLVy0BSt4JvDuZpY8EZkd6msMxG
 ZXgjfBfjcwt.qWHDkuK_81FTBzii717aJ2dltIWNeYmS.JycsErb0c.wD6eH2p7aPsmy.w_wxE2I
 MLxNth0tqcAV2MZIYFmIJ7AnzsXEKqGEeftbz53a0aWzSr3W79arvajuEOeT8LqIYNiQKsAYY
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:52:19 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:52:15 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 11/11] ez: lzma: add test program
Date: Sat, 29 Feb 2020 12:50:17 +0800
Message-Id: <20200229045017.12424-12-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229045017.12424-1-hsiangkao@aol.com>
References: <20200229045017.12424-1-hsiangkao@aol.com>
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

Usage:
$ ./run.sh
$ ./a.out output.bin.lzma infile

It will compress the beginning as much
as possible into 4k RAW LZMA block.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lzma/lzma_encoder.c | 115 ++++++++++++++++++++++++++++++++++++++++++++
 lzma/run.sh         |   1 +
 2 files changed, 116 insertions(+)
 create mode 100755 lzma/run.sh

diff --git a/lzma/lzma_encoder.c b/lzma/lzma_encoder.c
index 98cde22..7c4b51d 100644
--- a/lzma/lzma_encoder.c
+++ b/lzma/lzma_encoder.c
@@ -757,3 +757,118 @@ void lzma_default_properties(struct lzma_properties *p, int level)
 	p->mf.depth = (16 + (p->mf.nice_len >> 1)) >> 1;
 }
 
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#if 0
+const char text[] = "HABEABDABABABHHHEAAAAAAAA";
+#elif 0
+const char text[] = "abcde_bcdefgh_abcdefghxxxxxxx";
+#else
+const char text[] = "The only time we actually leave the path spinning is if we're truncating "
+"a small amount and don't actually free an extent, which is not a common "
+"occurrence.  We have to set the path blocking in order to add the "
+"delayed ref anyway, so the first extent we find we set the path to "
+"blocking and stay blocking for the duration of the operation.  With the "
+"upcoming file extent map stuff there will be another case that we have "
+"to have the path blocking, so just swap to blocking always.";
+#endif
+
+static const uint8_t lzma_header[] = {
+	0x5D,				/* LZMA model properties (lc, lp, pb) in encoded form */
+	0x00, 0x00, 0x80, 0x00,		/* Dictionary size (32-bit unsigned integer, little-endian) */
+	0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF,		/* Uncompressed size (64-bit unsigned integer, little-endian) */
+};
+
+int main(int argc, char *argv[])
+{
+	char *outfile;
+	struct lzma_encoder lzmaenc = {0};
+	struct lzma_properties props = {
+		.mf.dictsize = 65536,
+	};
+	struct lzma_encoder_destsize dstsize;
+	uint8_t buf[4096];
+	int inf, outf;
+
+	int err;
+
+	lzmaenc.mf.buffer = malloc(65536) + 1;
+	lzmaenc.mf.buffer[-1] = 0;
+
+	if (argc >= 3) {
+		int len;
+
+		inf = open(argv[2], O_RDONLY);
+
+		len = lseek(inf, 0, SEEK_END);
+		if (len >= 65535)
+			len = 65535;
+
+		printf("len: %d\n", len);
+
+		lseek(inf, 0, SEEK_SET);
+		read(inf, lzmaenc.mf.buffer, len);
+		close(inf);
+		lzmaenc.mf.iend = lzmaenc.mf.buffer + len;
+	} else {
+		memcpy(lzmaenc.mf.buffer, text, sizeof(text));
+		lzmaenc.mf.iend = lzmaenc.mf.buffer + sizeof(text);
+	}
+	lzmaenc.op = buf;
+	lzmaenc.oend = buf + sizeof(buf);
+	lzmaenc.finish = true;
+
+	lzmaenc.need_eopm = true;
+	dstsize.capacity = 4096 - sizeof(lzma_header); //UINT32_MAX;
+	lzmaenc.dstsize = &dstsize;
+
+
+	lzma_default_properties(&props, 5);
+	lzma_encoder_reset(&lzmaenc, &props);
+
+	err = __lzma_encode(&lzmaenc);
+
+	printf("%d\n", err);
+
+	rc_encode(&lzmaenc.rc, &lzmaenc.op, lzmaenc.oend);
+
+	if (err != -ERANGE) {
+		memcpy(lzmaenc.op, dstsize.ending, dstsize.esz);
+		lzmaenc.op += dstsize.esz;
+	} else {
+		encode_eopm(&lzmaenc);
+		rc_flush(&lzmaenc.rc);
+
+		rc_encode(&lzmaenc.rc, &lzmaenc.op, lzmaenc.oend);
+	}
+
+	printf("encoded length: %lu + %lu\n", lzmaenc.op - buf,
+	       sizeof(lzma_header));
+
+	if (argc < 2)
+		outfile = "output.bin.lzma";
+	else
+		outfile = argv[1];
+
+	outf = open(outfile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	write(outf, lzma_header, sizeof(lzma_header));
+	write(outf, buf, lzmaenc.op - buf);
+	close(outf);
+
+#if 0
+	nliterals = lzma_get_optimum_fast(&lzmaenc, &back_res, &len_res);
+	printf("nlits %d (%d %d)\n", nliterals, back_res, len_res);
+	encode_sequence(&lzmaenc, nliterals, back_res, len_res, &position);
+	nliterals = lzma_get_optimum_fast(&lzmaenc, &back_res, &len_res);
+	printf("nlits %d (%d %d)\n", nliterals, back_res, len_res);
+	nliterals = lzma_get_optimum_fast(&lzmaenc, &back_res, &len_res);
+	printf("nlits %d (%d %d)\n", nliterals, back_res, len_res);
+	nliterals = lzma_get_optimum_fast(&lzmaenc, &back_res, &len_res);
+	printf("nlits %d (%d %d)\n", nliterals, back_res, len_res);
+#endif
+}
+
diff --git a/lzma/run.sh b/lzma/run.sh
new file mode 100755
index 0000000..57adc12
--- /dev/null
+++ b/lzma/run.sh
@@ -0,0 +1 @@
+gcc -Wall -g -I ../include lzma_encoder.c mf.c
-- 
2.20.1

