Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E28967473
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 05:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725161545;
	bh=DYtKbnLRKUvB4w9DTBt8GqnBeffxBOW67NHBDR89lpA=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=m6PD5PG6V3uqTOvWGhS+s6iVL4TTN42GmmbqMO5ph5awjPm4OwDNKl6Yu2duBmUrn
	 bWhqKYRdau40JJqVZAvsyxz6nLiV6sEAcECi6VGhAUkll2yu0Y1iIhop5euZM6LsEz
	 +xrLaWAIIea+4T8L+i0kd4j5lewrgQt4Llg01IJgzOdxDlDX3HumP6HSbeQwPvRf4x
	 ZMfLRvCSCM2O+xX48m3NRtq5NJH42/SO9o2Iddu0WVEkO35PiY1vRf3RLlM6avewxD
	 StG6c25Ld4Yh6wG7AdeNinEJ7BsFK6ewqGtnL54xpECePyd4qqGNlUPX22zIi2xTA8
	 QuUz/C+7dxXqA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxHWY5fN1z309W
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 13:32:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.163.128.54
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725161544;
	cv=none; b=MH5SI+lUzCfCYbg3JpjkJVQ+NE7qY57Bsu+2+n2Jjz54GiAIfrGuhlyIH1K9aKBYaOC6XJrvKqlCnY8MCnm8SJaenMcRqexuAbalsezXD+4ciFuMvN4UdfG8Edm9wMQy+dDJyh1loMSa0cUlZqt9LshNdd7TPgp9ucpRPAX0hstQAg0LDb50jtvMNdKy7j99Nw0cVwy7oJaV/qiPkOfEBGJPB8Sp/4/JZ5zMRLbge54wtVVmZeYBmIbL7hiXynG7+ghfcj5V52IwjoSeCpBn93JLcg+aNXUeJ/58ab8dZSVYNSQIOA+EUbBfqzHd01RusGHzjPaamn8Z9cd0u/lbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725161544; c=relaxed/relaxed;
	bh=DYtKbnLRKUvB4w9DTBt8GqnBeffxBOW67NHBDR89lpA=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=FtbHEG0WO/CAwhKZ19criMo0eLklNzl7/rulYnHDnaChBfKHSl6VAG3SRznA7JA3tgcnbtobzL2tjOmFyoQCXe8pR0ZennuNQynZ9MQkMNU+6EN+oryopzm+07RDTj2mctzWevKPOMkcOP0yT7tEy3KMr/pGBqxu+G+td/MZThjxuXvPuwUZlpFQ0h8NhfBaPPAUhxkOg1J33S8U2/El2TpNcDEel15zZOi22RmOfn8lx8x07R2abFbWoIDXRMIZBYbY6hY8mIb4qQzBajbRGlxDQpXpjq1JOVTUReIvbVHRe3LStav74ppU6vQcBB7sKlIfEE7Z1Bhxr8wU1AUAMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dSEJ2Ei3; dkim-atps=neutral; spf=pass (client-ip=43.163.128.54; helo=xmbghk7.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=dSEJ2Ei3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=43.163.128.54; helo=xmbghk7.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WxHVc2gyKz2y64
	for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2024 13:31:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725161494; bh=DYtKbnLRKUvB4w9DTBt8GqnBeffxBOW67NHBDR89lpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dSEJ2Ei3PlA+zMmL5y/4bqbhfmOtWU+C6Mlhse1DqiD91RJSI8VKa6q8tcJlo+5FK
	 aRxTv7hj3U/EfnWWo98ZX6x1RFSoQzx1W6hscXIFJ5wIXhWVaayEPi+TsX5HGZOacN
	 CsbacGOYIUfCnyLNr768/jNmdaDlhE4g85gtDlpw=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 79AB0611; Sun, 01 Sep 2024 11:30:26 +0800
X-QQ-mid: xmsmtpt1725161427tgua900d5
Message-ID: <tencent_2943C07CFA6DA9245FC0918AE80C1FCD3C06@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujyyL6mKP9KNUo9aB+ttcJEI0xx3tO4ZLbpL8lmQcPnZAHl0NvlM
	 mlbBSOaefv7XfUkbCdXfMxgS+X8zaTTRyMueHxWv4m0vONBNgfbZ5hUzqkeRQ4j466sWmpYobPv/
	 7q1Q9WJ1dWzFBjiPhu6TsGfHrAo7gd8EcdXnhESMhUsOlLD+A5vqyW44c+8wx9Lb3wUyEr0A2C6a
	 1YAJv0qZ38/INuJ1hvJjl2Z7izzsaxc1wYKvAB/IIU+oh+H3+d2vRyo6555S3vwyUAieg0xZuMiK
	 jllX5N3paRNGEb0UeSuBT/1/xtlCxHWrIZxXNuHRS6VvKp2zrkIVjlDA3MMSdQq0IE3EkrkyNTJJ
	 nYPVQSr84HQ2l4msJwgMDSjEACiof6Zel3VS+aJWaWu+cn+xH0vEg165n9nWOwphcpTFwEWMC5F9
	 SD4faDLYI+E9TZ7xWJ/njRiAsVnAAz/ExFouYB5H9QawTDVfowfilF/QY3NfkqPzW1+n/lwu0GG/
	 /HIGe/fQj2QUaGDeE+jTx+QisCymgZ/qGJYHyalwBmYqfUIJmn+xlEOz8qwTPIVq2ZwKM4H2k6kX
	 kLF+xmy5VFq8Syq7fyeP2GdeRpMkUXDyRUqV0MhyeYL3F1ld4EKcWrGAQo8D7CUZwEUOh8qjBo9r
	 jku1juHPSurxTc47811Nssgc5c41/4VbsuakimmobbBn9l+4/PSPlS0yqDi4JpWDqoM2T1RdahFQ
	 lixOpMS3N4VLduumHYFwONhT+P4vdkbhMBEHnO2aMTjO5ocnhz2v5Pb+Pb4nOp0ZNQobjFJrz9VJ
	 yOIz6LSYei1/xiaWkYOp06JxKsQfgZGgLCoTZ3QSNkHC73ImoDORzwW+3nxAqgtNH8Akrpx2GAnz
	 e8RmGsqBcrfszq/DACCoT6prymRa8jLwniyJ2gTL+Ei6Oyu197bFhJFuYetSMon1192wnK/knpQS
	 Q07yBzzsKPulYp+ovKUq6lc1x3x3U3n3zRPmM8463mJbTjOPKFjbT3CSdbPhJJCuC+RUDmFtbi1n
	 JROcowgjaQe+OlTp998Z/5d1pB0ZE=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs-utils: tests: implement MD5 checksum for fssum
Date: Sun,  1 Sep 2024 11:30:19 +0800
X-OQ-MSGID: <20240901033021.2124850-2-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901033021.2124850-1-kyr1ewang@qq.com>
References: <20240901033021.2124850-1-kyr1ewang@qq.com>
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

This patch adds MD5 checksum initialization and some other related 
operations, providing support for subsequent implementation of checksum 
calculation for erofs image file.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 fsck/fssum.c | 269 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 269 insertions(+)
 create mode 100644 fsck/fssum.c

diff --git a/fsck/fssum.c b/fsck/fssum.c
new file mode 100644
index 0000000..b650641
--- /dev/null
+++ b/fsck/fssum.c
@@ -0,0 +1,269 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/sysmacros.h>
+#include <sys/xattr.h>
+#include "fssum.h"
+#include "erofs/print.h"
+#include "erofs/xattr.h"
+#include "erofs/list.h"
+#include "erofs/dir.h"
+
+static const void *erofs_fssum_MD5body(struct erofs_MD5_CTX *ctx, const void *data, unsigned long size)
+{
+	const unsigned char *ptr;
+	MD5_u32plus a, b, c, d;
+	MD5_u32plus saved_a, saved_b, saved_c, saved_d;
+
+	ptr = (const unsigned char *)data;
+
+	a = ctx->a;
+	b = ctx->b;
+	c = ctx->c;
+	d = ctx->d;
+
+	do {
+		saved_a = a;
+		saved_b = b;
+		saved_c = c;
+		saved_d = d;
+
+/* Round 1 */
+		STEP(F, a, b, c, d, SET(0), 0xd76aa478, 7)
+		STEP(F, d, a, b, c, SET(1), 0xe8c7b756, 12)
+		STEP(F, c, d, a, b, SET(2), 0x242070db, 17)
+		STEP(F, b, c, d, a, SET(3), 0xc1bdceee, 22)
+		STEP(F, a, b, c, d, SET(4), 0xf57c0faf, 7)
+		STEP(F, d, a, b, c, SET(5), 0x4787c62a, 12)
+		STEP(F, c, d, a, b, SET(6), 0xa8304613, 17)
+		STEP(F, b, c, d, a, SET(7), 0xfd469501, 22)
+		STEP(F, a, b, c, d, SET(8), 0x698098d8, 7)
+		STEP(F, d, a, b, c, SET(9), 0x8b44f7af, 12)
+		STEP(F, c, d, a, b, SET(10), 0xffff5bb1, 17)
+		STEP(F, b, c, d, a, SET(11), 0x895cd7be, 22)
+		STEP(F, a, b, c, d, SET(12), 0x6b901122, 7)
+		STEP(F, d, a, b, c, SET(13), 0xfd987193, 12)
+		STEP(F, c, d, a, b, SET(14), 0xa679438e, 17)
+		STEP(F, b, c, d, a, SET(15), 0x49b40821, 22)
+
+/* Round 2 */
+		STEP(G, a, b, c, d, GET(1), 0xf61e2562, 5)
+		STEP(G, d, a, b, c, GET(6), 0xc040b340, 9)
+		STEP(G, c, d, a, b, GET(11), 0x265e5a51, 14)
+		STEP(G, b, c, d, a, GET(0), 0xe9b6c7aa, 20)
+		STEP(G, a, b, c, d, GET(5), 0xd62f105d, 5)
+		STEP(G, d, a, b, c, GET(10), 0x02441453, 9)
+		STEP(G, c, d, a, b, GET(15), 0xd8a1e681, 14)
+		STEP(G, b, c, d, a, GET(4), 0xe7d3fbc8, 20)
+		STEP(G, a, b, c, d, GET(9), 0x21e1cde6, 5)
+		STEP(G, d, a, b, c, GET(14), 0xc33707d6, 9)
+		STEP(G, c, d, a, b, GET(3), 0xf4d50d87, 14)
+		STEP(G, b, c, d, a, GET(8), 0x455a14ed, 20)
+		STEP(G, a, b, c, d, GET(13), 0xa9e3e905, 5)
+		STEP(G, d, a, b, c, GET(2), 0xfcefa3f8, 9)
+		STEP(G, c, d, a, b, GET(7), 0x676f02d9, 14)
+		STEP(G, b, c, d, a, GET(12), 0x8d2a4c8a, 20)
+
+/* Round 3 */
+		STEP(H, a, b, c, d, GET(5), 0xfffa3942, 4)
+		STEP(H2, d, a, b, c, GET(8), 0x8771f681, 11)
+		STEP(H, c, d, a, b, GET(11), 0x6d9d6122, 16)
+		STEP(H2, b, c, d, a, GET(14), 0xfde5380c, 23)
+		STEP(H, a, b, c, d, GET(1), 0xa4beea44, 4)
+		STEP(H2, d, a, b, c, GET(4), 0x4bdecfa9, 11)
+		STEP(H, c, d, a, b, GET(7), 0xf6bb4b60, 16)
+		STEP(H2, b, c, d, a, GET(10), 0xbebfbc70, 23)
+		STEP(H, a, b, c, d, GET(13), 0x289b7ec6, 4)
+		STEP(H2, d, a, b, c, GET(0), 0xeaa127fa, 11)
+		STEP(H, c, d, a, b, GET(3), 0xd4ef3085, 16)
+		STEP(H2, b, c, d, a, GET(6), 0x04881d05, 23)
+		STEP(H, a, b, c, d, GET(9), 0xd9d4d039, 4)
+		STEP(H2, d, a, b, c, GET(12), 0xe6db99e5, 11)
+		STEP(H, c, d, a, b, GET(15), 0x1fa27cf8, 16)
+		STEP(H2, b, c, d, a, GET(2), 0xc4ac5665, 23)
+
+/* Round 4 */
+		STEP(I, a, b, c, d, GET(0), 0xf4292244, 6)
+		STEP(I, d, a, b, c, GET(7), 0x432aff97, 10)
+		STEP(I, c, d, a, b, GET(14), 0xab9423a7, 15)
+		STEP(I, b, c, d, a, GET(5), 0xfc93a039, 21)
+		STEP(I, a, b, c, d, GET(12), 0x655b59c3, 6)
+		STEP(I, d, a, b, c, GET(3), 0x8f0ccc92, 10)
+		STEP(I, c, d, a, b, GET(10), 0xffeff47d, 15)
+		STEP(I, b, c, d, a, GET(1), 0x85845dd1, 21)
+		STEP(I, a, b, c, d, GET(8), 0x6fa87e4f, 6)
+		STEP(I, d, a, b, c, GET(15), 0xfe2ce6e0, 10)
+		STEP(I, c, d, a, b, GET(6), 0xa3014314, 15)
+		STEP(I, b, c, d, a, GET(13), 0x4e0811a1, 21)
+		STEP(I, a, b, c, d, GET(4), 0xf7537e82, 6)
+		STEP(I, d, a, b, c, GET(11), 0xbd3af235, 10)
+		STEP(I, c, d, a, b, GET(2), 0x2ad7d2bb, 15)
+		STEP(I, b, c, d, a, GET(9), 0xeb86d391, 21)
+
+		a += saved_a;
+		b += saved_b;
+		c += saved_c;
+		d += saved_d;
+
+		ptr += 64;
+	} while (size -= 64);
+
+	ctx->a = a;
+	ctx->b = b;
+	ctx->c = c;
+	ctx->d = d;
+
+	return ptr;
+}
+
+void erofs_fssum_MD5Init(struct erofs_MD5_CTX *ctx)
+{
+	ctx->a = 0x67452301;
+	ctx->b = 0xefcdab89;
+	ctx->c = 0x98badcfe;
+	ctx->d = 0x10325476;
+
+	ctx->lo = 0;
+	ctx->hi = 0;
+}
+
+void erofs_fssum_MD5Update(struct erofs_MD5_CTX *ctx, const void *data, unsigned long size)
+{
+	MD5_u32plus saved_lo;
+	unsigned long used, available;
+
+	saved_lo = ctx->lo;
+	if ((ctx->lo = (saved_lo + size) & 0x1fffffff) < saved_lo)
+		ctx->hi++;
+	ctx->hi += size >> 29;
+
+	used = saved_lo & 0x3f;
+
+	if (used) {
+		available = 64 - used;
+
+		if (size < available) {
+			memcpy(&ctx->buffer[used], data, size);
+			return;
+		}
+
+		memcpy(&ctx->buffer[used], data, available);
+		data = (const unsigned char *)data + available;
+		size -= available;
+		erofs_fssum_MD5body(ctx, ctx->buffer, 64);
+	}
+
+	if (size >= 64) {
+		data = erofs_fssum_MD5body(ctx, data, size & ~(unsigned long)0x3f);
+		size &= 0x3f;
+	}
+
+	memcpy(ctx->buffer, data, size);
+}
+
+void erofs_fssum_MD5Final(unsigned char *result, struct erofs_MD5_CTX *ctx)
+{
+	unsigned long used, available;
+
+	used = ctx->lo & 0x3f;
+
+	ctx->buffer[used++] = 0x80;
+
+	available = 64 - used;
+
+	if (available < 8) {
+		memset(&ctx->buffer[used], 0, available);
+		erofs_fssum_MD5body(ctx, ctx->buffer, 64);
+		used = 0;
+		available = 64;
+	}
+
+	memset(&ctx->buffer[used], 0, available - 8);
+
+	ctx->lo <<= 3;
+	OUT(&ctx->buffer[56], ctx->lo)
+	OUT(&ctx->buffer[60], ctx->hi)
+
+	erofs_fssum_MD5body(ctx, ctx->buffer, 64);
+
+	OUT(&result[0], ctx->a)
+	OUT(&result[4], ctx->b)
+	OUT(&result[8], ctx->c)
+	OUT(&result[12], ctx->d)
+
+	memset(ctx, 0, sizeof(*ctx));
+}
+
+void* erofs_fssum_alloc(size_t sz)
+{
+	void *p = malloc(sz);
+	
+	if (!p) {
+		erofs_err("malloc falied");
+		exit(-1);
+	}
+	
+	return p;
+}
+
+void erofs_fssum_init(struct erofs_sum_t *cs)
+{
+	erofs_fssum_MD5Init(&cs->md5);
+}
+
+void erofs_fssum_fini(struct erofs_sum_t *cs)
+{
+	erofs_fssum_MD5Final(cs->out, &cs->md5);
+}
+
+void erofs_fssum_add(struct erofs_sum_t *cs, void* buf, int size)
+{
+	erofs_fssum_MD5Update(&cs->md5, buf, size);
+}
+
+void erofs_fssum_addsum(struct erofs_sum_t *dst, struct erofs_sum_t *src)
+{
+	erofs_fssum_add(dst, src->out, sizeof(src->out));
+}
+
+void erofs_fssum_addu64(struct erofs_sum_t *dst, uint64_t val)
+{
+	uint64_t v = htobe64(val);
+	erofs_fssum_add(dst, &v, sizeof(v));
+}
+
+void erofs_fssum_addtime(struct erofs_sum_t *dst, time_t t)
+{
+	erofs_fssum_addu64(dst, t);
+}
+
+int erofs_fssum_addinode(struct erofs_sum_t *dst, struct erofs_inode vi)
+{
+        int err;
+	char buf[EROFS_MAX_BLOCK_SIZE];
+	erofs_off_t offset = 0;
+	
+	while (offset < vi.i_size) {
+	        erofs_off_t maxsize = min_t(erofs_off_t,
+			                    vi.i_size - offset, erofs_blksiz(&g_sbi));
+
+	        err = erofs_pread(&vi, buf, maxsize, offset);
+	        if (err)
+		        return err;
+		        
+	        erofs_fssum_add(dst, buf, maxsize);
+	        offset += maxsize;
+	}
+	
+	return 0;
+}
+
+char* erofs_fssum_sum2string(struct erofs_sum_t *dst)
+{
+	int i;
+	char *s = erofs_fssum_alloc(CS_SIZE * 2 + 1);
+	
+	for (i = 0; i < CS_SIZE; ++i)
+		sprintf(s + i * 2, "%02x", dst->out[i]);
+		
+	return s;
+}
-- 
2.34.1

