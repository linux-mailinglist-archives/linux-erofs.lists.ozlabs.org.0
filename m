Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A179967443
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 05:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725159955;
	bh=3Anal0tIAnM09WFmzZIHpoOTC4ChU+0GAt3tRk9q6Kw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=l7N960mBJ6z1zoR99B0xnv2vVpO4AGSAR4a+Orc/HpizdSsIqlNe8JEQ/60/coqzr
	 jlqAL8Ber+AXan36/fkCZZf87UrEigycm7wE1yd9ivq+YZXxhW4I71NdDpCqGLg+hc
	 wUCiYdEHo8bOvtMtLqtOlGCSMj5bkIXviauzDN3FqgtjZeHZFF9N6ZDqHGtqJs93jn
	 qXNM+QO5qyYrV2WXMN9hj6oVq4XioiS9kHfCDmUJmTvLZR+vJZal7SQuZ+XDJnLBYM
	 S3AYySw6DmhjuC1+67ULNI6iRVFIjYkNRVUMPPLpzxTamPATSdJxRkp+N4w7onuKD8
	 FkYCVCzkv9Rlg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxGwz6PKdz2yjV
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 13:05:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.235
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725159953;
	cv=none; b=h0mo/7wgvlBDOjd+2lE2QZRNGp58cUl2UFzRDpZ+NGq3vAEpMDla/2fef5UN20FEcGF+iVzHOJGKMHpffcmKkFBk5vt0ILkcFGstjmVbBN2+fwg5ctfdB5ySRWsKSIHrhYq9X3VYDtRzXR3J5LVgSC0b3RDHkrqmLtTCNeUEfbTQEMxNax2j96cMeNmi/Yb+5Qhiz48qU8uqpyuYNau39lZPNodxQaUJlitwIuwUYsyz9fe3ezfFAFHsuEQL3bx23ar9AeO9xwEyC5g/uJmKqOIe6Q+QiTmbI0+R2+MVfJq8EW9idAl8JwiPBNmzVosLJ6S86a6CDQCu/+g1AHtrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725159953; c=relaxed/relaxed;
	bh=3Anal0tIAnM09WFmzZIHpoOTC4ChU+0GAt3tRk9q6Kw=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=KzX+2MhSyApssrwrMrcrvlCwmtguAfuGUmbUexckPg0IxRmR9CzNx/Mdqpfk6jO5F7zo7k0MA4CfkZmoYB76tF6DJjIT8RJEdrIVIAtrAFKIVJjp1CgyZDx+ufP5C+waz9S//V8eFuvu0FLLXdtwiSTame7p3d9+o9rtJ4RAsz1nZn4yD0VgaGp+q0AAwoqO6i0yHeqFRMEZIQWs4wOoJM0wE1XNce9l6XUCKjY2MxwK17Cl8WK63vChPIpqJHF6v2AEXx/d1VTYWNPjsMqeeJmZWgq6WPK2gbHJBSNb9msWq4rK2QIn1PtvSUUoXbReWN/Kpx2GgZQCLYBON0hx/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ER9F5/cp; dkim-atps=neutral; spf=pass (client-ip=203.205.221.235; helo=out203-205-221-235.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ER9F5/cp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.235; helo=out203-205-221-235.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WxGwx3YM7z2xTP
	for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2024 13:05:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725159949; bh=3Anal0tIAnM09WFmzZIHpoOTC4ChU+0GAt3tRk9q6Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ER9F5/cpgAEwMIlUjC0bUuiTPVR7XuovNt/Wwg1VNbXgtC7K5s+NdXqoAWMWkAGFq
	 JICQSjnYQoGMxD7zba9r6mpetAAUGXeeS2GZbi115NSUYahqkwBCq2O/MpFt/tumFJ
	 MizICt3uq5IGEWM7UAgY6uFoDKiKk51Hlq/KokpI=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id E563A462; Sun, 01 Sep 2024 10:57:22 +0800
X-QQ-mid: xmsmtpt1725159443tdxjsz5uf
Message-ID: <tencent_8102A25422677C68BC18D0E6796EA925D709@qq.com>
X-QQ-XMAILINFO: Mo29KZ8DTxVykqGAvP4I5KZWIlWTxtKltLX/cAwas00ysLCjqNieQq9KBX3VyO
	 iscRXfrMFPsx5pjcef8wDieOF5n1DYN43wz7SSin4/4zKfa5PZSJcFXbHgiCb/0bOwVb9bdsOjum
	 Ffg+c72YSwneiMMJhEawIvNwz2+mTFamae9lxajqdXgY/RLdr/wkTAk17k33gWgZEj62Bo9Js3lM
	 dcuPUfIJs+5fL6tXqnYATGL1O33miM3Rp500Iluht22CBHnLFO3zgj6himlThvkm4XBUbpQviFF3
	 sSRvZaVIIiaa1o4UrBIN42w5E42kBNaR9pHEsqYXzWnTHvFBITmwVIPsvzjJdlybgswMJI0abllu
	 I7+E5WPP8acKSefMpVeNsyDPUztF2N8XB1y3kOO/LSCCg8nlqEg5Jv6BBVJlUC0d9ZdB4ivoWs7F
	 wLeIJXjm3bDA7DmL5vuamr8kT5qRNOlc9NdDHi3bzt7GFGwS/fs2Qj2Stlxh7RZ77EOiFhv4v/X9
	 sRcHETqlh/x6H0HBlsB3UDXvphy1cEavAPSw9DhkhrQzxc9SZ3Q6WuSdfNhQ+18O3Za41cWftS8g
	 baGTetE0CMb/e6I3O1oXuf5zYOTIxuKpjc3Dwx07Gc3uSIPl/C2a/vl40Tle61T108O7W63Mn9ke
	 U2HEZOz5cLEs8/e2EfJ2uHvBvZO8NBmU713AflMxzXwpIk8/csmJDAlKQ3ihfBrsLqT01v3UPzz5
	 FNCHgX3Vk8GiXLdccYfLAr1qscRH2aiDmVpLl1uISBPOn3axouH01CxZ5X+EZhod9jg6BQUe2mXz
	 qMO8ISfU6Ci+CfAKjjpxkKn2Me2Z/669Zb5Yr79WHV9xu+tqaJb9gaTQsQxdhVpWsyK5aE4D4jX0
	 GW+/0+2gAaRHUH6OiJZ4JlSPcddl0pxOKnnDlzbTD9+VmJMFBPdQAyf1UcjnpuBWtnu732ER+Ju0
	 GP2GaBoLu/NKv57Sv1FSQb9kSDqFJmAkmPe3a9Oaoea+rDD30gOGIheFhlsMB7fgH30qoOBNE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: add fssum.c and fssum.h to support fssum
Date: Sun,  1 Sep 2024 10:57:20 +0800
X-OQ-MSGID: <20240901025720.2114485-2-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901025720.2114485-1-kyr1ewang@qq.com>
References: <20240901025720.2114485-1-kyr1ewang@qq.com>
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

This patch specifically implements the function of calculating image checksum 
and provides interface function that enables fsck to call to complete the 
calculation of image checksum.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 fsck/fssum.c | 513 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/fssum.h |  57 ++++++
 2 files changed, 570 insertions(+)
 create mode 100644 fsck/fssum.c
 create mode 100644 fsck/fssum.h

diff --git a/fsck/fssum.c b/fsck/fssum.c
new file mode 100644
index 0000000..9bcea1f
--- /dev/null
+++ b/fsck/fssum.c
@@ -0,0 +1,513 @@
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
+
+int erofs_fssum_traverse_dirents(struct erofs_dir_context *ctx,
+			    void *dentry_blk, unsigned int lblk,
+			    unsigned int next_nameoff, unsigned int maxsize,
+			    struct erofs_sum_t *dircs, int level)
+{
+	struct erofs_sb_info *sbi = ctx->dir->sbi;
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + next_nameoff;
+	const char *prev_name = NULL;
+	const char *errmsg;
+	unsigned int prev_namelen = 0;
+	int ret = 0;
+	bool silent = false;
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+		unsigned int nameoff;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent check */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		ctx->de_nid = le64_to_cpu(de->nid);
+		erofs_dbg("traversed nid (%llu)", ctx->de_nid | 0ULL);
+
+		ret = -EFSCORRUPTED;
+		/* corrupted entry check */
+		if (nameoff != next_nameoff) {
+			errmsg = "bogus dirent nameoff";
+			break;
+		}
+
+		if (nameoff + de_namelen > maxsize || !de_namelen ||
+				de_namelen > EROFS_NAME_LEN) {
+			errmsg = "bogus dirent namelen";
+			break;
+		}
+
+		ctx->dname = de_name;
+		ctx->de_namelen = de_namelen;
+		ctx->de_ftype = de->file_type;
+		ctx->dot_dotdot = is_dot_dotdot_len(de_name, de_namelen);
+		ret = erofs_fssum_sum(ctx, dircs, level);
+		if (ret) {
+			silent = true;
+			break;
+		}
+		prev_name = de_name;
+		prev_namelen = de_namelen;
+		next_nameoff += de_namelen;
+		++de;
+	}
+out:
+	if (ret && !silent)
+		erofs_err("%s @ nid %llu, lblk %u, index %lu",
+			  errmsg, ctx->dir->nid | 0ULL, lblk,
+			  (de - (struct erofs_dirent *)dentry_blk) | 0UL);
+	return ret;
+}
+
+int erofs_fssum_iterate_dir(struct erofs_dir_context *ctx, struct erofs_sum_t *dircs, int level)
+{
+	struct erofs_inode *dir = ctx->dir;
+	struct erofs_sb_info *sbi = dir->sbi;
+	int err = 0;
+	erofs_off_t pos;
+	char buf[EROFS_MAX_BLOCK_SIZE];
+
+	if (!S_ISDIR(dir->i_mode))
+		return -ENOTDIR;
+
+	ctx->flags &= ~EROFS_READDIR_ALL_SPECIAL_FOUND;
+	pos = 0;
+	while (pos < dir->i_size) {
+		erofs_blk_t lblk = erofs_blknr(sbi, pos);
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					dir->i_size - pos, erofs_blksiz(sbi));
+		const struct erofs_dirent *de = (const void *)buf;
+		unsigned int nameoff;
+
+		err = erofs_pread(dir, buf, maxsize, pos);
+		if (err) {
+			erofs_err("I/O error occurred when reading dirents @ nid %llu, lblk %u: %d",
+				  dir->nid | 0ULL, lblk, err);
+			return err;
+		}
+
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= erofs_blksiz(sbi)) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu, lblk %u",
+				  nameoff, dir->nid | 0ULL, lblk);
+			return -EFSCORRUPTED;
+		}
+		err = erofs_fssum_traverse_dirents(ctx, buf, lblk, nameoff, maxsize, dircs, level);
+		if (err)
+			break;
+		pos += maxsize;
+	}
+	
+	return err;
+}
+
+int erofs_fssum_sum(struct erofs_dir_context *ctx, struct erofs_sum_t *dircs, int level)
+{
+	int err;
+	struct erofs_sum_t meta;
+	struct erofs_sum_t cs;
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = ctx->de_nid };
+	
+	
+	if (ctx->dot_dotdot)
+		return 0;
+	
+	err = erofs_read_inode_from_disk(&vi);
+	if (err) {
+		erofs_err("failed to read file inode from disk");
+		return err;
+	}
+
+	erofs_fssum_init(&meta);
+	erofs_fssum_init(&cs);
+	
+	erofs_fssum_addu64(&meta, level);
+	erofs_fssum_add(&meta, ctx->dname, ctx->de_namelen);
+	if (!S_ISDIR(vi.i_mode))
+		erofs_fssum_addu64(&meta, vi.i_nlink);
+	erofs_fssum_addu64(&meta, vi.i_uid);
+	erofs_fssum_addu64(&meta, vi.i_gid);
+	erofs_fssum_addu64(&meta, vi.i_mode);
+	erofs_fssum_addtime(&meta, vi.i_mtime);
+
+	if (S_ISDIR(vi.i_mode) || S_ISREG(vi.i_mode)) {
+		ssize_t kllen;
+		ssize_t ret;
+		char *keylst, *key;
+		
+		kllen = erofs_listxattr(&vi, NULL, 0);
+		if (kllen < 0)
+			return kllen;
+		
+		keylst = malloc(kllen);
+		if(!keylst)
+			return -ENOMEM;
+			
+		ret = erofs_listxattr(&vi, keylst, kllen);
+		if (ret < 0) {
+			free(keylst);
+			return err;
+		}
+		
+		for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
+			char *value;
+			ssize_t size;
+			        
+			ret = erofs_getxattr(&vi, key, NULL, 0);
+			if (ret < 0)
+				return ret;
+			        
+			erofs_fssum_add(&meta, key, strlen(key));
+			if (ret == 0)
+				continue;
+			if (ret) {
+				size = ret;
+				value = malloc(size);
+			        if (!value)
+			        	return -ENOMEM;
+			        ret = erofs_getxattr(&vi, key, value, size);
+			        if (ret < 0){
+			        	free(value);
+			                free(keylst);
+			                return ret;
+			        }
+			        erofs_fssum_add(&meta, value, size);
+			        printf("key:%s val:%s\n", key, value);
+			}    
+		}
+		free(keylst);
+	}
+	
+	if (S_ISDIR(vi.i_mode)) {
+		struct erofs_dir_context nctx = {
+			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
+			.pnid = ctx->dir ? ctx->dir->nid : 0,
+			.dir = &vi,
+		};
+		
+		err = erofs_fssum_iterate_dir(&nctx, &cs, level + 1);
+		if (err)
+			return err;
+	} else {
+		if (S_ISREG(vi.i_mode)) {
+			erofs_fssum_addu64(&meta, vi.i_size);
+			err = erofs_fssum_addinode(&cs, vi); 
+			if (err)
+				return err;
+		} else if (S_ISLNK(vi.i_mode)) {
+			err = erofs_fssum_addinode(&cs, vi);
+			if (err)
+			        return err;
+		} else if (S_ISCHR(vi.i_mode) || S_ISBLK(vi.i_mode)) {
+			erofs_fssum_addu64(&cs, major(vi.u.i_rdev));
+			erofs_fssum_addu64(&cs, minor(vi.u.i_rdev));
+		}
+	}
+	
+	erofs_fssum_fini(&cs);
+	erofs_fssum_fini(&meta);
+	erofs_fssum_addsum(dircs, &cs);
+	erofs_fssum_addsum(dircs, &meta);
+	
+	return 0;
+}
+
+int erofs_fssum_calculate(struct erofs_dir_context *ctx)
+{
+	struct erofs_sum_t ans_cs;
+	struct erofs_inode vi = { .sbi = &g_sbi, .nid = ctx->de_nid };
+	struct erofs_dir_context nctx = {
+			.flags = ctx->dir ? EROFS_READDIR_VALID_PNID : 0,
+			.pnid = ctx->dir ? ctx->dir->nid : 0,
+			.dir = &vi,
+		};
+	int ret = 0;
+	
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret) {
+		erofs_err("failed to read file inode from disk");
+		return ret;
+	}
+	erofs_fssum_init(&ans_cs);
+	ret = erofs_fssum_iterate_dir(&nctx, &ans_cs, 1);
+	erofs_fssum_fini(&ans_cs);
+	fprintf(stdout, "%s\n", erofs_fssum_sum2string(&ans_cs));
+	
+	return ret;
+}
diff --git a/fsck/fssum.h b/fsck/fssum.h
new file mode 100644
index 0000000..0203169
--- /dev/null
+++ b/fsck/fssum.h
@@ -0,0 +1,57 @@
+#ifndef EROFS_FSSUM_H
+#define EROFS_FSSUM_H
+#include "erofs/dir.h"
+
+#define CS_SIZE 16
+#define CHUNKS 128
+
+#define F(x, y, z)			((z) ^ ((x) & ((y) ^ (z))))
+#define G(x, y, z)			((y) ^ ((z) & ((x) ^ (y))))
+#define H(x, y, z)			(((x) ^ (y)) ^ (z))
+#define H2(x, y, z)			((x) ^ ((y) ^ (z)))
+#define I(x, y, z)			((y) ^ ((x) | ~(z)))
+
+#define STEP(f, a, b, c, d, x, t, s) \
+	(a) += f((b), (c), (d)) + (x) + (t); \
+	(a) = (((a) << (s)) | (((a) & 0xffffffff) >> (32 - (s)))); \
+	(a) += (b);
+	
+#define OUT(dst, src) \
+	(dst)[0] = (unsigned char)(src); \
+	(dst)[1] = (unsigned char)((src) >> 8); \
+	(dst)[2] = (unsigned char)((src) >> 16); \
+	(dst)[3] = (unsigned char)((src) >> 24);
+
+#if defined(__i386__) || defined(__x86_64__) || defined(__vax__)
+#define SET(n) \
+	(*(MD5_u32plus *)&ptr[(n) * 4])
+#define GET(n) \
+	SET(n)
+#else
+#define SET(n) \
+	(ctx->block[(n)] = \
+	(MD5_u32plus)ptr[(n) * 4] | \
+	((MD5_u32plus)ptr[(n) * 4 + 1] << 8) | \
+	((MD5_u32plus)ptr[(n) * 4 + 2] << 16) | \
+	((MD5_u32plus)ptr[(n) * 4 + 3] << 24))
+#define GET(n) \
+	(ctx->block[(n)])
+#endif
+
+typedef unsigned int MD5_u32plus;
+
+struct erofs_MD5_CTX {
+	MD5_u32plus lo, hi;
+	MD5_u32plus a, b, c, d;
+	unsigned char buffer[64];
+	MD5_u32plus block[16];
+};
+
+struct erofs_sum_t {
+	struct erofs_MD5_CTX md5;
+	unsigned char out[16];
+};
+
+int erofs_fssum_calculate(struct erofs_dir_context *ctx);
+
+#endif
-- 
2.34.1

