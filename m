Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDED78EC0E
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 13:31:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RbzWj4xZ1z30dt
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 21:31:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RbzWL2YdZz3bV7
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 21:31:10 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vqy4wi9_1693481464;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vqy4wi9_1693481464)
          by smtp.aliyun-inc.com;
          Thu, 31 Aug 2023 19:31:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19.y] erofs: ensure that the post-EOF tails are all zeroed
Date: Thu, 31 Aug 2023 19:29:59 +0800
Message-Id: <20230831112959.99884-7-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230831112959.99884-1-hsiangkao@linux.alibaba.com>
References: <20230831112959.99884-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, keltargw <keltar.gw@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit e4c1cf523d820730a86cae2c6d55924833b6f7ac upstream.

This was accidentally fixed up in commit e4c1cf523d82 but we can't
take the full change due to other dependancy issues, so here is just
the actual bugfix that is needed.

[Background]

keltargw reported an issue [1] that with mmaped I/Os, sometimes the
tail of the last page (after file ends) is not filled with zeroes.

The root cause is that such tail page could be wrongly selected for
inplace I/Os so the zeroed part will then be filled with compressed
data instead of zeroes.

A simple fix is to avoid doing inplace I/Os for such tail parts,
actually that was already fixed upstream in commit e4c1cf523d82
("erofs: tidy up z_erofs_do_read_page()") by accident.

[1] https://lore.kernel.org/r/3ad8b469-25db-a297-21f9-75db2d6ad224@linux.alibaba.com

Reported-by: keltargw <keltar.gw@gmail.com>
Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 drivers/staging/erofs/unzip_vle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 83e4d9384bd2..7ccc4a18a900 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -675,6 +675,8 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	cur = end - min_t(unsigned, offset + end - map->m_la, end);
 	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED))) {
 		zero_user_segment(page, cur, end);
+		++spiltted;
+		tight = false;
 		goto next_part;
 	}
 
-- 
2.24.4

