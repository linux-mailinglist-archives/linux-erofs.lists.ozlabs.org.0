Return-Path: <linux-erofs+bounces-1085-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CACB95CA6
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 14:11:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWJkL1mFbz2ySb;
	Tue, 23 Sep 2025 22:11:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758629514;
	cv=none; b=SKbONCAT8qZpLd6LQJFNJmNGPgl1Dm8dNFFR28OZiLq85qBvLNUFiykYtnHtkIxGxarvyEj/vuUUbQ4qNW5vcH8Y05e8z89u+qMx5ABhCKYZNagDHEG8dVj5NMt8K1k8U53lqmzocz6GQejQ8DedNQn0iHqy/uGqkvJ58KWAmL7RYiMldMdGbF+YYDRR8B857cwE+pgI2CrME/1NIJ9lQVYo+jiUHCv/pbCgwzVaB4vQqofr/W68dhaJswcfe8VVir+9u3EMA35KFYIlPf+Gr7FqjzwYCcm+IpL6D1t9Exg+TP6g+OSaJgO5Un7oFv2QGxDhc4EnbsqlFP+D21DtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758629514; c=relaxed/relaxed;
	bh=3hJQr0kFfDPr79YFv1//NUQbLZpVxnrV5SDQaa2X+tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+SP7Zks50w8vz0TVcO235c+O/gRqyov5WOUhBlMasyZw73a+JF88NjMwG5S2dKYsWN/UqGuoMdiUfHZY7kY/n1aqdcYgm8vYU9jrrqKIbkQkAn65A/ZyZWA77rzqbxEvhZ/cVqwicPpj4TMf7yveb6lTrZfUpR+ZziItXvUHPHQdyOzxTzcaZB5NsUkEBjZb7oUqSfZm/FJydTwVF2WrApLV8+jn1rnThSgQzFf6mnGvtDzd01HSukvprDBEuzttUE5CViEX0XHP4NAicIYWY/PRAoPqDTinRO/dRled8S0vQVsZeK6/a77e2fanCts74RXitFwVpqPEuAdZckgqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DAtVJJni; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DAtVJJni;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWJkK2qfmz2xck
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 22:11:52 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758629509; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3hJQr0kFfDPr79YFv1//NUQbLZpVxnrV5SDQaa2X+tA=;
	b=DAtVJJni+huhYAMs5KtF8b/ExYap7DEL/C+T5GiU8ZtN2X/zN+NJ3LhMLK4YkP2i7pqygDIpc8Em2P4ZNRsVRDY/gvrCceLo+eyJi2QG+10PxMT9If3T1a/NzMWcT6x+GfHs6N2mAw6ra6w64lQtSs1UhYWg5AaAcc2slRjhJLo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WofQGeV_1758629179 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 20:06:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 2/2] erofs-utils: lib: add gzran virtual file support
Date: Tue, 23 Sep 2025 20:06:13 +0800
Message-ID: <20250923120613.2230166-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250923120613.2230166-1-hsiangkao@linux.alibaba.com>
References: <20250923120613.2230166-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add a .pread() interface to support gzip random access
with the help of the previous zinfo gzip indices.

Note that (e)stargz formats are also supported.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/gzran.c          | 176 +++++++++++++++++++++++++++++++++++++++++++
 lib/liberofs_gzran.h |   2 +
 2 files changed, 178 insertions(+)

diff --git a/lib/gzran.c b/lib/gzran.c
index e3b4e89..eba65ce 100644
--- a/lib/gzran.c
+++ b/lib/gzran.c
@@ -201,6 +201,176 @@ int erofs_gzran_builder_final(struct erofs_gzran_builder *gb)
 	free(gb);
 	return 0;
 }
+
+struct erofs_gzran_iostream {
+	struct erofs_vfile *vin;
+	struct erofs_gzran_cutpoint *cp;
+	u32 entries;
+	u32 span_size;
+};
+
+static void erofs_gzran_ios_vfclose(struct erofs_vfile *vf)
+{
+	struct erofs_gzran_iostream *ios =
+		(struct erofs_gzran_iostream *)vf->payload;
+	free(ios->cp);
+	free(vf);
+}
+
+static ssize_t erofs_gzran_ios_vfpread(struct erofs_vfile *vf, void *buf, size_t len, u64 offset)
+{
+	struct erofs_gzran_iostream *ios =
+		(struct erofs_gzran_iostream *)vf->payload;
+	struct erofs_gzran_cutpoint *cp = ios->cp;
+	u8 src[1 << 14], discard[EROFS_GZRAN_WINSIZE];
+	unsigned int bits;
+	bool skip = true;
+	u64 inpos;
+	z_stream strm;
+	int ret;
+
+	while (cp < ios->cp + ios->entries - 1 && cp[1].outpos <= offset)
+		++cp;
+
+	strm.zalloc = Z_NULL;
+	strm.zfree = Z_NULL;
+	strm.opaque = Z_NULL;
+	strm.avail_in = 0;
+	strm.next_in = Z_NULL;
+	ret = inflateInit2(&strm, -15);		/* raw inflate */
+	if (ret != Z_OK)
+		return -EFAULT;
+
+	bits = cp->in_bitpos & 7;
+	inpos = (cp->in_bitpos >> 3) - (bits ? 1 : 0);
+	ret = erofs_io_pread(ios->vin, src, sizeof(src), inpos);
+	if (ret < 0)
+		return ret;
+
+	if (bits) {
+		inflatePrime(&strm, bits, src[0] >> (8 - bits));
+		strm.next_in = src + 1;
+		strm.avail_in = ret - 1;
+	} else {
+		strm.next_in = src;
+		strm.avail_in = ret;
+	}
+	inpos += ret;
+	(void)inflateSetDictionary(&strm, cp->window, sizeof(cp->window));
+
+	offset -= cp->outpos;
+	do {
+		/* define where to put uncompressed data, and how much */
+		if (!offset && skip) {          /* at offset now */
+			strm.avail_out = len;
+			strm.next_out = buf;
+			skip = false;		/* only do this once */
+		} else if (offset > sizeof(discard)) {	/* skip WINSIZE bytes */
+			strm.avail_out = sizeof(discard);
+			strm.next_out = discard;
+			offset -= sizeof(discard);
+		} else if (offset) {			/* last skip */
+			strm.avail_out = (unsigned int)offset;
+			strm.next_out = discard;
+			offset = 0;
+		}
+
+		/* uncompress until avail_out filled, or end of stream */
+		do {
+			if (!strm.avail_in) {
+				ret = erofs_io_pread(ios->vin, src, sizeof(src),
+						     inpos);
+				if (ret < 0)
+					return ret;
+				if (!ret)
+					return -EIO;
+				inpos += ret;
+				strm.avail_in = ret;
+				strm.next_in = src;
+			}
+			ret = inflate(&strm, Z_NO_FLUSH);       /* normal inflate */
+			if (ret == Z_NEED_DICT)
+				ret = Z_DATA_ERROR;
+			if (ret == Z_MEM_ERROR || ret == Z_DATA_ERROR)
+				return -EIO;
+			if (ret == Z_STREAM_END)
+				break;
+		} while (strm.avail_out);
+
+		/* if reach end of stream, then don't keep trying to get more */
+		if (ret == Z_STREAM_END)
+			break;
+
+		/* do until offset reached and requested data read, or stream ends */
+	} while (skip);
+	return len - strm.avail_out;
+}
+
+static struct erofs_vfops erofs_gzran_ios_vfops = {
+	.pread = erofs_gzran_ios_vfpread,
+	.close = erofs_gzran_ios_vfclose,
+};
+
+struct erofs_vfile *erofs_gzran_zinfo_open(struct erofs_vfile *vin,
+					   void *zinfo_buf, unsigned int len)
+{
+	struct aws_soci_zinfo_header *h;
+	struct aws_soci_zinfo_ckpt *c;
+	struct erofs_vfile *vf;
+	struct erofs_gzran_iostream *ios;
+	unsigned int v2_size, version;
+	int ret, i;
+
+	if (len && len < sizeof(*h))
+		return ERR_PTR(-EINVAL);
+
+	vf = malloc(sizeof(*vf) + sizeof(*ios));
+	if (!vf)
+		return ERR_PTR(-ENOMEM);
+
+	ios = (struct erofs_gzran_iostream *)vf->payload;
+	h = zinfo_buf;
+	ios->entries = le32_to_cpu(h->have);
+	ios->span_size = le32_to_cpu(h->span_size);
+
+	v2_size = sizeof(*c) * ios->entries + sizeof(*h);
+	if (!len || v2_size == len) {
+		version = 2;
+	} else if (v2_size - sizeof(*c) == len) {
+		version = 1;
+	} else {
+		ret = -EOPNOTSUPP;
+		goto err_ios;
+	}
+
+	ios->cp = malloc(sizeof(*ios->cp) * ios->entries);
+	if (!ios->cp) {
+		ret = -ENOMEM;
+		goto err_ios;
+	}
+
+	i = 0;
+	if (version == 1) {
+		ios->cp[0] = (struct erofs_gzran_cutpoint) {
+			.in_bitpos = 10 << 3,
+			.outpos = 0,
+		};
+		i = 1;
+	}
+
+	c = (struct aws_soci_zinfo_ckpt *)(h + 1);
+	for (; i < ios->entries; ++i, ++c) {
+		ios->cp[i].in_bitpos = (le64_to_cpu(c->in) << 3) | c->bits;
+		ios->cp[i].outpos = le64_to_cpu(c->out);
+		memcpy(ios->cp[i].window, c->window, sizeof(*c->window));
+	}
+	ios->vin = vin;
+	vf->ops = &erofs_gzran_ios_vfops;
+	return vf;
+err_ios:
+	free(vf);
+	return ERR_PTR(ret);
+}
 #else
 struct erofs_gzran_builder *erofs_gzran_builder_init(struct erofs_vfile *vf,
 						     u32 span_size)
@@ -220,4 +390,10 @@ int erofs_gzran_builder_final(struct erofs_gzran_builder *gb)
 {
 	return 0;
 }
+
+struct erofs_vfile *erofs_gzran_zinfo_open(struct erofs_vfile *vin,
+					   void *zinfo_buf, unsigned int len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
 #endif
diff --git a/lib/liberofs_gzran.h b/lib/liberofs_gzran.h
index 4764506..443fe15 100644
--- a/lib/liberofs_gzran.h
+++ b/lib/liberofs_gzran.h
@@ -18,4 +18,6 @@ int erofs_gzran_builder_export_zinfo(struct erofs_gzran_builder *gb,
 				     struct erofs_vfile *zinfo_vf);
 int erofs_gzran_builder_final(struct erofs_gzran_builder *gb);
 
+struct erofs_vfile *erofs_gzran_zinfo_open(struct erofs_vfile *vin,
+					   void *zinfo_buf, unsigned int len);
 #endif
-- 
2.43.5


