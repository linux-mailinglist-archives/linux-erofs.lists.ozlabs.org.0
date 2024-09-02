Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 945FC968490
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 12:24:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725272647;
	bh=4sLfKRlp3UZ7CCM7BLzI5DgdFiS6sy6E/jWNs4yPE6Q=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=PG5mjyL4K+zflz05B4eCUxVGjwPHp2T5eVASkSGQB5L70gmsYmwt/k8koSkf6Zymg
	 FI24sATObZlBLOoTWmOOy2wll04ZN0nY1LMKHxznVUtiSNrXKzfXNJ17hUXAnppv63
	 p11aM+WZ+GC5KWB+o+1Z3oQdonqxb/DzLxVI3p/xmL1fqF84tiTSCuxSjmJpVLESr6
	 SJUIguFlDIPv9cSjnRaKGeu0xm/nf2omWHVfqf74/OpNg6uURwQk7ukJkEL+zoOVjg
	 0c0OFuNwopsvhDDv3mKL7obCl3XAu+coT7R4g0ZJhD7ank4TnhROwxf78HMConYq59
	 +l/WbwbF03n8A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy4c76sZWz2xtc
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 20:24:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.149
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725272644;
	cv=none; b=O8Kmlu83b2MV0kvGc5vJvTLoAgtahKKAIfm0kw1fUPLwny6DlodbBgay3Yx3DqDkwy8eLwTZhxitrIgthKKn4TMRYAO6qZ4gqVHfMaEKslxf1VtKyDkGQC3vSH3tXRgineoGGqz82mhNsvIUoHfUNlioVPQKf9Jrf//6aU/W1kChVBxlGpE2ytA8jahZDU2PTeDn7ODwro8Oq+T+h8pJ4SPcDyiFg/gxaJnnVwchJCS1P4rqgomnhnDy3a9RqDpYtQNsCPnNKkLNbJb3P6T8aT5Uq+miWaR1+HAx88meLgo1+w2PLuCOTJBdh+nk0HuTnyHJUFWmmLoKsvW0btE63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725272644; c=relaxed/relaxed;
	bh=4sLfKRlp3UZ7CCM7BLzI5DgdFiS6sy6E/jWNs4yPE6Q=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=mDhWb3XrE0glSOh08Nf7WVAq4mgovE0HHwz3bQz4CDggnoD1I0FT0HuQB9hMC/tJH7MpTUhgHrOs7LcIVrLZEG1YMqr2Ydvd2E/5qwlp8h/pMznq5CmSbMoaR+n84VYz/28NuqvLhQ9NtzlnsB6mibfRT73OzP67/jrru4r+ZhzRc+uQO+09owuqUSnWTDZTQ3BgdLVkAxkZyfTg/NdoQQhW5K8mtp79ZfGIucg6CqO7oQuYeN/9FliQHKryYFCy/vsyAmCPeqH2ur9ljCjsKRyH2wTdffQaqBoBVEzhk0COXB2nAytjXCb1ttcpsgMbEctP+5hgKdVhDItSYHgLVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=v9P7uy87; dkim-atps=neutral; spf=pass (client-ip=203.205.221.149; helo=out203-205-221-149.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=v9P7uy87;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.149; helo=out203-205-221-149.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4Wy4c406yjz2xtc
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 20:24:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725272637; bh=4sLfKRlp3UZ7CCM7BLzI5DgdFiS6sy6E/jWNs4yPE6Q=;
	h=From:To:Cc:Subject:Date;
	b=v9P7uy87bkRTLWpFXy/ZzFhR+xfcMeoD+79kL1y1Ofy9m7+q5VXTotwjAEKBmuV0f
	 p0NKVsL+LQx80nlC59s1WxxxxPBFhnRiLw9qnZDk0vC7eKDXXcFF8siitiPh40VXgu
	 bHN4mCerOjGa8pdvfkDWZXjh5IKCEnr0lQWLIrz0=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 5B60D264; Mon, 02 Sep 2024 18:22:54 +0800
X-QQ-mid: xmsmtpt1725272574trc54y3rc
Message-ID: <tencent_C482193A9A16068279A55B2649B5800B9507@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujoQy4L5dPNIhlliZTEXtY2zyGeSfcx7o0bw2+zL0EJhFkA+GUZh
	 ZssVzA52fRqErH+GYuNDu+vbUYVgWKqu/rY4Suj++h1/ufDXvrWNC/nDZpTV90djXTZb05VZRA+O
	 rg/zFsw/rX71ckjJiagAPyXQ6P0y3YmswoSJ3xqqanItRbfJ6PTY4LY5RQxyCIn7UeG7aFpCz9zs
	 Qx+nkNhyERK0FJrwezivgXa1dLH/eJLCRENFIZzQ1CrgzsH0WZQA1fRS9M5J9GiwdlMMqACYd12U
	 NDFqyncfDbk1cUgPtZfOCFZFX89P2zglEcY9Sfjk2kwN0vEVtW6d2p3VhvEScetocxxfeEuhmY+3
	 GT6Oippb+Z8CAY415UQkyABmg1AQ0oSfnKNrvjmFvGuERo38VNU1OakUkle6IiVSiOwzhgtNsPjr
	 OdImVz1CJlOm/eeo6UGDmW3FFnm/tKWxc6t4b947krjPCKtCtkU+PJj1W069ubXjkIVzU2OvYBI9
	 I0ceSvCV7f+YimsZ/GvC3Cmo1P6Nhv/QwjauGNxeQDmNUjMKxR6N/el1WjQgef8N0cU7tpD7EcdK
	 hbb6FG+XrIlT3lOpc0R7U3vSomfcminiCwSt3jTQBFpegOpqPD3t4ppMIN8ZLdLm3A71QQeP9Hc/
	 6zCSbx5I/hf4AUSQpzCkRNSEZqPqAKcp2xM6rTUtCHcLJaO6wHDdJ81LKgaSj4e/D69Q4X0xJ6tf
	 WybaXzTwlBXNcEGl2ODSYvmDNmlqP02osKclxAY9LmV8YhbueawkUIEpRj8UaO8fzEtq6Yt0da+i
	 PfsCQweaMnakiVU8KGdLHJ56pHeP5aE5M7fem3VZ+yj61umAGRRbM4wLfabfqX4ri+K8Tkghzz1u
	 B06RkBK3ZsdURkbcn+qZTVc0hbJYEfRpa/USCGM0/rMdz39E7Ra1i2/uUBVr+Xx1Dhhbxv4SMoLG
	 tHAR1A0Pql5DnYXgDBGDLhYGwIcj57GLfPlRsNS2q9X02UHicPhQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/3] erofs-utils: tests: implement MD5 checksum for fssum
Date: Mon,  2 Sep 2024 18:22:50 +0800
X-OQ-MSGID: <20240902102252.2150182-1-kyr1ewang@qq.com>
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

This patch adds MD5 checksum initialization and some other related 
operations, providing support for subsequent implementation of checksum 
calculation for erofs image file.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 fsck/fssum.c | 257 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/fssum.h |  57 ++++++++++++
 2 files changed, 314 insertions(+)
 create mode 100644 fsck/fssum.c
 create mode 100644 fsck/fssum.h

diff --git a/fsck/fssum.c b/fsck/fssum.c
new file mode 100644
index 0000000..7c5798c
--- /dev/null
+++ b/fsck/fssum.c
@@ -0,0 +1,257 @@
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

