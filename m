Return-Path: <linux-erofs+bounces-1265-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 65333BF54DE
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Oct 2025 10:41:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crQk50t8Rz300M;
	Tue, 21 Oct 2025 19:41:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=222.66.158.135
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761036061;
	cv=none; b=X8Jp75tQtezh09cpeJ9zzOpWrec13prU4fGedILJhPUJQIt6HCpreZ61IyJWnawPwXomwmNTOp7FsoRq1pgr1uSFDruoQ5SisoVIOPqzO14387UMhFZgjIi7lIoKNIcfcHUx7aF53nxqQN3mIwoaTLdFNSbbQ7TRZzWkG7ghED7h5xvdLTqllHpmpEDyapIBmB1KzbaZ64Hznei9vCwLvCcKb5UkN3UvMTDbMZXaBn8XI7s3WasB642xl2Pk4B9w864Mro1IN5wH5+2oJwk+nwbr3n0la/6eR69u0qjI0BhnyigYEnxfePlSf4Jacaka41Lyrs3kYlkI0t5BwjQ93w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761036061; c=relaxed/relaxed;
	bh=mdctOO+DdWDgLM9oFyMzgvhHtiRsuFQEI+VmTpFm3rE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FkNtSvdtCDmB8RZ8bO/c8pywSeelG9V0Y4EPLzXfKZ0NRx0aQd6VxWUjcDTHa/wdgcvA3eNh56bC+/6bNa3gCe197evZdCMTHiQrcwKsLngGuXM9HfkjNAXaWb6i0cz5ja3w9H0ZTTuVYlm1LRpY+GPgTcolMdp0OHxT9Cl8t9x6JswOZcF4yA03r/AM06Bdk9LferMCGrYV+kPUBXJW+WhoQ3K7837y+55y4CbRF225FFLJ56IrpauQbA0uQRbMAp5sDikvaXMvBVYG0luT7sNMk6Op0MqN1bF1EwuS9E323u/X3bFRkzo20cEbEPh8aii8v00yEbq9A04VGzUvOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; dkim=pass (2048-bit key; unprotected) header.d=unisoc.com header.i=@unisoc.com header.a=rsa-sha256 header.s=default header.b=J5y/bibW; dkim-atps=neutral; spf=pass (client-ip=222.66.158.135; helo=shsqr01.spreadtrum.com; envelope-from=zhiguo.niu@unisoc.com; receiver=lists.ozlabs.org) smtp.mailfrom=unisoc.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=unisoc.com header.i=@unisoc.com header.a=rsa-sha256 header.s=default header.b=J5y/bibW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=unisoc.com (client-ip=222.66.158.135; helo=shsqr01.spreadtrum.com; envelope-from=zhiguo.niu@unisoc.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1841 seconds by postgrey-1.37 at boromir; Tue, 21 Oct 2025 19:40:58 AEDT
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crQk23gzKz2ySm
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 19:40:55 +1100 (AEDT)
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 59L8AHg7037027
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 16:10:17 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 59L89qcn034968;
	Tue, 21 Oct 2025 16:09:52 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4crPz81QLWz2NxMR0;
	Tue, 21 Oct 2025 16:07:16 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 21 Oct 2025 16:09:49 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <hsiangkao@linux.alibaba.com>
CC: <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>, <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs-utils: fix to return correct err in z_erofs_fill_inode_lazy
Date: Tue, 21 Oct 2025 16:09:24 +0800
Message-ID: <1761034164-29967-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
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
Content-Type: text/plain
X-Originating-IP: [10.0.73.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 59L89qcn034968
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1761034199;
	bh=mdctOO+DdWDgLM9oFyMzgvhHtiRsuFQEI+VmTpFm3rE=;
	h=From:To:CC:Subject:Date;
	b=J5y/bibWGMd3bg2ZZvcjjZgmT4owyAxlFfPM9pqON0rRkQYEfnNcmuoCR4NzjrdlX
	 zsD+NcanvD59opXlAo8SK+YZaLioA2eo+Zbj3A+kjBAMTj8DNWmA7p3k3I+spYirlW
	 tTNwFw5eRkzx8nCYhkj05fkkUD0lRLLGmxug6etgwun/oo7JCfwcxfx/gfriTfz+y9
	 sPd6eKlx9GsAYBBnY0UKaLre25/1WpAN9lRP8XnCw3sT1gSPH+/QXFl6d4/VJbx6vZ
	 tCyzu0w70citeE2pFSp4ZFD7+faY+TfUk1NdXioUOL/iJnp7Bkv9kfBZr+WhxWZi9e
	 xaERGPYRIiwTw==
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Otherwise -EOPNOTSUPP and -EFSCORRUPTED err cases would be handled to
return 0.

Fixes: 3871365cb629 ("erofs-utils: lib: use meta buffers for zmap operations")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 lib/zmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 61cddb2..c1cf698 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -645,7 +645,7 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
-	int err, headnr;
+	int err = 0, headnr;
 	erofs_off_t pos;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct z_erofs_map_header *h;
@@ -715,7 +715,7 @@ done:
 	erofs_atomic_set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 out_put_metabuf:
 	erofs_put_metabuf(&buf);
-	return 0;
+	return err;
 }
 
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
-- 
1.9.1


