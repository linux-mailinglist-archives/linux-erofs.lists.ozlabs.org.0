Return-Path: <linux-erofs+bounces-408-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F4CADA114
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Jun 2025 07:18:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bKhGq5NFHz30Qk;
	Sun, 15 Jun 2025 15:17:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.245
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749964672;
	cv=none; b=oeJA1/uy+k7Ixc2IBm2iixqUGxFKogvtIbQTeTsyt/Fe0NYr6xGxxsqtpG7gMc5GXpnx5Ge34U8OM/RghcKXv6Ftedm4WEiLy1dDxQqSsHamC28WDeXkJOHvhG5RZ10Zv1RI7of5BvqbgiphGOclxpHnoqxWpa3IGg0DRW/NvA/DNscyf2zVk3iI7OvIqAB7ImJAaxT2Nyykl2MguF9FhjWt5dUkRzF+J4Y5l4ySNXV6/4aN5vuz5yv4715rHVx0qwCVYflNF0l03x5vl6Xae8iUkXIiMMA/ml/HEJpFXsKS4A7xg/GW/SXZYksbkE8+M9NwpugjJ8OfoqB0NwysZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749964672; c=relaxed/relaxed;
	bh=d5TyK4yx0XBWBsINgoNisr8SuMCID+F1Z6VSjQfI+JQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=m6+uYvSJBKmxn1ZdVZgDNInO5o3MHJejTX5RT6P387z7gzzl+5vCb5teST87fDJnqeowpUCB9h+qd23u/u9I8Vkx32I9AdROlyXDEdgz7keUH2//MwRkfCy6K4IMG9AB1ELTuy2WBALF14NivnbGrfwmUvO6xUFZ38UKfa59HF9c5WnrbBf1k8GQwEr4RXiv3MiYTnC3aI3qKxUcwfzUmXMOOOrDNEKgB9bKu4aX93KzJwa8KqGNrj9MfjY8gn3ezayytLotnFADHGdc1mJWN23DL/djIwwO6TpH0FebbGKb+JHC5SYLUUgs3Rcplh/miih3YKnnEpYRkzj8nM2Tfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yba6o1bU; dkim-atps=neutral; spf=pass (client-ip=203.205.221.245; helo=out203-205-221-245.mail.qq.com; envelope-from=eadavis@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yba6o1bU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.245; helo=out203-205-221-245.mail.qq.com; envelope-from=eadavis@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 376 seconds by postgrey-1.37 at boromir; Sun, 15 Jun 2025 15:17:48 AEST
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4bKhGh3sTpz30HB
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Jun 2025 15:17:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1749964663; bh=d5TyK4yx0XBWBsINgoNisr8SuMCID+F1Z6VSjQfI+JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yba6o1bU/PmorQy6BL9b/ZW6EDrB1CNDAFIsspCMk8sJsnL5x/SJ/StWywfkSB5Ek
	 uX+L5otXwVHWWGxdBKUm5ubRunLbtkJL9H4TXt5ab3mZrAgSmG7LOzKgC9psEaFQN8
	 PL8HquTcSXCguYAWMriYwfiW3OlqOV0a056JRvy4=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 148A9EEF; Sun, 15 Jun 2025 13:05:08 +0800
X-QQ-mid: xmsmtpt1749963908t7ag37dfo
Message-ID: <tencent_15B5C44A7766B77466C6B36CE367297EA305@qq.com>
X-QQ-XMAILINFO: MK3JR/K3P3T7YGLsROEKh1Zzhhimt0j3e7IXLnaz1nMYc7GnEjB3LLPR4Le8sZ
	 8GY93cyBCIw8BYbFm0Dj/OcZsPQcVQe6sf7TxkdyOD7Mybybo+EMR8oiJgu0fRDUWdlrndwSY3/L
	 Icyy3Jjl34Qgchf32/HleZ6Dft6NNgZ28pCD9L+mhb3v88A96d3yjequMYjueqcsDoozlgy7L48B
	 WqqmjJJo9Zqvb/lx1kxFAA2OuXFma7T7cXa8bjstpztQHDJ9tmgAz7k9iFaTmwt9hxFIqPyrzAyL
	 D3A0Lwp1r1TcwST+TB54dDUDoDufpeh70ut4RwJiADcUTRojYuNx3TxgpE+oHjd3YT05hD5PpTdT
	 WV9+nxBjHEvIA4pOwLex7lEohR1ChNg0TcDWYt1kzv1wLQNNilpQ4L94TfYSU9q0l+W0k9FaUYV4
	 33HhQVh5wxyM3P5rObPXShdSth9t5u1ZhtxUsrpJIE/lmUiv1TMaJombZKYBqoO3H5bCXhZ5AKHV
	 NqZ39q7A1LbRlHf1dz+urZ1Y+V+hK++Qb5oUNdaUEQNSfDWWwq13EaOeFd2Q/8eA66E/kiM7Kme4
	 P6X9qwqYASdBU/I5UMlSNxWXSHuDnrdFobJgcznc+8xpB6j8dvnC7pHuTdGV/uwWSype81HQkIUM
	 gqyX+GNmo/jqa+2f9JPpz/UPitbkFMF/llbzSE8d1QuW79j1OJr27CGN/TGBxaX/iSgHJCpkSrz9
	 v5yV417QEQ7ZhU0jdK04KaZMwoY0NuVEfxXAEMa4QnUMHylH1uaCPc0CzWJTH0mapqkCItu8wNl7
	 jLvH13dja759qynTlSowKMwCDh9lzcolZcNzb+61KoUruIL/faf/YsaErPgCR9mxmWN9WTDlDJom
	 eek7p8zL4EzdIknUVP8qOmZ+PcOihHIu1ifDnV6SF2S/ePeiv/lvc7GCo7pp3+KNCc6qvFkU6Io3
	 YxKHcFGuoXYff1AXXY7cyWC051z8N8CWP5m8auZlqtw804EmJAgR3emc5q5+mU
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	chao@kernel.org,
	djwong@kernel.org,
	eadavis@qq.com,
	hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	xiang@kernel.org
Subject: [PATCH] erofs: confirm big pcluster before setting extents
Date: Sun, 15 Jun 2025 13:05:09 +0800
X-OQ-MSGID: <20250615050508.3722289-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <684d44da.050a0220.be214.02b2.GAE@google.com>
References: <684d44da.050a0220.be214.02b2.GAE@google.com>
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
	RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [203.205.221.245 listed in list.dnswl.org]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [eadavis(at)qq.com]
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  3.2 HELO_DYNAMIC_IPADDR Relay HELO'd using suspicious hostname (IP addr
	*      1)
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In this case, advise contains Z_EROFS_ADVISE_EXTENTS,
Z_EROFS_ADVISE_BIG_PCLUSTER_1, Z_EROFS_ADVISE_BIG_PCLUSTER_2 at the same
time, and following 1 and 2 are met, WARN_ON_ONCE(iter->iomap.offset >
iter->pos) in iomap_iter_done() is triggered.

1. When Z_EROFS_ADVISE_EXTENTS exists, z_erofs_fill_inode_lazy() is exited
   after z_extents is set, which skips the check of big pcluster;
2. When the condition "lstart < lend" is met in z_erofs_map_blocks_ext(),
   m_la is updated, and m_la is used to update iomap->offset in
   z_erofs_iomap_begin_report();

Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Reported-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d8f000c609f05f52d9b5
Tested-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/erofs/zmap.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14ea47f954f5..664611cca689 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -686,7 +686,17 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		vi->z_tailextent_headlcn = 0;
 		goto done;
 	}
+
 	vi->z_advise = le16_to_cpu(h->h_advise);
+	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
+	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
+			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
+			  vi->nid);
+		err = -EFSCORRUPTED;
+		goto out_put_metabuf;
+	}
+
 	vi->z_lclusterbits = sb->s_blocksize_bits + (h->h_clusterbits & 15);
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_FULL &&
 	    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS)) {
@@ -711,14 +721,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 		goto out_put_metabuf;
 	}
 
-	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
-	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
-			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
-			  vi->nid);
-		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
-	}
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-- 
2.43.0


