Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B302D1744F0
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:51:25 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvBM07CyzDqLY
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:51:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951883;
	bh=OY//sZHCHMORJ1pN5csQMOogzfEjwLDg9wnni4doOBE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=AkQIMflkpj3N5l0IpcoQmnjvH/xCLd1whO42MhB41D2xMLYZYUUifpFslfcr/lfzJ
	 akVvQOMsfO0uACiOMahNVuq7/m83PG8iKn9KQ4yht7lPzMNBMXnnW+kNYFr84Itepc
	 IKEtNz47Mb7SZ/hC6IYB2HuZJzuoZpkzWfaYfw1j/NO3lwQ2v+8Py+0c//GISgy8jV
	 zj9qmMPcYJFML95isziFgOUjJZ7wc5YBH3BouFxqbae8H2lPcYYsxntlOP3Vk/VZwM
	 0YjbCLKgkCOFJZ+Unh1onmDi3Ib6tdsZSPco3O6VE+vAth9/jpeSDHhGRO6XhbUqKt
	 HhfG6+Uqi4/SQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.204; helo=sonic304-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=jBh3nddJ; dkim-atps=neutral
Received: from sonic304-23.consmr.mail.gq1.yahoo.com
 (sonic304-23.consmr.mail.gq1.yahoo.com [98.137.68.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvBB1gWGzDqLY
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:51:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951871; bh=rZ6Glj/8LfFSzzHqpWcIj4h0w8xrOzdTZ2eyLMoKl50=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=jBh3nddJZrlV+9hEdF5oReOinB3oCkZxduu4QBusalqnA3P8qUyjFJbvYbrvzBFXeSn9ZTgt6Mzd4EM73TQRyRXJb2tYBcyWr8mECWqiku13BiVdiyZwnRd5dUUt6RgD1Aveli+ljUdAGqH3mn06CYW0p6xd19kwb3ZdyqZib8XsLvupkR85uMBXZEQdEEGM+hePcC2AnoKBeqHSjtTdoIateaCyPMBt2GJdD9Rp+Qwhpha572IQRSTCSM3y7G/n/ZD6ZbHqWUytnhmh5Eb2IW+8jDHzxQSvWk3xsou/djyIJrRRyHgsfL0PlsCwYOGEZ3wt3j7GB4LeUtRH+DbRTA==
X-YMail-OSG: d4zWo.4VM1mU9uZL70zmsINcMjAUbawYw5KOwEQHdLhS7bdn87LYQNxDoLMwcy4
 nveavzEjkLIlk_nkQCim96yaEksdOrflOgm3Y6l2JE4XiSoOM1nMjDd6bRAIvuWuKFKkzrXTLVs0
 jy5f.BsKAthYYLs6AiDyqKZmpBTWzrzNZ1P0RZijSg40.EcvWQ7SCKgAUhflHcc._lCcCWy7i0nu
 0rSB4vRy6S8QyTWoXvvCGTDHmT2vlXiM1SNqudY9SjpwNiIolpspzTggfBXBl6li4F6DyDCC4huH
 uyhUXOpFVzpupSzg1rJZA_Rj3Wtl12_sO2TVWDkd6ToBGtT_Zp1M3tbvgZCTBfbxex9bA1tXlOCD
 Hix.Ee6zFexyjp9byw4NyQJTs1MFTPyTXREK4OnN_6TikTwtcPJ_wBFh.wCT3xB52rB3px0hrGMl
 RaHUHLR_8_UkZa.GEMVtoXw4MeSbWyp4xrba1_sAwmBbGSBE0DXRB0ie2Ezc3wA9IOF.HPAR8vRU
 63.W4NPmcJO8i9jABeRxaGPXYOcZ52skGE3Noe8qdT_FWtr7dLZ84CYzsBmIMbXnUgaqJ0L6oVuY
 ZU60_6Uj1DjUu19TEKqTAUlM_xZ7gOVhpaIM5LGs56xiFkOyBUs0jUuPcAR5uNjfSbgqNrMl7WHu
 WErN6ROvi8eBi1j5gSos5bvVBH3Ih7ngQ7DKTNhYfiJF2soMPFyoGsg1Px3KrWuWWCYDj3xyJOHk
 RnkrUlopF8fGdHO3wowNuOyRN2cdDio_J34S6JE2VKHsStuipqnnc8UuHRPgVBeB53RsrFlSG1i1
 iQbcoEADCbio8G1Y5FqXlGvjU3YyybOsVByGMXmeqxf9mhi0F3nY4edvhH_FeWmSr3SafB.SdM7g
 Jyz5rkIp.taikvZe6eyZhq8vnWTnCgpSqHzPLpkCt2n2TzS36codwn9dTZdEQpPJQ.Max.034Xml
 _hEYEaJnlHagVeXOpoAtjxHbSH8.aL6M5dxHxGl9lxZTbf9fVTUOvk7Srd8nUZhe57FCiaQXhGMQ
 HB0spDvGnZ.RlQcXPUXPNSzoGFRG772rB74AOfaHpHB2rYSFvk98QvclnQ8tLWFoySn4Tgh8xVmV
 znHTQkGL98SSHGdWvfO7xc6YUoc7MRm4aEgEfVsU.KlCoiPmuddjve.UkreaCt5egZ9Q1RtFZ3hO
 O9mqRNJwF0BpsHzAA6TY9Xmi8r6ury3yEiWz51oRz9ZhvcWbMlTPq3tSN4iFIHRIzJ4YxqIN2eIP
 7xx7rC_eWhSC_0fvEqTasFZjLXEUeoZYBPefPvpJsidYtpgncse1tu_yufHbZO0r33FZNawoJ7LP
 unlOEpjRHIj6mL8xgMTMYegHkFTKk5Cj193UyO_EIpHtfE6Y.uNfSj_TdGat8dn4-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:51:11 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:51:06 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 01/11] ez: add basic source files
Date: Sat, 29 Feb 2020 12:50:07 +0800
Message-Id: <20200229045017.12424-2-hsiangkao@aol.com>
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

Add common headers to provide basic definitions and
helpers. Open source license is included as well.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/ez/defs.h | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 include/ez/util.h | 25 ++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 include/ez/defs.h
 create mode 100644 include/ez/util.h

diff --git a/include/ez/defs.h b/include/ez/defs.h
new file mode 100644
index 0000000..d5acccf
--- /dev/null
+++ b/include/ez/defs.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: Apache-2.0 */
+/*
+ * ez/include/ez/defs.h
+ *
+ * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
+ */
+#ifndef __EZ_DEFS_H
+#define __EZ_DEFS_H
+
+#include <stdint.h>
+#include <assert.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <string.h>
+#include <errno.h>
+
+#define DIV_ROUND_UP(n, d)	(((n) + (d) - 1) / (d))
+
+#define min(x, y) ({				\
+	typeof(x) _min1 = (x);			\
+	typeof(y) _min2 = (y);			\
+	(void) (&_min1 == &_min2);		\
+	_min1 < _min2 ? _min1 : _min2; })
+
+#define max(x, y) ({				\
+	typeof(x) _max1 = (x);			\
+	typeof(y) _max2 = (y);			\
+	(void) (&_max1 == &_max2);		\
+	_max1 > _max2 ? _max1 : _max2; })
+
+/*
+ * ..and if you can't take the strict types, you can specify one yourself.
+ * Or don't use min/max at all, of course.
+ */
+#define min_t(type, x, y) ({			\
+	type __min1 = (x);			\
+	type __min2 = (y);			\
+	__min1 < __min2 ? __min1: __min2; })
+
+#define max_t(type, x, y) ({			\
+	type __max1 = (x);			\
+	type __max2 = (y);			\
+	__max1 > __max2 ? __max1: __max2; })
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+#ifndef __OPTIMIZE__
+#define BUILD_BUG_ON(condition)	((void)sizeof(char[1 - 2 * !!(condition)]))
+#else
+#define BUILD_BUG_ON(condition)	assert(condition)
+#endif
+
+#define BUG_ON(cond)	assert(!(cond))
+
+#ifdef NDEBUG
+#define DBG_BUGON(condition)	((void)(condition))
+#else
+#define DBG_BUGON(condition)	BUG_ON(condition)
+#endif
+
+#ifndef __maybe_unused
+#define __maybe_unused		__attribute__((__unused__))
+#endif
+
+#define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
+
+#ifndef likely
+#define likely(x)	__builtin_expect(!!(x), 1)
+#endif
+
+#ifndef unlikely
+#define unlikely(x)	__builtin_expect(!!(x), 0)
+#endif
+
+#endif
+
diff --git a/include/ez/util.h b/include/ez/util.h
new file mode 100644
index 0000000..9cb6e62
--- /dev/null
+++ b/include/ez/util.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: Apache-2.0 */
+/*
+ * ez/include/ez/util.h
+ *
+ * Copyright (C) 2019-2020 Gao Xiang <hsiangkao@aol.com>
+ */
+#ifndef __EZ_UTIL_H
+#define __EZ_UTIL_H
+
+#include "defs.h"
+
+static inline const uint8_t *ez_memcmp(const void *ptr1, const void *ptr2,
+				       const void *buf1end)
+{
+	const uint8_t *buf1 = ptr1;
+	const uint8_t *buf2 = ptr2;
+
+	for (; buf1 != buf1end; ++buf1, ++buf2)
+		if (*buf1 != *buf2)
+			break;
+	return buf1;
+}
+
+#endif
+
-- 
2.20.1

