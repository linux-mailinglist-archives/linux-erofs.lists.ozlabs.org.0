Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B07CEA47B1
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:53:06 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj741YTpzDqtN
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:53:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317184;
	bh=2+T8yNkHb39LAhicVsFWwaVH/QppeqkSzv7slx1Xvks=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cjzziofvsQLuvUefFYLsevzS5miHuLF1XZo12O+eg6dBWXOp9Zj4qCQjxxxOApWD4
	 hs0ypcLaZqTkegL+OsIp6I1Z8whdJip2n7fYoDIHnQnZ8rBcxc5CnlXQBFtxzBK3HC
	 eaYRhpIiL52JAgilXqVPg0U5OgO0ARy74/1vqgQtUHwZRAFwMX9cSVHVDsEimJPker
	 B+EZw19UJjMtdAzfOk/ZxXCpx8+sqY48qBzdgft/lku8hBYWkZkxd3tpGkPvN2MYA0
	 cigWGRShlrvukGAXj/XmtedqNpJSttGLOphiWUcmMuvgdWuqfkgn7ptFQeeq4LwL/v
	 qKdsaKexW9iaA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.146; helo=sonic301-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="XJk9k36/"; 
 dkim-atps=neutral
Received: from sonic301-20.consmr.mail.gq1.yahoo.com
 (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj6Z4m5vzDqtZ
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:52:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317151; bh=xyzLFbGFGOZTSaMtcMPutncgSOGzVBNC+NNTATqkoDA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=XJk9k36/zjsvTDf3JTiV0SC7u+4fA8Dn0kI9fhLgZqBC2WsUMTvwOSiNgllCFRae6Vz8BzjdaI60cAV1/fQPBVkXSBbGymEu9OA6simvfA9+78SxkItSLW5i8zKCgKJaenlayCbrrTkI7j2r0/j6w6AdSUk48fspzT9duWXMlaDYGRQT2ExAICNkTUkgJM8kk+sv/mHY4sQ4myo+OKo1uAokvxjY2VhkkRVM8gC0HZz+Z1AthJMgRVOVoRGZ1cy2Nf+RO6fql2fqcWPQYj6ULEzVUnkn8ErTVckYToGyiJXARm7ZjBjA6rhDWHhXwy7maD1EVkKSB1Mw6DtooxQVdQ==
X-YMail-OSG: ZoGfFlQVM1lN4mDgMJoo8KEKbdqaqy2_9W9yFXfW_qbuaZb3wJK5zBbke6429BP
 aDBIxiKrt2kZJT.RLCoJ4TdOIOilR9qUY9zjHct_67aEvFDssHdqyzjmB5xzcMJCdeONjVeMkw.e
 sK4Rtdu6AfDIiXf9nNb0oApNBcJj6xJIHjS27l6ez29lDf986VTFB6TltNDIgSeVmU3kwHXbmy_R
 uw43P5_g97uVVDKx7n_z2yDspXrC_e8158iaYDky8NTu051zGb2fbNAcBGC7fIxG9lT3OIfcRWRd
 mC2CQSw2EShVNAHUQH1BcwSC_bpNqHOUov2pl1eQoyw4OOL8Y2WUd.QWyU5XErD_OEv_c7sveB36
 OvCHwxcxoWxmAzVVZeBhQ43cTiTLf4YalyRBMZ9xYvBFg8YeMSJTNVwN7A5EwxZkccI_F0Yww1Tw
 B2OSBi20J1iSxce4Thh0s.KUStm404sJRJlv6F57TI_fJza1EYclW5zQT39cc2k1fUMmg61spxPx
 afjRQXFugr3mYSkPg9XT8qEiVRip4TgeuZHavdOCSddjd_GUGbWz.U1AjpgHO7YN4nAgPSrSMqZt
 tH7zZomUcly0cKBZEzrpMVO2Wga6f5WNmklYDAvdmFntY2WC6kKe1FjSLjwU.ROhkMpXU2G.OvEf
 mz3Ma5NsJKr12A7X4mD_UaG8fcvoUSrTpv1aDq93oHLurVi9E60DCb63H0z6WQXpBY3NLDjpZFTo
 ppS3ytbaebD4JXUXeiG4m7kPfnyIZTy_7Y3GFbqo83ukRL_WAbS9vTkqT8VdOZXS2eJLa.F7SW8n
 5fLIBQnjjFHUUGDrloooyvt_5zAsi2sYzTAMSa414px.BU4gJDhy0Hz_obuhW3m_2q4tofQc6eem
 KFx4InBt9kifDg3PQD7SF6dP1KqksUtr.LGrnn6X3WWStxv1yxlMB3ehL8AK.0WOKlDEKaf4pGW.
 nQXEQF240l38t5Bzh.dMnUwvcRGTUaJuC8OYerxHrgNeLEOG9TWfp9gZK73z01eRjQDwJUB0D4gx
 Zsl7lQGtQ5PKE0pRisXpvVCZJW994bWsnBrn9w.W5eHJq_s5Fq_VAHM9CJjyQYD74R_PmMpdg7oZ
 pjrD_qemdcaBOq3.1nKb0h8h_J_YAqFEsvdkt64ljRsQAQCc3ENgwpCXqbhL663t4cyZVXa5Iu2F
 Fsco1owAQfu7Emq6OAktbYBiE31rvPS2CixsK8fEN_j138zg5QECTiMGql2zA.wufGLr.M8jdf1C
 hlTVxHIDPnb3mp2tpGZWTTciQHIeT1QeO2BHs.x0AjA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:52:31 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:52:29 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/21] erofs: update comments in inode.c
Date: Sun,  1 Sep 2019 13:51:17 +0800
Message-Id: <20190901055130.30572-9-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph suggested [1], update them all.

[1] https://lore.kernel.org/r/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index de0373647959..24c94a7865f2 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -129,7 +129,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 	if (!is_inode_flat_inline(inode))
 		return 0;
 
-	/* fast symlink (following ext4) */
+	/* fast symlink */
 	if (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) {
 		char *lnk = erofs_kmalloc(sbi, inode->i_size + 1, GFP_KERNEL);
 
@@ -138,7 +138,7 @@ static int fill_inline_data(struct inode *inode, void *data,
 
 		m_pofs += vi->inode_isize + vi->xattr_isize;
 
-		/* inline symlink data shouldn't across page boundary as well */
+		/* inline symlink data shouldn't cross page boundary as well */
 		if (m_pofs + inode->i_size > PAGE_SIZE) {
 			kfree(lnk);
 			errln("inline data cross block boundary @ nid %llu",
@@ -147,7 +147,6 @@ static int fill_inline_data(struct inode *inode, void *data,
 			return -EFSCORRUPTED;
 		}
 
-		/* get in-page inline data */
 		memcpy(lnk, data + m_pofs, inode->i_size);
 		lnk[inode->i_size] = '\0';
 
-- 
2.17.1

