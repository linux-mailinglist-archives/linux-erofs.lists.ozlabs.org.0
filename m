Return-Path: <linux-erofs+bounces-1508-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6271BCCA1DC
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Dec 2025 03:59:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWwP35mjFz2xpg;
	Thu, 18 Dec 2025 13:59:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766026759;
	cv=none; b=Uwf6Ei9sfyizaRpKmOdSS9MWDcNN95GesosjltG9pDXKF+Z9wfdcDSxNej37BudTga8kO9Kaa0kjym3ySJVTq59LTzaRO2bvMKYyr4To3asfUZ/mHU/+XpWTP2S8Tld/0YIeiFzhNnQbaERsLyfcYIMHOnBUelX7W0of/+uxl+gxP2urO+Qcg9st5yrLJmS2iUrYv2RtYi2y9nDKp+d3YstvXcKWwB8vxse0Ik37aAhDXEe2vMhkzbzbhnSUs2QjwqUQGa92hw0lOx4teCuCsygphUlWgxF/X9zGZ6kVQdX2gOldQbbGuJlj0h7BF40A8sBwBLE273J272F2fNR9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766026759; c=relaxed/relaxed;
	bh=f6WIlm3NQrzkDp5di3uVHEazPDVw9kDdxE9w8UfSzkk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VKI1mO5cM1/pQ5dNUGUjEdUz5Hi9QlLC4otjp74W+pQpw9Vc4LE1Z8K8xiX5mAyKSoJmTOvvQef4S4Wf3EI180Bg1hYlG1NaRiBctQMXK9kRA0ZeAeQ29wp3qY3cK7/tBmRlt1NIHboBhSJqPucxR0fEr7cnjSfSbLRoiBAgMc5GYg5d7Ufa/8U4tTAy6M421kgfP+26qxGJ8BPS9Nso1s3pG3BsEmZni9mbDQz4VlqfEdiEeLPQSj10LVJqUx3/yrJKMvkNx24XpD+1mWmYDZSxdqaf+oGr4tG2V8rZBuD82MHadObalBkrIIanGjFFovdwcl7RRZV2DLRwGifBIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=u6YQNbVo; dkim-atps=neutral; spf=pass (client-ip=203.205.221.231; helo=out203-205-221-231.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=foxmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=u6YQNbVo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=foxmail.com (client-ip=203.205.221.231; helo=out203-205-221-231.mail.qq.com; envelope-from=ywen.chen@foxmail.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 63232 seconds by postgrey-1.37 at boromir; Thu, 18 Dec 2025 13:59:15 AEDT
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4dWwNz3yQCz2xDD
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Dec 2025 13:59:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766026746;
	bh=f6WIlm3NQrzkDp5di3uVHEazPDVw9kDdxE9w8UfSzkk=;
	h=From:To:Cc:Subject:Date;
	b=u6YQNbVoL0JT+1E6Xc7KZrV90auwUlvkg85vKR+9yMPFcPtXp4rUd/RwjgyVwGgyv
	 73IaFDOREnJ8bI/xTfXHjxFcjsv+CxOkot+3rTQ3sFwo4pE30k7SPvIsXk/sk/jAhl
	 w3PuXQCoSBA6WCmXSHVRl+2ppQy1foCSwlpe/6jA=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id E763CC66; Thu, 18 Dec 2025 10:57:54 +0800
X-QQ-mid: xmsmtpt1766026674tvgj5lsby
Message-ID: <tencent_9E5D8E4520DCDEE3CBAE5BE70D79F95FFD08@qq.com>
X-QQ-XMAILINFO: N5bMR0CdcU9onGdfnkd+zu932qwd19dpw1wudSuxBnYliZqZrIiUWp0YfWEbi2
	 Nj3gvGo+Gt7ZIMBR2WYUNxM4njKVn/EjPZHzTBAzyDvppAaH6wLk/GpZscNP4QFsJCOhNEj27hw6
	 QepGc2wfkETv4zmgefR04kHQwq8CiFs7Vd2qg/fgT+lgbr6Ji6JnkG3dg8UOEWF1HJyMpdglDFAD
	 p3zzsDQ+WN301Q4Ud9u7TFUDzuYDkt/EExBcQtgfLoi3KnC3h+1c5DWB+WvXnPLGYu6fUkVV2qCe
	 VOuc0HRD7hFwbGb6jerAT+ebEwM9fMTyNVMTXrpN8ajY25DjbdelWn7PVLjLpuYuqht8+jasef5Q
	 BsZT6/WwUUE1PEOtjVdLu0stITT9cEVfVwPjw09Kx8X3ePp7MVG7RkP82oZWwbemE8OhDtmnYchh
	 NiakCqFhnitZJzsqCx2X6DHZrpYusuhFJxYQduLx3bg7B9gZp2cz2obJivbbgqNaZRNo8L5tb9tD
	 lI+d1OTBPBCi6vEfQ2EoR3gUWfNhdIo9KjAFCKhfTTDqqy8h/GScjBAVn/k31o4pJ5l7t/Bptrfz
	 2NDq1mfKUw4zxr4NTYht+UlB9VEXaKqvPIcg60bXM8BMd1Jqcy1mcNzHV92LwvyGZz8Hzsp2dIKF
	 MgFsuRqQtANZzOlqiVU4BOBsOrzPzsIjvcngqhKAVH+mHxG//7JJUq90lpAy/PJNi3C+xni2Pp0W
	 o0JSoGKN3yZFQUIBy7fvazRpXBkDDLBPb//98xQ6N9uFAbfKhHUMmZtaOLBfa9rJ3FA5YzGTBzz2
	 KPnD6IaXbeQ0cZQ/DbsCYPuWJ1EQncENHr2P84C5m58JPYcg58qNqxvTEHHbpFurrpY8xgkE4O8z
	 NvpWdgfh8pcmL0MDo0plRdHYvXU077ji4Cq9+nX4Ae+Yxy75P7ywuyo9eFo4suNFex+FGdS4CnvF
	 SdPQeQJAb32jDVHHzS+/iwa+aNjp3g2TrkQgsJh4t6OoEA+kRcUJAbZvCGKBgndIIco0yP2WHj1u
	 to5B9EZLSIvOikARkw6PZxbKbyMZ0UfUQtLxIlnTLBoYzhM9egsWC4FXN36jltz+Oyl8ztdY+jzH
	 CG1yl5txHEeu/KmB3ZruAl6VCjvGwmcyyNjGHV56K7QxfmcXo=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yuwen Chen <ywen.chen@foxmail.com>
Subject: [PATCH v2] erofs: simplify the code using for_each_set_bit
Date: Thu, 18 Dec 2025 10:57:53 +0800
X-OQ-MSGID: <20251218025753.2855196-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [203.205.221.231 listed in list.dnswl.org]
	*  0.0 RCVD_IN_MSPIKE_H3 RBL: Good reputation (+3)
	*      [203.205.221.231 listed in wl.mailspike.net]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.0 RCVD_IN_MSPIKE_WL Mailspike good senders
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [ywen.chen(at)foxmail.com]
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  3.2 HELO_DYNAMIC_IPADDR Relay HELO'd using suspicious hostname (IP addr
	*      1)
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

When mounting the EROFS file system, it is necessary to check the
available compression algorithms. At this time, the for_each_set_bit
function can be used to simplify the code logic.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---

v1 -> v2:
    - revert the modifications to the fs/erofs/internal.h

 fs/erofs/decompressor.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2ec9b2bb628d6..be1e19b620523 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -405,7 +405,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	unsigned int algs, alg;
+	unsigned long algs, alg;
 	erofs_off_t offset;
 	int size, ret = 0;
 
@@ -423,13 +423,10 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 
 	erofs_init_metabuf(&buf, sb);
 	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
-	alg = 0;
-	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
+	algs = sbi->available_compr_algs;
+	for_each_set_bit(alg, &algs, Z_EROFS_COMPRESSION_MAX) {
 		void *data;
 
-		if (!(algs & 1))
-			continue;
-
 		data = erofs_read_metadata(sb, &buf, &offset, &size);
 		if (IS_ERR(data)) {
 			ret = PTR_ERR(data);
@@ -438,7 +435,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 
 		if (alg >= ARRAY_SIZE(erofs_decompressors) ||
 		    !erofs_decompressors[alg].config) {
-			erofs_err(sb, "algorithm %d isn't enabled on this kernel",
+			erofs_err(sb, "algorithm %ld isn't enabled on this kernel",
 				  alg);
 			ret = -EOPNOTSUPP;
 		} else {
-- 
2.34.1


